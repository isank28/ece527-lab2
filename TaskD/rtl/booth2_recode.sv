`timescale 1ns/1ps
`default_nettype none

// Booth-2 radix-4 multiplier recode.
// Given a 3-bit overlapping group {b[2i+1], b[2i], b[2i-1]},
// produces a signed coefficient in {-2,-1,0,1,2} as a 3-bit
// two's-complement bit pattern.
module booth2_recode (
    input  logic [2:0]  bits,   // {b[2i+1], b[2i], b[2i-1]}
    output logic [2:0]  coef    // signed coefficient {-2..2}
);

    always_comb begin
        case (bits)
            3'b000, 3'b111: coef = 3'b000;   //  0
            3'b001, 3'b010: coef = 3'b001;   // +1
            3'b011:         coef = 3'b010;   // +2
            3'b100:         coef = 3'b100;   // -2  (two's complement)
            3'b101, 3'b110: coef = 3'b111;   // -1  (two's complement)
            default:        coef = 3'b000;
        endcase
    end

endmodule

//======================================================================
// SystemVerilog Assertions (SVA) — booth2_recode
//======================================================================

// Coefficient validity: only {-2,-1,0,+1,+2} encodings allowed
assert coef_valid : (coef == 3'b000) || (coef == 3'b001) ||
                    (coef == 3'b010) || (coef == 3'b100) ||
                    (coef == 3'b111);

// Recode mapping correctness (combinational)
assert recode_mapping : !$isunknown(bits) |->
    ((bits == 3'b000 || bits == 3'b111) -> (coef == 3'b000)) &&
    ((bits == 3'b001 || bits == 3'b010) -> (coef == 3'b001)) &&
    ((bits == 3'b011)                   -> (coef == 3'b010)) &&
    ((bits == 3'b100)                   -> (coef == 3'b100)) &&
    ((bits == 3'b101 || bits == 3'b110) -> (coef == 3'b111));

`default_nettype wire
