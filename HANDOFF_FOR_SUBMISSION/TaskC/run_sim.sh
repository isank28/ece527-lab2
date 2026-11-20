#!/bin/bash
# Run the exhaustive common testbench with iverilog or VCS if available.
set -e
cd "$(dirname "$0")"

mkdir -p sim

if command -v iverilog >/dev/null 2>&1; then
    iverilog -g2012 -o sim/multiplier_tb.vvp rtl/*.sv tb/multiplier_tb.sv
    vvp sim/multiplier_tb.vvp
elif command -v vcs >/dev/null 2>&1; then
    vcs -sverilog -full64 rtl/*.sv tb/multiplier_tb.sv -o sim/multiplier_tb
    ./sim/multiplier_tb
else
    echo "ERROR: no supported simulator found (iverilog or VCS)."
    echo "Compile rtl/*.sv and tb/multiplier_tb.sv with your simulator manually."
    exit 1
fi
