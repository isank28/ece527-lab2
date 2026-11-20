# Task D report skeleton

## 1. Booth-2 recoding
Describe the recode table:
| Bits {b[2i+1], b[2i], b[2i-1]} | Coefficient | Partial product |
|---|---|---|
| 000, 111 | 0 | 0 |
| 001, 010 | +1 | +a |
| 011 | +2 | +2a |
| 100 | -2 | -2a |
| 101, 110 | -1 | -a |

Explain how 8 multiplier bits become 5 overlapping groups with b[-1]=0 and virtual sign bits above b[7].

## 2. Partial product generation
- Sign-extend `a` to 16 bits.
- Each partial product = coef × a_ext, shifted by 2*i (i = 0..4).
- Mention handling of negation (-a, -2a) via two's complement.

## 3. Reduction structure
- 5 partial products reduced by 3-stage CSA tree to 2 rows.
- Final carry-propagate adder produces 16-bit signed product.

## 4. Verification
- Exhaustive testbench over signed [-128, 127] × [-128, 127] = 65,536 cases.
- Result: PASS.

## 5. Synthesis results
Fill in after running `./run_dc.sh`:

| Metric | Booth-2 Multiplier |
|---|---|
| Total cells | |
| Cell area | |
| Max delay | |
| Dynamic power | |

Source: `reports/booth_{area,qor,timing,power}.rpt`

## 6. Comparison with unsigned 8×8 array multiplier (Task C)
Fill in side-by-side and discuss:
- Which is smaller/faster/lower power, and why?
- Impact of halving partial products vs. recode/negation overhead.
- Suitability for signed multiplication.

## 7. Critical path
Identify the critical path from `reports/booth_timing.rpt` (worst data arrival time). Describe it: e.g., recoder → partial-product mux/negation → CSA chain → final CPA → output.
