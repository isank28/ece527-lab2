# JasperGold Formal Verification Tcl Script
# Design: array_multiplier
# Task: TaskC

set_project "/Users/victor/ece527/lab2/TaskC/jasper_array_multiplier"

# Read RTL with inline SVA assertions
read_file -rtl "/Users/victor/ece527/lab2/TaskC/rtl/array_multiplier.sv"

# Set top module
set_top "array_multiplier"

# Prove all assertions
prove -all

# Generate formal report
report -assertions -file "/Users/victor/ece527/lab2/TaskC/jasper_array_multiplier/reports/formal_report.txt"

puts "Formal verification complete."
puts "Report: /Users/victor/ece527/lab2/TaskC/jasper_array_multiplier/reports/formal_report.txt"
