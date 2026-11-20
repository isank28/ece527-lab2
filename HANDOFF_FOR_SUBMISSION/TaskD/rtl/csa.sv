`timescale 1ns/1ps
`default_nettype none

// 3:2 carry-save adder.
//   a + b + c = sum + {carry, 1'b0}
module csa #(
    parameter int W = 16
) (
    input  logic [W-1:0] a,
    input  logic [W-1:0] b,
    input  logic [W-1:0] c,
    output logic [W-1:0] sum,
    output logic [W-1:0] carry
);

    assign sum = a ^ b ^ c;

    genvar i;
    generate
        for (i = 0; i < W; i++) begin : gen_carry
            if (i == 0) begin : gen_lsb
                assign carry[i] = 1'b0;
            end else begin : gen_bit
                assign carry[i] = (a[i-1] & b[i-1]) |
                                  (a[i-1] & c[i-1]) |
                                  (b[i-1] & c[i-1]);
            end
        end
    endgenerate

    // No X/Z on outputs when inputs are valid
    assert outputs_valid : !$isunknown(a) && !$isunknown(b) && !$isunknown(c)
                           |-> !$isunknown(sum) && !$isunknown(carry);

endmodule

`default_nettype wire
