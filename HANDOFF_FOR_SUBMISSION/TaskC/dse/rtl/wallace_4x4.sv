`timescale 1ns/1ps
`default_nettype none
// 4x4 unsigned Wallace-tree multiplier (DSE generated)
module wallace_multiplier_4x4 (
    input  logic [3:0]   a,
    input  logic [3:0]   b,
    output logic [7:0]   p
);

    localparam int W = 8;

    logic [W-1:0] pp [0:3];

    genvar i;

    assign pp[0] = ({4{1'b0}}, a} & {8{b[0]}}) << 0;
    assign pp[1] = ({4{1'b0}}, a} & {8{b[1]}}) << 1;
    assign pp[2] = ({4{1'b0}}, a} & {8{b[2]}}) << 2;
    assign pp[3] = ({4{1'b0}}, a} & {8{b[3]}}) << 3;

    logic [W-1:0] s_0_0;
    logic [W-1:0] c_0_0;
    // CSA stage 0 csa 0
    assign s_0_0 = pp[0] ^ pp[1] ^ pp[2];
    assign c_0_0[0] = 1'b0;
    assign c_0_0[1] = (pp[0][0] & pp[1][0]) | (pp[0][0] & pp[2][0]) | (pp[1][0] & pp[2][0]);
    assign c_0_0[2] = (pp[0][1] & pp[1][1]) | (pp[0][1] & pp[2][1]) | (pp[1][1] & pp[2][1]);
    assign c_0_0[3] = (pp[0][2] & pp[1][2]) | (pp[0][2] & pp[2][2]) | (pp[1][2] & pp[2][2]);
    assign c_0_0[4] = (pp[0][3] & pp[1][3]) | (pp[0][3] & pp[2][3]) | (pp[1][3] & pp[2][3]);
    assign c_0_0[5] = (pp[0][4] & pp[1][4]) | (pp[0][4] & pp[2][4]) | (pp[1][4] & pp[2][4]);
    assign c_0_0[6] = (pp[0][5] & pp[1][5]) | (pp[0][5] & pp[2][5]) | (pp[1][5] & pp[2][5]);
    assign c_0_0[7] = (pp[0][6] & pp[1][6]) | (pp[0][6] & pp[2][6]) | (pp[1][6] & pp[2][6]);

    logic [W-1:0] s_1_1;
    logic [W-1:0] c_1_1;
    // CSA stage 1 csa 1
    assign s_1_1 = s_0_0 ^ c_0_0 ^ pp[3];
    assign c_1_1[0] = 1'b0;
    assign c_1_1[1] = (s_0_0[0] & c_0_0[0]) | (s_0_0[0] & pp[3][0]) | (c_0_0[0] & pp[3][0]);
    assign c_1_1[2] = (s_0_0[1] & c_0_0[1]) | (s_0_0[1] & pp[3][1]) | (c_0_0[1] & pp[3][1]);
    assign c_1_1[3] = (s_0_0[2] & c_0_0[2]) | (s_0_0[2] & pp[3][2]) | (c_0_0[2] & pp[3][2]);
    assign c_1_1[4] = (s_0_0[3] & c_0_0[3]) | (s_0_0[3] & pp[3][3]) | (c_0_0[3] & pp[3][3]);
    assign c_1_1[5] = (s_0_0[4] & c_0_0[4]) | (s_0_0[4] & pp[3][4]) | (c_0_0[4] & pp[3][4]);
    assign c_1_1[6] = (s_0_0[5] & c_0_0[5]) | (s_0_0[5] & pp[3][5]) | (c_0_0[5] & pp[3][5]);
    assign c_1_1[7] = (s_0_0[6] & c_0_0[6]) | (s_0_0[6] & pp[3][6]) | (c_0_0[6] & pp[3][6]);

    logic [W:0] final_sum_stage1;
    assign final_sum_stage1 = {1'b0, s_1_1} + {1'b0, c_1_1};
    assign p = final_sum_stage1[7:0];

endmodule
`default_nettype wire