# ============================================================
# ECE 527 Project 2 - Task D
# Design Compiler script: 8x8 Booth-2 signed multiplier
#
# Run from TaskD/:
#     dc_shell -f scripts/dc_booth.tcl
# ============================================================

#---------------- Settings (change these) ----------------
set DESIGN      booth_multiplier
set RTL_FILES   {csa.sv booth2_recode.sv booth_multiplier.sv}
set CLK_PERIOD  10.0     ;# ns, combinational design - loose period for timing analysis
set IN_DELAY    0.6      ;# ns, input delay from assignment
set CLK_LATENCY 0.2      ;# ns, external clock latency
set OUT_DELAY   0.0      ;# ns, output delay

#---------------- Libraries ----------------
set target_library gscl45nm.db
set link_library   "* $LIB"

#---------------- Read and link the design ----------------
read_sverilog $RTL_FILES
current_design $DESIGN
link
check_design

#---------------- Timing constraints ----------------
create_clock -name clk -period $CLK_PERIOD [get_ports clk]
set_clock_latency -source $CLK_LATENCY [get_clocks clk]
set_input_delay  $IN_DELAY  -clock clk [remove_from_collection [all_inputs] [get_ports clk]]
set_output_delay $OUT_DELAY -clock clk [all_outputs]

# Same activity assumptions for power comparison with Task C
if {[catch {set_switching_activity -static_probability 0.5 -toggle_rate 0.2 [all_inputs]} msg]} {
    puts "WARNING: set_switching_activity failed: $msg"
    puts "         report_power will use DC default switching activity."
}

#---------------- Synthesize ----------------
compile -ungroup_all

#---------------- Reports (saved to files for turn-in) ----------------
file mkdir reports
file mkdir netlists

report_timing -delay_type max > reports/${DESIGN}_timing_max.rpt
report_timing -delay_type min > reports/${DESIGN}_timing_min.rpt
report_area                                > reports/${DESIGN}_area.rpt
report_reference                           > reports/${DESIGN}_cells.rpt
report_qor                                 > reports/${DESIGN}_qor.rpt
report_timing -delay_type max -max_paths 10 -nworst 10 -from [all_inputs] -to [all_outputs] > reports/${DESIGN}_timing.rpt
report_power -analysis_effort high         > reports/${DESIGN}_power.rpt

# Also show key reports on screen
report_timing -delay_type max
report_area

#---------------- Write netlist for PrimeTime ----------------
write -f verilog -hierarchy -output netlists/${DESIGN}_netlist.v
write -f ddc     -hierarchy -output netlists/${DESIGN}.ddc

exit
