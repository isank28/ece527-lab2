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

| Metric | Booth-2 Multiplier |
|---|---|
| Total cells | N/A* |
| Cell area | N/A* |
| Max delay | N/A* |
| Dynamic power | N/A* |

\* DC synthesis failed — all report files (booth_qor.rpt, booth_area.rpt, booth_timing.rpt, booth_power.rpt) contain **"Current design is not defined. (UID-4)"** error. The `booth_multiplier` design was not created in the WORK library because `read_sverilog`/`elaborate`/`link` failed. See `logs/dc_booth.log` for full error details.

Source: `reports/booth_{area,qor,timing,power}.rpt` (all empty/error files)

## 6. Comparison with unsigned 8×8 array multiplier (Task C)

Could not complete — Task D DC synthesis failed, so no Booth-2 metrics are available for comparison. Task C metrics (from DC reports):

| Metric | Task C Array Multiplier | Task C Wallace Tree |
|---|---|---|
| Total cells | 72 | 676 |
| Cell area | 150.18 μm² | 1947.13 μm² |
| Max delay | N/A (unresolved refs) | 2.32 ns |
| Dynamic power | 0.5029 mW | 3.9877 mW |

## 7. Critical path

Could not identify — `booth_timing.rpt` contains only the error "Current design is not defined. (UID-4)". No timing paths were computed because DC compilation failed for `booth_multiplier`. The `csa.sv` module compiled independently (122 cells, 0.91 ns max delay) but the top-level `booth_multiplier` design did not link successfully.

**Root cause:** All Task D RTL files (`csa.sv`, `booth2_recode.sv`, `booth_multiplier.sv`) contain SystemVerilog assertions (`assert property` / `assert`) that the Presto compiler in DC L-2016.03-SP3 rejects with `VER-708` / `VER-294` errors. The `// synthesis translate_off` / `translate_on` wrappers added to Task C files were not applied to Task D files before this DC run.

**Fix needed:** Add `// synthesis translate_off` before and `// synthesis translate_on` after all `assert` blocks in:
- `rtl/csa.sv` (line 31-33)
- `rtl/booth2_recode.sv` (lines 30-41)
- `rtl/booth_multiplier.sv` (lines 104-122)

Then re-run DC synthesis on the lab machine (X-2025.06-SP4).
