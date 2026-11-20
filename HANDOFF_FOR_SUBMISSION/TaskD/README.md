# Task D — Booth-Encoded Multiplier (Booth-2 / Radix-4)

## Files

```
TaskD/
├── rtl/
│   ├── csa.sv               # 3:2 carry-save adder (from Task C)
│   ├── booth2_recode.sv     # radix-4 Booth recoder {-2,-1,0,+1,+2}
│   └── booth_multiplier.sv  # 8x8 signed Booth-2 multiplier top
├── tb/
│   └── booth_tb.sv          # exhaustive signed self-checking testbench
├── scripts/
│   └── dc_booth.tcl         # DC synthesis + reports
├── run_sim.sh               # simulate with iverilog or VCS
├── run_dc.sh                # run DC synthesis
├── lib/gscl45nm.db          # technology library
├── reports/                 # generated DC reports
├── netlists/                # generated gate-level netlist
└── logs/                    # DC console log
```

## 1. Design summary

- Multiplier operand `b` is recoded into 5 overlapping Booth-2 groups:
  `{b[1],b[0],0}`, `{b[3],b[2],b[1]}`, `{b[5],b[4],b[3]}`,
  `{b[7],b[6],b[5]}`, and `{0,b[7],b[6]}` (virtual sign bits).
- Each group yields a signed coefficient in {-2,-1,0,+1,+2}.
- The multiplicand `a` is sign-extended to 16 bits; each partial product
  is `coef × a_ext`, shifted left by `2*i`.
- Five partial products are reduced with a 3-stage CSA tree, then a final
  carry-propagate adder forms the 16-bit signed product.

## 2. Functional verification

Common self-checking testbench: `tb/booth_tb.sv`.

- Exhaustive test over all signed `a, b ∈ [-128, 127]` (65,536 cases).
- Compares RTL product against `a * b`.

Run locally:

```bash
cd /Users/victor/ece527/lab2/TaskD
./run_sim.sh
```

Expected:

```text
PASS: Booth-2 multiplier matched all 65,536 signed combinations.
```

## 3. Synthesis with Design Compiler

On the VLSI lab machine:

```bash
addpkg          # select Synopsys Design Compiler
cd TaskD
./run_dc.sh
```

Constraints (same style as Task C):
- `set_max_delay 100 -from [all_inputs] -to [all_outputs]`
- `set_load 0.5 [all_outputs]`
- input switching activity: static probability `0.5`, toggle rate `0.2`
- `compile -map_effort high`

## 4. Metrics to record

| Metric | Where to find it |
|---|---|
| Total cells | `reports/booth_qor.rpt` → "Number of cells", or `booth_reference.rpt` |
| Cell area | `reports/booth_qor.rpt` → "Total cell area", or `booth_area.rpt` |
| Max delay | `reports/booth_timing.rpt` → data arrival time of worst path |
| Dynamic power | `reports/booth_power.rpt` → "Total Dynamic Power" |

## 5. Comparison with Task C array multiplier

After synthesis, compare Booth-2 signed multiplier against the unsigned
8×8 array multiplier from Task C:

| Metric | Array Mult (Task C) | Booth-2 Signed Mult (Task D) |
|---|---|---|
| Total cells | | |
| Cell area | | |
| Max delay | | |
| Dynamic power | | |

Discussion points:
- Booth-2 halves the number of partial products (5 vs 8), reducing CSA tree height and often improving delay and area for signed multiplication.
- Booth encoding adds recode logic and sign handling (two's-complement negation), which adds a small amount of overhead compared with a plain unsigned array.
- For signed operands, Booth-2 avoids the sign-extension penalty of a naive signed array multiplier.
