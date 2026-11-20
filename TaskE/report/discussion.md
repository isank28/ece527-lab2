# Task E — Discussion: Initial Estimate Quality vs. Latency & Hardware Cost

## Results Summary

| ε₀ (initial error) | Min Iterations to reach 2⁻¹⁶ | Final Error |
|--------------------|------------------------------|-------------|
| 0.5 | 4 | 1.53 × 10⁻⁵ |
| 0.1 | 3 | 1.00 × 10⁻⁸ |
| 0.01 | 2 | 1.00 × 10⁻⁸ |

Target precision: **2⁻¹⁶ ≈ 1.53 × 10⁻⁵**

## Effect of Initial Estimate on Latency

The number of Newton-Raphson iterations drops dramatically as the initial estimate improves:

- **ε₀ = 0.5** requires **4 iterations** — the error must be squared four times before it drops below 2⁻¹⁶.
- **ε₀ = 0.1** requires **3 iterations** — one fewer because the starting error is already 5× smaller.
- **ε₀ = 0.01** requires **2 iterations** — two fewer than ε₀ = 0.5.

Because the error recurrence is quadratic (ε_{n+1} = D·ε_n²), each iteration roughly **squares** the error. A smaller initial error means fewer squarings are needed to reach the target. This is the classic quadratic convergence of Newton-Raphson: the number of correct digits roughly doubles each iteration.

## Effect on Hardware Cost

Each iteration requires:
1. One multiplication: D · x_n
2. One subtraction: 2 − (D · x_n)
3. One multiplication: x_n · (result)

That is **2 multiplications and 1 subtraction per iteration**, plus register storage for x_n between stages.

| ε₀ | Multiplications | Subtractions | Pipeline Stages (iterations) |
|----|-----------------|--------------|------------------------------|
| 0.5 | 8 | 4 | 4 |
| 0.1 | 6 | 3 | 3 |
| 0.01 | 4 | 2 | 2 |

A better initial estimate directly reduces:
- **Latency** (fewer pipeline stages → fewer clock cycles to produce a result)
- **Area** (fewer multiplier/subtractor units if unrolled, or fewer cycles if time-multiplexed)
- **Power** (fewer switching events per division)

## Lookup Table Trade-off

The initial estimate typically comes from a small ROM/lookup table indexed by the leading bits of D. A better initial estimate (smaller ε₀) requires:
- **More address bits** → larger ROM → more area and power
- **More stored precision** → wider ROM words → more area

**Design trade-off:** Spending area on a better lookup table (smaller ε₀) saves area and latency in the Newton-Raphson iteration units. There is a crossover point where the ROM cost exceeds the savings from removing one iteration. For most divider designs, ε₀ ≈ 0.1 (3 iterations) is a common sweet spot: the ROM is small enough to be cheap, but good enough to keep the iteration count low.

## Conclusion

Improving the initial estimate from ε₀ = 0.5 to ε₀ = 0.01 cuts iterations from 4 to 2 — a 2× latency reduction — but at the cost of a larger, more precise initial-estimate lookup table. The optimal design point depends on whether the application prioritizes latency (favor better estimate) or area (favor simpler estimate with more iterations).
