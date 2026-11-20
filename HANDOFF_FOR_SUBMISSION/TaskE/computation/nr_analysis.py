#!/usr/bin/env python3
"""
ECE 527 Project 2 — Task E: Newton-Raphson Divider Error Analysis

This script:
  1. Derives/verifies the error recurrence ε_{n+1} = D·ε_n²
  2. Computes minimum iterations for target precision 2^-16
     starting from ε_0 = 0.5, 0.1, 0.01
  3. Generates error magnitude vs iteration count plots
  4. Saves results to TaskE/computation/results.csv and TaskE/plots/

Usage:
    cd /Users/victor/ece527/lab2/TaskE
    python3 computation/nr_analysis.py
"""

import csv
import math
import os
from pathlib import Path

TASKE_ROOT = Path(__file__).resolve().parent.parent  # TaskE/ (script is in TaskE/computation/)
COMPUTATION_DIR = TASKE_ROOT / "computation"
PLOTS_DIR = TASKE_ROOT / "plots"


def newton_raphson_error(epsilon_0: float, D: float, max_iter: int = 20) -> list[float]:
    """
    Compute error sequence using ε_{n+1} = D · ε_n².

    Args:
        epsilon_0: Initial error
        D: Divisor (scaling factor in recurrence)
        max_iter: Maximum iterations to compute

    Returns:
        List of errors [ε_0, ε_1, ..., ε_max_iter]
    """
    errors = [epsilon_0]
    for n in range(max_iter):
        errors.append(D * errors[-1] ** 2)
    return errors


def min_iterations_for_precision(
    epsilon_0: float, D: float, target_precision: float
) -> tuple[int, list[float]]:
    """
    Find minimum n such that ε_n <= target_precision.

    Returns (n, errors_list).
    """
    errors = [epsilon_0]
    n = 0
    while errors[-1] > target_precision and n < 50:
        errors.append(D * errors[-1] ** 2)
        n += 1
    return n, errors


def main() -> None:
    COMPUTATION_DIR.mkdir(parents=True, exist_ok=True)
    PLOTS_DIR.mkdir(parents=True, exist_ok=True)

    D = 1.0  # Normalized divisor (D ≈ 1 after range reduction)
    target_precision = 2 ** -16  # ≈ 1.5259e-5

    initial_errors = [0.5, 0.1, 0.01]

    print("=" * 70)
    print("Task E — Newton-Raphson Divider Error Analysis")
    print("=" * 70)
    print(f"Recurrence: ε_{{n+1}} = D · ε_n²  (D = {D})")
    print(f"Target precision: 2^-16 = {target_precision:.6e}")
    print("-" * 70)

    results = []

    for eps0 in initial_errors:
        n, errors = min_iterations_for_precision(eps0, D, target_precision)
        results.append({
            "epsilon_0": eps0,
            "min_iterations": n,
            "final_error": errors[-1],
            "errors": errors,
        })
        print(f"\nε_0 = {eps0}:")
        print(f"  Minimum iterations: {n}")
        for i, e in enumerate(errors):
            marker = " <-- meets target" if e <= target_precision else ""
            print(f"  ε_{i} = {e:.6e}{marker}")

    # Write CSV
    csv_path = COMPUTATION_DIR / "results.csv"
    with open(csv_path, "w", newline="") as f:
        writer = csv.writer(f)
        writer.writerow(["epsilon_0", "min_iterations", "final_error"])
        for r in results:
            writer.writerow([r["epsilon_0"], r["min_iterations"], r["final_error"]])
    print(f"\nResults written to {csv_path}")

    # Generate plots if matplotlib available
    try:
        import matplotlib
        matplotlib.use("Agg")
        import matplotlib.pyplot as plt

        plt.figure(figsize=(8, 5))
        for r in results:
            eps0 = r["epsilon_0"]
            errors = r["errors"]
            iterations = list(range(len(errors)))
            plt.semilogy(
                iterations,
                errors,
                marker="o",
                label=f"ε_0 = {eps0}",
            )
        plt.axhline(
            y=target_precision,
            color="red",
            linestyle="--",
            label=f"Target 2^-16 = {target_precision:.1e}",
        )
        plt.xlabel("Iteration n")
        plt.ylabel("Error magnitude ε_n (log scale)")
        plt.title("Newton-Raphson Divider: Error Convergence")
        plt.legend()
        plt.grid(True, alpha=0.3, which="both")
        plot_path = PLOTS_DIR / "error_convergence.png"
        plt.savefig(plot_path, dpi=150, bbox_inches="tight")
        plt.close()
        print(f"Plot saved to {plot_path}")

        # Individual plots per initial estimate
        for r in results:
            eps0 = r["epsilon_0"]
            errors = r["errors"]
            iterations = list(range(len(errors)))
            plt.figure(figsize=(6, 4))
            plt.semilogy(
                iterations, errors, marker="o", label=f"ε_0 = {eps0}"
            )
            plt.axhline(
                y=target_precision,
                color="red",
                linestyle="--",
                label="Target 2^-16",
            )
            plt.xlabel("Iteration n")
            plt.ylabel("Error magnitude ε_n")
            plt.title(f"NR Convergence (ε_0 = {eps0})")
            plt.legend()
            plt.grid(True, alpha=0.3, which="both")
            plt.savefig(
                PLOTS_DIR / f"nr_convergence_eps0_{eps0}.png",
                dpi=150,
                bbox_inches="tight",
            )
            plt.close()

    except ImportError:
        print("matplotlib not installed — skipping plots.")

    print("\n" + "=" * 70)
    print("Summary")
    print("=" * 70)
    print(f"{'ε_0':<10} {'Min Iterations':<18} {'Final Error':<14}")
    print("-" * 45)
    for r in results:
        print(
            f"{r['epsilon_0']:<10} {r['min_iterations']:<18} "
            f"{r['final_error']:.6e}"
        )


if __name__ == "__main__":
    main()
