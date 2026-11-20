`timescale 1ns/1ps
`default_nettype none

// 8x8 signed multiplier using modified Booth-2 (radix-4) encoding.
//
// Multiplier operand b is sign-extended by 2 bits and recoded into 5
// overlapping 2-bit groups (virtual b[-1]=0, with sign extension above b[7]).
// Each group produces a signed partial product in {-2,-1,0,+1,+2} x a,
// shifted by 2*i.  Partial products are reduced with a CSA tree and a
// final CPA.
//
// Partial products are kept in PW = W+8 bits so that the last group
// (shifted by 8) does not truncate sign/magnitude bits.
module booth_multiplier #(
    parameter int N = 8
) (
    input  logic [N-1:0]   a,        // multiplicand (signed)
    input  logic [N-1:0]   b,        // multiplier   (signed)
    output logic [2*N-1:0] p         // product      (signed)
);

    localparam int W = 2*N;          // 16-bit product width
    localparam int PW = W + 8;       // 24 bits to hold max-shifted pp

    // Sign-extended multiplicand and multiplier.
    logic signed [W-1:0]   a_ext;
    logic signed [N+1:0]   b_ext;    // b with 2 sign-extension bits above b[N-1]

    assign a_ext = {{(W-N){a[N-1]}}, a};
    assign b_ext = {{2{b[N-1]}}, b};

    // Booth groups: 5 groups for N=8.
    //   group i uses {b_ext[2i+1], b_ext[2i], b_ext[2i-1]}, with b_ext[-1]=0
    logic [2:0] group [0:4];
    logic [2:0] coef  [0:4];

    assign group[0] = {b_ext[1], b_ext[0], 1'b0};
    assign group[1] = {b_ext[3], b_ext[2], b_ext[1]};
    assign group[2] = {b_ext[5], b_ext[4], b_ext[3]};
    assign group[3] = {b_ext[7], b_ext[6], b_ext[5]};
    assign group[4] = {b_ext[9], b_ext[8], b_ext[7]};

    genvar g;
    generate
        for (g = 0; g < 5; g++) begin : gen_recode
            booth2_recode u_rec (
                .bits (group[g]),
                .coef (coef[g])
            );
        end
    endgenerate

    // Partial product generation function.
    // Returns a signed PW-bit value = coef * a_ext.
    function automatic logic [PW-1:0] booth_pp (
        input logic signed [W-1:0] ae,
        input logic [2:0]          c
    );
        logic signed [PW-1:0] v;
        begin
            // Sign-extend ae to PW bits.
            v = {{(PW-W){ae[W-1]}}, ae};
            case (c)
                3'b000: v = '0;                           //  0
                3'b001: v =  v;                           // +1  = ae
                3'b010: v =  v <<< 1;                     // +2  = 2*ae
                3'b100: v = -(v <<< 1);                   // -2  = -2*ae
                3'b111: v = -v;                           // -1  = -ae
                default: v = '0;
            endcase
            booth_pp = v;
        end
    endfunction

    // Partial products, sign-extended to PW bits and shifted by 2*g.
    logic [PW-1:0] pp [0:4];

    generate
        for (g = 0; g < 5; g++) begin : gen_pp
            always_comb begin
                pp[g] = booth_pp(a_ext, coef[g]) << (2*g);
            end
        end
    endgenerate

    // CSA reduction tree: 5 partial products -> 2 rows (PW bits wide).
    logic [PW-1:0] s0, c0;
    logic [PW-1:0] s1, c1;
    logic [PW-1:0] s2, c2;

    csa #(.W(PW)) u_csa0 (.a(pp[0]), .b(pp[1]), .c(pp[2]), .sum(s0), .carry(c0));
    csa #(.W(PW)) u_csa1 (.a(s0),    .b(c0),    .c(pp[3]), .sum(s1), .carry(c1));
    csa #(.W(PW)) u_csa2 (.a(s1),    .b(c1),    .c(pp[4]), .sum(s2), .carry(c2));

    // Final carry-propagate adder (PW bits wide).
    logic [PW:0] final_sum;
    assign final_sum = {1'b0, s2} + {1'b0, c2};
    assign p = final_sum[W-1:0];

endmodule

`default_nettype wire
