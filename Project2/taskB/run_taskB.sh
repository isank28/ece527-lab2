#!/bin/bash
#**************************************************
#* ECE 527 PR_2 Task B - run everything in one go
#*   Simulation : both 8-bit adders, common testbench (run.do)
#*   DC         : area, flop->flop and flop->output delay, DC minimum period
#*   PT         : at the DC minimum period with the assignment's skew,
#*                then just below / at the minimum passing period -> throughput,
#*                skew sweep (0.1 0.3 0.5 0.7 ns) saved with every PT run
#* Run from the taskB folder, inside addpkg_shell:
#*   chmod +x run_taskB.sh     (once)
#*   ./run_taskB.sh
#* Full tool output: logs/   Reports: reports/   Summary: reports/summary_taskB.txt
#**************************************************

cd "$(dirname "$0")" || exit 1
mkdir -p logs reports

D1=prefix8              # Part 1: Sklansky prefix adder
D2=csa8                 # Part 2: carry-select adder
DESIGNS="$D1 $D2"       # script suffixes; design name is <suffix>_pipe
SKEW=0.5                # assignment skew; must match SKEW in pt_*.tcl
SUMMARY=reports/summary_taskB.txt

fail() { echo "FAIL: $1"; exit 1; }

# First "slack (...)" value in a report (works for MET and VIOLATED lines)
slack_in() { awk '/slack \(/ { print $NF; exit }' "$1"; }
# MET or VIOLATED for the first "slack (...)" line
status_in() { awk '/slack \(/ { if ($0 ~ /VIOLATED/) print "VIOLATED"; else print "MET"; exit }' "$1"; }
# "start -> end" of the first path in a report
path_in() { awk '/Startpoint:/ && !s { s = $2 } /Endpoint:/ && !e { e = $2 } END { print s " -> " e }' "$1"; }
# a - b, 2 decimals
minus() { awk -v a="$1" -v b="$2" 'BEGIN { printf "%.2f", a - b }'; }

# Run PrimeTime for one design at a given period, reports into a given folder
pt_run() {   # $1 = design suffix   $2 = period (ns)   $3 = report folder
    local log=logs/pt_$1_$(basename "$3").log
    CLK_PERIOD=$2 RPT_DIR=$3 pt_shell -f pt_$1.tcl > "$log" 2>&1
    # PT-063 (Library Compiler path not set) is a harmless startup message
    if grep "^Error" "$log" | grep -qv "PT-063"; then
        grep "^Error" "$log" | grep -v "PT-063"
        fail "PT errors for $1 at $2 ns ($log)"
    fi
}

#---------------- Pre-checks ----------------
for f in fa2.sv prefix8_pipe.sv csa8_pipe.sv tb_taskB.sv run.do \
         dc_$D1.tcl dc_$D2.tcl pt_$D1.tcl pt_$D2.tcl gscl45nm.db; do
    [ -f "$f" ] || fail "missing file: $f"
done
for t in vsim dc_shell pt_shell; do
    command -v $t >/dev/null || fail "$t not found (run addpkg_shell first)"
done

declare -A AREA CELLS DCMIN R2R R2O P_R2R P_R2O SETUP4 HOLD4 TFAIL SFAIL TPASS SPASS HPASS

#================ Simulation ================
echo "=== Simulation ==="
vsim -c -do "do run.do; quit -f" > logs/sim.log 2>&1
if grep -q "\*\* Error" logs/sim.log; then
    grep "\*\* Error" logs/sim.log | head -20
    fail "compile/simulation errors (logs/sim.log)"
fi
grep -q "PASS:" logs/sim.log || { grep "FAIL" logs/sim.log | head -20; fail "simulation did not pass (logs/sim.log)"; }
SIM=$(grep -m1 "PASS:" logs/sim.log | sed 's/^# //')
echo "$SIM"

#================ DC synthesis ================
echo
echo "=== DC synthesis ==="
for d in $DESIGNS; do
    top=${d}_pipe
    rm -f ${top}_netlist.v
    dc_shell -f dc_${d}.tcl > logs/dc_${d}.log 2>&1
    if grep -q "^Error" logs/dc_${d}.log; then
        grep "^Error" logs/dc_${d}.log
        fail "DC errors for $top (logs/dc_${d}.log)"
    fi
    [ -f ${top}_netlist.v ] || fail "no netlist written for $top (logs/dc_${d}.log)"

    dcp=$(awk '/^set CLK_PERIOD/ { print $3; exit }' dc_${d}.tcl)
    DCMIN[$d]=$(minus "$dcp" "$(slack_in reports/${top}_timing_max.rpt)")
    R2R[$d]=$(minus "$dcp" "$(slack_in reports/${top}_timing_reg2reg.rpt)")
    R2O[$d]=$(minus "$dcp" "$(slack_in reports/${top}_timing_reg2out.rpt)")
    P_R2R[$d]=$(path_in reports/${top}_timing_reg2reg.rpt)
    P_R2O[$d]=$(path_in reports/${top}_timing_reg2out.rpt)
    AREA[$d]=$(awk '/Total cell area/ { print $4; exit }' reports/${top}_area.rpt)
    CELLS[$d]=$(awk '/Number of cells:/ { print $4; exit }' reports/${top}_area.rpt)
    echo "$top: area ${AREA[$d]}, flop->flop ${R2R[$d]} ns, flop->out ${R2O[$d]} ns, DC min period ${DCMIN[$d]} ns"
done

#================ PT at the DC minimum period ================
echo
echo "=== PT at the DC minimum period, skew $SKEW ns ==="
for d in $DESIGNS; do
    top=${d}_pipe
    dir=reports/item4
    pt_run $d ${DCMIN[$d]} $dir
    grep "FFs:" logs/pt_${d}_item4.log
    SETUP4[$d]="$(slack_in $dir/${top}_pt_setup.rpt) $(status_in $dir/${top}_pt_setup.rpt)"
    HOLD4[$d]="$(slack_in $dir/${top}_pt_hold.rpt) $(status_in $dir/${top}_pt_hold.rpt)"
    echo "$top @ ${DCMIN[$d]} ns: setup ${SETUP4[$d]}, hold ${HOLD4[$d]}"
done

#================ Minimum passing period ================
echo
echo "=== Minimum period with skew $SKEW ns ==="
for d in $DESIGNS; do
    top=${d}_pipe
    # Predicted minimum from the sweep (row = assignment skew, column 6 = Tmin_all),
    # rounded up to the next 0.01 ns with a small margin for the 3-decimal rounding
    tmin=$(awk -v s=$SKEW '$1 == s { print $6; exit }' reports/item4/${top}_pt_skew_sweep.txt)
    [ -n "$tmin" ] || fail "no Tmin_all for skew $SKEW in reports/item4/${top}_pt_skew_sweep.txt"
    pass=$(awk -v t="$tmin" 'BEGIN { x = t * 100 + 0.5; c = int(x); if (c < x) c++; printf "%.2f", c / 100 }')
    lower=$(minus "$pass" 0.01)

    pt_run $d $lower reports/item5_fail
    pt_run $d $pass  reports/item5_pass
    TFAIL[$d]=$lower
    SFAIL[$d]="$(slack_in reports/item5_fail/${top}_pt_setup.rpt) $(status_in reports/item5_fail/${top}_pt_setup.rpt)"
    TPASS[$d]=$pass
    SPASS[$d]="$(slack_in reports/item5_pass/${top}_pt_setup.rpt) $(status_in reports/item5_pass/${top}_pt_setup.rpt)"
    HPASS[$d]="$(slack_in reports/item5_pass/${top}_pt_hold.rpt) $(status_in reports/item5_pass/${top}_pt_hold.rpt)"
    echo "$top: ${lower} ns setup ${SFAIL[$d]} | ${pass} ns setup ${SPASS[$d]}, hold ${HPASS[$d]}"
done

#================ Summary ================
row() { printf "%-30s %16s %16s\n" "$1" "$2" "$3"; }
{
echo
echo "================ Task B summary ================"
echo "Simulation: $SIM"
echo
row "" "${D1}_pipe" "${D2}_pipe"
row "Total cell area"                 "${AREA[$D1]}"   "${AREA[$D2]}"
row "Number of cells"                 "${CELLS[$D1]}"  "${CELLS[$D2]}"
row "Flop->flop delay incl setup (ns)" "${R2R[$D1]}"   "${R2R[$D2]}"
row "Flop->output delay (ns)"         "${R2O[$D1]}"    "${R2O[$D2]}"
row "DC min period (ns)"              "${DCMIN[$D1]}"  "${DCMIN[$D2]}"
row "Setup @ DC min, skew $SKEW"      "${SETUP4[$D1]}" "${SETUP4[$D2]}"
row "Hold  @ DC min, skew $SKEW"      "${HOLD4[$D1]}"  "${HOLD4[$D2]}"
row "Period just below (ns)"          "${TFAIL[$D1]}"  "${TFAIL[$D2]}"
row "  setup there"                   "${SFAIL[$D1]}"  "${SFAIL[$D2]}"
row "Min passing period (ns)"         "${TPASS[$D1]}"  "${TPASS[$D2]}"
row "  setup there"                   "${SPASS[$D1]}"  "${SPASS[$D2]}"
row "  hold there"                    "${HPASS[$D1]}"  "${HPASS[$D2]}"
row "Throughput (M adds/s)" \
    "$(awk -v p=${TPASS[$D1]} 'BEGIN { printf "%.0f", 1000 / p }')" \
    "$(awk -v p=${TPASS[$D2]} 'BEGIN { printf "%.0f", 1000 / p }')"
echo
echo "Critical paths (DC):"
for d in $DESIGNS; do
    echo "  ${d}_pipe flop->flop  : ${P_R2R[$d]}"
    echo "  ${d}_pipe flop->output: ${P_R2O[$d]}"
done
echo
echo "Skew sweeps (at the minimum passing period)"
for d in $DESIGNS; do
    echo "--- ${d}_pipe"
    cat reports/item5_pass/${d}_pipe_pt_skew_sweep.txt
done
echo
echo "Reports: reports/ (DC), reports/item4, reports/item5_fail, reports/item5_pass (PT)"
} | tee $SUMMARY
