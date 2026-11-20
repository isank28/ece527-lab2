# Task C — Report Fill-In Guide

You have the DC reports (run them on the lab machine if not yet generated). Extract these metrics from each report:

## Where to Find Each Metric

| Metric | Report File | What to Look For |
|--------|-------------|------------------|
| Total cells | `reports/*_qor.rpt` | "Number of cells:" |
| Cell area | `reports/*_area.rpt` | "Total cell area:" |
| Max delay | `reports/*_timing.rpt` | Worst "data arrival time" |
| Dynamic power | `reports/*_power.rpt` | "Total Dynamic Power:" |

## Extract Commands (run in TaskC/)

```bash
# Total cells
grep "Number of cells" reports/array_qor.rpt reports/wallace_qor.rpt

# Cell area
grep "Total cell area" reports/array_area.rpt reports/wallace_area.rpt

# Max delay (worst data arrival time)
grep "data arrival time" reports/array_timing.rpt reports/wallace_timing.rpt

# Dynamic power
grep "Total Dynamic Power" reports/array_power.rpt reports/wallace_power.rpt
```

## Fill the Table

Copy these numbers into `TaskC/TaskC_report.md`:

| Metric | Array Multiplier | Wallace Tree |
|--------|-----------------|--------------|
| Total cells | **[from array_qor.rpt]** | **[from wallace_qor.rpt]** |
| Cell area | **[from array_area.rpt]** | **[from wallace_area.rpt]** |
| Max delay | **[from array_timing.rpt]** | **[from wallace_timing.rpt]** |
| Dynamic power | **[from array_power.rpt]** | **[from wallace_power.rpt]** |

## Critical Path (for discussion)

Open `reports/array_timing.rpt` and `reports/wallace_timing.rpt`. Find the path with the **worst (most negative) slack**. Record:
- Start point (input port)
- End point (output port)
- Data arrival time (max delay)
- Key intermediate cells

See `CRITICAL_PATH_GUIDE.md` for how to read these paths.

## Example Filled Table

| Metric | Array Multiplier | Wallace Tree |
|--------|-----------------|--------------|
| Total cells | 450 | 520 |
| Cell area | 1850 μm² | 2100 μm² |
| Max delay | 2.8 ns | 1.9 ns |
| Dynamic power | 4.2 mW | 5.1 mW |

*(Numbers above are illustrative — replace with your actual DC values.)*
