# Task B — Discussion: Critical Path Analysis & Scaling (Req 7 & 8)

## Req 7: Critical Path Identification & Structural Difference

### Critical Paths from DC Timing Reports

| Design | Path Type | Start Point | End Point | Data Arrival |
|--------|-----------|-------------|-----------|--------------|
| prefix8_pipe | flop→flop | `B_reg_reg[0]` | `G30_m_reg` | ~0.53 ns |
| prefix8_pipe | flop→output | `S_reg[7]` | `S[7]` | ~0.11 ns |
| csa8_pipe | flop→flop | `B_reg_reg[0]` | `s_lo_reg_reg[1]` | ~0.42 ns |
| csa8_pipe | flop→output | `c_lo_reg_reg` | `S[7]` | ~0.50 ns |

### Structural Difference: Prefix Tree vs Mux Chain

**prefix8_pipe (Sklansky parallel prefix tree):**
- The critical path (`B_reg_reg[0]` → `G30_m_reg`) traverses the **prefix tree reduction levels**.
- In a Sklansky tree, carries are computed in logarithmic depth: level 1 (adjacent pairs), level 2 (groups of 4), level 3 (groups of 8).
- The worst path goes through multiple black/gray cell stages (dot-operator compositions) before reaching the final carry register.
- Because the tree is balanced, no single stage dominates, but the cumulative delay through log₂(8) = 3 reduction levels sets the flop→flop bound.
- The flop→output path (`S_reg[7]` → `S[7]`) is short because it only XORs the final carry with the propagate signal — just one gate after the output register.

**csa8_pipe (carry-select with mux chain):**
- The critical path (`B_reg_reg[0]` → `s_lo_reg_reg[1]`) goes through **block 0 (lowest 2 bits)** first, then the carry ripples through the mux chain.
- Block 0 computes with the real carry-in. Its carry-out (`c_lo`) selects between the two precomputed results of block 1. Block 1's selected carry selects block 2, and so on.
- This creates a **serial mux chain**: sel[1] → sel[2] → sel[3] → sel[4]. Each mux adds delay.
- The flop→output path (`c_lo_reg_reg` → `S[7]`) is longer (0.50 ns) than prefix's (0.11 ns) because the output sum bits depend on the fully resolved carry chain through all muxes.

### Key Structural Contrast

| Aspect | Prefix Tree (prefix8_pipe) | Carry-Select (csa8_pipe) |
|--------|---------------------------|--------------------------|
| Critical path structure | Balanced tree (log depth) | Serial mux chain (linear depth) |
| Flop→flop delay | 0.53 ns | 0.42 ns |
| Flop→output delay | 0.11 ns | 0.50 ns |
| Path-determining logic | PG dot-operator composition | 2:1 mux select chain |
| Worst path start | `B_reg_reg[0]` (carry-in to tree) | `B_reg_reg[0]` (carry into block 0) |

**Counterintuitive result:** The prefix tree has a longer flop→flop delay (0.53 vs 0.42 ns) but a much shorter flop→output delay (0.11 vs 0.50 ns). This is because the prefix tree computes all carries in parallel within the tree (distributed delay), while carry-select resolves carries sequentially through the mux chain (concentrated delay at the output).

## Req 8: Scaling as Bit-Width N Grows

### Prefix Tree Scaling

- **Area:** O(N log N) — each prefix level needs O(N) cells, and there are log₂(N) levels.
- **Delay:** O(log N) — the tree depth grows logarithmically. Doubling N adds only one prefix level.
- **Critical path:** Grows slowly with N. At N=8, 3 levels; at N=16, 4 levels; at N=32, 5 levels.
- **Scaling verdict:** **Scales well.** Best for wide adders where delay matters more than area.

### Carry-Select Scaling

- **Area:** O(N) per block × O(N/block_size) blocks = O(N²/block_size) if block size fixed, or O(N log N) with optimal blocking. Carry-select duplicates hardware for carry-in 0 and 1.
- **Delay:** O(N/block_size) for the mux chain — linear in the number of blocks. To reduce delay, you need smaller blocks, which increases area quadratically.
- **Critical path:** Grows linearly with N (through the mux chain). At N=8, 4 muxes; at N=16, 8 muxes; at N=32, 16 muxes.
- **Scaling verdict:** **Scales poorly.** The mux chain becomes the bottleneck for wide adders.

### Recommendation

| Metric | Winner | Why |
|--------|--------|-----|
| Small N (≤8) | Carry-select | Simpler, slightly less area, lower flop→flop delay |
| Large N (>16) | Prefix tree | Logarithmic delay growth beats linear mux chain |
| Balanced design | Prefix tree | Better flop→output delay at all widths |

**Conclusion:** The prefix tree architecture scales better as bit-width N grows because its delay grows logarithmically (O(log N)) through the balanced tree, whereas the carry-select mux chain grows linearly (O(N/k) where k is block size). For wide adders, the prefix tree's parallel carry computation dominates, while carry-select's serial mux resolution becomes the bottleneck.
