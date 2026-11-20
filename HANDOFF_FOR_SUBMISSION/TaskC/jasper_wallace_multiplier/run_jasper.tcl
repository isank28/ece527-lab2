# JasperGold Formal Verification Tcl Script
# Design: wallace_multiplier
# Task: TaskC

set_project "/Users/victor/ece527/lab2/TaskC/jasper_wallace_multiplier"

# Read RTL with inline SVA assertions
read_file -rtl "/Users/victor/ece527/lab2/TaskC/rtl/wallace_multiplier.sv"

# Set top module
set_top "wallace_multiplier"

# Prove all assertions
prove -all

# Generate formal report
report -assertions -file "/Users/victor/ece527/lab2/TaskC/jasper_wallace_multiplier/reports/formal_report.txt"

puts "Formal verification complete."
puts "Report: /Users/victor/ece527/lab2/TaskC/jasper_wallace_multiplier/reports/formal_report.txt"
