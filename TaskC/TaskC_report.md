# Task C — Wallace Tree vs. Array Multiplier

## 1. Design summary

### 8×8 array multiplier
- Eight partial-product rows are generated as `a & {8{b[i]}}`, shifted by `i`.
- The rows are accumulated one at a time with a 16-bit ripple-carry adder.
- The structure is regular and has a long carry chain through every accumulated row.

### 8×8 Wallace-tree multiplier
- The same eight partial-product rows are generated.
- A balanced tree of six 3:2 carry-save adders reduces the eight rows to two.
- A final 16-bit carry-propagate adder forms the product.
- The CSA tree shortens the critical path at the cost of extra reduction hardware.

## 2. Functional verification

Common self-checking testbench: `tb/multiplier_tb.sv`.

- Exhaustive test of all 256 × 256 input combinations.
- Both multipliers are compared against the expected product `a*b`.
- Result: `PASS: both multipliers matched all 65,536 input combinations.`

## 3. Synthesis setup

- Tool: Synopsys Design Compiler
- Library: `lib/gscl45nm.db`
- Constraints applied identically to both designs:
  - `set_max_delay 100 -from [all_inputs] -to [all_outputs]`
  - `set_load 0.5 [all_outputs]`
  - `set_switching_activity -static_probability 0.5 -toggle_rate 0.2 [all_inputs]`
  - `compile -map_effort high`

## 4. Results

| Metric | Array Multiplier | Wallace Tree |
|---|---|---|
| Total cells | | |
| Cell area | | |
| Max delay | | |
| Dynamic power | | |

Source reports:

- `reports/array_qor.rpt`, `reports/array_area.rpt`, `reports/array_timing.rpt`, `reports/array_power.rpt`
- `reports/wallace_qor.rpt`, `reports/wallace_area.rpt`, `reports/wallace_timing.rpt`, `reports/wallace_power.rpt`

## 5. Critical-path comparison

- **Array multiplier:** the critical path runs through the serial row accumulations. Each row’s ripple-carry chain must finish before the next row can use the accumulated sum, so the delay grows roughly linearly with the number of partial-product rows. The worst path is expected to start at a high-order multiplier bit (for example `b[7]`), pass through the last partial-product row and the final ripple-carry chain, and end at `p[15]`.
- **Wallace tree:** the critical path runs through the balanced CSA tree and then through the final carry-propagate adder. The CSA tree depth is logarithmic in the number of rows, so the reduction is much shallower than the array’s serial accumulation. This implementation uses six 3:2 CSA instances; the longest path traverses four CSA stages before the final CPA. The worst path is expected to start at a partial-product input, pass through those CSA stages, then through the final CPA to `p[15]`.

## 6. Discussion

Expected qualitative result (confirm with the actual DC numbers):

- The **array multiplier** is usually smaller and lower power because it uses a regular, repeated row structure and fewer reduction gates. Its weakness is the serial carry chain through each accumulated row.
- The **Wallace tree** is usually faster because the CSA tree reduces the partial products in logarithmic depth instead of serially. Its weakness is extra CSA hardware and an irregular wiring network, which tends to increase area and switched capacitance.
- If the final Wallace CPA is a simple ripple adder, it can dominate the Wallace critical path. Replacing it with a carry-lookahead or carry-select adder would improve Wallace delay further, at additional area cost.

Answer these using your measured values:

- Which design has the smaller area, and why?
- Which design has the shorter max delay, and why?
- Which design has lower dynamic power, and why?
- How does the regular array structure compare with the irregular Wallace reduction network?
- What would change if the final Wallace CPA were replaced by a carry-lookahead or carry-select adder?
- Which design would you choose for a larger bit width, and why?
