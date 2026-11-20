#!/usr/bin/env tcsh
# ============================================================
# ECE 527 Project 2 - Task C - DC Synthesis Master Script
# Runs DC synthesis for both array_multiplier and wallace_multiplier
# on Synopsys Design Compiler X-2025.06-SP4
#
# Usage:
#   cd /u/sanketp/ece527-lab2/TaskC
#   ./run_dc_all.tcl
# ============================================================

set LAB_ROOT "/u/sanketp/ece527-lab2/TaskC"
set LIB "gscl45nm.db"
set RTL_DIR "${LAB_ROOT}/rtl"
set REPORTS_DIR "${LAB_ROOT}/reports"
set NETLISTS_DIR "${LAB_ROOT}/netlists"
set LOGS_DIR "${LAB_ROOT}/logs"

# Create output directories
file mkdir ${REPORTS_DIR}
file mkdir ${NETLISTS_DIR}
file mkdir ${LOGS_DIR}

# ------------------------------------------------------------
# Function: synthesize_design
# Arguments: design_name rtl_file_list
# ------------------------------------------------------------
proc synthesize_design {design_name rtl_files} {
    global LAB_ROOT LIB REPORTS_DIR NETLISTS_DIR LOGS_DIR

    puts "============================================================"
    puts "Synthesizing: ${design_name}"
    puts "============================================================"

    # Read all RTL files
    foreach f ${rtl_files} {
        set fpath "${LAB_ROOT}/rtl/${f}"
        if [file exists ${fpath}] {
            puts "  Reading: ${f}"
            read_sverilog ${fpath}
        } else {
            puts "  WARNING: File not found: ${fpath}"
        }
    }

    # Elaborate parameterized modules
    elaborate ${design_name}

    # Set top design and link
    current_design ${design_name}
    link
    check_design

    # Timing constraints
    set CLK_PERIOD 10.0
    set IN_DELAY 0.6
    set CLK_LATENCY 0.2
    set OUT_DELAY 0.0

    create_clock -name clk -period ${CLK_PERIOD} [get_ports clk]
    set_clock_latency -source ${CLK_LATENCY} [get_clocks clk]
    set_input_delay ${IN_DELAY} -clock clk [remove_from_collection [all_inputs] [get_ports clk]]
    set_output_delay ${OUT_DELAY} -clock clk [all_outputs]

    # Switching activity for power analysis
    if {[catch {set_switching_activity -static_probability 0.5 -toggle_rate 0.2 [all_inputs]} msg]} {
        puts "  WARNING: set_switching_activity failed: ${msg}"
    }

    # Synthesize
    compile -ungroup_all

    # Generate reports
    report_timing -delay_type max > ${REPORTS_DIR}/${design_name}_timing_max.rpt
    report_timing -delay_type min > ${REPORTS_DIR}/${design_name}_timing_min.rpt
    report_area > ${REPORTS_DIR}/${design_name}_area.rpt
    report_qor > ${REPORTS_DIR}/${design_name}_qor.rpt
    report_reference > ${REPORTS_DIR}/${design_name}_cells.rpt
    report_timing -delay_type max -max_paths 10 -nworst 10 -from [all_inputs] -to [all_outputs] > ${REPORTS_DIR}/${design_name}_timing.rpt
    report_power -analysis_effort high > ${REPORTS_DIR}/${design_name}_power.rpt

    # Write netlist
    write -f verilog -hierarchy -output ${NETLISTS_DIR}/${design_name}_netlist.v
    write -f ddc -hierarchy -output ${NETLISTS_DIR}/${design_name}.ddc

    puts "  Reports written to: ${REPORTS_DIR}/${design_name}_*.rpt"
    puts "  Netlist written to: ${NETLISTS_DIR}/${design_name}_netlist.v"
    puts ""
}

# ============================================================
# Main execution
# ============================================================

puts "============================================================"
puts "ECE 527 Project 2 - Task C - DC Synthesis Master Script"
puts "DC Version: X-2025.06-SP4"
puts "============================================================"
puts ""

# Verify RTL files exist
set rtl_files {full_adder.sv rca.sv csa.sv array_multiplier.sv wallace_multiplier.sv}
foreach f ${rtl_files} {
    set fpath "${LAB_ROOT}/rtl/${f}"
    if [file exists ${fpath}] {
        puts "  OK: ${f}"
    } else {
        puts "  ERROR: Missing: ${fpath}"
        exit 1
    }
}
puts ""

# Synthesize array_multiplier
synthesize_design array_multiplier {full_adder.sv rca.sv csa.sv array_multiplier.sv}

# Synthesize wallace_multiplier
synthesize_design wallace_multiplier {full_adder.sv rca.sv csa.sv wallace_multiplier.sv}

puts "============================================================"
puts "Task C DC Synthesis Complete!"
puts "Reports: ${REPORTS_DIR}/"
puts "Netlists: ${NETLISTS_DIR}/"
puts "============================================================"

exit
