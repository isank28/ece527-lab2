// ECE 527 PR_2 Task B - common testbench for the 8-bit pipelined adders
// Applies all 2^17 = 131072 combinations of {Cin, A, B}, one per clock,
// and checks each DUT against A+B+Cin after that DUT's own pipeline latency.
//
// prefix8_pipe (Part 1, Sklansky, latency 3) is always tested.
// csa8_pipe    (Part 2, carry-select)        is tested with +define+TEST_CSA8.

`timescale 1ns/1ps

module tb_taskB;

    localparam int NV       = 1 << 17;   // number of input vectors
    localparam int LAT_PFX  = 3;         // prefix8_pipe: input, mid, output registers
    localparam int LAT_CSA  = 2;         // csa8_pipe: input, output registers
    localparam int MAX_LAT  = 3;

    logic       clk = 0;
    logic       rst_n;
    logic [7:0] A, B;
    logic       Cin;

    always #5 clk = ~clk;                // 10 ns period (simulation only)

    // Part 1: Sklansky prefix adder
    logic [7:0] S_pfx;
    logic       Cout_pfx;
    prefix8_pipe dut_pfx (
        .clk(clk), .rst_n(rst_n), .A(A), .B(B), .Cin(Cin),
        .S(S_pfx), .Cout(Cout_pfx)
    );

`ifdef TEST_CSA8
    // Part 2: 8-bit carry-select adder
    logic [7:0] S_csa;
    logic       Cout_csa;
    csa8_pipe dut_csa (
        .clk(clk), .rst_n(rst_n), .A(A), .B(B), .Cin(Cin),
        .S(S_csa), .Cout(Cout_csa)
    );
`endif

    int errors_pfx = 0, errors_csa = 0, checks = 0;

    // Expected {Cout, S} for vector k = {Cin, A, B}
    function automatic logic [8:0] expect_sum(int k);
        logic [16:0] v = 17'(k);
        return v[15:8] + v[7:0] + v[16];
    endfunction

    task automatic check(string name, int k, logic [8:0] got, ref int errs);
        logic [16:0] v = 17'(k);
        if (got !== expect_sum(k)) begin
            errs++;
            if (errs <= 10)
                $display("%s FAIL: A=%0d B=%0d Cin=%0d -> got %0d, expected %0d",
                         name, v[15:8], v[7:0], v[16], got, expect_sum(k));
        end
    endtask

    initial begin
        rst_n = 0;
        A = 0; B = 0; Cin = 0;
        repeat (2) @(negedge clk);
        rst_n = 1;

        // Inputs change on the falling edge; vector i is applied at step i
        // and checked at step i + latency of each DUT.
        for (int i = 0; i < NV + MAX_LAT; i++) begin
            @(negedge clk);

            if (i >= LAT_PFX && i - LAT_PFX < NV) begin
                check("PFX", i - LAT_PFX, {Cout_pfx, S_pfx}, errors_pfx);
                checks++;
                if (i - LAT_PFX < 4 || i - LAT_PFX == NV - 1)
                    $display("t=%0t  A=%3d B=%3d Cin=%0d | PFX: Cout=%b S=%3d | expected %3d",
                             $time, (i - LAT_PFX) >> 8 & 8'hFF, (i - LAT_PFX) & 8'hFF,
                             (i - LAT_PFX) >> 16 & 1, Cout_pfx, S_pfx, expect_sum(i - LAT_PFX));
            end
`ifdef TEST_CSA8
            if (i >= LAT_CSA && i - LAT_CSA < NV)
                check("CSA", i - LAT_CSA, {Cout_csa, S_csa}, errors_csa);
`endif

            if (i < NV) {Cin, A, B} = 17'(i);
        end

        if (errors_pfx == 0 && errors_csa == 0)
            $display("PASS: %0d vectors checked, 0 errors", checks);
        else
            $display("FAIL: prefix %0d errors, carry-select %0d errors, in %0d vectors",
                     errors_pfx, errors_csa, checks);
        $finish;
    end

endmodule
