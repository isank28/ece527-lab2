// ECE 527 PR_2 Task B - Part 2
// 8-bit pipelined carry-select adder: Task A Fig 2 extended to 8 bits.
//   Block 0: bits [1:0] with the real Cin
//   Blocks 1-3: bits [3:2], [5:4], [7:6], each computed twice in parallel (carry-in 0 and 1)
// All adder results are registered in the output FF stage. After the FF stage a chain of
// MUXes picks each block's result: block 0's carry selects block 1, block 1's selected
// carry selects block 2, and so on. The chain grows with N, unlike the prefix tree.
// Latency: 2 clock edges (input, output registers). Requires fa2.sv.

module csa8_pipe (
    input  logic       clk, rst_n,   // rst_n: active-low asynchronous reset
    input  logic [7:0] A, B,
    input  logic       Cin,
    output logic [7:0] S,
    output logic       Cout
);
    //================ Input register stage ================
    logic [7:0] A_reg, B_reg;
    logic       Cin_reg;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            A_reg   <= '0;
            B_reg   <= '0;
            Cin_reg <= 1'b0;
        end else begin
            A_reg   <= A;
            B_reg   <= B;
            Cin_reg <= Cin;
        end
    end

    //================ Block adders ================
    // Block 0 with the real carry-in
    logic [1:0] s_lo;
    logic       c_lo;
    fa2 u_blk0 (.a(A_reg[1:0]), .b(B_reg[1:0]), .cin(Cin_reg), .s(s_lo), .cout(c_lo));

    // Blocks 1-3, each for carry-in 0 and carry-in 1
    logic [1:0] s0 [1:3], s1 [1:3];
    logic       c0 [1:3], c1 [1:3];

    for (genvar k = 1; k <= 3; k++) begin : g_blk
        fa2 u_cin0 (.a(A_reg[2*k+1:2*k]), .b(B_reg[2*k+1:2*k]), .cin(1'b0), .s(s0[k]), .cout(c0[k]));
        fa2 u_cin1 (.a(A_reg[2*k+1:2*k]), .b(B_reg[2*k+1:2*k]), .cin(1'b1), .s(s1[k]), .cout(c1[k]));
    end

    //================ Output register stage (21 FFs) ================
    // block 0: 2 sum + 1 carry; blocks 1-3: 2 versions x (2 sum + 1 carry)
    logic [1:0] s_lo_reg;
    logic       c_lo_reg;
    logic [1:0] s0_reg [1:3], s1_reg [1:3];
    logic       c0_reg [1:3], c1_reg [1:3];

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            s_lo_reg <= '0;
            c_lo_reg <= 1'b0;
            for (int k = 1; k <= 3; k++) begin
                s0_reg[k] <= '0; s1_reg[k] <= '0;
                c0_reg[k] <= 1'b0; c1_reg[k] <= 1'b0;
            end
        end else begin
            s_lo_reg <= s_lo;
            c_lo_reg <= c_lo;
            for (int k = 1; k <= 3; k++) begin
                s0_reg[k] <= s0[k]; s1_reg[k] <= s1[k];
                c0_reg[k] <= c0[k]; c1_reg[k] <= c1[k];
            end
        end
    end

    //================ MUX chain after the FF stage ================
    // sel[k] = carry into block k; sel[4] = carry out of the adder
    logic sel [1:4];
    assign sel[1] = c_lo_reg;
    assign S[1:0] = s_lo_reg;

    for (genvar k = 1; k <= 3; k++) begin : g_mux
        assign S[2*k+1:2*k] = sel[k] ? s1_reg[k] : s0_reg[k];
        assign sel[k+1]     = sel[k] ? c1_reg[k] : c0_reg[k];
    end

    assign Cout = sel[4];
endmodule
