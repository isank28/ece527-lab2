#**************************************************
#* ECE 527 PR_2 Task B
#* Design Compiler script: Part 2 pipelined 8-bit carry-select adder (csa8_pipe)
#* Adapted from the TA's dcFIFO.tcl
#* Run:  dc_shell -f dc_csa8.tcl | tee dc_csa8.log
#**************************************************

#---------------- Settings (change these) ----------------
set DESIGN      csa8_pipe
set RTL_FILES   {fa2.sv csa8_pipe.sv}
set CLK_PERIOD  2.0     ;# ns, starting guess; tighten after reading the timing report
set IN_DELAY    0.6     ;# ns, from the assignment
set CLK_LATENCY 0.2     ;# ns, external (source) clock latency, from the assignment
set OUT_DELAY   0.0     ;# ns, not given in the assignment; confirm with the TA

#---------------- Libraries ----------------
set target_library gscl45nm.db
set link_library   "* gscl45nm.db"

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

#---------------- Synthesize ----------------
compile -ungroup_all

#---------------- Reports (saved to files for turn-in) ----------------
file mkdir reports
report_timing -delay_type max -max_paths 5 > reports/${DESIGN}_timing_max.rpt
report_timing -delay_type min              > reports/${DESIGN}_timing_min.rpt
report_area                                > reports/${DESIGN}_area.rpt
report_reference                           > reports/${DESIGN}_cells.rpt
report_qor                                 > reports/${DESIGN}_qor.rpt

# Worst path of each type (the overall worst is often the input path)
report_timing -delay_type max \
    -from [all_registers -clock_pins] -to [all_registers -data_pins] \
                                           > reports/${DESIGN}_timing_reg2reg.rpt
report_timing -delay_type max \
    -from [all_registers -clock_pins] -to [all_outputs] \
                                           > reports/${DESIGN}_timing_reg2out.rpt

# Also show the key reports on screen
report_timing -delay_type max
report_area

#---------------- Write the netlist for PrimeTime ----------------
write -f verilog -h -o ${DESIGN}_netlist.v

exit
