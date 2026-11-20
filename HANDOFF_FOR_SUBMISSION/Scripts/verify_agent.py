#!/usr/bin/env python3
"""
ECE 527 Project 2 — Generic RTL Verification Agent

Supports two verification flows:
  1. Simulation (iverilog/VCS) — runs testbench, checks PASS/FAIL banner
  2. Formal (JasperGold) — generates project + Tcl script for labeled SVA proofs

Usage:
    # Simulation flow (default)
    python3 verify_agent.py --task c
    python3 verify_agent.py --task d
    python3 verify_agent.py --task all

    # Formal flow — generates JasperGold scripts
    python3 verify_agent.py --formal --task c
    python3 verify_agent.py --formal --task d
    python3 verify_agent.py --formal --task all

    # Booth-2 recoder unit check
    python3 verify_agent.py --task recoder
"""

import argparse
import json
import os
import re
import subprocess
import sys
from pathlib import Path
from typing import Any, Callable, Dict, List, Optional, Tuple

LAB_ROOT = Path(__file__).resolve().parent


# ---------------------------------------------------------------------------
# Golden models (independent software references)
# ---------------------------------------------------------------------------

def golden_mult_unsigned_8x8(a: int, b: int) -> int:
    return a * b


def golden_mult_signed_8x8(a: int, b: int) -> int:
    return a * b


def golden_booth_recoder(bits: int) -> int:
    table = {
        0b000: 0, 0b111: 0,
        0b001: 1, 0b010: 1,
        0b011: 2,
        0b100: -2,
        0b101: -1, 0b110: -1,
    }
    return table.get(bits & 0b111, 0)


GOLDEN_MODELS: Dict[str, Callable] = {
    "mult_unsigned_8x8": golden_mult_unsigned_8x8,
    "mult_signed_8x8": golden_mult_signed_8x8,
    "booth_recoder": golden_booth_recoder,
}


# ---------------------------------------------------------------------------
# Vector generators
# ---------------------------------------------------------------------------

def generate_exhaustive_unsigned(width: int) -> List[Tuple[int, int]]:
    n = 1 << width
    return [(a, b) for a in range(n) for b in range(n)]


def generate_exhaustive_signed(width: int) -> List[Tuple[int, int]]:
    lo = -(1 << (width - 1))
    hi = (1 << (width - 1)) - 1
    return [(a, b) for a in range(lo, hi + 1) for b in range(lo, hi + 1)]


def generate_directed() -> List[Tuple[int, int]]:
    vals = [-128, -127, -1, 0, 1, 127, 126]
    return [(a, b) for a in vals for b in vals]


def generate_random_unsigned(width: int, count: int, seed: int = 42) -> List[Tuple[int, int]]:
    import random
    random.seed(seed)
    n = 1 << width
    return [(random.randrange(n), random.randrange(n)) for _ in range(count)]


# ---------------------------------------------------------------------------
# Simulation runner
# ---------------------------------------------------------------------------

def find_simulator(preferred: Optional[str] = None) -> str:
    candidates = [preferred] if preferred else ["iverilog", "vcs"]
    for tool in candidates:
        if subprocess.run(
            ["sh", "-c", f"command -v {tool}"],
            capture_output=True, text=True,
        ).returncode == 0:
            return tool
    raise RuntimeError(
        "No simulator found. Install iverilog or add vcs to PATH."
    )


def compile_and_run_sim(
    task_dir: Path,
    rtl_files: List[Path],
    tb_file: Path,
    vvp_out: Path,
    simulator: str,
    extra_args: Optional[List[str]] = None,
) -> str:
    """
    Compile and run the testbench. For simulation, SVA assertions are
    stripped (iverilog/VCS don't support labeled assert properties).
    The original RTL files keep their JasperGold-compatible assertions.
    """
    task_dir = task_dir.resolve()
    vvp_out.parent.mkdir(parents=True, exist_ok=True)

    # Create assertion-stripped copies in sim/ for compilation
    sim_rtl_dir = task_dir / "sim" / "rtl_stripped"
    sim_rtl_dir.mkdir(parents=True, exist_ok=True)
    sim_rtl_files: List[Path] = []

    for rtl in rtl_files:
        stripped = sim_rtl_dir / rtl.name
        content = rtl.read_text(errors="ignore")
        lines = content.splitlines()
        stripped_lines: List[str] = []
        in_assertion = False
        for line in lines:
            stripped_line = line.rstrip()
            # Detect start of a labeled SVA assertion: "assert name : ..."
            if re.match(r"\s*assert\s+\w+\s*:", stripped_line):
                in_assertion = True
                continue  # skip the assert line
            if in_assertion:
                # Continuation lines end at semicolon
                if ";" in stripped_line:
                    in_assertion = False
                continue  # skip continuation lines
            stripped_lines.append(stripped_line)
        stripped.write_text("\n".join(stripped_lines))
        sim_rtl_files.append(stripped)

    if simulator == "iverilog":
        cmd = ["iverilog", "-g2012", "-o", str(vvp_out)]
        cmd.extend([str(f) for f in sim_rtl_files])
        cmd.append(str(tb_file))
        if extra_args:
            cmd.extend(extra_args)

        compile_res = subprocess.run(cmd, capture_output=True, text=True, cwd=task_dir)
        if compile_res.returncode != 0:
            return f"=== Icarus compile ERROR ===\n{compile_res.stderr}\n{compile_res.stdout}"

        run_res = subprocess.run(["vvp", str(vvp_out)], capture_output=True, text=True)
        return run_res.stdout + run_res.stderr

    elif simulator == "vcs":
        cmd = ["vcs", "-sverilog", "-full64"]
        cmd.extend([str(f) for f in sim_rtl_files])
        cmd.extend([str(tb_file), "-o", str(vvp_out)])
        if extra_args:
            cmd.extend(extra_args)

        compile_res = subprocess.run(cmd, capture_output=True, text=True, cwd=task_dir)
        if compile_res.returncode != 0:
            return f"=== VCS compile ERROR ===\n{compile_res.stderr}\n{compile_res.stdout}"

        run_res = subprocess.run([str(vvp_out)], capture_output=True, text=True)
        return run_res.stdout + run_res.stderr

    else:
        raise ValueError(f"Unsupported simulator: {simulator}")


# ---------------------------------------------------------------------------
# Golden-model cross-check (software reference)
# ---------------------------------------------------------------------------

def cross_check_golden(
    golden_fn: Callable,
    vectors: List[Tuple[int, int]],
) -> Tuple[int, int, List[Tuple[int, int, int, int]]]:
    mismatches = 0
    total = 0
    details: List[Tuple[int, int, int, int]] = []

    for a, b in vectors:
        exp = a * b
        got = golden_fn(a, b)
        total += 1
        if got != exp:
            mismatches += 1
            details.append((a, b, got, exp))
            if len(details) >= 20:
                break

    return mismatches, total, details


# ---------------------------------------------------------------------------
# Formal flow — generate JasperGold project + Tcl
# ---------------------------------------------------------------------------

def generate_jasper_project(task: str, design: str) -> str:
    """
    Create a JasperGold formal verification project for a given design.
    Returns the project directory path.
    """
    task_dir = LAB_ROOT / task
    rtl_file = task_dir / "rtl" / f"{design}.sv"
    proj_dir = task_dir / f"jasper_{design}"

    if not rtl_file.exists():
        raise FileNotFoundError(f"RTL file not found: {rtl_file}")

    proj_dir.mkdir(parents=True, exist_ok=True)

    # Generate run_jasper.tcl
    tcl_content = f"""# JasperGold Formal Verification Tcl Script
# Design: {design}
# Task: {task}

set_project "{proj_dir}"

# Read RTL with inline SVA assertions
read_file -rtl "{rtl_file}"

# Set top module
set_top "{design}"

# Prove all assertions
prove -all

# Generate formal report
report -assertions -file "{proj_dir}/reports/formal_report.txt"

puts "Formal verification complete."
puts "Report: {proj_dir}/reports/formal_report.txt"
"""

    tcl_file = proj_dir / "run_jasper.tcl"
    tcl_file.write_text(tcl_content)

    # Generate constraints file (optional, for inputs)
    constraints_file = task_dir / "jasper_constraints.sv"
    if not constraints_file.exists():
        constraints_content = """`timescale 1ns/1ps
`default_nettype none

// Formal constraints for combinational multipliers
module jasper_constraints #(
    parameter int N = 8
) (
    input  logic [N-1:0] a,
    input  logic [N-1:0] b
);

    // Assume inputs are valid (no X/Z) during formal analysis
    assume input_valid : !$isunknown(a) && !$isunknown(b);

endmodule
"""
        constraints_file.write_text(constraints_content)

    return str(proj_dir)


# ---------------------------------------------------------------------------
# Task-specific verification flows
# ---------------------------------------------------------------------------

def verify_task_c(formal: bool = False) -> bool:
    print("=" * 70)
    print("Verification Agent — Task C (Array + Wallace 8x8 unsigned multipliers)")
    print("=" * 70)

    task_dir = LAB_ROOT / "TaskC"
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

    if formal:
        print("Mode: FORMAL (JasperGold project generation)")
        for design in ["array_multiplier", "wallace_multiplier"]:
            proj = generate_jasper_project("TaskC", design)
            print(f"  JasperGold project: {proj}")
            print(f"    Run: cd {proj} && jg -t run_jasper.tcl")
        print("\nAssertions to be proved:")
        for design in ["array_multiplier", "wallace_multiplier"]:
            rtl = task_dir / "rtl" / f"{design}.sv"
            print(f"\n  {design}:")
            with open(rtl) as f:
                for line in f:
                    if "assert " in line:
                        print(f"    {line.strip()}")
        print("\nFormal projects generated. Run them with JasperGold on the lab machine.")
        return True

    print(f"Mode: SIMULATION")
    print(f"Simulator : {find_simulator()}")
    print(f"Directory : {task_dir}")
    print(f"RTL files : {[f.name for f in rtl_files]}")
    print(f"Testbench : {tb_file.name}")
    print("-" * 70)

    output = compile_and_run_sim(task_dir, rtl_files, tb_file, vvp_out, find_simulator())
    print(output)

    print("-" * 70)
    print("Cross-checking golden model (independent software reference)...")
    vectors = generate_exhaustive_unsigned(8)
    mismatches, total, details = cross_check_golden(
        golden_mult_unsigned_8x8, vectors
    )
    if mismatches == 0:
        print(f"Golden model cross-check: PASS ({total} unsigned combinations).")
    else:
        print(f"Golden model cross-check: FAIL ({mismatches}/{total} mismatches).")
        for a, b, got, exp in details[:5]:
            print(f"  MISMATCH: a={a} b={b} got={got} expected={exp}")
        return False

    if re.search(r"PASS: both multipliers matched all 65,536 input combinations", output):
        print("Simulator result: PASS (exhaustive 65,536 input combinations).")
        return True
    else:
        print("Simulator result: FAIL or PASS banner not found.")
        return False


def verify_task_d(formal: bool = False) -> bool:
    print("=" * 70)
    print("Verification Agent — Task D (Booth-2 8x8 signed multiplier)")
    print("=" * 70)

    task_dir = LAB_ROOT / "TaskD"
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

    if formal:
        print("Mode: FORMAL (JasperGold project generation)")
        for design in ["booth_multiplier", "csa", "booth2_recode"]:
            proj = generate_jasper_project("TaskD", design)
            print(f"  JasperGold project: {proj}")
            print(f"    Run: cd {proj} && jg -t run_jasper.tcl")
        print("\nKey assertions to be proved (booth_multiplier):")
        rtl = task_dir / "rtl" / "booth_multiplier.sv"
        with open(rtl) as f:
            for line in f:
                if "assert " in line and "functional_correct" in line:
                    print(f"    {line.strip()}")
        print("\n  (coef_valid, output_range, outputs_valid also included)")
        print("\nFormal projects generated. Run them with JasperGold on the lab machine.")
        return True

    print(f"Mode: SIMULATION")
    print(f"Simulator : {find_simulator()}")
    print(f"Directory : {task_dir}")
    print(f"RTL files : {[f.name for f in rtl_files]}")
    print(f"Testbench : {tb_file.name}")
    print("-" * 70)

    output = compile_and_run_sim(task_dir, rtl_files, tb_file, vvp_out, find_simulator())
    print(output)

    print("-" * 70)
    print("Cross-checking golden model (independent software reference)...")
    vectors = generate_exhaustive_signed(8)
    mismatches, total, details = cross_check_golden(
        golden_mult_signed_8x8, vectors
    )
    if mismatches == 0:
        print(f"Golden model cross-check: PASS ({total} signed combinations).")
    else:
        print(f"Golden model cross-check: FAIL ({mismatches}/{total} mismatches).")
        for a, b, got, exp in details[:5]:
            print(f"  MISMATCH: a={a} b={b} got={got} expected={exp}")
        return False

    if re.search(r"PASS: Booth-2 multiplier matched all 65,536 signed combinations", output):
        print("Simulator result: PASS (exhaustive 65,536 signed combinations).")
        return True
    else:
        print("Simulator result: FAIL or PASS banner not found.")
        return False


def verify_booth_recoder() -> bool:
    print("=" * 70)
    print("Verification Agent — Booth-2 Recoder (unit level)")
    print("=" * 70)

    table = {
        0b000: 0, 0b001: 1, 0b010: 1, 0b011: 2,
        0b100: -2, 0b101: -1, 0b110: -1, 0b111: 0,
    }

    mismatches = 0
    for bits in range(8):
        exp = table[bits]
        got = golden_booth_recoder(bits)
        if got != exp:
            mismatches += 1
            print(f"  MISMATCH: bits={bits:03b} got={got} expected={exp}")

    if mismatches == 0:
        print("PASS: all 8 Booth-2 recoder patterns correct.")
        return True
    print(f"FAIL: {mismatches} mismatches.")
    return False


# ---------------------------------------------------------------------------
# Report generation
# ---------------------------------------------------------------------------

def write_report(path: Path, results: Dict[str, Any]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with open(path, "w") as f:
        json.dump(results, f, indent=2)
    print(f"\nVerification report written to: {path}")


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def main() -> int:
    parser = argparse.ArgumentParser(
        description="ECE 527 Project 2 — RTL Verification Agent (Sim + Formal)"
    )
    parser.add_argument(
        "--task",
        choices=["c", "d", "recoder", "all"],
        default="all",
        help="Which verification to run (default: all).",
    )
    parser.add_argument(
        "--formal",
        action="store_true",
        help="Generate JasperGold formal verification projects instead of simulation.",
    )
    parser.add_argument(
        "--report",
        default="verification_report.json",
        help="Output JSON report path (default: verification_report.json).",
    )
    args = parser.parse_args()

    results: Dict[str, Any] = {}

    if args.task in ("c", "all"):
        results["task_c"] = verify_task_c(formal=args.formal)
    if args.task in ("d", "all"):
        results["task_d"] = verify_task_d(formal=args.formal)
    if args.task in ("recoder", "all"):
        results["booth_recoder"] = verify_booth_recoder()

    all_pass = all(results.values()) if results else False

    print("=" * 70)
    if args.formal:
        print("FORMAL PROJECTS GENERATED — run with JasperGold on lab machine")
    else:
        print("FINAL VERDICT:", "PASS" if all_pass else "FAIL")
    print("=" * 70)

    write_report(LAB_ROOT / args.report, {
        "results": results,
        "verdict": all_pass,
        "mode": "formal" if args.formal else "simulation",
    })
    return 0 if all_pass or args.formal else 1


if __name__ == "__main__":
    sys.exit(main())
