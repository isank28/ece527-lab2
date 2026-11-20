# JasperGold Formal Verification Tcl Script
# Design: csa
# Task: TaskD

set_project "/Users/victor/ece527/lab2/TaskD/jasper_csa"

# Read RTL with inline SVA assertions
read_file -rtl "/Users/victor/ece527/lab2/TaskD/rtl/csa.sv"

# Set top module
set_top "csa"

# Prove all assertions
prove -all

# Generate formal report
report -assertions -file "/Users/victor/ece527/lab2/TaskD/jasper_csa/reports/formal_report.txt"

puts "Formal verification complete."
puts "Report: /Users/victor/ece527/lab2/TaskD/jasper_csa/reports/formal_report.txt"
