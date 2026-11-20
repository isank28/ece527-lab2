/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : X-2025.06-SP4
// Date      : Mon Nov 16 20:59:56 2026
/////////////////////////////////////////////////////////////


module csa8_pipe ( clk, rst_n, A, B, Cin, S, Cout );
  input [7:0] A;
  input [7:0] B;
  output [7:0] S;
  input clk, rst_n, Cin;
  output Cout;
  wire   Cin_reg, c_lo, \s0[1][1] , \s0[2][1] , \s0[3][1] , \s1[1][1] ,
         \s1[1][0] , \s1[2][1] , \s1[2][0] , \s1[3][1] , \s1[3][0] ,
         \s0_reg[1][1] , \s0_reg[1][0] , \s0_reg[2][1] , \s0_reg[2][0] ,
         \s0_reg[3][1] , \s0_reg[3][0] , \s1_reg[1][1] , \s1_reg[1][0] ,
         \s1_reg[2][1] , \s1_reg[2][0] , \s1_reg[3][1] , \s1_reg[3][0] ,
         \sel[1] , n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57,
         \u_blk0/n5 , \u_blk0/n4 , \u_blk0/n3 , \u_blk0/n2 , \u_blk0/n1 , n58,
         n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72,
         n73, n74, n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85, n86,
         n87, n88, n89, n90, n91, n92, n93, n94, n95, n96, n97, n98, n99, n100,
         n101, n102, n103, n104, n105, n106, n107, n108, n109, n110, n111,
         n112, n113, n114, n115, n116, n117, n118, n119, n120, n121, n122,
         n123, n124, n125, n126, n127, n128, n129, n130, n131, n132, n133,
         n134;
  wire   [7:0] A_reg;
  wire   [7:0] B_reg;
  wire   [1:0] s_lo;
  wire   [1:3] c0;
  wire   [1:3] c1;
  wire   [1:3] c0_reg;
  wire   [1:3] c1_reg;

  DFFSR Cin_reg_reg ( .D(Cin), .CLK(clk), .R(rst_n), .S(1'b1), .Q(Cin_reg) );
  DFFSR \A_reg_reg[7]  ( .D(A[7]), .CLK(clk), .R(rst_n), .S(1'b1), .Q(A_reg[7]) );
  DFFSR \A_reg_reg[6]  ( .D(A[6]), .CLK(clk), .R(rst_n), .S(1'b1), .Q(A_reg[6]) );
  DFFSR \A_reg_reg[5]  ( .D(A[5]), .CLK(clk), .R(rst_n), .S(1'b1), .Q(A_reg[5]) );
  DFFSR \A_reg_reg[4]  ( .D(A[4]), .CLK(clk), .R(rst_n), .S(1'b1), .Q(A_reg[4]) );
  DFFSR \A_reg_reg[3]  ( .D(A[3]), .CLK(clk), .R(rst_n), .S(1'b1), .Q(A_reg[3]) );
  DFFSR \A_reg_reg[2]  ( .D(A[2]), .CLK(clk), .R(rst_n), .S(1'b1), .Q(A_reg[2]) );
  DFFSR \A_reg_reg[1]  ( .D(A[1]), .CLK(clk), .R(rst_n), .S(1'b1), .Q(A_reg[1]) );
  DFFSR \A_reg_reg[0]  ( .D(A[0]), .CLK(clk), .R(rst_n), .S(1'b1), .Q(A_reg[0]) );
  DFFSR \B_reg_reg[7]  ( .D(B[7]), .CLK(clk), .R(rst_n), .S(1'b1), .Q(B_reg[7]) );
  DFFSR \B_reg_reg[6]  ( .D(B[6]), .CLK(clk), .R(rst_n), .S(1'b1), .Q(B_reg[6]) );
  DFFSR \B_reg_reg[5]  ( .D(B[5]), .CLK(clk), .R(rst_n), .S(1'b1), .Q(B_reg[5]) );
  DFFSR \B_reg_reg[4]  ( .D(B[4]), .CLK(clk), .R(rst_n), .S(1'b1), .Q(B_reg[4]) );
  DFFSR \B_reg_reg[3]  ( .D(B[3]), .CLK(clk), .R(rst_n), .S(1'b1), .Q(B_reg[3]) );
  DFFSR \B_reg_reg[2]  ( .D(B[2]), .CLK(clk), .R(rst_n), .S(1'b1), .Q(B_reg[2]) );
  DFFSR \B_reg_reg[1]  ( .D(B[1]), .CLK(clk), .R(rst_n), .S(1'b1), .Q(B_reg[1]) );
  DFFSR \B_reg_reg[0]  ( .D(B[0]), .CLK(clk), .R(rst_n), .S(1'b1), .Q(B_reg[0]) );
  DFFSR \s1_reg_reg[1][1]  ( .D(\s1[1][1] ), .CLK(clk), .R(rst_n), .S(1'b1), 
        .Q(\s1_reg[1][1] ) );
  DFFSR \s1_reg_reg[1][0]  ( .D(\s1[1][0] ), .CLK(clk), .R(rst_n), .S(1'b1), 
        .Q(\s1_reg[1][0] ) );
  DFFSR \s1_reg_reg[2][1]  ( .D(\s1[2][1] ), .CLK(clk), .R(rst_n), .S(1'b1), 
        .Q(\s1_reg[2][1] ) );
  DFFSR \s1_reg_reg[2][0]  ( .D(\s1[2][0] ), .CLK(clk), .R(rst_n), .S(1'b1), 
        .Q(\s1_reg[2][0] ) );
  DFFSR \s1_reg_reg[3][1]  ( .D(\s1[3][1] ), .CLK(clk), .R(rst_n), .S(1'b1), 
        .Q(\s1_reg[3][1] ) );
  DFFSR \s1_reg_reg[3][0]  ( .D(\s1[3][0] ), .CLK(clk), .R(rst_n), .S(1'b1), 
        .Q(\s1_reg[3][0] ) );
  DFFSR \s_lo_reg_reg[1]  ( .D(s_lo[1]), .CLK(clk), .R(rst_n), .S(1'b1), .Q(
        S[1]) );
  DFFSR \s_lo_reg_reg[0]  ( .D(s_lo[0]), .CLK(clk), .R(rst_n), .S(1'b1), .Q(
        S[0]) );
  DFFSR c_lo_reg_reg ( .D(c_lo), .CLK(clk), .R(rst_n), .S(1'b1), .Q(\sel[1] )
         );
  DFFSR \c0_reg_reg[1]  ( .D(c0[1]), .CLK(clk), .R(rst_n), .S(1'b1), .Q(
        c0_reg[1]) );
  DFFSR \c0_reg_reg[2]  ( .D(c0[2]), .CLK(clk), .R(rst_n), .S(1'b1), .Q(
        c0_reg[2]) );
  DFFSR \c0_reg_reg[3]  ( .D(c0[3]), .CLK(clk), .R(rst_n), .S(1'b1), .Q(
        c0_reg[3]) );
  DFFSR \c1_reg_reg[1]  ( .D(c1[1]), .CLK(clk), .R(rst_n), .S(1'b1), .Q(
        c1_reg[1]) );
  DFFSR \c1_reg_reg[2]  ( .D(c1[2]), .CLK(clk), .R(rst_n), .S(1'b1), .Q(
        c1_reg[2]) );
  DFFSR \c1_reg_reg[3]  ( .D(c1[3]), .CLK(clk), .R(rst_n), .S(1'b1), .Q(
        c1_reg[3]) );
  DFFSR \s0_reg_reg[1][1]  ( .D(\s0[1][1] ), .CLK(clk), .R(rst_n), .S(1'b1), 
        .Q(\s0_reg[1][1] ) );
  DFFSR \s0_reg_reg[1][0]  ( .D(n116), .CLK(clk), .R(rst_n), .S(1'b1), .Q(
        \s0_reg[1][0] ) );
  DFFSR \s0_reg_reg[2][1]  ( .D(\s0[2][1] ), .CLK(clk), .R(rst_n), .S(1'b1), 
        .Q(\s0_reg[2][1] ) );
  DFFSR \s0_reg_reg[2][0]  ( .D(n124), .CLK(clk), .R(rst_n), .S(1'b1), .Q(
        \s0_reg[2][0] ) );
  DFFSR \s0_reg_reg[3][1]  ( .D(\s0[3][1] ), .CLK(clk), .R(rst_n), .S(1'b1), 
        .Q(\s0_reg[3][1] ) );
  DFFSR \s0_reg_reg[3][0]  ( .D(n132), .CLK(clk), .R(rst_n), .S(1'b1), .Q(
        \s0_reg[3][0] ) );
  AOI22X1 U51 ( .A(n66), .B(n94), .C(n77), .D(n46), .Y(n49) );
  AOI22X1 U52 ( .A(n65), .B(n94), .C(n76), .D(n46), .Y(n51) );
  AOI22X1 U53 ( .A(n68), .B(n99), .C(n79), .D(n47), .Y(n52) );
  AOI22X1 U54 ( .A(n67), .B(n99), .C(n78), .D(n47), .Y(n54) );
  AOI22X1 U55 ( .A(n70), .B(n48), .C(n81), .D(n104), .Y(n55) );
  AOI22X1 U56 ( .A(n69), .B(n48), .C(n80), .D(n104), .Y(n56) );
  AOI22X1 U57 ( .A(n71), .B(n94), .C(n74), .D(n46), .Y(n57) );
  AOI22X1 U58 ( .A(n72), .B(n99), .C(n75), .D(n47), .Y(n50) );
  AOI22X1 U59 ( .A(n73), .B(n48), .C(n104), .D(n82), .Y(n53) );
  XOR2X1 \u_blk0/U8  ( .A(n88), .B(n89), .Y(\u_blk0/n3 ) );
  AOI21X1 \u_blk0/U7  ( .A(\u_blk0/n3 ), .B(n103), .C(\u_blk0/n5 ), .Y(
        \u_blk0/n2 ) );
  XNOR2X1 \u_blk0/U6  ( .A(n87), .B(n90), .Y(\u_blk0/n1 ) );
  OAI21X1 \u_blk0/U4  ( .A(n95), .B(\u_blk0/n1 ), .C(n83), .Y(c_lo) );
  XOR2X1 \u_blk0/U3  ( .A(n103), .B(\u_blk0/n3 ), .Y(s_lo[0]) );
  XOR2X1 \u_blk0/U2  ( .A(\u_blk0/n1 ), .B(n95), .Y(s_lo[1]) );
  XOR2X1 \g_blk[3].u_cin1/U8  ( .A(n96), .B(n105), .Y(n132) );
  XNOR2X1 \g_blk[3].u_cin1/U6  ( .A(n100), .B(n108), .Y(n130) );
  OAI21X1 \g_blk[3].u_cin1/U4  ( .A(n93), .B(n130), .C(n86), .Y(c1[3]) );
  XOR2X1 \g_blk[3].u_cin1/U2  ( .A(n130), .B(n93), .Y(\s1[3][1] ) );
  XNOR2X1 \g_blk[3].u_cin0/U6  ( .A(n100), .B(n108), .Y(n127) );
  OAI21X1 \g_blk[3].u_cin0/U4  ( .A(n128), .B(n127), .C(n86), .Y(c0[3]) );
  XOR2X1 \g_blk[3].u_cin0/U2  ( .A(n127), .B(n128), .Y(\s0[3][1] ) );
  XOR2X1 \g_blk[2].u_cin1/U8  ( .A(n97), .B(n106), .Y(n124) );
  XNOR2X1 \g_blk[2].u_cin1/U6  ( .A(n101), .B(n109), .Y(n122) );
  OAI21X1 \g_blk[2].u_cin1/U4  ( .A(n92), .B(n122), .C(n85), .Y(c1[2]) );
  XOR2X1 \g_blk[2].u_cin1/U2  ( .A(n122), .B(n92), .Y(\s1[2][1] ) );
  XNOR2X1 \g_blk[2].u_cin0/U6  ( .A(n101), .B(n109), .Y(n119) );
  OAI21X1 \g_blk[2].u_cin0/U4  ( .A(n120), .B(n119), .C(n85), .Y(c0[2]) );
  XOR2X1 \g_blk[2].u_cin0/U2  ( .A(n119), .B(n120), .Y(\s0[2][1] ) );
  XOR2X1 \g_blk[1].u_cin1/U8  ( .A(n98), .B(n107), .Y(n116) );
  XNOR2X1 \g_blk[1].u_cin1/U6  ( .A(n102), .B(n110), .Y(n114) );
  OAI21X1 \g_blk[1].u_cin1/U4  ( .A(n91), .B(n114), .C(n84), .Y(c1[1]) );
  XOR2X1 \g_blk[1].u_cin1/U2  ( .A(n114), .B(n91), .Y(\s1[1][1] ) );
  XNOR2X1 \g_blk[1].u_cin0/U6  ( .A(n102), .B(n110), .Y(n111) );
  OAI21X1 \g_blk[1].u_cin0/U4  ( .A(n112), .B(n111), .C(n84), .Y(c0[1]) );
  XOR2X1 \g_blk[1].u_cin0/U2  ( .A(n111), .B(n112), .Y(\s0[1][1] ) );
  AND2X1 U60 ( .A(n105), .B(n96), .Y(n129) );
  AND2X1 U61 ( .A(n106), .B(n97), .Y(n121) );
  AND2X1 U62 ( .A(n107), .B(n98), .Y(n113) );
  AND2X1 U63 ( .A(n89), .B(n88), .Y(\u_blk0/n5 ) );
  AND2X1 U64 ( .A(n105), .B(n96), .Y(n134) );
  AND2X1 U65 ( .A(n106), .B(n97), .Y(n126) );
  AND2X1 U66 ( .A(n107), .B(n98), .Y(n118) );
  BUFX2 U67 ( .A(n57), .Y(n58) );
  BUFX2 U68 ( .A(n56), .Y(n59) );
  BUFX2 U69 ( .A(n55), .Y(n60) );
  BUFX2 U70 ( .A(n54), .Y(n61) );
  BUFX2 U71 ( .A(n52), .Y(n62) );
  BUFX2 U72 ( .A(n51), .Y(n63) );
  BUFX2 U73 ( .A(n49), .Y(n64) );
  BUFX2 U74 ( .A(\s0_reg[3][0] ), .Y(n65) );
  BUFX2 U75 ( .A(\s0_reg[3][1] ), .Y(n66) );
  BUFX2 U76 ( .A(\s0_reg[2][0] ), .Y(n67) );
  BUFX2 U77 ( .A(\s0_reg[2][1] ), .Y(n68) );
  BUFX2 U78 ( .A(\s0_reg[1][0] ), .Y(n69) );
  BUFX2 U79 ( .A(\s0_reg[1][1] ), .Y(n70) );
  BUFX2 U80 ( .A(c0_reg[3]), .Y(n71) );
  BUFX2 U81 ( .A(c0_reg[2]), .Y(n72) );
  BUFX2 U82 ( .A(c0_reg[1]), .Y(n73) );
  BUFX2 U83 ( .A(c1_reg[3]), .Y(n74) );
  BUFX2 U84 ( .A(c1_reg[2]), .Y(n75) );
  BUFX2 U85 ( .A(\s1_reg[3][0] ), .Y(n76) );
  BUFX2 U86 ( .A(\s1_reg[3][1] ), .Y(n77) );
  BUFX2 U87 ( .A(\s1_reg[2][0] ), .Y(n78) );
  BUFX2 U88 ( .A(\s1_reg[2][1] ), .Y(n79) );
  BUFX2 U89 ( .A(\s1_reg[1][0] ), .Y(n80) );
  BUFX2 U90 ( .A(\s1_reg[1][1] ), .Y(n81) );
  BUFX2 U91 ( .A(c1_reg[1]), .Y(n82) );
  AND2X1 U92 ( .A(n87), .B(n90), .Y(\u_blk0/n4 ) );
  INVX1 U93 ( .A(\u_blk0/n4 ), .Y(n83) );
  AND2X1 U94 ( .A(n102), .B(n110), .Y(n117) );
  INVX1 U95 ( .A(n117), .Y(n84) );
  AND2X1 U96 ( .A(n101), .B(n109), .Y(n125) );
  INVX1 U97 ( .A(n125), .Y(n85) );
  AND2X1 U98 ( .A(n100), .B(n108), .Y(n133) );
  INVX1 U99 ( .A(n133), .Y(n86) );
  BUFX2 U100 ( .A(A_reg[1]), .Y(n87) );
  BUFX2 U101 ( .A(A_reg[0]), .Y(n88) );
  BUFX2 U102 ( .A(B_reg[0]), .Y(n89) );
  BUFX2 U103 ( .A(B_reg[1]), .Y(n90) );
  OR2X1 U104 ( .A(n116), .B(n118), .Y(n115) );
  INVX1 U105 ( .A(n115), .Y(n91) );
  OR2X1 U106 ( .A(n124), .B(n126), .Y(n123) );
  INVX1 U107 ( .A(n123), .Y(n92) );
  OR2X1 U108 ( .A(n132), .B(n134), .Y(n131) );
  INVX1 U109 ( .A(n131), .Y(n93) );
  BUFX2 U110 ( .A(n50), .Y(n94) );
  BUFX2 U111 ( .A(\u_blk0/n2 ), .Y(n95) );
  BUFX2 U112 ( .A(A_reg[6]), .Y(n96) );
  BUFX2 U113 ( .A(A_reg[4]), .Y(n97) );
  BUFX2 U114 ( .A(A_reg[2]), .Y(n98) );
  BUFX2 U115 ( .A(n53), .Y(n99) );
  BUFX2 U116 ( .A(A_reg[7]), .Y(n100) );
  BUFX2 U117 ( .A(A_reg[5]), .Y(n101) );
  BUFX2 U118 ( .A(A_reg[3]), .Y(n102) );
  BUFX2 U119 ( .A(Cin_reg), .Y(n103) );
  BUFX2 U120 ( .A(\sel[1] ), .Y(n104) );
  BUFX2 U121 ( .A(B_reg[6]), .Y(n105) );
  BUFX2 U122 ( .A(B_reg[4]), .Y(n106) );
  BUFX2 U123 ( .A(B_reg[2]), .Y(n107) );
  BUFX2 U124 ( .A(B_reg[7]), .Y(n108) );
  BUFX2 U125 ( .A(B_reg[5]), .Y(n109) );
  BUFX2 U126 ( .A(B_reg[3]), .Y(n110) );
  INVX1 U127 ( .A(n99), .Y(n47) );
  INVX1 U128 ( .A(n94), .Y(n46) );
  INVX1 U129 ( .A(n132), .Y(\s1[3][0] ) );
  INVX1 U130 ( .A(n124), .Y(\s1[2][0] ) );
  INVX1 U131 ( .A(n116), .Y(\s1[1][0] ) );
  INVX1 U132 ( .A(n104), .Y(n48) );
  INVX1 U133 ( .A(n58), .Y(Cout) );
  INVX1 U134 ( .A(n63), .Y(S[6]) );
  INVX1 U135 ( .A(n64), .Y(S[7]) );
  INVX1 U136 ( .A(n129), .Y(n128) );
  INVX1 U137 ( .A(n121), .Y(n120) );
  INVX1 U138 ( .A(n113), .Y(n112) );
  INVX1 U139 ( .A(n61), .Y(S[4]) );
  INVX1 U140 ( .A(n62), .Y(S[5]) );
  INVX1 U141 ( .A(n59), .Y(S[2]) );
  INVX1 U142 ( .A(n60), .Y(S[3]) );
endmodule

