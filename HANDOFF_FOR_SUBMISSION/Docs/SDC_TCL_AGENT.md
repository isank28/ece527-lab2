# SDC/TCL Agent — Design Constraint & Synthesis Script Guide

ECE 527 Project 2 — reusable reference for writing Design Compiler (DC) TCL scripts and Synopsys Design Constraints (SDC) for multiplier/adder projects.

**Purpose:** Understand the architecture, timing needs, and constraint strategy before deciding on Task A/B constraint files. Use this as a template for future projects.

---

## 1. Architecture Taxonomy

Your project contains two distinct design classes. The constraint strategy differs fundamentally between them.

| Class | Tasks | Timing Nature | Clock? | Primary Constraint |
|-------|-------|---------------|--------|-------------------|
| **Combinational** | C (array/Wallace mult), D (Booth-2 mult) | Pure logic, no registers | No | `set_max_delay` input→output (loose, for intrinsic delay reporting) |
| **Pipelined Sequential** | A (4-bit RCA/CSA adders), B (8-bit prefix/CSA adders) | Register-to-register paths | Yes | `create_clock`, `set_input_delay`, `set_output_delay`, `set_clock_latency` |

---

## 2. Combinational Design Constraints (Tasks C & D)

### Architecture
- No flip-flops. Purely combinational logic from primary inputs to primary outputs.
- Clock is irrelevant — there is no `clk` port on these designs.
- Timing metric of interest: **worst-case input-to-output propagation delay** (critical path).

### Constraint Strategy
Use a deliberately **loose** `set_max_delay` so DC does not try to meet an artificial target. The goal is to let DC optimize freely, then read the intrinsic delay from `report_timing`.

```tcl
# --- Constraints (combinational) ---
# Loose upper bound: we want intrinsic delay, not a hard speed target.
set_max_delay 100 -from [all_inputs] -to [all_outputs]
set_load 0.5 [all_outputs]

# Activity for power estimation (optional, wrapped in catch for older DC versions)
if {[catch {set_switching_activity -static_probability 0.5 -toggle_rate 0.2 [all_inputs]} msg]} {
    puts "WARNING: set_switching_activity failed: $msg"
}

# --- Synthesis ---
compile -map_effort high

# --- Reports ---
report_timing -delay_type max -max_paths 10 -nworst 10 -from [all_inputs] -to [all_outputs]
report_power -analysis_effort high
report_area
report_qor
```

### Key TCL Commands for Combinational Designs

| Command | Purpose |
|---------|---------|
| `read_file -format sverilog` | Read SystemVerilog RTL |
| `current_design <name>` | Select top-level module |
| `link` / `check_design` | Elaborate and verify connectivity |
| `set_max_delay` | Constrain input→output max delay (ns) |
| `set_load` | Output load in pF (affects delay/power) |
| `compile -map_effort high` | High-effort technology mapping |
| `report_timing -delay_type max` | Worst-case arrival time = max delay |
| `report_power` | Dynamic/static power estimate |
| `report_area` / `report_qor` | Area and quality-of-results |
| `write -format verilog -h` | Output synthesized netlist |

### What to Extract from Reports
- **Max delay:** `report_timing` → "data arrival time" on worst path
- **Total cells:** `report_qor` → "Number of cells"
- **Cell area:** `report_area` → "Total cell area"
- **Dynamic power:** `report_power` → "Total Dynamic Power"

---

## 3. Pipelined Sequential Constraints (Tasks A & B)

### Architecture
- Multi-stage pipeline with input registers, combinational logic, output registers.
- Clocked design with `clk` and `rst_n` ports.
- Timing metrics of interest:
  1. **Register-to-register (flop→flop)** max delay — determines max clock frequency
  2. **Input-to-register** (setup)
  3. **Register-to-output** (output delay)
  4. **Clock period** — minimum achievable period
  5. **Hold time** violations

### Constraint Strategy
Use **realistic clock constraints** derived from the assignment specs. Unlike combinational designs, you are designing for a target clock period.

```tcl
# --- Settings ---
set DESIGN      rca4_pipe        # or csa4_pipe, prefix8_pipe, csa8_pipe
set CLK_PERIOD  2.0              # ns — starting guess; tighten after timing report
set IN_DELAY    0.6              # ns — input delay from assignment spec
set CLK_LATENCY 0.2              # ns — external source clock latency
set OUT_DELAY   0.0              # ns — confirm with TA if non-zero

# --- Libraries ---
set target_library gscl45nm.db
set link_library   "* gscl45nm.db"

# --- Read and link ---
read_sverilog {fa2.sv rca4_pipe.sv}
current_design $DESIGN
link
check_design

# --- Clock constraints ---
create_clock -name clk -period $CLK_PERIOD [get_ports clk]
set_clock_latency -source $CLK_LATENCY [get_clocks clk]

# --- Input/output delays ---
set_input_delay  $IN_DELAY  -clock clk [remove_from_collection [all_inputs] [get_ports clk]]
set_output_delay $OUT_DELAY -clock clk [all_outputs]

# --- Synthesis ---
compile -ungroup_all   # flatten hierarchy for flat netlist (sequential designs)

# --- Reports ---
report_timing -delay_type max -max_paths 5 > reports/${DESIGN}_timing_max.rpt
report_timing -delay_type min              > reports/${DESIGN}_timing_min.rpt
report_area                                > reports/${DESIGN}_area.rpt
report_reference                           > reports/${DESIGN}_cells.rpt
report_qor                                 > reports/${DESIGN}_qor.rpt

# Register-to-register (critical for max freq)
report_timing -delay_type max \
    -from [all_registers -clock_pins] -to [all_registers -data_pins] \
    > reports/${DESIGN}_timing_reg2reg.rpt

# Register-to-output
report_timing -delay_type max \
    -from [all_registers -clock_pins] -to [all_outputs] \
    > reports/${DESIGN}_timing_reg2out.rpt

# Write netlist for PrimeTime
write -f verilog -h -o ${DESIGN}_netlist.v
```

### Key TCL Commands for Pipelined Designs

| Command | Purpose |
|---------|---------|
| `create_clock` | Define clock period and name |
| `set_clock_latency` | External clock skew/latency |
| `set_input_delay` | Data arrival relative to clock at inputs |
| `set_output_delay` | Data required time relative to clock at outputs |
| `all_registers -clock_pins` | Register clock pins (launch) |
| `all_registers -data_pins` | Register data pins (capture) |
| `compile -ungroup_all` | Flatten hierarchy (preserves timing accuracy) |
| `report_timing` with `-from`/`-to` | Path-group-specific timing |

---

## 4. Task-by-Task Constraint Needs

### Task A — 4-bit Pipelined Adders (rca4_pipe, csa4_pipe)

| Aspect | Detail |
|--------|--------|
| Clock | Yes (pipelined, 2-stage) |
| Clock period | Start 2.0 ns, tighten based on timing |
| Input delay | 0.6 ns (from assignment) |
| Clock latency | 0.2 ns (source) |
| Output delay | 0.0 ns (confirm with TA) |
| Compile | `compile -ungroup_all` |
| Key reports | `reg2reg` (max freq), `reg2out` (output delay), skew sweep |

**SDC needs:** Full clock + input/output delay constraints. Skew sweep for PrimeTime at multiple periods.

### Task B — 8-bit Pipelined Adders (prefix8_pipe, csa8_pipe)

| Aspect | Detail |
|--------|--------|
| Clock | Yes (pipelined, prefix=3 stage, CSA=2 stage) |
| Clock period | Start 2.0 ns |
| Input delay | 0.6 ns |
| Clock latency | 0.2 ns |
| Output delay | 0.0 ns |
| Compile | `compile -ungroup_all` |

**SDC needs:** Same as Task A. Note `prefix8_pipe.sv` does NOT instantiate `fa2.sv` (standalone prefix tree), while `csa8_pipe.sv` instantiates `fa2.sv`. DC scripts must list correct RTL file sets.

### Task C — 8x8 Multipliers (array, Wallace)

| Aspect | Detail |
|--------|--------|
| Clock | No (combinational) |
| Max delay constraint | `set_max_delay 100` (loose) |
| Output load | 0.5 pF |
| Compile | `compile -map_effort high` |

**SDC needs:** No clock. Only `set_max_delay` and `set_load`.

### Task D — 8x8 Booth-2 Signed Multiplier

| Aspect | Detail |
|--------|--------|
| Clock | No (combinational) |
| Max delay constraint | `set_max_delay 100` (loose) |
| Output load | 0.5 pF |
| Compile | `compile -map_effort high` |
| RTL reuse | Imports `csa.sv` from Task C |

**SDC needs:** Same as Task C.

---

## 5. What Transfers Between Tasks (and What Doesn't)

### ✅ Transferable from C/D → A/B

| Element | How to adapt |
|---------|--------------|
| `set_switching_activity` | Add to A/B DC scripts for power analysis (currently missing in A/B) |
| `report_reference` | Already in A/B scripts — keep for cell counting |
| `report_qor` | Already in A/B scripts — keep for QoR summary |
| `set_load 0.5 [all_outputs]` | A/B use `set_output_delay` instead (more appropriate for sequential) — can add both |

### ❌ NOT Transferable

| Element | Why |
|---------|-----|
| `set_max_delay 100 -from [all_inputs] -to [all_outputs]` | A/B have clocked registers; this would constrain reg-to-reg paths incorrectly |
| `compile -map_effort high` | A/B use `compile -ungroup_all` to flatten pipeline hierarchy |
| `current_design` selection without clock | Sequential designs need clock constraints before `compile` |

---

## 6. Template TCL Scripts

### Template 1: Combinational (Tasks C & D)
```tcl
set DESIGN      <design_name>
set RTL_FILES   {<file1.sv> <file2.sv> ...}
set LIB         gscl45nm.db

set target_library $LIB
set link_library   "* $LIB"

read_file -format sverilog $RTL_FILES
current_design $DESIGN
link
check_design

set_max_delay 100 -from [all_inputs] -to [all_outputs]
set_load 0.5 [all_outputs]

if {[catch {set_switching_activity -static_probability 0.5 -toggle_rate 0.2 [all_inputs]} msg]} {
    puts "WARNING: $msg"
}

compile -map_effort high

report_area > reports/${DESIGN}_area.rpt
report_qor > reports/${DESIGN}_qor.rpt
report_reference > reports/${DESIGN}_reference.rpt
report_timing -delay_type max -from [all_inputs] -to [all_outputs] > reports/${DESIGN}_timing.rpt
report_power -analysis_effort high > reports/${DESIGN}_power.rpt

write -format verilog -hierarchy -output netlists/${DESIGN}.v
exit
```

### Template 2: Pipelined Sequential (Tasks A & B)
```tcl
set DESIGN      <design_name>
set RTL_FILES   {<file1.sv> <file2.sv> ...}
set CLK_PERIOD  2.0
set IN_DELAY    0.6
set CLK_LATENCY 0.2
set OUT_DELAY   0.0
set LIB         gscl45nm.db

set target_library $LIB
set link_library   "* $LIB"

read_sverilog $RTL_FILES
current_design $DESIGN
link
check_design

create_clock -name clk -period $CLK_PERIOD [get_ports clk]
set_clock_latency -source $CLK_LATENCY [get_clocks clk]
set_input_delay  $IN_DELAY  -clock clk [remove_from_collection [all_inputs] [get_ports clk]]
set_output_delay $OUT_DELAY -clock clk [all_outputs]

compile -ungroup_all

report_timing -delay_type max > reports/${DESIGN}_timing_max.rpt
report_timing -delay_type min > reports/${DESIGN}_timing_min.rpt
report_area > reports/${DESIGN}_area.rpt
report_qor > reports/${DESIGN}_qor.rpt
report_reference > reports/${DESIGN}_cells.rpt

report_timing -delay_type max -from [all_registers -clock_pins] -to [all_registers -data_pins] > reports/${DESIGN}_timing_reg2reg.rpt
report_timing -delay_type max -from [all_registers -clock_pins] -to [all_outputs] > reports/${DESIGN}_timing_reg2out.rpt

write -f verilog -h -o netlists/${DESIGN}_netlist.v
exit
```

---

## 7. PrimeTime (PT) Constraints for Tasks A & B

The `pt_*.tcl` scripts in Task A/B run static timing analysis on the synthesized netlist. Key variables:

| Variable | Meaning | Source |
|----------|---------|--------|
| `CLK_PERIOD` | Clock period for PT read | From DC `dc_*.tcl` or assignment |
| `SKEW` | Clock skew value | Assignment-specified (e.g., 0.5 ns) |
| `RPT_DIR` | Output report folder | `item4`, `item5_fail`, `item5_pass` |

### PT Flow Overview (from `run_taskA.sh`)
1. **Item 4:** PT at DC minimum period → check setup/hold MET or VIOLATED
2. **Item 5:** PT just below min period → expect VIOLATED; PT at min passing period → expect MET
3. **Item 6:** Skew sweep (0.1, 0.3, 0.5, 0.7 ns) at min passing period → record Tmin_all per skew

### PT TCL Structure (per design)
```tcl
# Variables set via environment: CLK_PERIOD, RPT_DIR, SKEW
read_verilog ${DESIGN}_netlist.v
link
create_clock -name clk -period $CLK_PERIOD [get_ports clk]
set_clock_latency -source 0.2 [get_clocks clk]   # or from assignment
set_input_delay  0.6 -clock clk [all_inputs]
set_output_delay 0.0 -clock clk [all_outputs]

# Skew (if applied)
set_clock_skew -skew $SKEW [get_clocks clk]   # if PT supports per-clock skew

check_timing
report_timing -max_paths 10 > $RPT_DIR/${DESIGN}_pt_setup.rpt
report_constraint -all_violators > $RPT_DIR/${DESIGN}_pt_violations.rpt
```

---

## 8. Common Pitfalls & Checklist

### Before running DC on any task
- [ ] Verify all RTL files exist and are listed in `RTL_FILES`
- [ ] `check_design` passes (no unconnected ports, no multiple drivers)
- [ ] Library path `gscl45nm.db` is correct and accessible
- [ ] For sequential designs: clock created BEFORE `compile`
- [ ] For combinational designs: NO `create_clock`

### Before running PT on Tasks A & B
- [ ] Netlist written by DC (`${DESIGN}_netlist.v`) exists
- [ ] `CLK_PERIOD` matches the value you want to test
- [ ] `SKEW` matches assignment spec
- [ ] Report directory exists (`reports/item4`, `reports/item5_pass`, etc.)

### Flaw Watchlist (Task A/B specific)
1. **`OUT_DELAY = 0.0`** — Flagged in DC scripts as "confirm with TA." If the assignment specifies a non-zero output delay, this will cause incorrect output-delay timing.
2. **`compile -ungroup_all`** — Flattens hierarchy. Good for flat netlists but may lose some hierarchy-based optimization. Confirm this is desired.
3. **Missing `set_switching_activity`** in A/B — Power reports will use DC defaults, not the 0.5/0.2 activity used in C/D. Add it for comparable power numbers.
4. **`read_sverilog` vs `read_file -format sverilog`** — A/B scripts use `read_sverilog`; C/D use `read_file -format sverilog`. Both work in modern DC but be consistent.
5. **Task B `prefix8_pipe` does not use `fa2.sv`** — Its DC script lists only `{prefix8_pipe.sv}`, which is correct. `csa8_pipe` lists `{fa2.sv csa8_pipe.sv}`, also correct.

---

## 9. Recommended Next Step for Tasks A & B

Given the architecture analysis:

1. **RTL is verified correct** (exhaustive simulation: 0 errors for all 4 designs).
2. **DC constraint files exist** but need review for:
   - `OUT_DELAY` confirmation with TA
   - Adding `set_switching_activity` for power parity with C/D
   - Verifying `compile -ungroup_all` is the intended compile strategy
3. **PT skew sweep** is already implemented in `run_taskA.sh` / `run_taskB.sh` — no changes needed unless skew values differ from assignment.

Would you like me to generate updated DC TCL files for Tasks A and B incorporating the `set_switching_activity` addition, or would you prefer to confirm `OUT_DELAY` with the TA first?