`timescale 1ns/1ps
`default_nettype none

// Common self-checking testbench for the 8x8 signed Booth-2 multiplier.
// Covers positive, negative, and mixed-sign operand combinations.
module booth_tb;

    logic signed [7:0]  a;
    logic signed [7:0]  b;
    logic signed [15:0] p_booth;
    logic signed [15:0] expected;

    integer errors;
    integer ia, ib;

    booth_multiplier #(.N(8)) dut (
        .a(a),
        .b(b),
        .p(p_booth)
    );

    initial begin
        errors = 0;
        $display("Starting 8x8 signed Booth-2 multiplier test...");
        $display("Covering all 65,536 signed operand combinations.");

        for (ia = -128; ia <= 127; ia++) begin
            for (ib = -128; ib <= 127; ib++) begin
                a = ia;
                b = ib;
                #1;

                expected = ia * ib;

                if (p_booth !== expected) begin
                    $display("ERROR: a=%0d b=%0d got=%0d expected=%0d",
                             a, b, p_booth, expected);
                    errors = errors + 1;
                end
            end
        end

        if (errors == 0)
            $display("PASS: Booth-2 multiplier matched all 65,536 signed combinations.");
        else
            $display("FAIL: %0d mismatches.", errors);

        $finish;
    end

endmodule

`default_nettype wire
