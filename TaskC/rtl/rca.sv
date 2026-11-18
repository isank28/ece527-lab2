`timescale 1ns/1ps
`default_nettype none

// Parameterized ripple-carry adder built from full adders.
module rca #(
    parameter int W = 8
) (
    input  logic [W-1:0] a,
    input  logic [W-1:0] b,
    input  logic         cin,
    output logic [W-1:0] sum,
    output logic         cout
);

    logic [W:0] carry;
    assign carry[0] = cin;

    genvar i;
    generate
        for (i = 0; i < W; i++) begin : gen_fa
            full_adder u_fa (
                .a   (a[i]),
                .b   (b[i]),
                .cin (carry[i]),
                .sum (sum[i]),
                .cout(carry[i+1])
            );
        end
    endgenerate

    assign cout = carry[W];

endmodule

`default_nettype wire
