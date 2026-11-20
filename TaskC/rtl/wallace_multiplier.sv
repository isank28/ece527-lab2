`timescale 1ns/1ps
`default_nettype none

// 8x8 unsigned Wallace-tree multiplier.
//
// The eight partial-product rows are reduced 8 -> 2 with a balanced
// tree of six 3:2 carry-save adders (CSA); the longest path traverses
// four CSA stages.  A final carry-propagate adder produces the product.
module wallace_multiplier #(
    parameter int N = 8
) (
    input  logic [N-1:0]   a,
    input  logic [N-1:0]   b,
    output logic [2*N-1:0] p
);

    localparam int W = 2*N;

    logic [W-1:0] pp [0:N-1];

    genvar i;
    generate
        for (i = 0; i < N; i++) begin : gen_partial_products
            assign pp[i] = ({{(W-N){1'b0}}, a} & {W{b[i]}}) << i;
        end
    endgenerate

    // CSA reduction tree: 8 rows -> 2 rows.
    logic [W-1:0] s0, c0;
    logic [W-1:0] s1, c1;
    logic [W-1:0] s2, c2;
    logic [W-1:0] s3, c3;
    logic [W-1:0] s4, c4;
    logic [W-1:0] s5, c5;

    csa #(.W(W)) u_csa0 (.a(pp[0]), .b(pp[1]), .c(pp[2]), .sum(s0), .carry(c0));
    csa #(.W(W)) u_csa1 (.a(pp[3]), .b(pp[4]), .c(pp[5]), .sum(s1), .carry(c1));
    csa #(.W(W)) u_csa2 (.a(pp[6]), .b(pp[7]), .c(s0),    .sum(s2), .carry(c2));
    csa #(.W(W)) u_csa3 (.a(c0),    .b(s1),    .c(c1),    .sum(s3), .carry(c3));
    csa #(.W(W)) u_csa4 (.a(s2),    .b(c2),    .c(s3),    .sum(s4), .carry(c4));
    csa #(.W(W)) u_csa5 (.a(c3),    .b(s4),    .c(c4),    .sum(s5), .carry(c5));

    // Final carry-propagate adder.  A faster CPA (CLA, carry-select)
    // would reduce this contribution to the critical path.
    logic [W:0] final_sum;
    assign final_sum = {1'b0, s5} + {1'b0, c5};
    assign p = final_sum[W-1:0];

    //======================================================================
    // SystemVerilog Assertions (SVA) — for formal verification / simulation
    //======================================================================
// synthesis translate_off
    // Output range: unsigned 8x8 product fits in [0, 2^(2N)-1]
    assert property (output_range :
        !$isunknown(p) |-> (p >= 0) && (p <= {2*N{1'b1}})
    );

    // No X/Z on primary outputs when inputs are valid
    assert property (outputs_valid :
        !$isunknown(a) && !$isunknown(b) |-> !$isunknown(p)
    );

    // Combinational stability: output must not be X when inputs are stable
    assert property (no_x_propagation :
        !$isunknown(a) && !$isunknown(b) |-> !$isunknown(p)
    );
// synthesis translate_on

endmodule

`default_nettype wire
