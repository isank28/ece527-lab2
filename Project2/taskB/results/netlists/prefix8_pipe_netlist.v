/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : X-2025.06-SP4
// Date      : Mon Nov 16 20:59:50 2026
/////////////////////////////////////////////////////////////


module prefix8_pipe ( clk, rst_n, A, B, Cin, S, Cout );
  input [7:0] A;
  input [7:0] B;
  output [7:0] S;
  input clk, rst_n, Cin;
  output Cout;
  wire   Cin_reg, \g[4] , P54, G30, P64, P74, G74, g4_m, G54_m, P54_m, G64_m,
         P64_m, G74_m, P74_m, Cin_m, n47, n48, n49, n50, n51, n52, n53, n54,
         n55, n56, n57, n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68,
         n69, n70, n71, n72, n73, n74, n75, n76, n77, n78, n79, n80, n81, n82,
         n83, n84, n85, n86, n87, n88, n89, n90, n91, n92, n93, n94, n95, n96,
         n97, n98, n99, n100, n101, n102, n103, n104, n105, n106, n107, n108,
         n109, n110, n111, n112, n113, n114, n115, n116, n117, n118, n119,
         n120;
  wire   [7:0] A_reg;
  wire   [7:0] B_reg;
  wire   [7:0] p;
  wire   [7:0] p_m;
  wire   [7:0] c;
  wire   [7:0] sum_c;

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
  DFFSR Cin_m_reg ( .D(n96), .CLK(clk), .R(rst_n), .S(1'b1), .Q(Cin_m) );
  DFFSR G30_m_reg ( .D(G30), .CLK(clk), .R(rst_n), .S(1'b1), .Q(c[3]) );
  DFFSR G00_m_reg ( .D(n49), .CLK(clk), .R(rst_n), .S(1'b1), .Q(c[0]) );
  DFFSR G10_m_reg ( .D(n48), .CLK(clk), .R(rst_n), .S(1'b1), .Q(c[1]) );
  DFFSR G20_m_reg ( .D(n47), .CLK(clk), .R(rst_n), .S(1'b1), .Q(c[2]) );
  DFFSR P74_m_reg ( .D(P74), .CLK(clk), .R(rst_n), .S(1'b1), .Q(P74_m) );
  DFFSR g4_m_reg ( .D(\g[4] ), .CLK(clk), .R(rst_n), .S(1'b1), .Q(g4_m) );
  DFFSR G54_m_reg ( .D(n52), .CLK(clk), .R(rst_n), .S(1'b1), .Q(G54_m) );
  DFFSR P54_m_reg ( .D(P54), .CLK(clk), .R(rst_n), .S(1'b1), .Q(P54_m) );
  DFFSR G64_m_reg ( .D(n51), .CLK(clk), .R(rst_n), .S(1'b1), .Q(G64_m) );
  DFFSR P64_m_reg ( .D(P64), .CLK(clk), .R(rst_n), .S(1'b1), .Q(P64_m) );
  DFFSR G74_m_reg ( .D(G74), .CLK(clk), .R(rst_n), .S(1'b1), .Q(G74_m) );
  DFFSR \p_m_reg[7]  ( .D(n50), .CLK(clk), .R(rst_n), .S(1'b1), .Q(p_m[7]) );
  DFFSR \p_m_reg[6]  ( .D(p[6]), .CLK(clk), .R(rst_n), .S(1'b1), .Q(p_m[6]) );
  DFFSR \p_m_reg[5]  ( .D(p[5]), .CLK(clk), .R(rst_n), .S(1'b1), .Q(p_m[5]) );
  DFFSR \p_m_reg[4]  ( .D(p[4]), .CLK(clk), .R(rst_n), .S(1'b1), .Q(p_m[4]) );
  DFFSR \p_m_reg[3]  ( .D(n53), .CLK(clk), .R(rst_n), .S(1'b1), .Q(p_m[3]) );
  DFFSR \p_m_reg[2]  ( .D(p[2]), .CLK(clk), .R(rst_n), .S(1'b1), .Q(p_m[2]) );
  DFFSR \p_m_reg[1]  ( .D(p[1]), .CLK(clk), .R(rst_n), .S(1'b1), .Q(p_m[1]) );
  DFFSR \p_m_reg[0]  ( .D(p[0]), .CLK(clk), .R(rst_n), .S(1'b1), .Q(p_m[0]) );
  DFFSR Cout_reg ( .D(n54), .CLK(clk), .R(rst_n), .S(1'b1), .Q(Cout) );
  DFFSR \S_reg[7]  ( .D(sum_c[7]), .CLK(clk), .R(rst_n), .S(1'b1), .Q(S[7]) );
  DFFSR \S_reg[6]  ( .D(sum_c[6]), .CLK(clk), .R(rst_n), .S(1'b1), .Q(S[6]) );
  DFFSR \S_reg[5]  ( .D(sum_c[5]), .CLK(clk), .R(rst_n), .S(1'b1), .Q(S[5]) );
  DFFSR \S_reg[4]  ( .D(sum_c[4]), .CLK(clk), .R(rst_n), .S(1'b1), .Q(S[4]) );
  DFFSR \S_reg[3]  ( .D(sum_c[3]), .CLK(clk), .R(rst_n), .S(1'b1), .Q(S[3]) );
  DFFSR \S_reg[2]  ( .D(sum_c[2]), .CLK(clk), .R(rst_n), .S(1'b1), .Q(S[2]) );
  DFFSR \S_reg[1]  ( .D(sum_c[1]), .CLK(clk), .R(rst_n), .S(1'b1), .Q(S[1]) );
  DFFSR \S_reg[0]  ( .D(sum_c[0]), .CLK(clk), .R(rst_n), .S(1'b1), .Q(S[0]) );
  XNOR2X1 U66 ( .A(n100), .B(n89), .Y(sum_c[7]) );
  AOI21X1 U67 ( .A(n120), .B(n81), .C(n78), .Y(n55) );
  XNOR2X1 U68 ( .A(n87), .B(n101), .Y(sum_c[6]) );
  AOI21X1 U69 ( .A(n82), .B(n120), .C(n79), .Y(n56) );
  XNOR2X1 U70 ( .A(n88), .B(n94), .Y(sum_c[5]) );
  AOI21X1 U71 ( .A(n110), .B(n120), .C(n80), .Y(n57) );
  XOR2X1 U72 ( .A(n110), .B(n120), .Y(sum_c[4]) );
  XOR2X1 U73 ( .A(n111), .B(n102), .Y(sum_c[3]) );
  XOR2X1 U74 ( .A(n85), .B(n95), .Y(sum_c[2]) );
  XOR2X1 U75 ( .A(n92), .B(n90), .Y(sum_c[1]) );
  XOR2X1 U76 ( .A(n93), .B(n112), .Y(sum_c[0]) );
  AOI21X1 U77 ( .A(n83), .B(n120), .C(n77), .Y(n59) );
  XOR2X1 U78 ( .A(n99), .B(n115), .Y(p[4]) );
  OAI21X1 U79 ( .A(n97), .B(n60), .C(n86), .Y(G74) );
  XNOR2X1 U81 ( .A(n103), .B(n118), .Y(n60) );
  AOI21X1 U82 ( .A(n52), .B(p[6]), .C(n63), .Y(n61) );
  XOR2X1 U83 ( .A(n107), .B(n117), .Y(p[6]) );
  AOI21X1 U84 ( .A(p[5]), .B(\g[4] ), .C(n65), .Y(n64) );
  XOR2X1 U85 ( .A(n106), .B(n116), .Y(p[5]) );
  OAI21X1 U86 ( .A(n91), .B(n58), .C(n84), .Y(G30) );
  XNOR2X1 U88 ( .A(n98), .B(n108), .Y(n58) );
  AOI21X1 U89 ( .A(n48), .B(p[2]), .C(n68), .Y(n66) );
  XOR2X1 U90 ( .A(n105), .B(n114), .Y(p[2]) );
  AOI21X1 U91 ( .A(n49), .B(p[1]), .C(n70), .Y(n69) );
  XOR2X1 U92 ( .A(n104), .B(n113), .Y(p[1]) );
  AOI21X1 U93 ( .A(n119), .B(n109), .C(n72), .Y(n71) );
  XOR2X1 U94 ( .A(n109), .B(n119), .Y(p[0]) );
  AND2X1 U95 ( .A(n107), .B(n117), .Y(n63) );
  AND2X1 U96 ( .A(n105), .B(n114), .Y(n68) );
  AND2X1 U97 ( .A(n106), .B(n116), .Y(n65) );
  AND2X1 U98 ( .A(n99), .B(n115), .Y(\g[4] ) );
  AND2X1 U99 ( .A(n104), .B(n113), .Y(n70) );
  BUFX2 U100 ( .A(n71), .Y(n73) );
  AND2X1 U101 ( .A(n96), .B(p[0]), .Y(n72) );
  BUFX2 U102 ( .A(n69), .Y(n74) );
  BUFX2 U103 ( .A(n64), .Y(n75) );
  BUFX2 U104 ( .A(n59), .Y(n76) );
  BUFX2 U105 ( .A(G74_m), .Y(n77) );
  BUFX2 U106 ( .A(G64_m), .Y(n78) );
  BUFX2 U107 ( .A(G54_m), .Y(n79) );
  BUFX2 U108 ( .A(g4_m), .Y(n80) );
  BUFX2 U109 ( .A(P64_m), .Y(n81) );
  BUFX2 U110 ( .A(P54_m), .Y(n82) );
  BUFX2 U111 ( .A(P74_m), .Y(n83) );
  AND2X1 U112 ( .A(n98), .B(n108), .Y(n67) );
  INVX1 U113 ( .A(n67), .Y(n84) );
  BUFX2 U114 ( .A(p_m[2]), .Y(n85) );
  AND2X1 U115 ( .A(n103), .B(n118), .Y(n62) );
  INVX1 U116 ( .A(n62), .Y(n86) );
  BUFX2 U117 ( .A(p_m[6]), .Y(n87) );
  BUFX2 U118 ( .A(p_m[5]), .Y(n88) );
  BUFX2 U119 ( .A(n55), .Y(n89) );
  BUFX2 U120 ( .A(c[0]), .Y(n90) );
  BUFX2 U121 ( .A(n66), .Y(n91) );
  BUFX2 U122 ( .A(p_m[1]), .Y(n92) );
  BUFX2 U123 ( .A(p_m[0]), .Y(n93) );
  BUFX2 U124 ( .A(n57), .Y(n94) );
  BUFX2 U125 ( .A(c[1]), .Y(n95) );
  BUFX2 U126 ( .A(Cin_reg), .Y(n96) );
  BUFX2 U127 ( .A(n61), .Y(n97) );
  BUFX2 U128 ( .A(A_reg[3]), .Y(n98) );
  BUFX2 U129 ( .A(A_reg[4]), .Y(n99) );
  BUFX2 U130 ( .A(p_m[7]), .Y(n100) );
  BUFX2 U131 ( .A(n56), .Y(n101) );
  BUFX2 U132 ( .A(c[2]), .Y(n102) );
  BUFX2 U133 ( .A(A_reg[7]), .Y(n103) );
  BUFX2 U134 ( .A(A_reg[1]), .Y(n104) );
  BUFX2 U135 ( .A(A_reg[2]), .Y(n105) );
  BUFX2 U136 ( .A(A_reg[5]), .Y(n106) );
  BUFX2 U137 ( .A(A_reg[6]), .Y(n107) );
  BUFX2 U138 ( .A(B_reg[3]), .Y(n108) );
  BUFX2 U139 ( .A(A_reg[0]), .Y(n109) );
  BUFX2 U140 ( .A(p_m[4]), .Y(n110) );
  BUFX2 U141 ( .A(p_m[3]), .Y(n111) );
  BUFX2 U142 ( .A(Cin_m), .Y(n112) );
  BUFX2 U143 ( .A(B_reg[1]), .Y(n113) );
  BUFX2 U144 ( .A(B_reg[2]), .Y(n114) );
  BUFX2 U145 ( .A(B_reg[4]), .Y(n115) );
  BUFX2 U146 ( .A(B_reg[5]), .Y(n116) );
  BUFX2 U147 ( .A(B_reg[6]), .Y(n117) );
  BUFX2 U148 ( .A(B_reg[7]), .Y(n118) );
  BUFX2 U149 ( .A(B_reg[0]), .Y(n119) );
  BUFX2 U150 ( .A(c[3]), .Y(n120) );
  AND2X1 U151 ( .A(P64), .B(n50), .Y(P74) );
  INVX1 U152 ( .A(n91), .Y(n47) );
  AND2X1 U153 ( .A(P54), .B(p[6]), .Y(P64) );
  AND2X1 U154 ( .A(p[4]), .B(p[5]), .Y(P54) );
  INVX1 U155 ( .A(n97), .Y(n51) );
  INVX1 U156 ( .A(n60), .Y(n50) );
  INVX1 U157 ( .A(n58), .Y(n53) );
  INVX1 U158 ( .A(n73), .Y(n49) );
  INVX1 U159 ( .A(n74), .Y(n48) );
  INVX1 U160 ( .A(n75), .Y(n52) );
  INVX1 U161 ( .A(n76), .Y(n54) );
endmodule

