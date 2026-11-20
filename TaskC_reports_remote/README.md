# Task C — Wallace Tree vs. Array Multiplier

8×8 unsigned multiplier comparison for ECE 527 Project 2.

**Verification status:** the common testbench passes locally with Icarus Verilog
13.0 for all 65,536 input combinations. DC synthesis still needs to be run on
the VLSI lab machine (`./run_dc.sh`) to fill in the comparison table.

## Files

```
TaskC/
├── rtl/
│   ├── full_adder.sv          # gate-level full adder
│   ├── rca.sv                 # ripple-carry adder (used by array multiplier)
│   ├── csa.sv                 # 3:2 carry-save adder (used by Wallace tree)
│   ├── array_multiplier.sv    # 8x8 array multiplier, RCA row accumulation
│   └── wallace_multiplier.sv  # 8x8 Wallace tree, CSA reduction + final CPA
├── tb/
│   └── multiplier_tb.sv       # common exhaustive self-checking testbench
├── scripts/
│   ├── dc_array.tcl           # DC synthesis + reports for array multiplier
│   └── dc_wallace.tcl         # DC synthesis + reports for Wallace multiplier
├── lib/
│   └── gscl45nm.db            # technology library
├── run_sim.sh                 # simulate with iverilog or VCS
├── run_dc.sh                  # run both DC syntheses
├── reports/                   # generated DC reports
├── netlists/                  # generated gate-level netlists
└── logs/                      # generated DC console logs
```

## 1. Verify functionality

```bash
./run_sim.sh
```

Expected final line:

```
PASS: both multipliers matched all 65,536 input combinations.
```

Manual equivalent:

```bash
iverilog -g2012 -o sim/multiplier_tb.vvp rtl/*.sv tb/multiplier_tb.sv
vvp sim/multiplier_tb.vvp
```

## 2. Synthesize with Design Compiler

On the VLSI lab machine:

```bash
addpkg          # select Synopsys Design Compiler
./run_dc.sh
```

or run the scripts separately:

```bash
dc_shell -f scripts/dc_array.tcl
dc_shell -f scripts/dc_wallace.tcl
```

Both scripts use the same constraints:

- `set_max_delay 100` from all inputs to all outputs (loose constraint; the reported arrival time is the intrinsic worst-case delay)
- `set_load 0.5` on all outputs (same value used in the course getting-started script; keep it identical for both designs)
- input switching activity: static probability `0.5`, toggle rate `0.2`
- `compile -map_effort high`

Keeping these identical is what makes the area/delay/power comparison meaningful.

## 3. Extract the comparison metrics

| Metric | Where to find it |
|---|---|
| Total cells | `reports/*_qor.rpt` → “Number of cells”, or `*_reference.rpt` total |
| Cell area | `reports/*_qor.rpt` → “Total cell area”, or `*_area.rpt` |
| Max delay | `reports/*_timing.rpt` → data arrival time of the worst path |
| Dynamic power | `reports/*_power.rpt` → “Total Dynamic Power” |

Fill in:

| Metric | Array Multiplier | Wallace Tree |
|---|---|---|
| Total cells | | |
| Cell area | | |
| Max delay | | |
| Power | | |

## 4. Discussion points for the report

- **Structure:** the array multiplier adds one partial-product row at a time with a 16-bit ripple-carry adder, so the carry chain is traversed once per row. The Wallace tree reduces all eight partial-product rows with a balanced 3:2 CSA tree, then performs one final carry-propagate addition.
- **Speed:** the array critical path is approximately `7 rows × 7-bit effective carry chains`; the Wallace critical path is up to `4 CSA stages + one 16-bit final CPA` (six CSA instances in total). The CSA tree is shallower, so Wallace should have the smaller max delay.
- **Area:** the Wallace tree uses more CSA hardware and an irregular reduction network, while the array multiplier is regular and reuses identical rows. The array multiplier is therefore usually smaller.
- **Power:** dynamic power follows switched capacitance and activity. The array’s regular, smaller structure often has lower dynamic power, while the Wallace tree’s extra CSA gates and final adder increase switching capacitance. Report the actual values from `report_power`.
- **Limitations of this comparison:** the Wallace implementation uses a row-based balanced CSA tree and a ripple-carry final adder. A column-optimized Wallace tree and a faster final CPA (CLA or carry-select) would reduce the Wallace delay further at the cost of more area.

## 5. Notes

- `array_multiplier` and `wallace_multiplier` are combinational; no clock constraint is needed. Task C only requires DC synthesis metrics, not PT/STA.
- The Wallace tree is written for `N = 8` (eight partial-product rows). The array multiplier is parameterized but the task only requires 8×8.
- The generated `.ddc` and gate-level `.v` files can be used for further inspection or imported into PrimeTime if desired.
