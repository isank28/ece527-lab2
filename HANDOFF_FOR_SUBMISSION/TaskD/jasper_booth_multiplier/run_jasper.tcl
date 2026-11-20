# JasperGold Formal Verification Tcl Script
# Design: booth_multiplier
# Task: TaskD

set_project "/Users/victor/ece527/lab2/TaskD/jasper_booth_multiplier"

# Read RTL with inline SVA assertions
read_file -rtl "/Users/victor/ece527/lab2/TaskD/rtl/booth_multiplier.sv"

# Set top module
set_top "booth_multiplier"

# Prove all assertions
prove -all

# Generate formal report
report -assertions -file "/Users/victor/ece527/lab2/TaskD/jasper_booth_multiplier/reports/formal_report.txt"

puts "Formal verification complete."
puts "Report: /Users/victor/ece527/lab2/TaskD/jasper_booth_multiplier/reports/formal_report.txt"
