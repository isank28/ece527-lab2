# ECE 527 PR_2 Task B - Questa simulation script
# GUI:    vsim -do run.do
# Batch:  vsim -c -do "do run.do; quit -f"

vlib work
vdel -all
vlib work

# ----------------------------
# Step 1: Compile shared building block (2-bit full adder, used by csa8_pipe)
# ----------------------------
vlog -sv -cover bcst +incdir+. fa2.sv

# ----------------------------
# Step 2: Compile DUTs (Part 1 Sklansky prefix, Part 2 carry-select)
# ----------------------------
vlog -sv -cover bcst +incdir+. prefix8_pipe.sv
vlog -sv -cover bcst +incdir+. csa8_pipe.sv

# ----------------------------
# Step 3: Compile common testbench (TEST_CSA8 enables the Part 2 checks)
# ----------------------------
vlog -sv +incdir+. +define+TEST_CSA8 tb_taskB.sv

# ----------------------------
# Step 4: Optimize + simulate with coverage
# ----------------------------
vopt tb_taskB -o top_opt +acc

vsim top_opt -coverage -nolog -onfinish stop

run -all
