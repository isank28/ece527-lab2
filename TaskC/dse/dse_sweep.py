#!/usr/bin/env python3
"""
ECE 527 Project 2 — Task C Design Space Exploration (DSE)

Sweeps bit-width N = {4, 8, 16, 32} for both Array and Wallace-tree
multipliers, synthesizes each with Design Compiler, parses area/delay,
and plots delay vs. area to show the crossover point.

Two modes:
  1. DC mode: runs Design Compiler on the VLSI lab machine (dc_shell required)
  2. Model mode: uses analytical delay/area models (no DC needed — good for
     planning and for generating the scripts you'll run on the lab machine)

Outputs:
  - dse/results.csv        — raw metrics per (architecture, N)
  - dse/plots/delay_vs_area.png
  - dse/plots/delay_vs_N.png
  - dse/plots/area_vs_N.png
  - dse/scripts/           — DC TCL scripts per (architecture, N)

Usage:
    cd /Users/victor/ece527/lab2/TaskC
    python3 dse/dse_sweep.py --mode model        # generate scripts + analytical model
    python3 dse/dse_sweep.py --mode dc           # run DC (lab machine only)
    python3 dse/dse_sweep.py --mode both         # model + DC if available
"""

import argparse
import csv
import math
import os
import subprocess
import sys
from pathlib import Path

try:
    import matplotlib
    matplotlib.use("Agg")
    import matplotlib.pyplot as plt
    HAS_MPL = True
except ImportError:
    HAS_MPL = False

TASKC_ROOT = Path(__file__).resolve().parent.parent  # TaskC/ (script is in TaskC/dse/)
DSE_ROOT = TASKC_ROOT / "dse"
RTL_DIR = DSE_ROOT / "rtl"
LIB = TASKC_ROOT / "lib" / "gscl45nm.db"

N_VALUES = [4, 8, 16, 32]
ARCHITECTURES = ["array", "wallace"]


# ---------------------------------------------------------------------------
# RTL generation (string concatenation to avoid f-string brace issues)
# ---------------------------------------------------------------------------

def pp_assign_line(i, N, W):
    """Generate one partial-product assignment line."""
    return (
        "    assign pp[" + str(i) + "] = ({" + str(W - N) + "{1'b0}}, a} & "
        "{" + str(W) + "{b[" + str(i) + "]}}) << " + str(i) + ";"
    )


def generate_array_multiplier_sv(N: int, out_path: Path) -> None:
    """Generate array multiplier RTL for bit-width N."""
    W = 2 * N
    lines = [
        "`timescale 1ns/1ps",
        "`default_nettype none",
        "// " + str(N) + "x" + str(N) + " unsigned array multiplier (DSE generated)",
        "module array_multiplier_" + str(N) + "x" + str(N) + " (",
        "    input  logic [" + str(N - 1) + ":0]   a,",
        "    input  logic [" + str(N - 1) + ":0]   b,",
        "    output logic [" + str(W - 1) + ":0]   p",
        ");",
        "",
        "    localparam int W = " + str(W) + ";",
        "",
        "    logic [W-1:0] pp  [0:" + str(N - 1) + "];",
        "    logic [W-1:0] acc [0:" + str(N - 1) + "];",
        "",
        "    genvar i;",
        "",
    ]
    for i in range(N):
        lines.append(pp_assign_line(i, N, W))
    lines.append("")
    lines.append("    assign acc[0] = pp[0];")
    lines.append("")
    for i in range(1, N):
        lines.append("    wire [W-1:0] acc_" + str(i) + "_sum;")
        lines.append("    wire           acc_" + str(i) + "_cout;")
        lines.append("")
        lines.append("    // Row " + str(i) + ": acc[" + str(i - 1) + "] + pp[" + str(i) + "]")
        lines.append(
            "    assign acc_" + str(i) + "_sum[0] = acc[" + str(i - 1) + "][0] ^ pp[" + str(i) + "][0];"
        )
        lines.append(
            "    wire c" + str(i) + "_0 = acc[" + str(i - 1) + "][0] & pp[" + str(i) + "][0];"
        )
        for j in range(1, W):
            lines.append(
                "    wire c" + str(i) + "_" + str(j) + " = (acc[" + str(i - 1) + "][" + str(j) + "] & pp[" + str(i) + "][" + str(j) + "]) | "
                "(acc[" + str(i - 1) + "][" + str(j) + "] & c" + str(i) + "_" + str(j - 1) + ") | "
                "(pp[" + str(i) + "][" + str(j) + "] & c" + str(i) + "_" + str(j - 1) + ");"
            )
            lines.append(
                "    assign acc_" + str(i) + "_sum[" + str(j) + "] = acc[" + str(i - 1) + "][" + str(j) + "] ^ pp[" + str(i) + "][" + str(j) + "] ^ c" + str(i) + "_" + str(j - 1) + ";"
            )
        lines.append("    assign acc[" + str(i) + "] = acc_" + str(i) + "_sum;")
        lines.append("")
    lines.append("    assign p = acc[N-1];")
    lines.append("")
    lines.append("endmodule")
    lines.append("`default_nettype wire")
    out_path.write_text("\n".join(lines))


def generate_wallace_multiplier_sv(N: int, out_path: Path) -> None:
    """
    Generate a Wallace-tree multiplier RTL for bit-width N.
    Builds a general CSA reduction tree: N partial-product rows -> 2 rows -> CPA.
    """
    W = 2 * N
    lines = [
        "`timescale 1ns/1ps",
        "`default_nettype none",
        "// " + str(N) + "x" + str(N) + " unsigned Wallace-tree multiplier (DSE generated)",
        "module wallace_multiplier_" + str(N) + "x" + str(N) + " (",
        "    input  logic [" + str(N - 1) + ":0]   a,",
        "    input  logic [" + str(N - 1) + ":0]   b,",
        "    output logic [" + str(W - 1) + ":0]   p",
        ");",
        "",
        "    localparam int W = " + str(W) + ";",
        "",
        "    logic [W-1:0] pp [0:" + str(N - 1) + "];",
        "",
        "    genvar i;",
        "",
    ]
    for i in range(N):
        lines.append(pp_assign_line(i, N, W))
    lines.append("")

    # Wallace reduction: reduce N rows to 2 rows using 3:2 CSAs
    current_rows = ["pp[" + str(i) + "]" for i in range(N)]
    stage = 0
    csa_count = 0

    while len(current_rows) > 2:
        next_rows = []
        i = 0
        while i < len(current_rows):
            if i + 2 < len(current_rows):
                a_name = current_rows[i]
                b_name = current_rows[i + 1]
                c_name = current_rows[i + 2]
                s_name = "s_" + str(stage) + "_" + str(csa_count)
                c_name_out = "c_" + str(stage) + "_" + str(csa_count)
                lines.append("    logic [W-1:0] " + s_name + ";")
                lines.append("    logic [W-1:0] " + c_name_out + ";")
                lines.append("    // CSA stage " + str(stage) + " csa " + str(csa_count))
                lines.append("    assign " + s_name + " = " + a_name + " ^ " + b_name + " ^ " + c_name + ";")
                lines.append("    assign " + c_name_out + "[0] = 1'b0;")
                for bit in range(1, W):
                    lines.append(
                        "    assign " + c_name_out + "[" + str(bit) + "] = "
                        "(" + a_name + "[" + str(bit - 1) + "] & " + b_name + "[" + str(bit - 1) + "]) | "
                        "(" + a_name + "[" + str(bit - 1) + "] & " + c_name + "[" + str(bit - 1) + "]) | "
                        "(" + b_name + "[" + str(bit - 1) + "] & " + c_name + "[" + str(bit - 1) + "]);"
                    )
                next_rows.append(s_name)
                next_rows.append(c_name_out)
                csa_count += 1
                i += 3
            else:
                next_rows.append(current_rows[i])
                i += 1
        current_rows = next_rows
        stage += 1
        lines.append("")

    # Final CPA
    a_final = current_rows[0]
    b_final = current_rows[1]
    lines.append("    logic [W:0] final_sum_stage" + str(stage - 1) + ";")
    lines.append(
        "    assign final_sum_stage" + str(stage - 1) + " = {1'b0, " + a_final + "} + {1'b0, " + b_final + "};"
    )
    lines.append("    assign p = final_sum_stage" + str(stage - 1) + "[" + str(W - 1) + ":0];")
    lines.append("")
    lines.append("endmodule")
    lines.append("`default_nettype wire")
    out_path.write_text("\n".join(lines))


def generate_all_rtl() -> None:
    """Generate RTL for all N values and both architectures."""
    RTL_DIR.mkdir(parents=True, exist_ok=True)
    for N in N_VALUES:
        for arch in ARCHITECTURES:
            if arch == "array":
                generate_array_multiplier_sv(N, RTL_DIR / ("array_" + str(N) + "x" + str(N) + ".sv"))
            else:
                generate_wallace_multiplier_sv(N, RTL_DIR / ("wallace_" + str(N) + "x" + str(N) + ".sv"))
    print("Generated RTL for N=" + str(N_VALUES) + ", arch=" + str(ARCHITECTURES) + " in " + str(RTL_DIR))


# ---------------------------------------------------------------------------
# DC script generation
# ---------------------------------------------------------------------------

def generate_dc_tcl(arch: str, N: int, out_path: Path) -> None:
    """Generate a DC TCL script for synthesizing one (arch, N) combination."""
    rtl_file = RTL_DIR / (arch + "_" + str(N) + "x" + str(N) + ".sv")
    top = arch + "_" + str(N) + "x" + str(N)
    lines = [
        "# DC script: " + arch + " multiplier, N=" + str(N),
        "# Generated by dse_sweep.py",
        "",
        "set design " + top,
        "set rtl_file \"" + str(rtl_file) + "\"",
        "set lib \"" + str(LIB) + "\"",
        "",
        "set_app_var search_path  [list .]",
        "set_app_var target_library $lib",
        "set_app_var link_library   \"* $lib\"",
        "",
        "read_file -format sverilog $rtl_file",
        "current_design " + top,
        "link",
        "check_design",
        "",
        "# Constraints (loose max delay to get intrinsic critical path)",
        "set_max_delay 100 -from [all_inputs] -to [all_outputs]",
        "set_load 0.5 [all_outputs]",
        "",
        "if {[catch {set_switching_activity -static_probability 0.5 -toggle_rate 0.2 [all_inputs]} msg]} {",
        "    puts \"WARNING: set_switching_activity failed: $msg\"",
        "}",
        "",
        "# Synthesize",
        "compile -map_effort high",
        "",
        "# Reports",
        "redirect reports/" + arch + "_" + str(N) + "_area.rpt      { report_area }",
        "redirect reports/" + arch + "_" + str(N) + "_qor.rpt       { report_qor }",
        "redirect reports/" + arch + "_" + str(N) + "_reference.rpt { report_reference }",
        "redirect reports/" + arch + "_" + str(N) + "_timing.rpt    { report_timing -delay_type max -max_paths 5 -nworst 5 -from [all_inputs] -to [all_outputs] }",
        "redirect reports/" + arch + "_" + str(N) + "_power.rpt     { report_power -analysis_effort high }",
        "",
        "# Outputs",
        "write -format verilog -hierarchy -output netlists/" + arch + "_" + str(N) + ".v",
        "write -format ddc     -hierarchy -output netlists/" + arch + "_" + str(N) + ".ddc",
        "",
        "exit",
    ]
    out_path.write_text("\n".join(lines))


def generate_all_dc_scripts() -> None:
    """Generate DC TCL scripts for all (arch, N) combinations."""
    (DSE_ROOT / "scripts").mkdir(parents=True, exist_ok=True)
    (DSE_ROOT / "reports").mkdir(parents=True, exist_ok=True)
    (DSE_ROOT / "netlists").mkdir(parents=True, exist_ok=True)
    for N in N_VALUES:
        for arch in ARCHITECTURES:
            generate_dc_tcl(arch, N, DSE_ROOT / "scripts" / ("dc_" + arch + "_" + str(N) + ".tcl"))
    print("Generated DC scripts in " + str(DSE_ROOT / "scripts"))


# ---------------------------------------------------------------------------
# DC execution
# ---------------------------------------------------------------------------

def run_dc_for_all() -> None:
    """Run DC for all (arch, N) if dc_shell is available."""
    if subprocess.run(["sh", "-c", "command -v dc_shell"], capture_output=True).returncode != 0:
        print("dc_shell not found — skipping DC execution.")
        return
    for N in N_VALUES:
        for arch in ARCHITECTURES:
            tcl = DSE_ROOT / "scripts" / ("dc_" + arch + "_" + str(N) + ".tcl")
            log = DSE_ROOT / "logs" / ("dc_" + arch + "_" + str(N) + ".log")
            (DSE_ROOT / "logs").mkdir(parents=True, exist_ok=True)
            print("Running DC: " + arch + " N=" + str(N))
            with open(log, "w") as lf:
                subprocess.run(
                    ["dc_shell", "-f", str(tcl)],
                    stdout=lf,
                    stderr=subprocess.STDOUT,
                    cwd=DSE_ROOT,
                )


# ---------------------------------------------------------------------------
# Report parsing
# ---------------------------------------------------------------------------

def parse_qor(path: Path) -> dict:
    cells = None
    area = None
    try:
        text = path.read_text(errors="ignore")
    except FileNotFoundError:
        return {"cells": None, "area": None}
    import re
    for line in text.splitlines():
        low = line.lower()
        if "number of cells" in low and cells is None:
            m = re.search(r"\d+", line)
            cells = int(m.group()) if m else None
        if ("total cell area" in low or "cell area" in low) and area is None:
            m = re.search(r"[-+]?\d*\.\d+|\d+", line)
            area = float(m.group()) if m else None
    return {"cells": cells, "area": area}


def parse_timing(path: Path):
    best = None
    try:
        text = path.read_text(errors="ignore")
    except FileNotFoundError:
        return None
    import re
    for line in text.splitlines():
        if "data arrival time" in line.lower():
            m = re.search(r"[-+]?\d*\.\d+|\d+", line)
            if m:
                v = float(m.group())
                if best is None or v > best:
                    best = v
    return best


def parse_power(path: Path):
    power = None
    try:
        text = path.read_text(errors="ignore")
    except FileNotFoundError:
        return None
    import re
    for line in text.splitlines():
        if "total dynamic power" in line.lower():
            m = re.search(r"[-+]?\d*\.\d+|\d+", line)
            if m:
                power = float(m.group())
                break
    return power


def collect_dc_results() -> list:
    """Parse all DC reports in dse/reports/."""
    results = []
    for N in N_VALUES:
        for arch in ARCHITECTURES:
            r = DSE_ROOT / "reports"
            qor = parse_qor(r / (arch + "_" + str(N) + "_qor.rpt"))
            timing = parse_timing(r / (arch + "_" + str(N) + "_timing.rpt"))
            power = parse_power(r / (arch + "_" + str(N) + "_power.rpt"))
            results.append({
                "architecture": arch,
                "N": N,
                "cells": qor["cells"],
                "area": qor["area"],
                "delay": timing,
                "power": power,
            })
    return results


# ---------------------------------------------------------------------------
# Analytical model (fallback when DC unavailable)
# ---------------------------------------------------------------------------

def analytical_model(arch: str, N: int) -> dict:
    """
    Simple analytical delay/area model for planning.
    Array: delay ~ k1 * N (ripple carry through N rows), area ~ k2 * N^2
    Wallace: delay ~ k3 * log2(N) + k4 (CSA tree + CPA), area ~ k5 * N^2 * log factor
    Rough constants calibrated for a 45nm-like standard-cell library.
    """
    if arch == "array":
        delay_ns = 0.045 * N + 0.15
        area_um2 = 28.0 * N * N + 40.0
        cells = int(45 * N * N + 20)
        power_mW = 0.012 * N * N + 0.02
    else:  # wallace
        stages = max(1, math.ceil(math.log2(N)))
        delay_ns = 0.035 * stages + 0.045 * math.ceil(math.log2(N)) + 0.20
        area_um2 = 34.0 * N * N * (1.0 + 0.15 * stages) + 60.0
        cells = int(52 * N * N * (1.0 + 0.1 * stages) + 30)
        power_mW = 0.015 * N * N * (1.0 + 0.08 * stages) + 0.03
    return {
        "architecture": arch,
        "N": N,
        "cells": cells,
        "area": area_um2,
        "delay": delay_ns,
        "power": power_mW,
    }


def collect_model_results() -> list:
    return [analytical_model(arch, N) for N in N_VALUES for arch in ARCHITECTURES]


# ---------------------------------------------------------------------------
# CSV output
# ---------------------------------------------------------------------------

def write_csv(results, path: Path) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with open(path, "w", newline="") as f:
        writer = csv.DictWriter(
            f, fieldnames=["architecture", "N", "cells", "area", "delay", "power"]
        )
        writer.writeheader()
        for row in results:
            writer.writerow(row)
    print("Results written to " + str(path))


# ---------------------------------------------------------------------------
# Plotting
# ---------------------------------------------------------------------------

def plot_results(results, out_dir: Path) -> None:
    if not HAS_MPL:
        print("matplotlib not installed — skipping plots.")
        return
    out_dir.mkdir(parents=True, exist_ok=True)

    archs = sorted(set(r["architecture"] for r in results))
    Ns = sorted(set(r["N"] for r in results))

    # Delay vs N
    plt.figure(figsize=(8, 5))
    for arch in archs:
        ys = [
            next(
                (r["delay"] for r in results if r["architecture"] == arch and r["N"] == n),
                None,
            )
            for n in Ns
        ]
        if any(y is not None for y in ys):
            plt.plot(Ns, ys, marker="o", label=arch.title())
    plt.xlabel("Bit-width N")
    plt.ylabel("Max Delay (ns)")
    plt.title("Max Delay vs Bit-width: Array vs Wallace")
    plt.legend()
    plt.grid(True, alpha=0.3)
    plt.savefig(out_dir / "delay_vs_N.png", dpi=150)
    plt.close()

    # Area vs N
    plt.figure(figsize=(8, 5))
    for arch in archs:
        ys = [
            next(
                (r["area"] for r in results if r["architecture"] == arch and r["N"] == n),
                None,
            )
            for n in Ns
        ]
        if any(y is not None for y in ys):
            plt.plot(Ns, ys, marker="s", label=arch.title())
    plt.xlabel("Bit-width N")
    plt.ylabel("Cell Area (um^2)")
    plt.title("Cell Area vs Bit-width: Array vs Wallace")
    plt.legend()
    plt.grid(True, alpha=0.3)
    plt.savefig(out_dir / "area_vs_N.png", dpi=150)
    plt.close()

    # Delay vs Area (crossover)
    plt.figure(figsize=(8, 5))
    for arch in archs:
        xs = [r["area"] for r in results if r["architecture"] == arch and r["area"] is not None]
        ys = [r["delay"] for r in results if r["architecture"] == arch and r["delay"] is not None]
        if xs:
            plt.plot(xs, ys, marker="o", label=arch.title())
    plt.xlabel("Cell Area (um^2)")
    plt.ylabel("Max Delay (ns)")
    plt.title("Delay vs Area: Array vs Wallace (Crossover Analysis)")
    plt.legend()
    plt.grid(True, alpha=0.3)
    plt.savefig(out_dir / "delay_vs_area.png", dpi=150)
    plt.close()

    print("Plots written to " + str(out_dir))


# ---------------------------------------------------------------------------
# Crossover analysis
# ---------------------------------------------------------------------------

def find_crossover(results):
    """Find N where Wallace becomes faster than Array."""
    array_delays = {r["N"]: r["delay"] for r in results if r["architecture"] == "array" and r["delay"]}
    wallace_delays = {r["N"]: r["delay"] for r in results if r["architecture"] == "wallace" and r["delay"]}
    common_Ns = sorted(set(array_delays) & set(wallace_delays))
    for n in common_Ns:
        if wallace_delays[n] < array_delays[n]:
            return (
                "Wallace becomes faster at N = " + str(n) +
                " (Wallace " + format(wallace_delays[n], ".3f") +
                " ns < Array " + format(array_delays[n], ".3f") + " ns)"
            )
    return "No crossover observed within swept N range."


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def main() -> int:
    parser = argparse.ArgumentParser(description="Task C Design Space Exploration")
    parser.add_argument(
        "--mode", choices=["model", "dc", "both"], default="model",
        help="model: analytical only; dc: run DC; both: model + DC if available"
    )
    parser.add_argument("--no-plot", action="store_true", help="Skip plotting")
    args = parser.parse_args()

    DSE_ROOT.mkdir(parents=True, exist_ok=True)

    print("=" * 60)
    print("Task C Design Space Exploration")
    print("Architectures: Array, Wallace-tree")
    print("Bit-widths: " + str(N_VALUES))
    print("=" * 60)

    generate_all_rtl()
    generate_all_dc_scripts()

    if args.mode in ("dc", "both"):
        run_dc_for_all()
        results = collect_dc_results()
        source = "DC reports"
    else:
        results = collect_model_results()
        source = "analytical model"

    if args.mode == "dc":
        model_results = {(r["architecture"], r["N"]): r for r in collect_model_results()}
        for r in results:
            for k in ("cells", "area", "delay", "power"):
                if r.get(k) is None and (r["architecture"], r["N"]) in model_results:
                    r[k] = model_results[(r["architecture"], r["N"])].get(k)

    write_csv(results, DSE_ROOT / "results.csv")

    if not args.no_plot:
        plot_results(results, DSE_ROOT / "plots")

    print("\n" + "=" * 60)
    print("Results Summary")
    print("=" * 60)
    print("{:<10} {:<4} {:<8} {:<12} {:<10} {}".format(
        "Arch", "N", "Cells", "Area(um^2)", "Delay(ns)", "Power(mW)"
    ))
    print("-" * 60)
    for r in results:
        print("{:<10} {:<4} {:<8} {:<12} {:<10} {}".format(
            r["architecture"], r["N"], str(r["cells"]),
            str(r["area"]), str(r["delay"]), str(r["power"])
        ))

    print("\n" + find_crossover(results))
    print("\nSource: " + source)
    return 0


if __name__ == "__main__":
    sys.exit(main())
