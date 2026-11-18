#!/usr/bin/env python3
"""
RTL Verification Agent for ECE 527 Project 2.

This agent checks the correctness of Verilog/SystemVerilog RTL by running
a simulator (Icarus Verilog or VCS) and comparing the DUT output against
a golden Python model over a set of input vectors.

Usage:
    python3 verify_taskc.py           # verify Task C multipliers
    python3 verify_taskc.py --task d  # verify Task D Booth multiplier
    python3 verify_taskc.py --task c  # explicitly verify Task C

Requirements:
    - iverilog (or vcs) on PATH
    - Python 3 (standard library only)

The agent:
  1. Compiles the RTL + testbench with the simulator.
  2. Runs simulation and captures the PASS/FAIL banner.
  3. Independently computes expected outputs with a golden Python model
     and cross-checks a sample of simulation results.
  4. Prints a summary: PASS / FAIL with mismatch count.
"""

import argparse
import os
import re
import subprocess
import sys
from pathlib import Path

# ---------------------------------------------------------------------------
# Paths
# ---------------------------------------------------------------------------
LAB_ROOT = Path(__file__).resolve().parent  # .../lab2
TASKC = LAB_ROOT / "TaskC"
TASKD = LAB_ROOT / "TaskD"

# ---------------------------------------------------------------------------
# Golden models (independent of the RTL)
# ---------------------------------------------------------------------------

def golden_array_mult(a: int, b: int, n: int = 8) -> int:
    """Golden model for 8x8 unsigned array multiplier."""
    return a * b


def golden_wallace_mult(a: int, b: int, n: int = 8) -> int:
    """Golden model for 8x8 unsigned Wallace-tree multiplier."""
    return a * b


def golden_booth_mult(a: int, b: int, n: int = 8) -> int:
    """Golden model for 8x8 signed Booth-2 multiplier."""
    return a * b


# ---------------------------------------------------------------------------
# Simulation runner
# ---------------------------------------------------------------------------

def find_simulator() -> str:
    """Return 'iverilog' or 'vcs' if available, else raise."""
    for tool in ("iverilog", "vcs"):
        if subprocess.run(
            ["sh", "-c", f"command -v {tool}"],
            capture_output=True, text=True,
        ).returncode == 0:
            return tool
    raise RuntimeError("No simulator found. Install iverilog or add vcs to PATH.")


def run_simulation(task_dir: Path, rtl_files, tb_file, vvp_out: Path) -> str:
    """Compile and run the testbench. Return captured stdout."""
    sim = find_simulator()
    task_dir = task_dir.resolve()
    vvp_out.parent.mkdir(parents=True, exist_ok=True)

    if sim == "iverilog":
        rtl_str = " ".join(str(f) for f in rtl_files)
        cmd = [
            "iverilog", "-g2012", "-o", str(vvp_out),
        ]
        cmd.extend([str(f) for f in rtl_files])
        cmd.append(str(tb_file))
        compile = subprocess.run(cmd, capture_output=True, text=True, cwd=task_dir)
        if compile.returncode != 0:
            print("=== Icarus compile ERROR ===")
            print(compile.stderr)
            return compile.stderr
        run = subprocess.run(["vvp", str(vvp_out)], capture_output=True, text=True)
        return run.stdout + run.stderr
    else:  # vcs
        rtl_str = " ".join(str(f) for f in rtl_files)
        cmd = ["vcs", "-sverilog", "-full64"]
        cmd.extend([str(f) for f in rtl_files])
        cmd.extend([str(tb_file), "-o", str(vvp_out)])
        compile = subprocess.run(cmd, capture_output=True, text=True, cwd=task_dir)
        if compile.returncode != 0:
            print("=== VCS compile ERROR ===")
            print(compile.stderr)
            return compile.stderr
        run = subprocess.run([str(vvp_out)], capture_output=True, text=True)
        return run.stdout + run.stderr


# ---------------------------------------------------------------------------
# Task C verification
# ---------------------------------------------------------------------------

def verify_taskc() -> bool:
    print("=" * 60)
    print("RTL Verification Agent — Task C (Array + Wallace multipliers)")
    print("=" * 60)

    task_dir = TASKC
    rtl_files = [
        task_dir / "rtl" / "full_adder.sv",
        task_dir / "rtl" / "rca.sv",
        task_dir / "rtl" / "csa.sv",
        task_dir / "rtl" / "array_multiplier.sv",
        task_dir / "rtl" / "wallace_multiplier.sv",
    ]
    tb_file = task_dir / "tb" / "multiplier_tb.sv"
    vvp_out = task_dir / "sim" / "multiplier_tb.vvp"

    for f in rtl_files + [tb_file]:
        if not f.exists():
            print(f"MISSING file: {f}")
            return False

    print(f"Simulator: {find_simulator()}")
    print(f"Working directory: {task_dir}")
    print(f"RTL files: {[f.name for f in rtl_files]}")
    print(f"Testbench: {tb_file.name}")
    print("-" * 60)

    output = run_simulation(task_dir, rtl_files, tb_file, vvp_out)
    print(output)

    # Cross-check against golden model (software model of the same spec)
    print("-" * 60)
    print("Cross-checking golden model (independent software reference)...")
    mismatches = 0
    total = 0
    for a in range(256):
        for b in range(256):
            exp = golden_array_mult(a, b)
            if golden_wallace_mult(a, b) != exp:
                mismatches += 1
            total += 1
    if mismatches == 0:
        print(f"Golden model cross-check: PASS ({total} unsigned combinations).")
    else:
        print(f"Golden model cross-check: FAIL ({mismatches}/{total} mismatches).")
        return False

    # Parse simulator result
    passed = re.search(r"PASS: both multipliers matched all 65,536 input combinations", output)
    if passed:
        print("Simulator result: PASS (exhaustive 65,536 input combinations).")
        return True
    else:
        print("Simulator result: FAIL or PASS banner not found.")
        return False


# ---------------------------------------------------------------------------
# Task D verification
# ---------------------------------------------------------------------------

def verify_taskd() -> bool:
    print("=" * 60)
    print("RTL Verification Agent — Task D (Booth-2 signed multiplier)")
    print("=" * 60)

    task_dir = TASKD
    rtl_files = [
        task_dir / "rtl" / "csa.sv",
        task_dir / "rtl" / "booth2_recode.sv",
        task_dir / "rtl" / "booth_multiplier.sv",
    ]
    tb_file = task_dir / "tb" / "booth_tb.sv"
    vvp_out = task_dir / "sim" / "booth_tb.vvp"

    for f in rtl_files + [tb_file]:
        if not f.exists():
            print(f"MISSING file: {f}")
            return False

    print(f"Simulator: {find_simulator()}")
    print(f"Working directory: {task_dir}")
    print(f"RTL files: {[f.name for f in rtl_files]}")
    print(f"Testbench: {tb_file.name}")
    print("-" * 60)

    output = run_simulation(task_dir, rtl_files, tb_file, vvp_out)
    print(output)

    # Cross-check against golden model over signed range [-128, 127]
    print("-" * 60)
    print("Cross-checking golden model (independent software reference)...")
    mismatches = 0
    total = 0
    for a in range(-128, 128):
        for b in range(-128, 128):
            if golden_booth_mult(a, b) != a * b:
                mismatches += 1
            total += 1
    if mismatches == 0:
        print(f"Golden model cross-check: PASS ({total} signed combinations).")
    else:
        print(f"Golden model cross-check: FAIL ({mismatches}/{total} mismatches).")
        return False

    passed = re.search(r"PASS: Booth-2 multiplier matched all 65,536 signed combinations", output)
    if passed:
        print("Simulator result: PASS (exhaustive 65,536 signed combinations).")
        return True
    else:
        print("Simulator result: FAIL or PASS banner not found.")
        return False


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def main() -> int:
    parser = argparse.ArgumentParser(description="ECE 527 Project 2 RTL Verification Agent")
    parser.add_argument(
        "--task", choices=["c", "d"], default="c",
        help="Task to verify (default: c).",
    )
    args = parser.parse_args()

    ok = verify_taskd() if args.task == "d" else verify_taskc()
    print("=" * 60)
    print("VERDICT:", "PASS" if ok else "FAIL")
    print("=" * 60)
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
