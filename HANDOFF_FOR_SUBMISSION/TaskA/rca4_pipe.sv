// ECE 527 PR_2 Task A - Fig 1
// 4-bit pipelined ripple-carry adder built from two 2-bit full adders.
// Input FF stage -> fa2 (bits 1:0) -> carry -> fa2 (bits 3:2) -> output FF stage.
// Latency: result appears 2 clock edges after inputs are applied.
// Requires fa2.sv (2-bit full adder).

// Top level: pipelined 4-bit ripple-carry adder
module rca4_pipe (
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
    logic [3:0] Sum_wire;
    logic       c_mid;       // carry from low half into high half
    logic       Cout_wire;   // final carry out

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

    // Low half: bits [1:0]
    fa2 u_fa2_low (
        .a    (A_reg[1:0]),
        .b    (B_reg[1:0]),
        .cin  (Cin_reg),
        .s    (Sum_wire[1:0]),
        .cout (c_mid)
    );

    // High half: bits [3:2]
    fa2 u_fa2_high (
        .a    (A_reg[3:2]),
        .b    (B_reg[3:2]),
        .cin  (c_mid),
        .s    (Sum_wire[3:2]),
        .cout (Cout_wire)
    );

    // Output FF stage
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            S    <= '0;
            Cout <= 1'b0;
        end else begin
            S    <= Sum_wire;
            Cout <= Cout_wire;
        end
    end
endmodule
