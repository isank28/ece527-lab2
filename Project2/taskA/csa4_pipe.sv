// ECE 527 PR_2 Task A - Fig 2
// 4-bit pipelined carry-select adder built from three 2-bit full adders.
//   Low adder:   bits [1:0] with the real Cin
//   High adders: bits [3:2] computed twice in parallel, once with carry-in 0, once with 1
// All adder results are registered in the output FF stage; the MUX after the
// FF stage uses the registered low-half carry to pick the correct upper result.
// Latency: result appears 2 clock edges after inputs are applied.
// Requires fa2.sv (2-bit full adder).

module csa4_pipe (
    input  logic       clk, rst_n,   // rst_n: active-low asynchronous reset
    input  logic [3:0] A, B,
    input  logic       Cin,
    output logic [3:0] S,
    output logic       Cout
);
    // Input FF stage outputs
    logic [3:0] A_reg, B_reg;
    logic       Cin_reg;

    // Combinational adder outputs
    logic [1:0] s_lo;            // bits [1:0]
    logic       c_lo;            // carry out of low half (select signal)
    logic [1:0] s_hi0, s_hi1;    // bits [3:2] assuming carry-in 0 / 1
    logic       c_hi0, c_hi1;    // carry out assuming carry-in 0 / 1

    // Output FF stage outputs
    logic [1:0] s_lo_reg;
    logic       c_lo_reg;
    logic [1:0] s_hi0_reg, s_hi1_reg;
    logic       c_hi0_reg, c_hi1_reg;

    // Input FF stage
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

    // Low half: bits [1:0] with the real carry-in
    fa2 u_fa2_low (
        .a    (A_reg[1:0]),
        .b    (B_reg[1:0]),
        .cin  (Cin_reg),
        .s    (s_lo),
        .cout (c_lo)
    );

    // High half, assuming carry-in = 0
    fa2 u_fa2_high0 (
        .a    (A_reg[3:2]),
        .b    (B_reg[3:2]),
        .cin  (1'b0),
        .s    (s_hi0),
        .cout (c_hi0)
    );

    // High half, assuming carry-in = 1
    fa2 u_fa2_high1 (
        .a    (A_reg[3:2]),
        .b    (B_reg[3:2]),
        .cin  (1'b1),
        .s    (s_hi1),
        .cout (c_hi1)
    );

    // Output FF stage: register all three adder results
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            s_lo_reg  <= '0;
            c_lo_reg  <= 1'b0;
            s_hi0_reg <= '0;
            c_hi0_reg <= 1'b0;
            s_hi1_reg <= '0;
            c_hi1_reg <= 1'b0;
        end else begin
            s_lo_reg  <= s_lo;
            c_lo_reg  <= c_lo;
            s_hi0_reg <= s_hi0;
            c_hi0_reg <= c_hi0;
            s_hi1_reg <= s_hi1;
            c_hi1_reg <= c_hi1;
        end
    end

    // MUX after the FF stage: low-half carry selects the correct upper result
    assign S[1:0] = s_lo_reg;
    assign S[3:2] = c_lo_reg ? s_hi1_reg : s_hi0_reg;
    assign Cout   = c_lo_reg ? c_hi1_reg : c_hi0_reg;
endmodule
