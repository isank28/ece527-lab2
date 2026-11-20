/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : X-2025.06-SP4
// Date      : Tue Nov 17 20:23:32 2026
/////////////////////////////////////////////////////////////


module rca4_pipe ( clk, rst_n, A, B, Cin, S, Cout );
  input [3:0] A;
  input [3:0] B;
  output [3:0] S;
  input clk, rst_n, Cin;
  output Cout;
  wire   Cin_reg, c_mid, Cout_wire, \u_fa2_low/n5 , \u_fa2_low/n4 ,
         \u_fa2_low/n3 , \u_fa2_low/n2 , \u_fa2_low/n1 , n15, n16, n17, n18,
         n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32;
  wire   [3:0] A_reg;
  wire   [3:0] B_reg;
  wire   [3:0] Sum_wire;

  DFFSR Cin_reg_reg ( .D(Cin), .CLK(clk), .R(rst_n), .S(1'b1), .Q(Cin_reg) );
  DFFSR \A_reg_reg[3]  ( .D(A[3]), .CLK(clk), .R(rst_n), .S(1'b1), .Q(A_reg[3]) );
  DFFSR \A_reg_reg[2]  ( .D(A[2]), .CLK(clk), .R(rst_n), .S(1'b1), .Q(A_reg[2]) );
  DFFSR \A_reg_reg[1]  ( .D(A[1]), .CLK(clk), .R(rst_n), .S(1'b1), .Q(A_reg[1]) );
  DFFSR \A_reg_reg[0]  ( .D(A[0]), .CLK(clk), .R(rst_n), .S(1'b1), .Q(A_reg[0]) );
  DFFSR \B_reg_reg[3]  ( .D(B[3]), .CLK(clk), .R(rst_n), .S(1'b1), .Q(B_reg[3]) );
  DFFSR \B_reg_reg[2]  ( .D(B[2]), .CLK(clk), .R(rst_n), .S(1'b1), .Q(B_reg[2]) );
  DFFSR \B_reg_reg[1]  ( .D(B[1]), .CLK(clk), .R(rst_n), .S(1'b1), .Q(B_reg[1]) );
  DFFSR \B_reg_reg[0]  ( .D(B[0]), .CLK(clk), .R(rst_n), .S(1'b1), .Q(B_reg[0]) );
  DFFSR Cout_reg ( .D(Cout_wire), .CLK(clk), .R(rst_n), .S(1'b1), .Q(Cout) );
  DFFSR \S_reg[3]  ( .D(Sum_wire[3]), .CLK(clk), .R(rst_n), .S(1'b1), .Q(S[3])
         );
  DFFSR \S_reg[2]  ( .D(Sum_wire[2]), .CLK(clk), .R(rst_n), .S(1'b1), .Q(S[2])
         );
  DFFSR \S_reg[1]  ( .D(Sum_wire[1]), .CLK(clk), .R(rst_n), .S(1'b1), .Q(S[1])
         );
  DFFSR \S_reg[0]  ( .D(Sum_wire[0]), .CLK(clk), .R(rst_n), .S(1'b1), .Q(S[0])
         );
  XOR2X1 \u_fa2_low/U8  ( .A(n18), .B(n21), .Y(\u_fa2_low/n3 ) );
  AOI21X1 \u_fa2_low/U7  ( .A(\u_fa2_low/n3 ), .B(n23), .C(\u_fa2_low/n5 ), 
        .Y(\u_fa2_low/n2 ) );
  XNOR2X1 \u_fa2_low/U6  ( .A(n17), .B(n22), .Y(\u_fa2_low/n1 ) );
  OAI21X1 \u_fa2_low/U4  ( .A(n27), .B(\u_fa2_low/n1 ), .C(n15), .Y(c_mid) );
  XOR2X1 \u_fa2_low/U3  ( .A(n23), .B(\u_fa2_low/n3 ), .Y(Sum_wire[0]) );
  XOR2X1 \u_fa2_low/U2  ( .A(\u_fa2_low/n1 ), .B(n27), .Y(Sum_wire[1]) );
  XOR2X1 \u_fa2_high/U8  ( .A(n20), .B(n25), .Y(n30) );
  AOI21X1 \u_fa2_high/U7  ( .A(n30), .B(c_mid), .C(n32), .Y(n29) );
  XNOR2X1 \u_fa2_high/U6  ( .A(n19), .B(n26), .Y(n28) );
  OAI21X1 \u_fa2_high/U4  ( .A(n24), .B(n28), .C(n16), .Y(Cout_wire) );
  XOR2X1 \u_fa2_high/U3  ( .A(c_mid), .B(n30), .Y(Sum_wire[2]) );
  XOR2X1 \u_fa2_high/U2  ( .A(n28), .B(n24), .Y(Sum_wire[3]) );
  AND2X1 U17 ( .A(n21), .B(n18), .Y(\u_fa2_low/n5 ) );
  AND2X1 U18 ( .A(n25), .B(n20), .Y(n32) );
  AND2X1 U19 ( .A(n17), .B(n22), .Y(\u_fa2_low/n4 ) );
  INVX1 U20 ( .A(\u_fa2_low/n4 ), .Y(n15) );
  AND2X1 U21 ( .A(n19), .B(n26), .Y(n31) );
  INVX1 U22 ( .A(n31), .Y(n16) );
  BUFX2 U23 ( .A(A_reg[1]), .Y(n17) );
  BUFX2 U24 ( .A(A_reg[0]), .Y(n18) );
  BUFX2 U25 ( .A(A_reg[3]), .Y(n19) );
  BUFX2 U26 ( .A(A_reg[2]), .Y(n20) );
  BUFX2 U27 ( .A(B_reg[0]), .Y(n21) );
  BUFX2 U28 ( .A(B_reg[1]), .Y(n22) );
  BUFX2 U29 ( .A(Cin_reg), .Y(n23) );
  BUFX2 U30 ( .A(n29), .Y(n24) );
  BUFX2 U31 ( .A(B_reg[2]), .Y(n25) );
  BUFX2 U32 ( .A(B_reg[3]), .Y(n26) );
  BUFX2 U33 ( .A(\u_fa2_low/n2 ), .Y(n27) );
endmodule

