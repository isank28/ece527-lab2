#!/bin/bash
# Run Task D Booth-2 multiplier synthesis with Design Compiler.
set -e
set -o pipefail
cd "$(dirname "$0")"

mkdir -p reports netlists logs

if ! command -v dc_shell >/dev/null 2>&1; then
    echo "ERROR: dc_shell is not on PATH."
    echo "On the VLSI lab machine, run 'addpkg', select Synopsys DC, then rerun."
    exit 1
fi

dc_shell -f scripts/dc_booth.tcl | tee logs/dc_booth.log

echo
echo "Done. Reports are in reports/, netlists in netlists/."
