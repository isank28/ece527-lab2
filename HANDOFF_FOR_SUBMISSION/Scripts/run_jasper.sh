#!/bin/bash
# ============================================================================
# JasperGold Formal Verification Setup — ECE 527 Project 2 (Task C & Task D)
#
# Runs formal property verification on the labeled SVA assertions in:
#   TaskC/rtl/array_multiplier.sv
#   TaskC/rtl/wallace_multiplier.sv
#   TaskD/rtl/booth_multiplier.sv
#   TaskD/rtl/csa.sv
#   TaskD/rtl/booth2_recode.sv
#
# Usage:
#   cd /Users/victor/ece527/lab2
#   ./run_jasper.sh <task> <design>
#
# Example:
#   ./run_jasper.sh taskc array_multiplier
#   ./run_jasper.sh taskd booth_multiplier
# ============================================================================

set -e

LAB_ROOT="$(cd "$(dirname "$0")" && pwd)"
TASK=$1
DESIGN=$2

if [ -z "$TASK" ] || [ -z "$DESIGN" ]; then
    echo "Usage: $0 <taskc|taskd> <design_name>"
    echo "  e.g. $0 taskc array_multiplier"
    echo "       $0 taskd booth_multiplier"
    exit 1
fi

# Map task to directory and design file
case $TASK in
    taskc)
        TASK_DIR="$LAB_ROOT/TaskC"
        ;;
    taskd)
        TASK_DIR="$LAB_ROOT/TaskD"
        ;;
    *)
        echo "Unknown task: $TASK (use taskc or taskd)"
        exit 1
        ;;
esac

RTL_FILE="$TASK_DIR/rtl/${DESIGN}.sv"
if [ ! -f "$RTL_FILE" ]; then
    echo "ERROR: RTL file not found: $RTL_FILE"
    exit 1
fi

# JasperGold project directory
JASPER_PROJ="$TASK_DIR/jasper_${DESIGN}"

echo "============================================================"
echo "JasperGold Formal Verification"
echo "  Task   : $TASK"
echo "  Design : $DESIGN"
echo "  RTL    : $RTL_FILE"
echo "  Project: $JASPER_PROJ"
echo "============================================================"

# Create JasperGold project
jgsetup -project "$JASPER_PROJ" -rtl "$RTL_FILE" -top "$DESIGN"

# Add assertion file (the SVA assertions are inline in the RTL, so no separate file needed)
# But we can create a constraints/fmodel file if needed:
cat > "$TASK_DIR/jasper_constraints.sv" <<'JASPER_CONSTRAINTS`
`timescale 1ns/1ps
`default_nettype none

// Formal constraints for combinational multipliers
module jasper_constraints #(
    parameter int N = 8
) (
    input  logic [N-1:0] a,
    input  logic [N-1:0] b
);

    // Assume inputs are stable (no X/Z) during formal analysis
    assume input_valid : !$isunknown(a) && !$isunknown(b);

endmodule
JASPER_CONSTRAINTS

# Write a JasperGold Tcl script for running proof
cat > "$TASK_DIR/run_jasper.tcl" <<JASPER_TCL
# JasperGold Tcl script for formal verification
set_project "$JASPER_PROJ"

# Read the RTL with assertions
read_file -rtl "$RTL_FILE"

# Set the top module
set_top "$DESIGN"

# Run formal proof on all assertions
prove -all

# Report results
report -assertions -file "${JASPER_PROJ}/reports/formal_report.txt"

echo "Formal verification complete. See ${JASPER_PROJ}/reports/formal_report.txt"
JASPER_TCL

echo ""
echo "JasperGold project created at: $JASPER_PROJ"
echo ""
echo "To run formal verification:"
echo "  cd $JASPER_PROJ"
echo "  jg -t run_jasper.tcl"
echo ""
echo "Or run directly:"
echo "  jgsetup -project $JASPER_PROJ -rtl $RTL_FILE -top $DESIGN && jg -prove -all"
echo ""
echo "Assertions checked:"
grep -n "assert " "$RTL_FILE" || true
echo ""
echo "Note: The labeled assertions (e.g., output_range, coef_valid,"
echo "functional_correct) will appear as individual checkable properties"
echo "in JasperGold's GUI and Tcl interface."
