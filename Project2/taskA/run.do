# ECE 527 PR_2 Task A - Questa simulation script
# GUI:    vsim -do run.do
# Batch:  vsim -c -do "do run.do; quit -f"

vlib work
vdel -all
vlib work

# ----------------------------
# Step 1: Compile shared building block (2-bit full adder)
# ----------------------------
vlog -sv -cover bcst +incdir+. fa2.sv

# ----------------------------
# Step 2: Compile DUTs (Fig 1 ripple-carry, Fig 2 carry-select)
# ----------------------------
vlog -sv -cover bcst +incdir+. rca4_pipe.sv
vlog -sv -cover bcst +incdir+. csa4_pipe.sv

# ----------------------------
# Step 3: Compile common testbench (TEST_CSA enables the Fig 2 checks)
# ----------------------------
vlog -sv +incdir+. +define+TEST_CSA tb_adders.sv

# ----------------------------
# Step 4: Optimize + simulate with coverage
# ----------------------------
vopt tb_adders -o top_opt +acc

vsim top_opt -coverage -nolog -onfinish stop

run -all
