# HANDOFF FOR SUBMISSION - ECE 527 Project 2 (PR_2)

## IMPORTANT: READ THIS FIRST

This folder contains all work completed for ECE 527 Project 2. You can submit this entire folder as-is if you are unable to complete remaining items before the deadline.

## What's Included

| Task | Status | Files |
|------|--------|-------|
| Task A | ✅ Complete | RTL, testbench, DC scripts, PT scripts, logs, netlists, reports, run_taskA.sh |
| Task B | ✅ Complete | RTL, testbench, DC scripts, PT scripts, logs, netlists, reports, run_taskB.sh |
| Task C | ⚠️ Partial | RTL, testbench, DC scripts (updated), simulation PASSED, DC reports partially extracted |
| Task D | ⚠️ Partial | RTL, testbench, DC script, simulation PASSED, DC reports NOT yet generated |
| Task E | ✅ Complete | nr_analysis.py, results.csv, derivation.md, 4 PNG plots, discussion.md |

## What's Done vs. What Needs Completion

### Task A (4-bit Pipelined Adders) - COMPLETE
- RTL: fa2.sv, rca4_pipe.sv, csa4_pipe.sv
- Testbench: tb_adders.sv (exhaustive 512 vectors, 0 errors)
- DC synthesis: dc_rca4.tcl, dc_csa4.tcl
- PrimeTime STA: pt_rca4.tcl, pt_csa4.tcl
- Logs, netlists, reports all present
- Run: `cd TaskA && ./run_taskA.sh`

### Task B (8-bit Pipelined Adders) - COMPLETE
- RTL: fa2.sv, prefix8_pipe.sv, csa8_pipe.sv
- Testbench: tb_taskB.sv (exhaustive 131,072 vectors, 0 errors)
- DC synthesis: dc_prefix8.tcl, dc_csa8.tcl
- PrimeTime STA: pt_prefix8.tcl, pt_csa8.tcl
- Logs, netlists, reports all present
- Run: `cd TaskB && ./run_taskB.sh`

### Task C (8x8 Multipliers: Array vs Wallace) - PARTIAL
- RTL: full_adder.sv, rca.sv, csa.sv, array_multiplier.sv, wallace_multiplier.sv
- Testbench: tb/multiplier_tb.sv (exhaustive 65,536 vectors, 0 errors)
- DC scripts: dc_array.tcl, dc_wallace.tcl (updated for X-2025.06-SP4)
- DC reports: PARTIALLY extracted (Wallace timing = 2.32 ns; Array timing blocked by SVA assertion issue)
- **To complete**: Run DC on lab machine (X-2025.06-SP4) with updated scripts
- Fill tables in TaskC/TaskC_report.md using REPORT_FILL_GUIDE.md

### Task D (8x8 Booth-2 Signed Multiplier) - PARTIAL
- RTL: csa.sv, booth2_recode.sv, booth_multiplier.sv
- Testbench: tb/booth_tb.sv (exhaustive 65,536 signed vectors, 0 errors)
- DC script: dc_booth.tcl
- DC reports: NOT yet generated
- **To complete**: Run DC on lab machine (X-2025.06-SP4)
- Fill tables in TaskD/TaskD_report.md using REPORT_FILL_GUIDE.md

### Task E (Newton-Raphson Divider) - COMPLETE
- nr_analysis.py - computes iterations and generates plots
- results.csv - epsilon_0, min_iterations, final_error
- derivation.md - error recurrence derivation
- plots/error_convergence.png + 3 individual plots
- report/discussion.md - latency vs hardware cost analysis

## How to Complete Remaining Items

### Running DC on Lab Machine (mo.ece.pdx.edu)

1. SSH into the lab machine:
   ```
   ssh sanketp@mo.ece.pdx.edu
   ```

2. Load Synopsys tools:
   ```
   addpkg_shell
   ```

3. Navigate to Task C and run:
   ```
   cd /u/sanketp/ece527/lab2/TaskC
   dc_shell -f scripts/dc_array.tcl
   dc_shell -f scripts/dc_wallace.tcl
   ```

4. Navigate to Task D and run:
   ```
   cd /u/sanketp/ece527/lab2/TaskD
   dc_shell -f scripts/dc_booth.tcl
   ```

5. Copy reports back and fill tables using REPORT_FILL_GUIDE.md

### Critical Path Extraction
See Docs/CRITICAL_PATH_GUIDE.md for how to extract critical path from DC timing reports.

## How to Submit

### Option 1: Upload this entire HANDOFF_FOR_SUBMISSION folder
Contains everything. Your instructor can see what's complete and what's in progress.

### Option 2: GitHub repository
All work is also pushed to: `git@github.com:isank28/ece527-lab2.git` (branch: main)
```
git remote add origin git@github.com:isank28/ece527-lab2.git
git push -u origin main
```

### Option 3: Submit individual task folders
Each Task folder (TaskA, TaskB, TaskC, TaskD, TaskE) is self-contained.

## Honor Pledge (Page 4 of PR_2.pdf)

You must write this on your report cover:
> "On my honor, I have neither given nor received unauthorized aid on this work."

Type or sign your name underneath. This is NOT in any repo file — add it to your report cover.

## Contact / Files

- Main repo: `/Users/victor/ece527/lab2/`
- GitHub: `https://github.com/isank28/ece527-lab2`
- Handoff folder: `/Users/victor/ece527/lab2/HANDOFF_FOR_SUBMISSION/`

## Key Files for Quick Reference

| Purpose | File |
|---------|------|
| Assignment handout | Docs/C_2026_04_527_PR_2.pdf |
| Task C report skeleton | TaskC/TaskC_report.md |
| Task D report skeleton | TaskD/TaskD_report.md |
| Task C fill guide | Docs/REPORT_FILL_GUIDE.md |
| Task D fill guide | Docs/REPORT_FILL_GUIDE.md |
| Critical path guide | Docs/CRITICAL_PATH_GUIDE.md |
| SDC/TCL reference | Docs/SDC_TCL_AGENT.md |
| Task B discussion | Docs/discussion_taskB.md |
| Task E discussion | Docs/discussion.md |
