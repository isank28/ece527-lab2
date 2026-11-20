// ECE 527 PR_2 Task B - Part 1
// 8-bit pipelined parallel prefix adder, Sklansky tree, PG dot operator.
//
//   input regs -> [PG + level 1 + level 2] -> mid regs -> [level 3 + sum XOR] -> output regs
//
// Notation (lecture): G(i,j) = G(i,k) + P(i,k)*G(k-1,j),  P(i,j) = P(i,k)*P(k-1,j)
//   black cell: computes G and P      gray cell: computes G only (result reaches bit 0)
// Cin is folded into bit 0: g0' = g0 + p0*Cin, so G(i,0) is the carry out of bit i.
// Latency: 3 clock edges (input, mid, output registers). Throughput: 1 sum per cycle.

module prefix8_pipe (
    input  logic       clk, rst_n,   // rst_n: active-low asynchronous reset
    input  logic [7:0] A, B,
    input  logic       Cin,
    output logic [7:0] S,
    output logic       Cout
);
    // Dot-operator cells
    function automatic logic gray_cell(input logic G_hi, P_hi, G_lo);
        return G_hi | (P_hi & G_lo);
    endfunction

    function automatic logic [1:0] black_cell(input logic G_hi, P_hi, G_lo, P_lo);  // returns {G, P}
        return {G_hi | (P_hi & G_lo), P_hi & P_lo};
    endfunction

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

    //================ Stage 1: PG + levels 1-2 ================
    logic [7:0] g, p;
    logic       g0c;                       // g0' = g0 + p0*Cin  (G(0,0))

    assign g   = A_reg & B_reg;
    assign p   = A_reg ^ B_reg;
    assign g0c = g[0] | (p[0] & Cin_reg);

    // Level 1: adjacent pairs
    logic G10;                             // gray
    logic G32, P32, G54, P54, G76, P76;    // black
    assign G10        = gray_cell (g[1], p[1], g0c);
    assign {G32, P32} = black_cell(g[3], p[3], g[2], p[2]);
    assign {G54, P54} = black_cell(g[5], p[5], g[4], p[4]);
    assign {G76, P76} = black_cell(g[7], p[7], g[6], p[6]);

    // Level 2: groups of four
    logic G20, G30;                        // gray
    logic G64, P64, G74, P74;              // black
    assign G20        = gray_cell (g[2], p[2], G10);
    assign G30        = gray_cell (G32,  P32,  G10);
    assign {G64, P64} = black_cell(g[6], p[6], G54, P54);
    assign {G74, P74} = black_cell(G76,  P76,  G54, P54);

    //================ Mid register stage (20 FFs) ================
    // Final carries G(0..3,0): 4 | upper groups g4, (5:4), (6:4), (7:4): 7 | p[7:0]: 8 | Cin: 1
    logic       G00_m, G10_m, G20_m, G30_m;
    logic       g4_m, G54_m, P54_m, G64_m, P64_m, G74_m, P74_m;
    logic [7:0] p_m;
    logic       Cin_m;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            {G00_m, G10_m, G20_m, G30_m}                       <= '0;
            {g4_m, G54_m, P54_m, G64_m, P64_m, G74_m, P74_m}   <= '0;
            p_m                                                <= '0;
            Cin_m                                              <= 1'b0;
        end else begin
            {G00_m, G10_m, G20_m, G30_m}                       <= {g0c, G10, G20, G30};
            {g4_m, G54_m, P54_m, G64_m, P64_m, G74_m, P74_m}   <= {g[4], G54, P54, G64, P64, G74, P74};
            p_m                                                <= p;
            Cin_m                                              <= Cin_reg;
        end
    end

    //================ Stage 2: level 3 + sums ================
    // Level 3: upper half joins (3:0); p4 comes from p_m[4]
    logic G40, G50, G60, G70;              // all gray
    assign G40 = gray_cell(g4_m,  p_m[4], G30_m);
    assign G50 = gray_cell(G54_m, P54_m,  G30_m);
    assign G60 = gray_cell(G64_m, P64_m,  G30_m);
    assign G70 = gray_cell(G74_m, P74_m,  G30_m);

    // c[i] = G(i,0) = carry out of bit i
    logic [7:0] c;
    assign c = {G70, G60, G50, G40, G30_m, G20_m, G10_m, G00_m};

    logic [7:0] sum_c;
    assign sum_c = p_m ^ {c[6:0], Cin_m};  // s0 = p0^Cin, s_i = p_i ^ G(i-1,0)

    //================ Output register stage ================
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            S    <= '0;
            Cout <= 1'b0;
        end else begin
            S    <= sum_c;
            Cout <= c[7];
        end
    end
endmodule
