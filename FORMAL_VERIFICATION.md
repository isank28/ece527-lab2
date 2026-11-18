# Formal Verification Guide — JasperGold + SVA Assertions

## Overview

All RTL files in Task C and Task D contain **labeled SystemVerilog Assertions (SVA)** that are compatible with JasperGold formal verification. Each assertion is a checkable property that JasperGold can prove or find counterexamples for.

## Assertions by Design

### Task C — Array Multiplier (`array_multiplier.sv`)

| Assertion | Property | What it proves |
|-----------|----------|----------------|
| `output_range` | `!$isunknown(p) |-> (p >= 0) && (p <= {2*N{1'b1}})` | Output is always a valid unsigned 16-bit value |
| `outputs_valid` | `!$isunknown(a) && !$isunknown(b) |-> !$isunknown(p)` | No X/Z on output when inputs are valid |
| `no_x_propagation` | `!$isunknown(a) && !$isunknown(b) |-> !$isunknown(p)` | X/Z never propagates from inputs to output |

### Task C — Wallace Multiplier (`wallace_multiplier.sv`)

| Assertion | Property |
|-----------|----------|
| `output_range` | Output is valid unsigned 16-bit |
| `outputs_valid` | No X/Z on output when inputs valid |
| `no_x_propagation` | X/Z never propagates |

### Task D — Booth Multiplier (`booth_multiplier.sv`)

| Assertion | Property | What it proves |
|-----------|----------|----------------|
| `coef_valid` | `coef[g] in {000,001,010,100,111}` | Each Booth recoder output is a valid coefficient |
| `output_range` | Signed 16-bit range check | Output fits in [-32768, 32767] |
| `outputs_valid` | No X/Z on output when inputs valid | |
| `functional_correct` | `p == $signed(a) * $signed(b)` | **Full functional correctness** vs golden model |

### Task D — CSA (`csa.sv`)

| Assertion | Property |
|-----------|----------|
| `outputs_valid` | No X/Z on sum/carry when inputs valid |

### Task D — Booth Recoder (`booth2_recode.sv`)

| Assertion | Property | What it proves |
|-----------|----------|----------------|
| `coef_valid` | Output in valid coefficient set | Recode output is always legal |
| `recode_mapping` | Full truth-table mapping | Each 3-bit input maps to correct coefficient |

---

## Running with JasperGold

### Quick Start

```bash
cd /Users/victor/ece527/lab2

# Task C — Array Multiplier
./run_jasper.sh taskc array_multiplier

# Task C — Wallace Multiplier
./run_jasper.sh taskc wallace_multiplier

# Task D — Booth Multiplier
./run_jasper.sh taskd booth_multiplier
```

### What `run_jasper.sh` does

1. Creates a JasperGold project in `Task*/jasper_<design>/`
2. Reads the RTL with inline SVA assertions
3. Generates a Tcl script (`run_jasper.tcl`) that runs `prove -all`
4. Outputs a formal report to `jasper_<design>/reports/formal_report.txt`

### Manual JasperGold Commands

```bash
# Create project
jgsetup -project TaskC/jasper_array_multiplier -rtl TaskC/rtl/array_multiplier.sv -top array_multiplier

# Run formal proof on all assertions
cd TaskC/jasper_array_multiplier
jg -t run_jasper.tcl

# Or interactively
jg -gui
```

### Interpreting Results

| JasperGold Result | Meaning |
|-------------------|---------|
| **Proven** | The assertion holds for all possible inputs |
| **Failed** | Counterexample found — there is a bug |
| **Inconclusive** | Tool could not prove or disprove within limits |

Focus on `functional_correct` in Task D — if this is proven, the Booth multiplier is mathematically correct for all 65,536 input combinations without needing simulation.

---

## Combining Simulation + Formal

| Method | Strength | Best for |
|--------|----------|----------|
| **Exhaustive Simulation** (`verify_agent.py`) | Caches all 65,536 input combos | Finding concrete bugs quickly |
| **Formal (JasperGold)** | Proves correctness for ALL inputs (mathematical) | Sign-off, `functional_correct` assertion |
| **SVA Assertions** | Granular per-property checking | Understanding which part of design is correct |

**Recommended workflow:**
1. Run `python3 verify_agent.py --task all` → simulation finds obvious bugs
2. Run `./run_jasper.sh taskd booth_multiplier` → formal proves `functional_correct`
3. If formal passes, you have mathematical certainty the Booth multiplier is correct
