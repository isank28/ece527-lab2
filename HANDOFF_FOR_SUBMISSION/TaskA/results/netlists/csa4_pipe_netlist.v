/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : X-2025.06-SP4
// Date      : Tue Nov 17 20:23:38 2026
/////////////////////////////////////////////////////////////


module csa4_pipe ( clk, rst_n, A, B, Cin, S, Cout );
  input [3:0] A;
  input [3:0] B;
  output [3:0] S;
  input clk, rst_n, Cin;
  output Cout;
  wire   Cin_reg, c_lo, \s_hi0[1] , c_hi0, c_hi1, c_lo_reg, c_hi0_reg,
         c_hi1_reg, n22, n23, n24, n25, \u_fa2_low/n5 , \u_fa2_low/n4 ,
         \u_fa2_low/n3 , \u_fa2_low/n2 , \u_fa2_low/n1 , n26, n27, n28, n29,
         n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43,
         n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56;
  wire   [3:0] A_reg;
  wire   [3:0] B_reg;
  wire   [1:0] s_lo;
  wire   [1:0] s_hi1;
  wire   [1:0] s_hi0_reg;
  wire   [1:0] s_hi1_reg;

  DFFSR Cin_reg_reg ( .D(Cin), .CLK(clk), .R(rst_n), .S(1'b1), .Q(Cin_reg) );
  DFFSR \A_reg_reg[3]  ( .D(A[3]), .CLK(clk), .R(rst_n), .S(1'b1), .Q(A_reg[3]) );
  DFFSR \A_reg_reg[2]  ( .D(A[2]), .CLK(clk), .R(rst_n), .S(1'b1), .Q(A_reg[2]) );
  DFFSR \A_reg_reg[1]  ( .D(A[1]), .CLK(clk), .R(rst_n), .S(1'b1), .Q(A_reg[1]) );
  DFFSR \A_reg_reg[0]  ( .D(A[0]), .CLK(clk), .R(rst_n), .S(1'b1), .Q(A_reg[0]) );
  DFFSR \B_reg_reg[3]  ( .D(B[3]), .CLK(clk), .R(rst_n), .S(1'b1), .Q(B_reg[3]) );
  DFFSR \B_reg_reg[2]  ( .D(B[2]), .CLK(clk), .R(rst_n), .S(1'b1), .Q(B_reg[2]) );
  DFFSR \B_reg_reg[1]  ( .D(B[1]), .CLK(clk), .R(rst_n), .S(1'b1), .Q(B_reg[1]) );
  DFFSR \B_reg_reg[0]  ( .D(B[0]), .CLK(clk), .R(rst_n), .S(1'b1), .Q(B_reg[0]) );
  DFFSR c_hi1_reg_reg ( .D(c_hi1), .CLK(clk), .R(rst_n), .S(1'b1), .Q(
        c_hi1_reg) );
  DFFSR \s_lo_reg_reg[1]  ( .D(s_lo[1]), .CLK(clk), .R(rst_n), .S(1'b1), .Q(
        S[1]) );
  DFFSR \s_lo_reg_reg[0]  ( .D(s_lo[0]), .CLK(clk), .R(rst_n), .S(1'b1), .Q(
        S[0]) );
  DFFSR c_lo_reg_reg ( .D(c_lo), .CLK(clk), .R(rst_n), .S(1'b1), .Q(c_lo_reg)
         );
  DFFSR \s_hi0_reg_reg[1]  ( .D(\s_hi0[1] ), .CLK(clk), .R(rst_n), .S(1'b1), 
        .Q(s_hi0_reg[1]) );
  DFFSR \s_hi0_reg_reg[0]  ( .D(n55), .CLK(clk), .R(rst_n), .S(1'b1), .Q(
        s_hi0_reg[0]) );
  DFFSR c_hi0_reg_reg ( .D(c_hi0), .CLK(clk), .R(rst_n), .S(1'b1), .Q(
        c_hi0_reg) );
  DFFSR \s_hi1_reg_reg[1]  ( .D(s_hi1[1]), .CLK(clk), .R(rst_n), .S(1'b1), .Q(
        s_hi1_reg[1]) );
  DFFSR \s_hi1_reg_reg[0]  ( .D(s_hi1[0]), .CLK(clk), .R(rst_n), .S(1'b1), .Q(
        s_hi1_reg[0]) );
  AOI22X1 U25 ( .A(n31), .B(n22), .C(n33), .D(n46), .Y(n23) );
  AOI22X1 U26 ( .A(n30), .B(n22), .C(n32), .D(n46), .Y(n24) );
  AOI22X1 U27 ( .A(n29), .B(n22), .C(n34), .D(n46), .Y(n25) );
  XOR2X1 \u_fa2_low/U8  ( .A(n38), .B(n39), .Y(\u_fa2_low/n3 ) );
  AOI21X1 \u_fa2_low/U7  ( .A(\u_fa2_low/n3 ), .B(n45), .C(\u_fa2_low/n5 ), 
        .Y(\u_fa2_low/n2 ) );
  XNOR2X1 \u_fa2_low/U6  ( .A(n37), .B(n40), .Y(\u_fa2_low/n1 ) );
  OAI21X1 \u_fa2_low/U4  ( .A(n42), .B(\u_fa2_low/n1 ), .C(n35), .Y(c_lo) );
  XOR2X1 \u_fa2_low/U3  ( .A(n45), .B(\u_fa2_low/n3 ), .Y(s_lo[0]) );
  XOR2X1 \u_fa2_low/U2  ( .A(\u_fa2_low/n1 ), .B(n42), .Y(s_lo[1]) );
  XOR2X1 \u_fa2_high1/U8  ( .A(n43), .B(n47), .Y(n55) );
  XNOR2X1 \u_fa2_high1/U6  ( .A(n44), .B(n48), .Y(n53) );
  OAI21X1 \u_fa2_high1/U4  ( .A(n41), .B(n53), .C(n36), .Y(c_hi1) );
  XOR2X1 \u_fa2_high1/U2  ( .A(n53), .B(n41), .Y(s_hi1[1]) );
  XNOR2X1 \u_fa2_high0/U6  ( .A(n44), .B(n48), .Y(n49) );
  OAI21X1 \u_fa2_high0/U4  ( .A(n50), .B(n49), .C(n36), .Y(c_hi0) );
  XOR2X1 \u_fa2_high0/U2  ( .A(n49), .B(n50), .Y(\s_hi0[1] ) );
  AND2X1 U28 ( .A(n47), .B(n43), .Y(n52) );
  AND2X1 U29 ( .A(n39), .B(n38), .Y(\u_fa2_low/n5 ) );
  AND2X1 U30 ( .A(n47), .B(n43), .Y(n56) );
  BUFX2 U31 ( .A(n25), .Y(n26) );
  BUFX2 U32 ( .A(n24), .Y(n27) );
  BUFX2 U33 ( .A(n23), .Y(n28) );
  BUFX2 U34 ( .A(c_hi0_reg), .Y(n29) );
  BUFX2 U35 ( .A(s_hi0_reg[0]), .Y(n30) );
  BUFX2 U36 ( .A(s_hi0_reg[1]), .Y(n31) );
  BUFX2 U37 ( .A(s_hi1_reg[0]), .Y(n32) );
  BUFX2 U38 ( .A(s_hi1_reg[1]), .Y(n33) );
  BUFX2 U39 ( .A(c_hi1_reg), .Y(n34) );
  AND2X1 U40 ( .A(n37), .B(n40), .Y(\u_fa2_low/n4 ) );
  INVX1 U41 ( .A(\u_fa2_low/n4 ), .Y(n35) );
  AND2X1 U42 ( .A(n44), .B(n48), .Y(n51) );
  INVX1 U43 ( .A(n51), .Y(n36) );
  BUFX2 U44 ( .A(A_reg[1]), .Y(n37) );
  BUFX2 U45 ( .A(A_reg[0]), .Y(n38) );
  BUFX2 U46 ( .A(B_reg[0]), .Y(n39) );
  BUFX2 U47 ( .A(B_reg[1]), .Y(n40) );
  OR2X1 U48 ( .A(n55), .B(n56), .Y(n54) );
  INVX1 U49 ( .A(n54), .Y(n41) );
  BUFX2 U50 ( .A(\u_fa2_low/n2 ), .Y(n42) );
  BUFX2 U51 ( .A(A_reg[2]), .Y(n43) );
  BUFX2 U52 ( .A(A_reg[3]), .Y(n44) );
  BUFX2 U53 ( .A(Cin_reg), .Y(n45) );
  BUFX2 U54 ( .A(c_lo_reg), .Y(n46) );
  BUFX2 U55 ( .A(B_reg[2]), .Y(n47) );
  BUFX2 U56 ( .A(B_reg[3]), .Y(n48) );
  INVX1 U57 ( .A(n55), .Y(s_hi1[0]) );
  INVX1 U58 ( .A(n52), .Y(n50) );
  INVX1 U59 ( .A(n46), .Y(n22) );
  INVX1 U60 ( .A(n26), .Y(Cout) );
  INVX1 U61 ( .A(n27), .Y(S[2]) );
  INVX1 U62 ( .A(n28), .Y(S[3]) );
endmodule

