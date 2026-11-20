`timescale 1ns/1ps
`default_nettype none
// 8x8 unsigned array multiplier (DSE generated)
module array_multiplier_8x8 (
    input  logic [7:0]   a,
    input  logic [7:0]   b,
    output logic [15:0]   p
);

    localparam int W = 16;

    logic [W-1:0] pp  [0:7];
    logic [W-1:0] acc [0:7];

    genvar i;

    assign pp[0] = ({8{1'b0}}, a} & {16{b[0]}}) << 0;
    assign pp[1] = ({8{1'b0}}, a} & {16{b[1]}}) << 1;
    assign pp[2] = ({8{1'b0}}, a} & {16{b[2]}}) << 2;
    assign pp[3] = ({8{1'b0}}, a} & {16{b[3]}}) << 3;
    assign pp[4] = ({8{1'b0}}, a} & {16{b[4]}}) << 4;
    assign pp[5] = ({8{1'b0}}, a} & {16{b[5]}}) << 5;
    assign pp[6] = ({8{1'b0}}, a} & {16{b[6]}}) << 6;
    assign pp[7] = ({8{1'b0}}, a} & {16{b[7]}}) << 7;

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
    wire c1_8 = (acc[0][8] & pp[1][8]) | (acc[0][8] & c1_7) | (pp[1][8] & c1_7);
    assign acc_1_sum[8] = acc[0][8] ^ pp[1][8] ^ c1_7;
    wire c1_9 = (acc[0][9] & pp[1][9]) | (acc[0][9] & c1_8) | (pp[1][9] & c1_8);
    assign acc_1_sum[9] = acc[0][9] ^ pp[1][9] ^ c1_8;
    wire c1_10 = (acc[0][10] & pp[1][10]) | (acc[0][10] & c1_9) | (pp[1][10] & c1_9);
    assign acc_1_sum[10] = acc[0][10] ^ pp[1][10] ^ c1_9;
    wire c1_11 = (acc[0][11] & pp[1][11]) | (acc[0][11] & c1_10) | (pp[1][11] & c1_10);
    assign acc_1_sum[11] = acc[0][11] ^ pp[1][11] ^ c1_10;
    wire c1_12 = (acc[0][12] & pp[1][12]) | (acc[0][12] & c1_11) | (pp[1][12] & c1_11);
    assign acc_1_sum[12] = acc[0][12] ^ pp[1][12] ^ c1_11;
    wire c1_13 = (acc[0][13] & pp[1][13]) | (acc[0][13] & c1_12) | (pp[1][13] & c1_12);
    assign acc_1_sum[13] = acc[0][13] ^ pp[1][13] ^ c1_12;
    wire c1_14 = (acc[0][14] & pp[1][14]) | (acc[0][14] & c1_13) | (pp[1][14] & c1_13);
    assign acc_1_sum[14] = acc[0][14] ^ pp[1][14] ^ c1_13;
    wire c1_15 = (acc[0][15] & pp[1][15]) | (acc[0][15] & c1_14) | (pp[1][15] & c1_14);
    assign acc_1_sum[15] = acc[0][15] ^ pp[1][15] ^ c1_14;
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
    wire c2_8 = (acc[1][8] & pp[2][8]) | (acc[1][8] & c2_7) | (pp[2][8] & c2_7);
    assign acc_2_sum[8] = acc[1][8] ^ pp[2][8] ^ c2_7;
    wire c2_9 = (acc[1][9] & pp[2][9]) | (acc[1][9] & c2_8) | (pp[2][9] & c2_8);
    assign acc_2_sum[9] = acc[1][9] ^ pp[2][9] ^ c2_8;
    wire c2_10 = (acc[1][10] & pp[2][10]) | (acc[1][10] & c2_9) | (pp[2][10] & c2_9);
    assign acc_2_sum[10] = acc[1][10] ^ pp[2][10] ^ c2_9;
    wire c2_11 = (acc[1][11] & pp[2][11]) | (acc[1][11] & c2_10) | (pp[2][11] & c2_10);
    assign acc_2_sum[11] = acc[1][11] ^ pp[2][11] ^ c2_10;
    wire c2_12 = (acc[1][12] & pp[2][12]) | (acc[1][12] & c2_11) | (pp[2][12] & c2_11);
    assign acc_2_sum[12] = acc[1][12] ^ pp[2][12] ^ c2_11;
    wire c2_13 = (acc[1][13] & pp[2][13]) | (acc[1][13] & c2_12) | (pp[2][13] & c2_12);
    assign acc_2_sum[13] = acc[1][13] ^ pp[2][13] ^ c2_12;
    wire c2_14 = (acc[1][14] & pp[2][14]) | (acc[1][14] & c2_13) | (pp[2][14] & c2_13);
    assign acc_2_sum[14] = acc[1][14] ^ pp[2][14] ^ c2_13;
    wire c2_15 = (acc[1][15] & pp[2][15]) | (acc[1][15] & c2_14) | (pp[2][15] & c2_14);
    assign acc_2_sum[15] = acc[1][15] ^ pp[2][15] ^ c2_14;
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
    wire c3_8 = (acc[2][8] & pp[3][8]) | (acc[2][8] & c3_7) | (pp[3][8] & c3_7);
    assign acc_3_sum[8] = acc[2][8] ^ pp[3][8] ^ c3_7;
    wire c3_9 = (acc[2][9] & pp[3][9]) | (acc[2][9] & c3_8) | (pp[3][9] & c3_8);
    assign acc_3_sum[9] = acc[2][9] ^ pp[3][9] ^ c3_8;
    wire c3_10 = (acc[2][10] & pp[3][10]) | (acc[2][10] & c3_9) | (pp[3][10] & c3_9);
    assign acc_3_sum[10] = acc[2][10] ^ pp[3][10] ^ c3_9;
    wire c3_11 = (acc[2][11] & pp[3][11]) | (acc[2][11] & c3_10) | (pp[3][11] & c3_10);
    assign acc_3_sum[11] = acc[2][11] ^ pp[3][11] ^ c3_10;
    wire c3_12 = (acc[2][12] & pp[3][12]) | (acc[2][12] & c3_11) | (pp[3][12] & c3_11);
    assign acc_3_sum[12] = acc[2][12] ^ pp[3][12] ^ c3_11;
    wire c3_13 = (acc[2][13] & pp[3][13]) | (acc[2][13] & c3_12) | (pp[3][13] & c3_12);
    assign acc_3_sum[13] = acc[2][13] ^ pp[3][13] ^ c3_12;
    wire c3_14 = (acc[2][14] & pp[3][14]) | (acc[2][14] & c3_13) | (pp[3][14] & c3_13);
    assign acc_3_sum[14] = acc[2][14] ^ pp[3][14] ^ c3_13;
    wire c3_15 = (acc[2][15] & pp[3][15]) | (acc[2][15] & c3_14) | (pp[3][15] & c3_14);
    assign acc_3_sum[15] = acc[2][15] ^ pp[3][15] ^ c3_14;
    assign acc[3] = acc_3_sum;

    wire [W-1:0] acc_4_sum;
    wire           acc_4_cout;

    // Row 4: acc[3] + pp[4]
    assign acc_4_sum[0] = acc[3][0] ^ pp[4][0];
    wire c4_0 = acc[3][0] & pp[4][0];
    wire c4_1 = (acc[3][1] & pp[4][1]) | (acc[3][1] & c4_0) | (pp[4][1] & c4_0);
    assign acc_4_sum[1] = acc[3][1] ^ pp[4][1] ^ c4_0;
    wire c4_2 = (acc[3][2] & pp[4][2]) | (acc[3][2] & c4_1) | (pp[4][2] & c4_1);
    assign acc_4_sum[2] = acc[3][2] ^ pp[4][2] ^ c4_1;
    wire c4_3 = (acc[3][3] & pp[4][3]) | (acc[3][3] & c4_2) | (pp[4][3] & c4_2);
    assign acc_4_sum[3] = acc[3][3] ^ pp[4][3] ^ c4_2;
    wire c4_4 = (acc[3][4] & pp[4][4]) | (acc[3][4] & c4_3) | (pp[4][4] & c4_3);
    assign acc_4_sum[4] = acc[3][4] ^ pp[4][4] ^ c4_3;
    wire c4_5 = (acc[3][5] & pp[4][5]) | (acc[3][5] & c4_4) | (pp[4][5] & c4_4);
    assign acc_4_sum[5] = acc[3][5] ^ pp[4][5] ^ c4_4;
    wire c4_6 = (acc[3][6] & pp[4][6]) | (acc[3][6] & c4_5) | (pp[4][6] & c4_5);
    assign acc_4_sum[6] = acc[3][6] ^ pp[4][6] ^ c4_5;
    wire c4_7 = (acc[3][7] & pp[4][7]) | (acc[3][7] & c4_6) | (pp[4][7] & c4_6);
    assign acc_4_sum[7] = acc[3][7] ^ pp[4][7] ^ c4_6;
    wire c4_8 = (acc[3][8] & pp[4][8]) | (acc[3][8] & c4_7) | (pp[4][8] & c4_7);
    assign acc_4_sum[8] = acc[3][8] ^ pp[4][8] ^ c4_7;
    wire c4_9 = (acc[3][9] & pp[4][9]) | (acc[3][9] & c4_8) | (pp[4][9] & c4_8);
    assign acc_4_sum[9] = acc[3][9] ^ pp[4][9] ^ c4_8;
    wire c4_10 = (acc[3][10] & pp[4][10]) | (acc[3][10] & c4_9) | (pp[4][10] & c4_9);
    assign acc_4_sum[10] = acc[3][10] ^ pp[4][10] ^ c4_9;
    wire c4_11 = (acc[3][11] & pp[4][11]) | (acc[3][11] & c4_10) | (pp[4][11] & c4_10);
    assign acc_4_sum[11] = acc[3][11] ^ pp[4][11] ^ c4_10;
    wire c4_12 = (acc[3][12] & pp[4][12]) | (acc[3][12] & c4_11) | (pp[4][12] & c4_11);
    assign acc_4_sum[12] = acc[3][12] ^ pp[4][12] ^ c4_11;
    wire c4_13 = (acc[3][13] & pp[4][13]) | (acc[3][13] & c4_12) | (pp[4][13] & c4_12);
    assign acc_4_sum[13] = acc[3][13] ^ pp[4][13] ^ c4_12;
    wire c4_14 = (acc[3][14] & pp[4][14]) | (acc[3][14] & c4_13) | (pp[4][14] & c4_13);
    assign acc_4_sum[14] = acc[3][14] ^ pp[4][14] ^ c4_13;
    wire c4_15 = (acc[3][15] & pp[4][15]) | (acc[3][15] & c4_14) | (pp[4][15] & c4_14);
    assign acc_4_sum[15] = acc[3][15] ^ pp[4][15] ^ c4_14;
    assign acc[4] = acc_4_sum;

    wire [W-1:0] acc_5_sum;
    wire           acc_5_cout;

    // Row 5: acc[4] + pp[5]
    assign acc_5_sum[0] = acc[4][0] ^ pp[5][0];
    wire c5_0 = acc[4][0] & pp[5][0];
    wire c5_1 = (acc[4][1] & pp[5][1]) | (acc[4][1] & c5_0) | (pp[5][1] & c5_0);
    assign acc_5_sum[1] = acc[4][1] ^ pp[5][1] ^ c5_0;
    wire c5_2 = (acc[4][2] & pp[5][2]) | (acc[4][2] & c5_1) | (pp[5][2] & c5_1);
    assign acc_5_sum[2] = acc[4][2] ^ pp[5][2] ^ c5_1;
    wire c5_3 = (acc[4][3] & pp[5][3]) | (acc[4][3] & c5_2) | (pp[5][3] & c5_2);
    assign acc_5_sum[3] = acc[4][3] ^ pp[5][3] ^ c5_2;
    wire c5_4 = (acc[4][4] & pp[5][4]) | (acc[4][4] & c5_3) | (pp[5][4] & c5_3);
    assign acc_5_sum[4] = acc[4][4] ^ pp[5][4] ^ c5_3;
    wire c5_5 = (acc[4][5] & pp[5][5]) | (acc[4][5] & c5_4) | (pp[5][5] & c5_4);
    assign acc_5_sum[5] = acc[4][5] ^ pp[5][5] ^ c5_4;
    wire c5_6 = (acc[4][6] & pp[5][6]) | (acc[4][6] & c5_5) | (pp[5][6] & c5_5);
    assign acc_5_sum[6] = acc[4][6] ^ pp[5][6] ^ c5_5;
    wire c5_7 = (acc[4][7] & pp[5][7]) | (acc[4][7] & c5_6) | (pp[5][7] & c5_6);
    assign acc_5_sum[7] = acc[4][7] ^ pp[5][7] ^ c5_6;
    wire c5_8 = (acc[4][8] & pp[5][8]) | (acc[4][8] & c5_7) | (pp[5][8] & c5_7);
    assign acc_5_sum[8] = acc[4][8] ^ pp[5][8] ^ c5_7;
    wire c5_9 = (acc[4][9] & pp[5][9]) | (acc[4][9] & c5_8) | (pp[5][9] & c5_8);
    assign acc_5_sum[9] = acc[4][9] ^ pp[5][9] ^ c5_8;
    wire c5_10 = (acc[4][10] & pp[5][10]) | (acc[4][10] & c5_9) | (pp[5][10] & c5_9);
    assign acc_5_sum[10] = acc[4][10] ^ pp[5][10] ^ c5_9;
    wire c5_11 = (acc[4][11] & pp[5][11]) | (acc[4][11] & c5_10) | (pp[5][11] & c5_10);
    assign acc_5_sum[11] = acc[4][11] ^ pp[5][11] ^ c5_10;
    wire c5_12 = (acc[4][12] & pp[5][12]) | (acc[4][12] & c5_11) | (pp[5][12] & c5_11);
    assign acc_5_sum[12] = acc[4][12] ^ pp[5][12] ^ c5_11;
    wire c5_13 = (acc[4][13] & pp[5][13]) | (acc[4][13] & c5_12) | (pp[5][13] & c5_12);
    assign acc_5_sum[13] = acc[4][13] ^ pp[5][13] ^ c5_12;
    wire c5_14 = (acc[4][14] & pp[5][14]) | (acc[4][14] & c5_13) | (pp[5][14] & c5_13);
    assign acc_5_sum[14] = acc[4][14] ^ pp[5][14] ^ c5_13;
    wire c5_15 = (acc[4][15] & pp[5][15]) | (acc[4][15] & c5_14) | (pp[5][15] & c5_14);
    assign acc_5_sum[15] = acc[4][15] ^ pp[5][15] ^ c5_14;
    assign acc[5] = acc_5_sum;

    wire [W-1:0] acc_6_sum;
    wire           acc_6_cout;

    // Row 6: acc[5] + pp[6]
    assign acc_6_sum[0] = acc[5][0] ^ pp[6][0];
    wire c6_0 = acc[5][0] & pp[6][0];
    wire c6_1 = (acc[5][1] & pp[6][1]) | (acc[5][1] & c6_0) | (pp[6][1] & c6_0);
    assign acc_6_sum[1] = acc[5][1] ^ pp[6][1] ^ c6_0;
    wire c6_2 = (acc[5][2] & pp[6][2]) | (acc[5][2] & c6_1) | (pp[6][2] & c6_1);
    assign acc_6_sum[2] = acc[5][2] ^ pp[6][2] ^ c6_1;
    wire c6_3 = (acc[5][3] & pp[6][3]) | (acc[5][3] & c6_2) | (pp[6][3] & c6_2);
    assign acc_6_sum[3] = acc[5][3] ^ pp[6][3] ^ c6_2;
    wire c6_4 = (acc[5][4] & pp[6][4]) | (acc[5][4] & c6_3) | (pp[6][4] & c6_3);
    assign acc_6_sum[4] = acc[5][4] ^ pp[6][4] ^ c6_3;
    wire c6_5 = (acc[5][5] & pp[6][5]) | (acc[5][5] & c6_4) | (pp[6][5] & c6_4);
    assign acc_6_sum[5] = acc[5][5] ^ pp[6][5] ^ c6_4;
    wire c6_6 = (acc[5][6] & pp[6][6]) | (acc[5][6] & c6_5) | (pp[6][6] & c6_5);
    assign acc_6_sum[6] = acc[5][6] ^ pp[6][6] ^ c6_5;
    wire c6_7 = (acc[5][7] & pp[6][7]) | (acc[5][7] & c6_6) | (pp[6][7] & c6_6);
    assign acc_6_sum[7] = acc[5][7] ^ pp[6][7] ^ c6_6;
    wire c6_8 = (acc[5][8] & pp[6][8]) | (acc[5][8] & c6_7) | (pp[6][8] & c6_7);
    assign acc_6_sum[8] = acc[5][8] ^ pp[6][8] ^ c6_7;
    wire c6_9 = (acc[5][9] & pp[6][9]) | (acc[5][9] & c6_8) | (pp[6][9] & c6_8);
    assign acc_6_sum[9] = acc[5][9] ^ pp[6][9] ^ c6_8;
    wire c6_10 = (acc[5][10] & pp[6][10]) | (acc[5][10] & c6_9) | (pp[6][10] & c6_9);
    assign acc_6_sum[10] = acc[5][10] ^ pp[6][10] ^ c6_9;
    wire c6_11 = (acc[5][11] & pp[6][11]) | (acc[5][11] & c6_10) | (pp[6][11] & c6_10);
    assign acc_6_sum[11] = acc[5][11] ^ pp[6][11] ^ c6_10;
    wire c6_12 = (acc[5][12] & pp[6][12]) | (acc[5][12] & c6_11) | (pp[6][12] & c6_11);
    assign acc_6_sum[12] = acc[5][12] ^ pp[6][12] ^ c6_11;
    wire c6_13 = (acc[5][13] & pp[6][13]) | (acc[5][13] & c6_12) | (pp[6][13] & c6_12);
    assign acc_6_sum[13] = acc[5][13] ^ pp[6][13] ^ c6_12;
    wire c6_14 = (acc[5][14] & pp[6][14]) | (acc[5][14] & c6_13) | (pp[6][14] & c6_13);
    assign acc_6_sum[14] = acc[5][14] ^ pp[6][14] ^ c6_13;
    wire c6_15 = (acc[5][15] & pp[6][15]) | (acc[5][15] & c6_14) | (pp[6][15] & c6_14);
    assign acc_6_sum[15] = acc[5][15] ^ pp[6][15] ^ c6_14;
    assign acc[6] = acc_6_sum;

    wire [W-1:0] acc_7_sum;
    wire           acc_7_cout;

    // Row 7: acc[6] + pp[7]
    assign acc_7_sum[0] = acc[6][0] ^ pp[7][0];
    wire c7_0 = acc[6][0] & pp[7][0];
    wire c7_1 = (acc[6][1] & pp[7][1]) | (acc[6][1] & c7_0) | (pp[7][1] & c7_0);
    assign acc_7_sum[1] = acc[6][1] ^ pp[7][1] ^ c7_0;
    wire c7_2 = (acc[6][2] & pp[7][2]) | (acc[6][2] & c7_1) | (pp[7][2] & c7_1);
    assign acc_7_sum[2] = acc[6][2] ^ pp[7][2] ^ c7_1;
    wire c7_3 = (acc[6][3] & pp[7][3]) | (acc[6][3] & c7_2) | (pp[7][3] & c7_2);
    assign acc_7_sum[3] = acc[6][3] ^ pp[7][3] ^ c7_2;
    wire c7_4 = (acc[6][4] & pp[7][4]) | (acc[6][4] & c7_3) | (pp[7][4] & c7_3);
    assign acc_7_sum[4] = acc[6][4] ^ pp[7][4] ^ c7_3;
    wire c7_5 = (acc[6][5] & pp[7][5]) | (acc[6][5] & c7_4) | (pp[7][5] & c7_4);
    assign acc_7_sum[5] = acc[6][5] ^ pp[7][5] ^ c7_4;
    wire c7_6 = (acc[6][6] & pp[7][6]) | (acc[6][6] & c7_5) | (pp[7][6] & c7_5);
    assign acc_7_sum[6] = acc[6][6] ^ pp[7][6] ^ c7_5;
    wire c7_7 = (acc[6][7] & pp[7][7]) | (acc[6][7] & c7_6) | (pp[7][7] & c7_6);
    assign acc_7_sum[7] = acc[6][7] ^ pp[7][7] ^ c7_6;
    wire c7_8 = (acc[6][8] & pp[7][8]) | (acc[6][8] & c7_7) | (pp[7][8] & c7_7);
    assign acc_7_sum[8] = acc[6][8] ^ pp[7][8] ^ c7_7;
    wire c7_9 = (acc[6][9] & pp[7][9]) | (acc[6][9] & c7_8) | (pp[7][9] & c7_8);
    assign acc_7_sum[9] = acc[6][9] ^ pp[7][9] ^ c7_8;
    wire c7_10 = (acc[6][10] & pp[7][10]) | (acc[6][10] & c7_9) | (pp[7][10] & c7_9);
    assign acc_7_sum[10] = acc[6][10] ^ pp[7][10] ^ c7_9;
    wire c7_11 = (acc[6][11] & pp[7][11]) | (acc[6][11] & c7_10) | (pp[7][11] & c7_10);
    assign acc_7_sum[11] = acc[6][11] ^ pp[7][11] ^ c7_10;
    wire c7_12 = (acc[6][12] & pp[7][12]) | (acc[6][12] & c7_11) | (pp[7][12] & c7_11);
    assign acc_7_sum[12] = acc[6][12] ^ pp[7][12] ^ c7_11;
    wire c7_13 = (acc[6][13] & pp[7][13]) | (acc[6][13] & c7_12) | (pp[7][13] & c7_12);
    assign acc_7_sum[13] = acc[6][13] ^ pp[7][13] ^ c7_12;
    wire c7_14 = (acc[6][14] & pp[7][14]) | (acc[6][14] & c7_13) | (pp[7][14] & c7_13);
    assign acc_7_sum[14] = acc[6][14] ^ pp[7][14] ^ c7_13;
    wire c7_15 = (acc[6][15] & pp[7][15]) | (acc[6][15] & c7_14) | (pp[7][15] & c7_14);
    assign acc_7_sum[15] = acc[6][15] ^ pp[7][15] ^ c7_14;
    assign acc[7] = acc_7_sum;

    assign p = acc[N-1];

endmodule
`default_nettype wire