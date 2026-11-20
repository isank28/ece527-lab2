# Subagent / Agent Creation Documentation

## Overview

This document explains how subagents (and verification agents) are created and used in this environment, with a specific focus on the exploration subagent launched for ECE 527 Lab 2 Tasks A–B resource gathering.

---

## 1. Types of Agents in This Environment

### A. Subagents (via `subagent` tool)

Subagents are spawned child sessions that run independently in the background. They are created using the `subagent` tool with the following parameters:

| Parameter | Description | Example |
|-----------|-------------|---------|
| `agent` | Type of agent: `"explore"` or `"general"` | `"explore"` |
| `description` | Short 3–5 word label shown to the user | `"Explore lab resources"` |
| `prompt` | Full task instructions for the subagent | Multi-paragraph description of what to do |
| `model` | Optional: specific model ID (omit for default) | Not used here |
| `sessionID` | Optional: continue an existing subagent session | Omitted for new subagents |

**Available agent types:**
- `explore` — Fast agent for codebase exploration: finding files by pattern, searching code for keywords, answering questions about codebase structure.
- `general` — General-purpose agent for complex research and multi-step tasks.

**Key behaviors:**
- Subagents run in the background; the `subagent` call returns immediately with a `sessionID`.
- The user is notified when the subagent goes idle or completes.
- The parent agent should **not** poll, sleep, or check on the subagent's progress.
- Follow-up messages can be sent to a running subagent by passing its `sessionID`.

### B. Verification Agents (Python scripts)

Verification agents are standalone Python programs (not subagent sessions) that automate testing and formal verification. Examples created in this lab:

| File | Purpose |
|------|---------|
| `verify_agent.py` | Generic RTL verification agent — simulation (iverilog/VCS) + JasperGold formal project generation |
| `verify_taskc.py` | Legacy verification script for Task C (superseded by `verify_agent.py`) |
| `parse_reports.py` | Parses DC `reports/*.rpt` → comparison table |

---

## 2. How the Exploration Subagent Was Created

### Step 1: Identify the Need

Before starting Tasks A and B (pipelined adders and parallel prefix adder), it was necessary to understand:
- What DC/PT scripts already exist in the lab
- What library files (`.db`) are available
- What example designs (FIFO, gray adder) exist as templates
- What constraint patterns (clock, I/O delay, latency, skew) are used
- The exact wording of Tasks A and B from the PR_2 PDF

### Step 2: Choose the Agent Type

The `explore` agent type was selected because the task was:
- File discovery (find all files recursively)
- Content search (read PDFs, TCL scripts, SV files)
- Codebase structure analysis
- Pattern extraction (DC commands, PT commands, constraints)

### Step 3: Write the Prompt

The prompt given to the subagent was:

```
Thoroughly explore the directory /Users/victor/ece527/lab2, focusing on:

1. The DC_Tutorial1 directory (all subdirectories and files) - read all PDFs, TCL scripts, SV files, and any other files. Extract all DC synthesis commands, PT commands, library names, file paths, and example structures.

2. The Starting guide directory - read all files including dcFIFO.tcl, ptFIFO.tcl, SVFIFO.sv, gscl45nm.db info, and the Getting started guide PDF.

3. The C_2026_04_527_PR_2.pdf - confirm the exact wording for Tasks A and B.

4. List ALL files in the entire lab2 directory tree recursively.

Provide a comprehensive report including:
- All DC shell commands and TCL script patterns found
- All PrimeTime commands found
- Library names (.db files) and their locations
- Example design structures (FIFO, gray adder, etc.)
- Any constraints examples (clock, input/output delay, latency, skew)
- File paths for all relevant resources
- Recommendations on how to structure Tasks A and B based on the examples found

Be very thorough - read every file you can find.
```

### Step 4: Set Thoroughness

The `thoroughness` parameter was set to `"very thorough"` to ensure comprehensive coverage of all files and subdirectories.

### Step 5: Launch

The subagent was launched via:

```python
subagent(
    agent="explore",
    description="Explore lab resources for Tasks A-B",
    prompt="<full prompt above>",
    thoroughness="very thorough"
)
```

This returned immediately with `sessionID: ses_e1274a55affejmfP3AnWF9b4vO`.

---

## 3. What the Exploration Subagent Did

The subagent performed the following work in the background:

### File Discovery
Listed **83 files** across the entire `lab2/` directory tree, including:
- Top-level: `C_2026_04_527_PR_2.pdf`, `README.md`, `verify_agent.py`, `parse_reports.py`, `run_jasper.sh`, etc.
- `DC_Tutorial1/`: `DC_task1/` and `DC_task2/` with PDFs, TCL scripts, SV files, and `.db` libraries
- `Starting guide/`: `dcFIFO.tcl`, `ptFIFO.tcl`, `SVFIFO.sv`, `gscl45nm.db`, Getting Started guide PDF
- `TaskC/`, `TaskD/`, `TaskE/`: All previously created task directories
- `__pycache__/`: Compiled Python cache

### Content Extraction

Because the `read` tool cannot process PDFs, the subagent used **pure-Python zlib stream decompression** (built-in, no `pip`/network required) to extract text from:
- `C_2026_04_527_PR_2.pdf` — Tasks A–E wording + Honor Pledge
- DC Tutorial PDFs
- Getting Started guide PDF

### Pattern Extraction

The subagent extracted and categorized:

**DC Synthesis Commands:**
- `set target_library`, `set link_library`
- `read_file -format sverilog`, `read_verilog`
- `link`, `link_design`, `check_design`
- `create_clock`, `set_input_delay`, `set_output_delay`
- `set_clock_uncertainty`, `set_clock_latency`, `set_load`
- `compile -map_effort high`, `compile -ungroup_all`
- `report_area`, `report_qor`, `report_reference`, `report_timing`, `report_power`
- `write -format verilog -hierarchy`, `write -format ddc`

**PrimeTime Commands:**
- `set search_path`, `set target_library`, `set link_library`
- `read_verilog`, `current_design`, `list_libs`, `link_design`
- `create_clock`, `set_clock_latency`
- `set timing_report_unconstrained_paths`
- `all_registers`, `get_pins`
- `report_timing -delay_type max/min`

**Constraint Values (from Task A):**
- Input delay: **0.6 ns**
- External clock latency: **0.2 ns**
- Clock skew between FF levels: **0.5 ns**
- Skew sweep values: 0.1, 0.3, 0.5, 0.7 ns

**Library Files:**
- `gscl45nm.db` (Starting guide/, TaskC/lib/, TaskD/lib/)
- `osu05_stdcells.db` (DC_Tutorial1/DC_task1/)

**Example Designs:**
- Dual-port FIFO (`SVFIFO.sv` + `dcFIFO.tcl` + `ptFIFO.tcl`)
- Gray adder (`gray_adder.sv` + `compile_gray_adder.tcl`)
- MY_DESIGN sequential circuit (`MY_DESIGN.v` + `dc.tcl`)

### Output Format

The subagent returned a structured report with:
1. Complete recursive file listing (83 files)
2. DC synthesis commands & TCL script patterns (6 scripts analyzed)
3. PrimeTime commands found (12 commands)
4. Library names and locations (2 `.db` files + Verilog cell models)
5. Example design structures (4 designs)
6. Constraints examples (clock/I/O delay/latency/skew)
7. Exact Task A and Task B wording from the PDF
8. Recommendations for directory structure and script templates for Tasks A and B

---

## 4. .md File for the Exploration Subagent

Below is the documentation file for the subagent that was created:

```markdown
# Subagent: Lab Resource Explorer (Tasks A–B)

## Session ID
`ses_e1274a55affejmfP3AnWF9b4vO`

## Agent Type
`explore`

## Description
Explore lab resources for Tasks A–B — gather DC/PT script patterns, library names, example designs, constraint values, and exact task wording from the PR_2 PDF.

## Launch Command
```python
subagent(
    agent="explore",
    description="Explore lab resources for Tasks A-B",
    prompt="<comprehensive exploration prompt>",
    thoroughness="very thorough"
)
```

## Status
**COMPLETED** — The subagent went idle and returned its findings.

## Key Deliverables

### Files Discovered (83 total)
- Top-level: PR_2 PDF, README.md, verify_agent.py, parse_reports.py, run_jasper.sh, verification_report.json
- DC Tutorials: DC_task1 (gray adder), DC_task2 (MY_DESIGN)
- Starting Guide: dcFIFO.tcl, ptFIFO.tcl, SVFIFO.sv, gscl45nm.db
- Tasks C, D, E: All previously created with RTL, testbenches, DC scripts, reports, plots

### DC Script Patterns Extracted
6 TCL scripts analyzed:
1. `compile_gray_adder.tcl` — minimal template
2. `dc.tcl` — run script with constraint placeholder
3. `dcFIFO.tcl` — full DC flow with constraints (reference pattern)
4. `dc_array.tcl` — Task C array multiplier
5. `dc_wallace.tcl` — Task C Wallace multiplier
6. `dc_booth.tcl` — Task D Booth multiplier

### PrimeTime Commands
12 commands extracted from `ptFIFO.tcl` including `create_clock`, `set_clock_latency`, `report_timing -delay_type max/min`.

### Constraint Values for Tasks A & B
| Parameter | Value |
|-----------|-------|
| Input delay | 0.6 ns |
| External clock latency | 0.2 ns |
| Clock skew (FF to FF) | 0.5 ns |
| Skew sweep values | 0.1, 0.3, 0.5, 0.7 ns |

### Libraries
- `gscl45nm.db` — Starting guide/ (128K), copied to TaskC/lib/, TaskD/lib/
- `osu05_stdcells.db` — DC_Tutorial1/DC_task1/ (124K)

### Example Designs
- Dual-port FIFO (SVFIFO.sv + dcFIFO.tcl + ptFIFO.tcl)
- Gray adder (gray_adder.sv + compile_gray_adder.tcl)
- MY_DESIGN sequential circuit (MY_DESIGN.v + dc.tcl)

### Task A & B Wording
Exact wording extracted from `C_2026_04_527_PR_2.pdf` via zlib decompression.

### Recommendations
- Directory structure for TaskA/ and TaskB/
- DC script templates adapted from dc_array.tcl/dc_wallace.tcl patterns
- PT script templates adapted from ptFIFO.tcl
- Critical-path guidance for prefix tree vs carry-select comparison

## How to Use This Subagent's Findings

The exploration subagent's report provides everything needed to start Tasks A and B:

1. **Copy** `gscl45nm.db` from `Starting guide/` into `TaskA/lib/` and `TaskB/lib/`
2. **Adapt** the DC script pattern from `TaskC/scripts/dc_array.tcl` for pipelined/sequential designs (add `create_clock`, `set_input_delay 0.6`, `set_output_delay 0.6`, `set_clock_latency 0.2`, `set_clock_uncertainty/skew 0.5`)
3. **Adapt** the PT script pattern from `TaskC/.../ptFIFO.tcl` for STA with skew sweep values
4. **Follow** the recommended directory structure (TaskA/, TaskB/ mirroring TaskC/TaskD layout)
5. **Use** `report_timing -delay_type max/min` from PT for setup/hold slack analysis

## Follow-Up

To send follow-up instructions to this subagent, use:
```python
subagent(
    agent="explore",
    sessionID="ses_e1274a55affejmfP3AnWF9b4vO",
    prompt="<follow-up instructions>"
)
```
