# Task D — Report Fill-In Guide

You have the DC reports (run them on the lab machine if not yet generated). Extract these metrics:

## Where to Find Each Metric

| Metric | Report File | What to Look For |
|--------|-------------|------------------|
| Total cells | `reports/booth_qor.rpt` | "Number of cells:" |
| Cell area | `reports/booth_area.rpt` | "Total cell area:" |
| Max delay | `reports/booth_timing.rpt` | Worst "data arrival time" |
| Dynamic power | `reports/booth_power.rpt` | "Total Dynamic Power:" |

## Extract Commands (run in TaskD/)

```bash
# Total cells
grep "Number of cells" reports/booth_qor.rpt

# Cell area
grep "Total cell area" reports/booth_area.rpt

# Max delay (worst data arrival time)
grep "data arrival time" reports/booth_timing.rpt

# Dynamic power
grep "Total Dynamic Power" reports/booth_power.rpt
```

## Fill the Table in `TaskD/TaskD_report.md`

| Metric | Booth-2 Multiplier |
|--------|-------------------|
| Total cells | **[from booth_qor.rpt]** |
| Cell area | **[from booth_area.rpt]** |
| Max delay | **[from booth_timing.rpt]** |
| Dynamic power | **[from booth_power.rpt]** |

## Comparison with Task C Array Multiplier

After filling Task C's table, create a side-by-side:

| Metric | Task C Array | Task D Booth-2 |
|--------|-------------|----------------|
| Total cells | **[from C]** | **[from D]** |
| Cell area | **[from C]** | **[from D]** |
| Max delay | **[from C]** | **[from D]** |
| Dynamic power | **[from C]** | **[from D]** |

## Critical Path

Open `reports/booth_timing.rpt`. Find the worst slack path. Record:
- Start point → End point
- Data arrival time
- Intermediate cells

Likely path: recoder → partial-product mux/negation → CSA chain → final CPA → output

See `CRITICAL_PATH_GUIDE.md` for reading instructions.

## Discussion Points to Write

1. **Booth-2 vs Array:** Which is smaller/faster/lower power, and why?
   - Booth-2 halves the partial products (5 vs 8), reducing CSA tree size
   - But adds recoder logic and negation hardware overhead
   
2. **Signed vs Unsigned:** Booth-2 natively handles signed operands; array needs sign extension.

3. **Trade-off:** Fewer partial products (good for delay/area) vs recode/negation overhead (bad for area).

See existing `TaskD/TaskD_report.md` sections 6-7 for the skeleton to fill in.
