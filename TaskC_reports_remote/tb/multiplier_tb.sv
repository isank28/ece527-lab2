`timescale 1ns/1ps
`default_nettype none

// Common self-checking testbench for the 8x8 array and Wallace multipliers.
// The test is exhaustive: all 256 x 256 input combinations are checked.
module multiplier_tb;

    logic [7:0]  a;
    logic [7:0]  b;
    logic [15:0] p_array;
    logic [15:0] p_wallace;
    logic [15:0] expected;

    integer errors;

    array_multiplier #(.N(8)) dut_array (
        .a(a),
        .b(b),
        .p(p_array)
    );

    wallace_multiplier #(.N(8)) dut_wallace (
        .a(a),
        .b(b),
        .p(p_wallace)
    );

    initial begin
        errors = 0;
        $display("Starting exhaustive 8x8 multiplier test...");

        for (int ia = 0; ia < 256; ia++) begin
            for (int ib = 0; ib < 256; ib++) begin
                a = ia[7:0];
                b = ib[7:0];
                #1;

                expected = {8'b0, a} * {8'b0, b};

                if (p_array !== expected) begin
                    $display("ERROR: ARRAY   a=%0d b=%0d got=%0d expected=%0d",
                             a, b, p_array, expected);
                    errors = errors + 1;
                end

                if (p_wallace !== expected) begin
                    $display("ERROR: WALLACE a=%0d b=%0d got=%0d expected=%0d",
                             a, b, p_wallace, expected);
                    errors = errors + 1;
                end
            end
        end

        if (errors == 0)
            $display("PASS: both multipliers matched all 65,536 input combinations.");
        else
            $display("FAIL: %0d mismatches.", errors);

        $finish;
    end

endmodule

`default_nettype wire
