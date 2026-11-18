# ============================================================
# ECE 527 Project 2 - Task C
# Design Compiler script: 8x8 array multiplier
#
# Run from TaskC/:
#     dc_shell -f scripts/dc_array.tcl
# ============================================================

set SCRIPT_DIR [file dirname [info script]]
if {$SCRIPT_DIR eq "" || $SCRIPT_DIR eq "."} {
    set ROOT [pwd]
} else {
    set ROOT [file normalize [file join $SCRIPT_DIR ..]]
}

set LIB $ROOT/lib/gscl45nm.db

file mkdir $ROOT/reports
file mkdir $ROOT/netlists
file mkdir $ROOT/logs

set_app_var search_path  [list $ROOT/rtl $ROOT/lib]
set_app_var target_library $LIB
set_app_var link_library   "* $LIB"

# Read all RTL; current_design below selects the top level.
foreach f {full_adder.sv rca.sv csa.sv array_multiplier.sv wallace_multiplier.sv} {
    read_file -format sverilog $ROOT/rtl/$f
}

current_design array_multiplier
link
check_design

# --- Constraints -------------------------------------------------
# This is a combinational design, so constrain every input-to-output
# path.  The 100 ns value is deliberately loose: we want the intrinsic
# delay from report_timing, not a hard speed target.
set_max_delay 100 -from [all_inputs] -to [all_outputs]
set_load 0.5 [all_outputs]

# Same activity assumptions for both multipliers so that the power
# numbers are directly comparable.  If the installed DC version does
# not support this command, fall back to DC's default activity.
if {[catch {set_switching_activity -static_probability 0.5 -toggle_rate 0.2 [all_inputs]} msg]} {
    puts "WARNING: set_switching_activity failed: $msg"
    puts "         report_power will use DC default switching activity."
}

# --- Synthesis ---------------------------------------------------
compile -map_effort high

# --- Reports -----------------------------------------------------
redirect $ROOT/reports/array_area.rpt      { report_area }
redirect $ROOT/reports/array_qor.rpt       { report_qor }
redirect $ROOT/reports/array_reference.rpt { report_reference }
redirect $ROOT/reports/array_timing.rpt    { report_timing -delay_type max -max_paths 10 -nworst 10 -from [all_inputs] -to [all_outputs] }
redirect $ROOT/reports/array_power.rpt     { report_power -analysis_effort high }

# --- Outputs -----------------------------------------------------
write -format verilog -hierarchy -output $ROOT/netlists/array_multiplier.v
write -format ddc     -hierarchy -output $ROOT/netlists/array_multiplier.ddc

exit
