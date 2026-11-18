`timescale 1ns/1ps
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
