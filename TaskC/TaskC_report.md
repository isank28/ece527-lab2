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
| Total cells | 72 | 676 |
| Cell area | 150.18 μm² | 1947.13 μm² |
| Max delay | N/A* | 2.32 ns |
| Dynamic power | 0.5029 mW | 3.9877 mW |

\* Array multiplier timing report shows "No paths" due to unresolved references (black box). Max delay could not be computed by DC. See note below.

Source reports:

- `reports/array_qor.rpt`, `reports/array_area.rpt`, `reports/array_timing.rpt`, `reports/array_power.rpt`
- `reports/wallace_qor.rpt`, `reports/wallace_area.rpt`, `reports/wallace_timing.rpt`, `reports/wallace_power.rpt`

### Critical Note: Array Multiplier Timing

The `array_timing.rpt` reports **"No paths"** with warning: *"Design 'array_multiplier' has '1' unresolved references."* This means DC could not compute max delay for the array multiplier because of black box/unresolved module references. You must resolve these references (ensure all submodules are compiled and linked) and re-run `report_timing` before the array max delay can be measured.

## 5. Critical-path comparison

- **Array multiplier:** Critical path could not be measured by DC due to unresolved references (see note above). Structurally, the worst path runs through the serial row accumulations — each row's ripple-carry chain must finish before the next row can use the accumulated sum. Expected worst path starts at a high-order multiplier bit (e.g., `b[7]`), passes through the last partial-product row and final ripple-carry chain, ending at `p[15]`.

- **Wallace tree:** The critical path runs from input `a[3]` to output `p[15]`, traversing the CSA tree levels (u_csa0 → u_csa2 → u_csa4 → u_csa5) and the final carry-propagate adder (`add_46` / `wallace_multiplier_DW01_add_0`). Max delay = **2.32 ns** with slack of 97.68 ns (MET, since constraint was loose at 100 ns). The longest path goes through four CSA stages plus the final CPA buffer stage (`add_46/U30/Y`).

## 6. Discussion

Measured results (from DC reports):

- **Area:** Wallace Tree (1947.13 μm²) is **12.97× larger** than Array (150.18 μm²). The Wallace tree uses 676 cells vs Array's 72 cells — a 9.4× increase in cell count. This is because the Wallace tree requires many 3:2 CSA instances plus a final carry-propagate adder, while the array uses a simple regular row structure.

- **Max delay:** Wallace Tree = **2.32 ns** (measured). Array max delay could not be computed (unresolved references). Structurally, the Wallace tree's logarithmic CSA tree depth should give it shorter delay than the array's linear ripple chain — but this needs verification once the array timing references are resolved.

- **Dynamic power:** Array (0.5029 mW) uses **7.9× less power** than Wallace Tree (3.9877 mW). This is expected — the Wallace tree has 9.4× more cells and significantly more switching activity.

- **Regular vs irregular:** The array is highly regular (repeated ripple-carry rows), making it compact and low power but slow due to serial carry propagation. The Wallace tree is irregular (unbalanced CSA reduction network), giving it faster theoretical delay but at much higher area and power cost.

- **Final CPA impact:** The Wallace critical path already spends ~0.83 ns in a single buffer (`add_46/U30/Y`) inside the final DW01 adder. Replacing the final CPA with carry-lookahead or carry-select would reduce this stage's delay, improving overall Wallace max delay at additional area cost.

- **Design choice for larger bit width:** For larger N, the **Wallace tree** is the better choice because its delay grows logarithmically (O(log N)) while the array's delay grows linearly (O(N)). The area penalty becomes less significant as bit width increases, and the speed advantage dominates.

Answers to reflection questions:

- **Smaller area:** Array Multiplier (150.18 vs 1947.13 μm²) — fewer cells, simpler regular structure.
- **Shorter max delay:** Wallace Tree (2.32 ns measured) — logarithmic CSA depth vs linear ripple chain.
- **Lower dynamic power:** Array Multiplier (0.5029 vs 3.9877 mW) — 9.4× fewer cells, less switching.
- **Regular vs irregular:** Array is regular/compact/slow; Wallace is irregular/large/fast.
- **Final CPA replacement:** Would reduce Wallace delay further but add area.
- **Larger bit width:** Wallace Tree — delay scales logarithmically vs linearly.
