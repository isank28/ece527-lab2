`timescale 1ns/1ps
`default_nettype none
// 4x4 unsigned array multiplier (DSE generated)
module array_multiplier_4x4 (
    input  logic [3:0]   a,
    input  logic [3:0]   b,
    output logic [7:0]   p
);

    localparam int W = 8;

    logic [W-1:0] pp  [0:3];
    logic [W-1:0] acc [0:3];

    genvar i;

    assign pp[0] = ({4{1'b0}}, a} & {8{b[0]}}) << 0;
    assign pp[1] = ({4{1'b0}}, a} & {8{b[1]}}) << 1;
    assign pp[2] = ({4{1'b0}}, a} & {8{b[2]}}) << 2;
    assign pp[3] = ({4{1'b0}}, a} & {8{b[3]}}) << 3;

    assign acc[0] = pp[0];

    wire [W-1:0] acc_1_sum;
    wire           acc_1_cout;

    // Row 1: acc[0] + pp[1]
    assign acc_1_sum[0] = acc[0][0] ^ pp[1][0];
    wire c1_0 = acc[0][0] & pp[1][0];
    wire c1_1 = (acc[0][1] & pp[1][1]) | (acc[0][1] & c1_0) | (pp[1][1] & c1_0);
    assign acc_1_sum[1] = acc[0][1] ^ pp[1][1] ^ c1_0;
    wire c1_2 = (acc[0][2] & pp[1][2]) | (acc[0][2] & c1_1) | (pp[1][2] & c1_1);
    assign acc_1_sum[2] = acc[0][2] ^ pp[1][2] ^ c1_1;
    wire c1_3 = (acc[0][3] & pp[1][3]) | (acc[0][3] & c1_2) | (pp[1][3] & c1_2);
    assign acc_1_sum[3] = acc[0][3] ^ pp[1][3] ^ c1_2;
    wire c1_4 = (acc[0][4] & pp[1][4]) | (acc[0][4] & c1_3) | (pp[1][4] & c1_3);
    assign acc_1_sum[4] = acc[0][4] ^ pp[1][4] ^ c1_3;
    wire c1_5 = (acc[0][5] & pp[1][5]) | (acc[0][5] & c1_4) | (pp[1][5] & c1_4);
    assign acc_1_sum[5] = acc[0][5] ^ pp[1][5] ^ c1_4;
    wire c1_6 = (acc[0][6] & pp[1][6]) | (acc[0][6] & c1_5) | (pp[1][6] & c1_5);
    assign acc_1_sum[6] = acc[0][6] ^ pp[1][6] ^ c1_5;
    wire c1_7 = (acc[0][7] & pp[1][7]) | (acc[0][7] & c1_6) | (pp[1][7] & c1_6);
    assign acc_1_sum[7] = acc[0][7] ^ pp[1][7] ^ c1_6;
    assign acc[1] = acc_1_sum;

    wire [W-1:0] acc_2_sum;
    wire           acc_2_cout;

    // Row 2: acc[1] + pp[2]
    assign acc_2_sum[0] = acc[1][0] ^ pp[2][0];
    wire c2_0 = acc[1][0] & pp[2][0];
    wire c2_1 = (acc[1][1] & pp[2][1]) | (acc[1][1] & c2_0) | (pp[2][1] & c2_0);
    assign acc_2_sum[1] = acc[1][1] ^ pp[2][1] ^ c2_0;
    wire c2_2 = (acc[1][2] & pp[2][2]) | (acc[1][2] & c2_1) | (pp[2][2] & c2_1);
    assign acc_2_sum[2] = acc[1][2] ^ pp[2][2] ^ c2_1;
    wire c2_3 = (acc[1][3] & pp[2][3]) | (acc[1][3] & c2_2) | (pp[2][3] & c2_2);
    assign acc_2_sum[3] = acc[1][3] ^ pp[2][3] ^ c2_2;
    wire c2_4 = (acc[1][4] & pp[2][4]) | (acc[1][4] & c2_3) | (pp[2][4] & c2_3);
    assign acc_2_sum[4] = acc[1][4] ^ pp[2][4] ^ c2_3;
    wire c2_5 = (acc[1][5] & pp[2][5]) | (acc[1][5] & c2_4) | (pp[2][5] & c2_4);
    assign acc_2_sum[5] = acc[1][5] ^ pp[2][5] ^ c2_4;
    wire c2_6 = (acc[1][6] & pp[2][6]) | (acc[1][6] & c2_5) | (pp[2][6] & c2_5);
    assign acc_2_sum[6] = acc[1][6] ^ pp[2][6] ^ c2_5;
    wire c2_7 = (acc[1][7] & pp[2][7]) | (acc[1][7] & c2_6) | (pp[2][7] & c2_6);
    assign acc_2_sum[7] = acc[1][7] ^ pp[2][7] ^ c2_6;
    assign acc[2] = acc_2_sum;

    wire [W-1:0] acc_3_sum;
    wire           acc_3_cout;

    // Row 3: acc[2] + pp[3]
    assign acc_3_sum[0] = acc[2][0] ^ pp[3][0];
    wire c3_0 = acc[2][0] & pp[3][0];
    wire c3_1 = (acc[2][1] & pp[3][1]) | (acc[2][1] & c3_0) | (pp[3][1] & c3_0);
    assign acc_3_sum[1] = acc[2][1] ^ pp[3][1] ^ c3_0;
    wire c3_2 = (acc[2][2] & pp[3][2]) | (acc[2][2] & c3_1) | (pp[3][2] & c3_1);
    assign acc_3_sum[2] = acc[2][2] ^ pp[3][2] ^ c3_1;
    wire c3_3 = (acc[2][3] & pp[3][3]) | (acc[2][3] & c3_2) | (pp[3][3] & c3_2);
    assign acc_3_sum[3] = acc[2][3] ^ pp[3][3] ^ c3_2;
    wire c3_4 = (acc[2][4] & pp[3][4]) | (acc[2][4] & c3_3) | (pp[3][4] & c3_3);
    assign acc_3_sum[4] = acc[2][4] ^ pp[3][4] ^ c3_3;
    wire c3_5 = (acc[2][5] & pp[3][5]) | (acc[2][5] & c3_4) | (pp[3][5] & c3_4);
    assign acc_3_sum[5] = acc[2][5] ^ pp[3][5] ^ c3_4;
    wire c3_6 = (acc[2][6] & pp[3][6]) | (acc[2][6] & c3_5) | (pp[3][6] & c3_5);
    assign acc_3_sum[6] = acc[2][6] ^ pp[3][6] ^ c3_5;
    wire c3_7 = (acc[2][7] & pp[3][7]) | (acc[2][7] & c3_6) | (pp[3][7] & c3_6);
    assign acc_3_sum[7] = acc[2][7] ^ pp[3][7] ^ c3_6;
    assign acc[3] = acc_3_sum;

    assign p = acc[N-1];

endmodule
`default_nettype wire