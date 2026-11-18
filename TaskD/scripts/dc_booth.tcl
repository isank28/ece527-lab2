# ============================================================
# ECE 527 Project 2 - Task D
# Design Compiler script: 8x8 Booth-2 signed multiplier
#
# Run from TaskD/:
#     dc_shell -f scripts/dc_booth.tcl
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

# Read RTL: reuse structural cells from Task C plus Booth-specific files.
foreach f {csa.sv booth2_recode.sv booth_multiplier.sv} {
    read_file -format sverilog $ROOT/rtl/$f
}

current_design booth_multiplier
link
check_design

# --- Constraints -------------------------------------------------
# Combinational design: constrain all input-to-output paths loosely
# so the reported arrival time is the intrinsic worst-case delay.
set_max_delay 100 -from [all_inputs] -to [all_outputs]
set_load 0.5 [all_outputs]

if {[catch {set_switching_activity -static_probability 0.5 -toggle_rate 0.2 [all_inputs]} msg]} {
    puts "WARNING: set_switching_activity failed: $msg"
    puts "         report_power will use DC default switching activity."
}

# --- Synthesis ---------------------------------------------------
compile -map_effort high

# --- Reports -----------------------------------------------------
redirect $ROOT/reports/booth_area.rpt      { report_area }
redirect $ROOT/reports/booth_qor.rpt       { report_qor }
redirect $ROOT/reports/booth_reference.rpt { report_reference }
redirect $ROOT/reports/booth_timing.rpt    { report_timing -delay_type max -max_paths 10 -nworst 10 -from [all_inputs] -to [all_outputs] }
redirect $ROOT/reports/booth_power.rpt     { report_power -analysis_effort high }

# --- Outputs -----------------------------------------------------
write -format verilog -hierarchy -output $ROOT/netlists/booth_multiplier.v
write -format ddc     -hierarchy -output $ROOT/netlists/booth_multiplier.ddc

exit
