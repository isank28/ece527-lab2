# ECE 527 — Project 2 (PR_2) — Task C & Task D

Personal execution guide for Victor.

---

## Overview

This repository contains my work for **Task C** (Wallace Tree vs. Array Multiplier) and **Task D** (Booth-Encoded Multiplier) of ECE 527 Project 2.

- **Task C**: Design and compare two 8×8 unsigned multipliers — an array multiplier (ripple-carry row accumulation) and a Wallace-tree multiplier (CSA-based partial product reduction).
- **Task D**: Design an 8×8 signed multiplier using modified Booth-2 (radix-4) encoding, and compare it against the Task C array multiplier.

Directory layout:

```
lab2/
├── README.md                      # this file
├── C_2026_04_527_PR_2.pdf         # original project handout
├── verify_agent.py                # RTL verification agent (sim + formal)
├── verify_taskc.py                # legacy verification script (superseded by verify_agent.py)
├── parse_reports.py               # parses DC reports -> comparison table
├── run_jasper.sh                  # generates JasperGold formal verification projects
├── VERIFICATION_PLAN.md           # verification plan (levels, exit criteria)
├── FORMAL_VERIFICATION.md         # JasperGold SVA assertion guide
├── TaskC/                         # Task C files
│   ├── rtl/
│   │   ├── full_adder.sv
│   │   ├── rca.sv
│   │   ├── csa.sv
│   │   ├── array_multiplier.sv
│   │   └── wallace_multiplier.sv
│   ├── tb/
│   │   └── multiplier_tb.sv
│   ├── scripts/
│   │   ├── dc_array.tcl
│   │   └── dc_wallace.tcl
│   ├── lib/
│   │   └── gscl45nm.db
│   ├── sim/                       # generated simulation output (includes rtl_stripped/)
│   ├── reports/                   # generated DC reports
│   ├── netlists/                  # generated DC netlists
│   ├── logs/                      # generated DC logs
│   ├── dse/                       # Design Space Exploration (sweep N=4,8,16,32)
│   │   ├── dse_sweep.py           # DSE script: RTL gen + DC scripts + parse + plot
│   │   ├── rtl/                   # generated parameterized RTL per N
│   │   ├── scripts/               # generated DC TCL per (arch, N)
│   │   ├── reports/               # generated DC reports per (arch, N)
│   │   ├── netlists/              # generated netlists per (arch, N)
│   │   ├── logs/                  # DC console logs
│   │   ├── plots/                 # generated PNG plots
│   │   └── results.csv            # parsed metrics
│   ├── jasper_*                   # generated JasperGold formal projects
│   ├── run_sim.sh
│   ├── run_dc.sh
│   ├── README.md
│   └── TaskC_report.md
├── TaskD/                         # Task D files
│   ├── rtl/
│   │   ├── csa.sv
│   │   ├── booth2_recode.sv
│   │   └── booth_multiplier.sv
│   ├── tb/
│   │   └── booth_tb.sv
│   ├── scripts/
│   │   └── dc_booth.tcl
│   ├── lib/
│   │   └── gscl45nm.db
│   ├── sim/
│   ├── reports/
│   ├── netlists/
│   ├── logs/
│   ├── jasper_*                   # generated JasperGold formal projects
│   ├── run_sim.sh
│   ├── run_dc.sh
│   ├── README.md
│   └── TaskD_report.md
├── TaskE/                         # Task E files (Newton-Raphson Divider Error Analysis)
│   ├── derivation/
│   │   └── derivation.md          # Error recurrence derivation, quadratic proof, iteration table
│   ├── computation/
│   │   ├── nr_analysis.py         # Python script: compute iterations + generate plots
│   │   └── results.csv            # Computed results
│   ├── plots/                     # Generated convergence plots (PNG)
│   ├── report/                    # Place for your written report section
│   └── README.md                  # Task E specific instructions
├── Starting guide/                # course getting-started guide + library
└── DC_Tutorial1/                  # course DC tutorials
```

---

## Prerequisites

| Tool | Needed for | How to get it |
|------|-----------|---------------|
| **Icarus Verilog** (`iverilog`) | Local RTL simulation | `brew install icarus-verilog` (already installed on this Mac) |
| **Synopsys Design Compiler** (`dc_shell`) | Synthesis & reports | VLSI lab machine: run `addpkg`, select Synopsys DC |
| **Python 3** | Verification agent + report parser | Built-in on macOS |
| **gscl45nm.db** | DC target/link library | Copied into `TaskC/lib/` and `TaskD/lib/` from `Starting guide/` |

---

## Step-by-Step Execution

### Step 0: Confirm simulator is installed

```bash
cd /Users/victor/ece527/lab2
iverilog -V
```

You should see version output (e.g. Icarus Verilog 13.0). If not, install it:

```bash
brew install icarus-verilog
```

---

### Step 1: Verify Task C RTL (Array + Wallace multipliers)

Run the exhaustive common testbench locally:

```bash
cd /Users/victor/ece527/lab2/TaskC
./run_sim.sh
```

Expected output:

```
Starting exhaustive 8x8 multiplier test...
PASS: both multipliers matched all 65,536 input combinations.
```

Or use the verification agent from the lab2 root:

```bash
cd /Users/victor/ece527/lab2
python3 verify_taskc.py --task c
```

**What this does:** Exhaustively tests all 256 × 256 = 65,536 input combinations for both multipliers against `a * b`.

---

### Step 2: Verify Task D RTL (Booth-2 signed multiplier)

```bash
cd /Users/victor/ece527/lab2/TaskD
./run_sim.sh
```

Expected output:

```
Starting 8x8 signed Booth-2 multiplier test...
Covering all 65,536 signed operand combinations.
PASS: Booth-2 multiplier matched all 65,536 signed combinations.
```

Or:

```bash
cd /Users/victor/ece527/lab2
python3 verify_taskc.py --task d
```

**What this does:** Exhaustively tests all signed `a, b ∈ [-128, 127]` (65,536 cases) against `a * b`.

---

### Step 3: Synthesize with Design Compiler (VLSI lab machine only)

DC is **not** available on this Mac. You must run these on the VLSI lab computer:

```bash
# Task C
cd /Users/victor/ece527/lab2/TaskC
addpkg                # select Synopsys Design Compiler
./run_dc.sh

# Task D
cd /Users/victor/ece527/lab2/TaskD
./run_dc.sh
```

What `run_dc.sh` does:
1. Reads the RTL into DC.
2. Links to `gscl45nm.db`.
3. Applies constraints (`set_max_delay`, `set_load`, switching activity).
4. Runs `compile -map_effort high`.
5. Generates reports in `reports/` and netlists in `netlists/`.

---

### Step 4: Parse DC reports into a comparison table

Back on this Mac (or anywhere Python 3 is available), copy the `reports/` folders from the lab machine, then:

```bash
cd /Users/victor/ece527/lab2
python3 parse_reports.py
```

This prints tables for:

- Task C: Array Multiplier vs Wallace Tree
- Task D: Booth-2 Multiplier
- Task D side-by-side: Array (Task C) vs Booth-2 (Task D)

Metrics extracted:
- **Total cells** — from `*_qor.rpt` (`Number of cells`)
- **Cell area** — from `*_qor.rpt` (`Total cell area`)
- **Max delay** — from `*_timing.rpt` (worst `Data arrival time`)
- **Dynamic power** — from `*_power.rpt` (`Total Dynamic Power`)

If reports are missing, it prints `N/A` placeholders.

---

### Step 5: Fill in the report tables

Edit these files with the numbers from Step 4:

- `TaskC/TaskC_report.md` — Task C results + discussion
- `TaskD/TaskD_report.md` — Task D results + comparison with Task C

Example table to complete:

| Metric | Array Multiplier | Wallace Tree |
|---|---|---|
| Total cells | | |
| Cell area | | |
| Max delay | | |
| Dynamic power | | |

---

## Key Details You Asked About

### What to include in "Total # of cells"
Count of library cells (gates) instantiated in the synthesized netlist — from `reports/*_qor.rpt` → "Number of cells", or sum instances in `reports/*_reference.rpt`. Include every gate (AND, OR, XOR, MUX, FA, CSA). Exclude the top-level wrapper and I/O ports. Multipliers are purely combinational, so there are no flip-flops.

### How to calculate Max Delay
It is **not** setup time — setup time is a flip-flop parameter and does not apply to combinational multipliers.

**Max delay = worst-case input-to-output propagation delay** (critical path delay).

**Where to look:** `reports/*_timing.rpt` from `report_timing -delay_type max -from [all_inputs] -to [all_outputs]`. Find the path with the largest **data arrival time** — that's your max delay / critical path. Because the scripts set `set_max_delay 100`, slack = 100 − data arrival time; the path with the smallest slack is your critical path.

---

## Verification Flows

Two flows are supported: **Simulation** (iverilog/VCS) and **Formal** (JasperGold).

### Simulation Flow

```bash
cd /Users/victor/ece527/lab2

# Verify Task C (array + Wallace multipliers)
python3 verify_agent.py --task c

# Verify Task D (Booth-2 signed multiplier)
python3 verify_agent.py --task d

# Verify both
python3 verify_agent.py --task all
```

What it does:
1. Strips labeled SVA assertions (iverilog doesn't support them)
2. Compiles RTL + testbench
3. Runs exhaustive simulation (65,536 input combinations)
4. Cross-checks against an independent Python golden model
5. Prints `VERDICT: PASS/FAIL`

Results are also written to `verification_report.json`.

### Formal Flow (JasperGold)

All RTL files contain labeled SVA assertions for formal verification:

```bash
cd /Users/victor/ece527/lab2

# Generate JasperGold projects for all designs
python3 verify_agent.py --formal --task all
```

This creates:
- `TaskC/jasper_array_multiplier/`
- `TaskC/jasper_wallace_multiplier/`
- `TaskD/jasper_booth_multiplier/`
- `TaskD/jasper_csa/`
- `TaskD/jasper_booth2_recode/`

Each project contains `run_jasper.tcl`. On the lab machine with JasperGold:

```bash
cd TaskD/jasper_booth_multiplier
jg -t run_jasper.tcl
```

Key formal assertions:
- **`functional_correct`** (booth_multiplier): `p == $signed(a) * $signed(b)` — proves mathematical correctness for all inputs
- **`coef_valid`**: Booth recoder output is always a valid coefficient
- **`output_range`**: Output stays within valid range
- **`outputs_valid` / `no_x_propagation`**: No X/Z propagation

See `FORMAL_VERIFICATION.md` for details.

---

## Design Space Exploration (Task C)

The DSE script sweeps bit-width N = {4, 8, 16, 32} for both Array and Wallace-tree
multipliers, synthesizes each with Design Compiler, parses area/delay/power, and
plots delay vs. area to show the crossover point.

### Run the DSE (model mode — no DC needed)

```bash
cd /Users/victor/ece527/lab2/TaskC/dse

# With matplotlib (for plots):
/tmp/dsevenv/bin/python3 dse_sweep.py --mode model

# Without matplotlib (CSV only):
python3 dse_sweep.py --mode model --no-plot
```

### Run the DSE with DC (VLSI lab machine only)

```bash
cd /Users/victor/ece527/lab2/TaskC/dse
addpkg                # select Synopsys Design Compiler
python3 dse_sweep.py --mode dc
```

### Outputs

| Output | Description |
|--------|-------------|
| `dse/rtl/array_NxN.sv` | Generated array multiplier RTL for each N |
| `dse/rtl/wallace_NxN.sv` | Generated Wallace-tree multiplier RTL for each N |
| `dse/scripts/dc_*_*.tcl` | DC TCL script per (architecture, N) |
| `dse/reports/*_qor.rpt` | DC QoR reports (cells, area) |
| `dse/reports/*_timing.rpt` | DC timing reports (max delay) |
| `dse/reports/*_power.rpt` | DC power reports (dynamic power) |
| `dse/results.csv` | Parsed metrics CSV |
| `dse/plots/delay_vs_N.png` | Delay vs bit-width plot |
| `dse/plots/area_vs_N.png` | Area vs bit-width plot |
| `dse/plots/delay_vs_area.png` | Delay vs area (crossover) plot |

### Crossover Analysis

The analytical model predicts Wallace becomes faster than Array at **N = 8**:
- At N=4: Array is slightly faster (less Wallace overhead)
- At N=8+: Wallace's logarithmic-depth CSA tree beats Array's linear ripple chain
- At N=32: Wallace delay is ~0.6 ns vs Array ~1.6 ns (~2.7× faster)

This is the key insight for Task C: **Wallace wins on speed for wider multipliers, Array wins on area/power for narrow ones.**

---

## Task E Execution (Newton-Raphson Divider Error Analysis)

Task E is a mathematical analysis task — no RTL, no synthesis, no timing analysis.

```bash
cd /Users/victor/ece527/lab2/TaskE/computation

# With matplotlib (generates plots):
/tmp/dsevenv/bin/python3 nr_analysis.py

# Without matplotlib (CSV only):
python3 nr_analysis.py --no-plot
```

This computes the minimum iterations for each initial estimate (ε₀ = 0.5, 0.1, 0.01) to reach 2⁻¹⁶ precision and generates convergence plots in `TaskE/plots/`.

Results are saved to `TaskE/computation/results.csv`.

The full derivation (error recurrence, quadratic convergence proof, iteration table, discussion) is in `TaskE/derivation/derivation.md`.

---

## Useful Commands Cheat Sheet

```bash
# From lab2 root
cd /Users/victor/ece527/lab2

# Simulation verification
python3 verify_agent.py --task c
python3 verify_agent.py --task d
python3 verify_agent.py --task all

# Formal verification project generation (JasperGold)
python3 verify_agent.py --formal --task all

# Parse DC reports (after running DC on lab machine)
python3 parse_reports.py

# From TaskC directory
cd TaskC
./run_sim.sh          # local simulation
./run_dc.sh           # DC synthesis (lab machine only)

# From TaskD directory
cd TaskD
./run_sim.sh          # local simulation
./run_dc.sh           # DC synthesis (lab machine only)
```

---

## Files I Created

| File | Purpose |
|------|---------|
| `verify_agent.py` | RTL verification agent — simulation + JasperGold formal project generation |
| `verify_taskc.py` | Legacy verification script (superseded by verify_agent.py) |
| `parse_reports.py` | Parses DC `reports/*.rpt` → comparison table |
| `run_jasper.sh` | Generates JasperGold formal verification projects |
| `TaskC/dse/dse_sweep.py` | Design Space Exploration: sweep N=4,8,16,32, generate RTL+DC scripts, parse reports, plot |
| `VERIFICATION_PLAN.md` | Verification plan (levels, exit criteria, methodology) |
| `FORMAL_VERIFICATION.md` | JasperGold SVA assertion guide and formal flow |
| `TaskC/rtl/*.sv` | Array + Wallace multiplier RTL |
| `TaskC/tb/multiplier_tb.sv` | Exhaustive common testbench |
| `TaskC/scripts/dc_*.tcl` | DC synthesis scripts |
| `TaskD/rtl/*.sv` | Booth-2 multiplier RTL |
| `TaskD/tb/booth_tb.sv` | Exhaustive signed testbench |
| `TaskD/scripts/dc_booth.tcl` | DC synthesis script |
| `TaskC/README.md`, `TaskD/README.md` | Task-specific details |
| `TaskC/TaskC_report.md`, `TaskD/TaskD_report.md` | Report skeletons to fill in |

---

## Notes

- The `iverilog "sorry: constant selects"` messages during compilation are **benign warnings**, not errors — simulation still runs correctly.
- DC must be run on the VLSI lab machine (licensed tool). This Mac only has Icarus Verilog for simulation.
- Both Task C and Task D RTL have been independently verified against a Python golden model over all 65,536 input combinations — **VERDICT: PASS**.
