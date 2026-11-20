#!/bin/bash
# Run both Task C syntheses and save the DC console output.
set -e
set -o pipefail
cd "$(dirname "$0")"

mkdir -p reports netlists logs

if ! command -v dc_shell >/dev/null 2>&1; then
    echo "ERROR: dc_shell is not on PATH."
    echo "On the VLSI lab machine, run 'addpkg', select Synopsys DC, then rerun."
    exit 1
fi

dc_shell -f scripts/dc_array.tcl   | tee logs/dc_array.log
dc_shell -f scripts/dc_wallace.tcl | tee logs/dc_wallace.log

echo
echo "Done. Reports are in reports/, netlists in netlists/."
