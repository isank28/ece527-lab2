# Task E — Newton-Raphson Divider Error Analysis

## Overview

Task E analyzes the convergence behavior of the Newton-Raphson (NR) divider. It is a **purely mathematical/analytical task** — no RTL, no synthesis, no timing analysis.

## Files

```
TaskE/
├── derivation/
│   └── derivation.md       # Error recurrence derivation, quadratic convergence proof, iteration table, discussion
├── computation/
│   ├── nr_analysis.py      # Python script: computes iterations, generates CSV + plots
│   └── results.csv         # Computed results (epsilon_0, min_iterations, final_error)
├── plots/
│   ├── error_convergence.png              # All three initial estimates on one plot
│   ├── nr_convergence_eps0_0.5.png        # Individual plot for ε₀ = 0.5
│   ├── nr_convergence_eps0_0.1.png        # Individual plot for ε₀ = 0.1
│   └── nr_convergence_eps0_0.01.png       # Individual plot for ε₀ = 0.01
└── report/                  # Place for your written report section
```

## How to Run

```bash
cd /Users/victor/ece527/lab2/TaskE/computation
python3 nr_analysis.py
```

This recomputes the iteration counts and regenerates all plots.

## Results Summary

| ε₀ | Min Iterations for 2⁻¹⁶ | Final Error |
|----|------------------------|-------------|
| 0.5 | 4 | 1.5259e-05 |
| 0.1 | 3 | 1.0000e-08 |
| 0.01 | 2 | 1.0000e-08 |

## Key Results for Your Report

1. **Error recurrence:** $\varepsilon_{n+1} = D \cdot \varepsilon_n^2$
2. **Convergence:** Quadratic (error squares each iteration)
3. **Iterations for 2⁻¹⁶ precision:** 4 (ε₀=0.5), 3 (ε₀=0.1), 2 (ε₀=0.01)
4. **Tradeoff:** Better initial estimate (larger LUT) → fewer iterations → lower latency, but higher hardware cost

## Dependencies

- **None** on Tasks A–D. Task E is fully independent.
- Requires Python 3 with `matplotlib` (for plots) — available in `/tmp/dsevenv/`
