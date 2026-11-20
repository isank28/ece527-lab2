# ECE 527 Project 2 — Verification Plan (Task C & Task D)

## 1. Objectives

| Goal | Method |
|------|--------|
| Functional correctness | Exhaustive simulation against golden Python model |
| Corner-case coverage | Directed tests (0, ±1, −128, 127, −128×−128) |
| Timing correctness | DC max-delay report → critical path identification |
| Area/power comparison | DC report parsing → side-by-side table |
| Early bug capture | SystemVerilog Assertions (SVA) + formal properties |

## 2. Verification Levels

### Level 1 — Unit / Block Level
- **Full adder**: all 8 input combinations (a, b, cin)
- **RCA**: ripple carry chains, carry propagation
- **CSA**: sum = a ⊕ b ⊕ c, carry = majority(a,b,c)
- **Booth recoder**: all 8 possible 3-bit group patterns → coefficient mapping

### Level 2 — Multiplier Level (Task C & D)
- **Exhaustive simulation**: all 256 × 256 unsigned (Task C) and all 65,536 signed (Task D)
- **Directed corner cases**: `a=0`, `b=0`, `a=±128`, `b=±128`, `a=127`, `b=127`, `a=−128`, `b=−128`
- **Range check**: output must fit in 16 bits signed/unsigned

### Level 3 — System Level
- Common testbench for both Task C multipliers
- Compare array vs Wallace cycle-accurate (combinational delay)
- Compare Task C array vs Task D Booth (signed vs unsigned)

### Level 4 — Formal (optional, if formal tool available)
- **Assert**: combinational output equals golden model for all inputs (bounded model check)
- **Cover**: every Booth recoder output, every CSA stage, every final-adder path
- **Assume**: inputs are stable before output is sampled

## 3. Simulation Flow

```
1. Compile RTL + testbench with iverilog or VCS
2. Run exhaustive simulation
3. Capture PASS/FAIL banner
4. Cross-check against independent Python golden model
5. Generate coverage report (if supported)
```

## 4. Formal Verification Flow (template)

```
1. Write SVA properties (assert/assume/cover)
2. Bind assertions to DUT
3. Run bounded model checking (e.g., JasperGold, VC Formal, Questa Formal)
4. Check for counterexamples on:
   - output range violation
   - partial product sign-extension error
   - recoder-to-coefficient mismatch
```

## 5. Exit Criteria

- [ ] Exhaustive simulation: 0 mismatches
- [ ] Corner cases: all pass
- [ ] SVA assertions: no violations during simulation
- [ ] DC reports: area/delay/power extracted into comparison table
- [ ] Formal (if available): no counterexamples found
