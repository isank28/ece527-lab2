# JasperGold Formal Verification Tcl Script
# Design: booth2_recode
# Task: TaskD

set_project "/Users/victor/ece527/lab2/TaskD/jasper_booth2_recode"

# Read RTL with inline SVA assertions
read_file -rtl "/Users/victor/ece527/lab2/TaskD/rtl/booth2_recode.sv"

# Set top module
set_top "booth2_recode"

# Prove all assertions
prove -all

# Generate formal report
report -assertions -file "/Users/victor/ece527/lab2/TaskD/jasper_booth2_recode/reports/formal_report.txt"

puts "Formal verification complete."
puts "Report: /Users/victor/ece527/lab2/TaskD/jasper_booth2_recode/reports/formal_report.txt"
