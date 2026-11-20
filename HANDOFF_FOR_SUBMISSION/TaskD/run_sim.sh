#!/bin/bash
# Run the exhaustive Booth-2 multiplier testbench with iverilog or VCS.
set -e
cd "$(dirname "$0")"

mkdir -p sim

if command -v iverilog >/dev/null 2>&1; then
    iverilog -g2012 -o sim/booth_tb.vvp rtl/csa.sv rtl/booth2_recode.sv rtl/booth_multiplier.sv tb/booth_tb.sv
    vvp sim/booth_tb.vvp
elif command -v vcs >/dev/null 2>&1; then
    vcs -sverilog -full64 rtl/csa.sv rtl/booth2_recode.sv rtl/booth_multiplier.sv tb/booth_tb.sv -o sim/booth_tb
    ./sim/booth_tb
else
    echo "ERROR: no supported simulator found (iverilog or VCS)."
    echo "Compile rtl/*.sv and tb/booth_tb.sv with your simulator manually."
    exit 1
fi
