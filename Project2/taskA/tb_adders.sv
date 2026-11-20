// ECE 527 PR_2 Task A - common testbench for the pipelined 4-bit adders
// Tests all 512 input combinations ({Cin, A, B}) and checks each result
// 2 clock cycles later (input FF stage + output FF stage).
//
// rca4_pipe (Fig 1) is always tested.
// csa4_pipe (Fig 2) is tested when compiled with +define+TEST_CSA.

`timescale 1ns/1ps

module tb_adders;

    logic       clk = 0;
    logic       rst_n;
    logic [3:0] A, B;
    logic       Cin;

    // 10 ns clock period (simulation only; synthesis uses its own clock)
    always #5 clk = ~clk;

    // Fig 1: ripple-carry
    logic [3:0] S_rca;
    logic       Cout_rca;
    rca4_pipe dut_rca (
        .clk(clk), .rst_n(rst_n), .A(A), .B(B), .Cin(Cin),
        .S(S_rca), .Cout(Cout_rca)
    );

`ifdef TEST_CSA
    // Fig 2: carry-select (same ports as rca4_pipe)
    logic [3:0] S_csa;
    logic       Cout_csa;
    csa4_pipe dut_csa (
        .clk(clk), .rst_n(rst_n), .A(A), .B(B), .Cin(Cin),
        .S(S_csa), .Cout(Cout_csa)
    );
`endif

    int         errors = 0;
    int         checks = 0;
    logic [8:0] v;          // test vector: v = {Cin, A, B}
    logic [4:0] expected;   // {Cout, S}

    initial begin
        // Reset
        rst_n = 0;
        A = 0; B = 0; Cin = 0;
        repeat (2) @(negedge clk);
        rst_n = 1;

        // Inputs change on the falling edge, so they are stable at the rising edge.
        // Vector k is applied at loop step k and checked at step k+2.
        for (int i = 0; i < 512 + 2; i++) begin
            @(negedge clk);

            // Check the result of the vector applied 2 cycles ago
            if (i >= 2) begin
                v        = 9'(i - 2);
                expected = v[7:4] + v[3:0] + v[8];
                checks++;

                if ({Cout_rca, S_rca} !== expected) begin
                    errors++;
                    $display("RCA FAIL: A=%0d B=%0d Cin=%0d -> got Cout=%b S=%0d, expected %0d",
                             v[7:4], v[3:0], v[8], Cout_rca, S_rca, expected);
                end
`ifdef TEST_CSA
                if ({Cout_csa, S_csa} !== expected) begin
                    errors++;
                    $display("CSA FAIL: A=%0d B=%0d Cin=%0d -> got Cout=%b S=%0d, expected %0d",
                             v[7:4], v[3:0], v[8], Cout_csa, S_csa, expected);
                end
`endif
                // Print a few samples as evidence for the report
                if (i - 2 < 5 || i - 2 == 511)
                    $display("t=%0t  A=%2d B=%2d Cin=%0d | RCA: Cout=%b S=%2d | expected %2d",
                             $time, v[7:4], v[3:0], v[8], Cout_rca, S_rca, expected);
            end

            // Apply the next vector
            if (i < 512) begin
                v = 9'(i);
                {Cin, A, B} = v;
            end
        end

        if (errors == 0)
            $display("PASS: %0d vectors checked, 0 errors", checks);
        else
            $display("FAIL: %0d errors in %0d vectors", errors, checks);
        $finish;
    end

endmodule
