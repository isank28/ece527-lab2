# How to Find Critical Path from DC Timing Reports

You mentioned you have the DC reports but couldn't locate the critical path. Here's exactly what to look for.

## Step 1: Open the Timing Report

Look for `reports/*_timing.rpt` (or `*_timing_max.rpt`) in each task's `reports/` folder:

- Task C: `TaskC/reports/array_timing.rpt`, `TaskC/reports/wallace_timing.rpt`
- Task D: `TaskD/reports/booth_timing.rpt`
- Task A: `Project2/taskA/reports/*_timing_max.rpt`
- Task B: `Project2/taskB/reports/*_timing_max.rpt`

## Step 2: Find the Worst Path

In the timing report, look for the section that looks like this:

```
------------------------------------------------------------------
Path 1: Slack: -0.50 ns (VIOLATED)
  Delay:    0.67 ns
  ...
  Point                               Incr    Path
  ----------------------------------------------------------------
  clock clk (rise edge)               0.00    0.00
  clock network delay (ideal)         0.00    0.00
  input port A[0]                     0.00    0.00
  fa2/u_x/A                           0.15    0.15
  fa2/u_x/S                           0.12    0.27
  ...
  output port S[7]                    0.00    0.67
------------------------------------------------------------------
```

**The critical path is the path with the worst (most negative or least positive) slack.**

Key fields:
- **Slack:** How much timing margin you have. Negative = violation.
- **Data arrival time:** The total delay from start to end of the path (last number in the "Path" column).
- **Start point:** Usually an input port or register clock pin.
- **End point:** Usually an output port or register data pin.
- **Intermediate points:** The gates/net names the signal passes through.

## Step 3: Identify the Start and End Points

Look at the first and last entries in the path:

| Start point | End point | What it means |
|-------------|-----------|---------------|
| `input port` | `output port` | Pure combinational path (Tasks C, D) |
| `register clock pin` | `register data pin` | Register-to-register path (Tasks A, B) |
| `register clock pin` | `output port` | Register-to-output path |
| `input port` | `register data pin` | Input-to-register path |

## Step 4: Read the Critical Path for Your Designs

From your existing `summary_taskB.txt`:

```
Critical paths (DC):
  prefix8_pipe flop->flop  : B_reg_reg[0] -> G30_m_reg
  prefix8_pipe flop->output: S_reg[7] -> S[7]
  csa8_pipe flop->flop  : B_reg_reg[0] -> s_lo_reg_reg[1]
  csa8_pipe flop->output: c_lo_reg_reg -> S[7]
```

This tells you:
- **prefix8_pipe** flop→flop worst path starts at `B_reg_reg[0]` (a register output) and ends at `G30_m_reg` (a register input). This is your **max clock frequency limiter**.
- **prefix8_pipe** flop→output worst path ends at `S[7]` (output port). This affects output setup time.
- **csa8_pipe** flop→flop worst path starts at `B_reg_reg[0]` and ends at `s_lo_reg_reg[1]` — goes through the carry-select mux chain.
- **csa8_pipe** flop→output worst path goes from `c_lo_reg_reg` to `S[7]` — through the final mux selection.

## Step 5: What to Write in Your Report

For each design, state:
1. **Worst slack value** (from the timing report)
2. **Data arrival time** (the max delay)
3. **Start point** (input port or register name)
4. **End point** (output port or register name)
5. **Key intermediate gates** (the critical cells in the path)
6. **Why this is the critical path** (e.g., "longest carry chain," "deepest CSA tree level," "longest mux select chain")

Example phrasing:
> "The critical path for prefix8_pipe runs from register `B_reg_reg[0]` through the Sklansky prefix tree levels 1-3, ending at register `G30_m_reg`. This flop-to-flop path has a data arrival time of 0.53 ns, setting the minimum clock period."

---

## Quick Commands to Extract from Reports

```bash
# See the worst slack and arrival time
grep -A 5 "Slack:" TaskC/reports/array_timing.rpt | head -20

# See start and end points of worst path
grep -E "input port|output port|register" TaskC/reports/array_timing.rpt | head -10

# Find max data arrival time
grep "data arrival time" TaskC/reports/array_timing.rpt
```

If you paste the relevant section of your timing report here, I can help you identify the exact critical path and write the description for your report.
