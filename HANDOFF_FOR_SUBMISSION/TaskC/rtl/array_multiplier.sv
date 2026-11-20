`timescale 1ns/1ps
`default_nettype none

// 8x8 unsigned array multiplier.
//
// The partial-product rows are accumulated one at a time with a
// ripple-carry adder, which is the "ripple-carry row accumulation"
// structure required by Task C.
module array_multiplier #(
    parameter int N = 8
) (
    input  logic [N-1:0]   a,
    input  logic [N-1:0]   b,
    output logic [2*N-1:0] p
);

    localparam int W = 2*N;

    logic [W-1:0] pp  [0:N-1];  // shifted partial-product rows
    logic [W-1:0] acc [0:N-1];  // accumulated rows

    genvar i;
    generate
        for (i = 0; i < N; i++) begin : gen_partial_products
            // pp[i] = (a & {N{b[i]}}) << i, zero-extended to W bits
            assign pp[i] = ({{(W-N){1'b0}}, a} & {W{b[i]}}) << i;
        end
    endgenerate

    assign acc[0] = pp[0];

    generate
        for (i = 1; i < N; i++) begin : gen_row_accumulation
            rca #(.W(W)) u_row_adder (
                .a   (acc[i-1]),
                .b   (pp[i]),
                .cin (1'b0),
                .sum (acc[i]),
                .cout()
            );
        end
    endgenerate

    assign p = acc[N-1];

endmodule

`default_nettype wire
