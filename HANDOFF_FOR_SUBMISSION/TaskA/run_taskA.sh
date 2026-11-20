#!/bin/bash
#**************************************************
#* ECE 527 PR_2 Task A - run everything in one go
#*   Item 1    : simulation of both adders (common testbench, run.do)
#*   Items 2-3 : DC synthesis -> max delay, DC minimum period, area
#*   Item 4    : PT at the DC minimum period with the assignment's skew
#*   Item 5    : PT just below / at the minimum passing period -> throughput
#*   Item 6    : skew sweep (0.1 0.3 0.5 0.7 ns), saved with every PT run
#* Run from the taskA folder, inside addpkg_shell:
#*   chmod +x run_taskA.sh     (once)
#*   ./run_taskA.sh
#* Full tool output: logs/   Reports: reports/   Summary: reports/summary_taskA.txt
#**************************************************

cd "$(dirname "$0")" || exit 1
mkdir -p logs reports

DESIGNS="rca4 csa4"     # script suffixes; design name is <suffix>_pipe
SKEW=0.5                # assignment skew; must match SKEW in pt_*.tcl
SUMMARY=reports/summary_taskA.txt

fail() { echo "FAIL: $1"; exit 1; }

# First "slack (...)" value in a report (works for MET and VIOLATED lines)
slack_in() { awk '/slack \(/ { print $NF; exit }' "$1"; }

# First "slack (...)" line status word: MET or VIOLATED
status_in() { awk '/slack \(/ { if ($0 ~ /VIOLATED/) print "VIOLATED"; else print "MET"; exit }' "$1"; }

# a - b, 2 decimals
minus() { awk -v a="$1" -v b="$2" 'BEGIN { printf "%.2f", a - b }'; }

# Run PrimeTime for one design at a given period, reports into a given folder
pt_run() {   # $1 = rca4|csa4   $2 = period (ns)   $3 = report folder
    local log=logs/pt_$1_$(basename "$3").log
    CLK_PERIOD=$2 RPT_DIR=$3 pt_shell -f pt_$1.tcl > "$log" 2>&1
    # PT-063 (Library Compiler path not set) is a harmless startup message
    if grep "^Error" "$log" | grep -qv "PT-063"; then
        grep "^Error" "$log" | grep -v "PT-063"
        fail "PT errors for $1 at $2 ns ($log)"
    fi
}

#---------------- Pre-checks ----------------
for f in fa2.sv rca4_pipe.sv csa4_pipe.sv tb_adders.sv run.do \
         dc_rca4.tcl dc_csa4.tcl pt_rca4.tcl pt_csa4.tcl gscl45nm.db; do
    [ -f "$f" ] || fail "missing file: $f"
done
for t in vsim dc_shell pt_shell; do
    command -v $t >/dev/null || fail "$t not found (run addpkg_shell first)"
done

declare -A AREA DCMIN ADDER SETUP4 HOLD4 TFAIL SFAIL TPASS SPASS HPASS

#================ Item 1: simulation ================
echo "=== Item 1: simulation ==="
vsim -c -do "do run.do; quit -f" > logs/sim.log 2>&1
if grep -q "\*\* Error" logs/sim.log; then
    grep "\*\* Error" logs/sim.log | head -20
    fail "compile/simulation errors (logs/sim.log)"
fi
grep -q "PASS:" logs/sim.log || { grep "FAIL" logs/sim.log | head -20; fail "simulation did not pass (logs/sim.log)"; }
SIM=$(grep -m1 "PASS:" logs/sim.log | sed 's/^# //')
echo "$SIM"

#================ Items 2-3: DC synthesis ================
echo
echo "=== Items 2-3: DC synthesis ==="
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
    ADDER[$d]=$(minus "$dcp" "$(slack_in reports/${top}_timing_reg2reg.rpt)")
    AREA[$d]=$(awk '/Total cell area/ { print $4; exit }' reports/${top}_area.rpt)
    echo "$top: area ${AREA[$d]}, adder (flop->flop) ${ADDER[$d]} ns, DC min period ${DCMIN[$d]} ns"
done

#================ Item 4: PT at the DC minimum period ================
echo
echo "=== Item 4: PT at the DC minimum period, skew $SKEW ns ==="
for d in $DESIGNS; do
    top=${d}_pipe
    dir=reports/item4
    pt_run $d ${DCMIN[$d]} $dir
    SETUP4[$d]="$(slack_in $dir/${top}_pt_setup.rpt) $(status_in $dir/${top}_pt_setup.rpt)"
    HOLD4[$d]="$(slack_in $dir/${top}_pt_hold.rpt) $(status_in $dir/${top}_pt_hold.rpt)"
    echo "$top @ ${DCMIN[$d]} ns: setup ${SETUP4[$d]}, hold ${HOLD4[$d]}"
done

#================ Item 5: minimum passing period ================
echo
echo "=== Item 5: minimum period with skew $SKEW ns ==="
for d in $DESIGNS; do
    top=${d}_pipe
    # Predicted minimum from the item 4 sweep (row = assignment skew, column 6 = Tmin_all),
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
{
echo
echo "================ Task A summary ================"
echo "Item 1: $SIM"
echo
printf "%-28s %14s %14s\n" "" "rca4_pipe" "csa4_pipe"
printf "%-28s %14s %14s\n" "Item 3: total cell area"           "${AREA[rca4]}"   "${AREA[csa4]}"
printf "%-28s %14s %14s\n" "Item 2: adder flop->flop (ns)"     "${ADDER[rca4]}"  "${ADDER[csa4]}"
printf "%-28s %14s %14s\n" "Item 2: DC min period (ns)"        "${DCMIN[rca4]}"  "${DCMIN[csa4]}"
printf "%-28s %14s %14s\n" "Item 4: setup @ DC min"            "${SETUP4[rca4]}" "${SETUP4[csa4]}"
printf "%-28s %14s %14s\n" "Item 4: hold  @ DC min"            "${HOLD4[rca4]}"  "${HOLD4[csa4]}"
printf "%-28s %14s %14s\n" "Item 5: period just below (ns)"    "${TFAIL[rca4]}"  "${TFAIL[csa4]}"
printf "%-28s %14s %14s\n" "        setup there"               "${SFAIL[rca4]}"  "${SFAIL[csa4]}"
printf "%-28s %14s %14s\n" "Item 5: min passing period (ns)"   "${TPASS[rca4]}"  "${TPASS[csa4]}"
printf "%-28s %14s %14s\n" "        setup there"               "${SPASS[rca4]}"  "${SPASS[csa4]}"
printf "%-28s %14s %14s\n" "        hold there"                "${HPASS[rca4]}"  "${HPASS[csa4]}"
printf "%-28s %14s %14s\n" "Item 5: throughput (M adds/s)" \
    "$(awk -v p=${TPASS[rca4]} 'BEGIN { printf "%.0f", 1000 / p }')" \
    "$(awk -v p=${TPASS[csa4]} 'BEGIN { printf "%.0f", 1000 / p }')"
echo
echo "Item 6: skew sweeps (at the minimum passing period)"
for d in $DESIGNS; do
    echo "--- ${d}_pipe"
    cat reports/item5_pass/${d}_pipe_pt_skew_sweep.txt
done
echo
echo "Reports: reports/ (DC), reports/item4, reports/item5_fail, reports/item5_pass (PT)"
} | tee $SUMMARY
