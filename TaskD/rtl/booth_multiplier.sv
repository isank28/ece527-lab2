`timescale 1ns/1ps
`default_nettype none

// 8x8 signed multiplier using Modified Booth (Booth-2) encoding
// and carry-save adder (CSA) partial-product reduction.
module booth_multiplier #(
    parameter int N = 8  // Must be an even integer >= 4
) (
    input  logic signed [N-1:0]   a,  // Multiplicand (two's complement)
    input  logic signed [N-1:0]   b,  // Multiplier   (two's complement)
    output logic signed [2*N-1:0] p   // Signed 16-bit product
);

    localparam int W      = 2 * N;
    localparam int NUM_PP = N / 2;  // 4 partial products for N = 8

    // Append implicit b[-1] = 0 for Booth-2 overlapping triplets
    logic [N:0] b_ext;
    assign b_ext = {b, 1'b0};

    // Sign-extend multiplicand to N+1 bits so 2*A fits in N+2 bits
    // without overflow even when A = -128 (8'sb1000_0000).
    logic signed [N:0] a_ext;
    assign a_ext = {a[N-1], a};

    logic [W-1:0] pp [0:NUM_PP-1];

    genvar i;
    generate
        for (i = 0; i < NUM_PP; i++) begin : gen_booth_pp
            logic              neg;
            logic              two;
            logic              zero;
            logic signed [N+1:0] mag;
            logic signed [N+1:0] pp_signed;
            logic        [W-1:0] pp_sext;

            // Step 1: Booth-2 recoding of multiplier bits {b[2i+1], b[2i], b[2i-1]}
            booth2_encoder u_enc (
                .bits (b_ext[2*i +: 3]),
                .neg  (neg),
                .two  (two),
                .zero (zero)
            );

            // Step 2: Select {0, +A, +2A}, apply two's complement negation if neg=1,
            // sign-extend to W bits, and shift left by 2*i.
            always_comb begin
                if (zero) begin
                    mag = '0;
                end else if (two) begin
                    mag = {a_ext, 1'b0};        // +2 * A
                end else begin
                    mag = {a_ext[N], a_ext};    // +1 * A
                end

                pp_signed = neg ? (~mag + {{(N+1){1'b0}}, 1'b1}) : mag;
                pp_sext   = {{(W-(N+2)){pp_signed[N+1]}}, pp_signed};
                pp[i]     = pp_sext << (2 * i);
            end
        end
    endgenerate

    // Step 3: Reduce NUM_PP (4) partial products to 2 vectors using a 2-stage CSA tree
    logic [W-1:0] csa_sum   [0:NUM_PP-2];
    logic [W-1:0] csa_carry [0:NUM_PP-2];

    assign csa_sum[0]   = pp[0];
    assign csa_carry[0] = pp[1];

    genvar j;
    generate
        for (j = 1; j < NUM_PP - 1; j++) begin : gen_csa_tree
            csa #(.W(W)) u_csa (
                .a     (csa_sum[j-1]),
                .b     (csa_carry[j-1]),
                .c     (pp[j+1]),
                .sum   (csa_sum[j]),
                .carry (csa_carry[j])
            );
        end
    endgenerate

    // Final carry-propagate adder
    logic [W-1:0] p_raw;
    rca #(.W(W)) u_final_cpa (
        .a    (csa_sum[NUM_PP-2]),
        .b    (csa_carry[NUM_PP-2]),
        .cin  (1'b0),
        .sum  (p_raw),
        .cout ()
    );

    assign p = signed'(p_raw);

endmodule

`default_nettype wire
