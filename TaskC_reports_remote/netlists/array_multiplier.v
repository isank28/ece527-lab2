/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : L-2016.03-SP3
// Date      : Tue Nov 17 15:04:47 2026
/////////////////////////////////////////////////////////////


module array_multiplier ( a, b, p );
  input [7:0] a;
  input [7:0] b;
  output [15:0] p;

  tri   \*Logic0* ;
  tri   [15:0] p;
  tri   \pp[0][7] ;
  tri   \pp[0][6] ;
  tri   \pp[0][5] ;
  tri   \pp[0][4] ;
  tri   \pp[0][3] ;
  tri   \pp[0][2] ;
  tri   \pp[0][1] ;
  tri   \pp[0][0] ;
  tri   \pp[1][8] ;
  tri   \pp[1][7] ;
  tri   \pp[1][6] ;
  tri   \pp[1][5] ;
  tri   \pp[1][4] ;
  tri   \pp[1][3] ;
  tri   \pp[1][2] ;
  tri   \pp[1][1] ;
  tri   \pp[2][9] ;
  tri   \pp[2][8] ;
  tri   \pp[2][7] ;
  tri   \pp[2][6] ;
  tri   \pp[2][5] ;
  tri   \pp[2][4] ;
  tri   \pp[2][3] ;
  tri   \pp[2][2] ;
  tri   \pp[3][10] ;
  tri   \pp[3][9] ;
  tri   \pp[3][8] ;
  tri   \pp[3][7] ;
  tri   \pp[3][6] ;
  tri   \pp[3][5] ;
  tri   \pp[3][4] ;
  tri   \pp[3][3] ;
  tri   \pp[4][11] ;
  tri   \pp[4][10] ;
  tri   \pp[4][9] ;
  tri   \pp[4][8] ;
  tri   \pp[4][7] ;
  tri   \pp[4][6] ;
  tri   \pp[4][5] ;
  tri   \pp[4][4] ;
  tri   \pp[5][12] ;
  tri   \pp[5][11] ;
  tri   \pp[5][10] ;
  tri   \pp[5][9] ;
  tri   \pp[5][8] ;
  tri   \pp[5][7] ;
  tri   \pp[5][6] ;
  tri   \pp[5][5] ;
  tri   \pp[6][13] ;
  tri   \pp[6][12] ;
  tri   \pp[6][11] ;
  tri   \pp[6][10] ;
  tri   \pp[6][9] ;
  tri   \pp[6][8] ;
  tri   \pp[6][7] ;
  tri   \pp[6][6] ;
  tri   \pp[7][14] ;
  tri   \pp[7][13] ;
  tri   \pp[7][12] ;
  tri   \pp[7][11] ;
  tri   \pp[7][10] ;
  tri   \pp[7][9] ;
  tri   \pp[7][8] ;
  tri   \pp[7][7] ;
  tri   \acc[1][15] ;
  tri   \acc[1][14] ;
  tri   \acc[1][13] ;
  tri   \acc[1][12] ;
  tri   \acc[1][11] ;
  tri   \acc[1][10] ;
  tri   \acc[1][9] ;
  tri   \acc[1][8] ;
  tri   \acc[1][7] ;
  tri   \acc[1][6] ;
  tri   \acc[1][5] ;
  tri   \acc[1][4] ;
  tri   \acc[1][3] ;
  tri   \acc[1][2] ;
  tri   \acc[1][1] ;
  tri   \acc[1][0] ;
  tri   \acc[2][15] ;
  tri   \acc[2][14] ;
  tri   \acc[2][13] ;
  tri   \acc[2][12] ;
  tri   \acc[2][11] ;
  tri   \acc[2][10] ;
  tri   \acc[2][9] ;
  tri   \acc[2][8] ;
  tri   \acc[2][7] ;
  tri   \acc[2][6] ;
  tri   \acc[2][5] ;
  tri   \acc[2][4] ;
  tri   \acc[2][3] ;
  tri   \acc[2][2] ;
  tri   \acc[2][1] ;
  tri   \acc[2][0] ;
  tri   \acc[3][15] ;
  tri   \acc[3][14] ;
  tri   \acc[3][13] ;
  tri   \acc[3][12] ;
  tri   \acc[3][11] ;
  tri   \acc[3][10] ;
  tri   \acc[3][9] ;
  tri   \acc[3][8] ;
  tri   \acc[3][7] ;
  tri   \acc[3][6] ;
  tri   \acc[3][5] ;
  tri   \acc[3][4] ;
  tri   \acc[3][3] ;
  tri   \acc[3][2] ;
  tri   \acc[3][1] ;
  tri   \acc[3][0] ;
  tri   \acc[4][15] ;
  tri   \acc[4][14] ;
  tri   \acc[4][13] ;
  tri   \acc[4][12] ;
  tri   \acc[4][11] ;
  tri   \acc[4][10] ;
  tri   \acc[4][9] ;
  tri   \acc[4][8] ;
  tri   \acc[4][7] ;
  tri   \acc[4][6] ;
  tri   \acc[4][5] ;
  tri   \acc[4][4] ;
  tri   \acc[4][3] ;
  tri   \acc[4][2] ;
  tri   \acc[4][1] ;
  tri   \acc[4][0] ;
  tri   \acc[5][15] ;
  tri   \acc[5][14] ;
  tri   \acc[5][13] ;
  tri   \acc[5][12] ;
  tri   \acc[5][11] ;
  tri   \acc[5][10] ;
  tri   \acc[5][9] ;
  tri   \acc[5][8] ;
  tri   \acc[5][7] ;
  tri   \acc[5][6] ;
  tri   \acc[5][5] ;
  tri   \acc[5][4] ;
  tri   \acc[5][3] ;
  tri   \acc[5][2] ;
  tri   \acc[5][1] ;
  tri   \acc[5][0] ;
  tri   \acc[6][15] ;
  tri   \acc[6][14] ;
  tri   \acc[6][13] ;
  tri   \acc[6][12] ;
  tri   \acc[6][11] ;
  tri   \acc[6][10] ;
  tri   \acc[6][9] ;
  tri   \acc[6][8] ;
  tri   \acc[6][7] ;
  tri   \acc[6][6] ;
  tri   \acc[6][5] ;
  tri   \acc[6][4] ;
  tri   \acc[6][3] ;
  tri   \acc[6][2] ;
  tri   \acc[6][1] ;
  tri   \acc[6][0] ;

  rca \gen_row_accumulation[1].u_row_adder  ( .a({1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, \pp[0][7] , \pp[0][6] , \pp[0][5] , \pp[0][4] , 
        \pp[0][3] , \pp[0][2] , \pp[0][1] , \pp[0][0] }), .b({1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, \pp[1][8] , \pp[1][7] , \pp[1][6] , \pp[1][5] , 
        \pp[1][4] , \pp[1][3] , \pp[1][2] , \pp[1][1] , 1'b0}), .cin(1'b0), 
        .sum({\acc[1][15] , \acc[1][14] , \acc[1][13] , \acc[1][12] , 
        \acc[1][11] , \acc[1][10] , \acc[1][9] , \acc[1][8] , \acc[1][7] , 
        \acc[1][6] , \acc[1][5] , \acc[1][4] , \acc[1][3] , \acc[1][2] , 
        \acc[1][1] , \acc[1][0] }) );
  rca \gen_row_accumulation[2].u_row_adder  ( .a({\acc[1][15] , \acc[1][14] , 
        \acc[1][13] , \acc[1][12] , \acc[1][11] , \acc[1][10] , \acc[1][9] , 
        \acc[1][8] , \acc[1][7] , \acc[1][6] , \acc[1][5] , \acc[1][4] , 
        \acc[1][3] , \acc[1][2] , \acc[1][1] , \acc[1][0] }), .b({1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, \pp[2][9] , \pp[2][8] , \pp[2][7] , \pp[2][6] , 
        \pp[2][5] , \pp[2][4] , \pp[2][3] , \pp[2][2] , 1'b0, 1'b0}), .cin(
        1'b0), .sum({\acc[2][15] , \acc[2][14] , \acc[2][13] , \acc[2][12] , 
        \acc[2][11] , \acc[2][10] , \acc[2][9] , \acc[2][8] , \acc[2][7] , 
        \acc[2][6] , \acc[2][5] , \acc[2][4] , \acc[2][3] , \acc[2][2] , 
        \acc[2][1] , \acc[2][0] }) );
  rca \gen_row_accumulation[3].u_row_adder  ( .a({\acc[2][15] , \acc[2][14] , 
        \acc[2][13] , \acc[2][12] , \acc[2][11] , \acc[2][10] , \acc[2][9] , 
        \acc[2][8] , \acc[2][7] , \acc[2][6] , \acc[2][5] , \acc[2][4] , 
        \acc[2][3] , \acc[2][2] , \acc[2][1] , \acc[2][0] }), .b({1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, \pp[3][10] , \pp[3][9] , \pp[3][8] , \pp[3][7] , 
        \pp[3][6] , \pp[3][5] , \pp[3][4] , \pp[3][3] , 1'b0, 1'b0, 1'b0}), 
        .cin(1'b0), .sum({\acc[3][15] , \acc[3][14] , \acc[3][13] , 
        \acc[3][12] , \acc[3][11] , \acc[3][10] , \acc[3][9] , \acc[3][8] , 
        \acc[3][7] , \acc[3][6] , \acc[3][5] , \acc[3][4] , \acc[3][3] , 
        \acc[3][2] , \acc[3][1] , \acc[3][0] }) );
  rca \gen_row_accumulation[4].u_row_adder  ( .a({\acc[3][15] , \acc[3][14] , 
        \acc[3][13] , \acc[3][12] , \acc[3][11] , \acc[3][10] , \acc[3][9] , 
        \acc[3][8] , \acc[3][7] , \acc[3][6] , \acc[3][5] , \acc[3][4] , 
        \acc[3][3] , \acc[3][2] , \acc[3][1] , \acc[3][0] }), .b({1'b0, 1'b0, 
        1'b0, 1'b0, \pp[4][11] , \pp[4][10] , \pp[4][9] , \pp[4][8] , 
        \pp[4][7] , \pp[4][6] , \pp[4][5] , \pp[4][4] , 1'b0, 1'b0, 1'b0, 1'b0}), .cin(1'b0), .sum({\acc[4][15] , \acc[4][14] , \acc[4][13] , \acc[4][12] , 
        \acc[4][11] , \acc[4][10] , \acc[4][9] , \acc[4][8] , \acc[4][7] , 
        \acc[4][6] , \acc[4][5] , \acc[4][4] , \acc[4][3] , \acc[4][2] , 
        \acc[4][1] , \acc[4][0] }) );
  rca \gen_row_accumulation[5].u_row_adder  ( .a({\acc[4][15] , \acc[4][14] , 
        \acc[4][13] , \acc[4][12] , \acc[4][11] , \acc[4][10] , \acc[4][9] , 
        \acc[4][8] , \acc[4][7] , \acc[4][6] , \acc[4][5] , \acc[4][4] , 
        \acc[4][3] , \acc[4][2] , \acc[4][1] , \acc[4][0] }), .b({1'b0, 1'b0, 
        1'b0, \pp[5][12] , \pp[5][11] , \pp[5][10] , \pp[5][9] , \pp[5][8] , 
        \pp[5][7] , \pp[5][6] , \pp[5][5] , 1'b0, 1'b0, 1'b0, 1'b0, 1'b0}), 
        .cin(1'b0), .sum({\acc[5][15] , \acc[5][14] , \acc[5][13] , 
        \acc[5][12] , \acc[5][11] , \acc[5][10] , \acc[5][9] , \acc[5][8] , 
        \acc[5][7] , \acc[5][6] , \acc[5][5] , \acc[5][4] , \acc[5][3] , 
        \acc[5][2] , \acc[5][1] , \acc[5][0] }) );
  rca \gen_row_accumulation[6].u_row_adder  ( .a({\acc[5][15] , \acc[5][14] , 
        \acc[5][13] , \acc[5][12] , \acc[5][11] , \acc[5][10] , \acc[5][9] , 
        \acc[5][8] , \acc[5][7] , \acc[5][6] , \acc[5][5] , \acc[5][4] , 
        \acc[5][3] , \acc[5][2] , \acc[5][1] , \acc[5][0] }), .b({1'b0, 1'b0, 
        \pp[6][13] , \pp[6][12] , \pp[6][11] , \pp[6][10] , \pp[6][9] , 
        \pp[6][8] , \pp[6][7] , \pp[6][6] , 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0}), .cin(1'b0), .sum({\acc[6][15] , \acc[6][14] , \acc[6][13] , \acc[6][12] , 
        \acc[6][11] , \acc[6][10] , \acc[6][9] , \acc[6][8] , \acc[6][7] , 
        \acc[6][6] , \acc[6][5] , \acc[6][4] , \acc[6][3] , \acc[6][2] , 
        \acc[6][1] , \acc[6][0] }) );
  rca \gen_row_accumulation[7].u_row_adder  ( .a({\acc[6][15] , \acc[6][14] , 
        \acc[6][13] , \acc[6][12] , \acc[6][11] , \acc[6][10] , \acc[6][9] , 
        \acc[6][8] , \acc[6][7] , \acc[6][6] , \acc[6][5] , \acc[6][4] , 
        \acc[6][3] , \acc[6][2] , \acc[6][1] , \acc[6][0] }), .b({1'b0, 
        \pp[7][14] , \pp[7][13] , \pp[7][12] , \pp[7][11] , \pp[7][10] , 
        \pp[7][9] , \pp[7][8] , \pp[7][7] , 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0}), .cin(1'b0), .sum(p) );
  AND2X1 C71 ( .A(a[7]), .B(b[0]), .Y(\pp[0][7] ) );
  AND2X1 C72 ( .A(a[6]), .B(b[0]), .Y(\pp[0][6] ) );
  AND2X1 C73 ( .A(a[5]), .B(b[0]), .Y(\pp[0][5] ) );
  AND2X1 C74 ( .A(a[4]), .B(b[0]), .Y(\pp[0][4] ) );
  AND2X1 C75 ( .A(a[3]), .B(b[0]), .Y(\pp[0][3] ) );
  AND2X1 C76 ( .A(a[2]), .B(b[0]), .Y(\pp[0][2] ) );
  AND2X1 C77 ( .A(a[1]), .B(b[0]), .Y(\pp[0][1] ) );
  AND2X1 C78 ( .A(a[0]), .B(b[0]), .Y(\pp[0][0] ) );
  AND2X1 C79 ( .A(a[7]), .B(b[1]), .Y(\pp[1][8] ) );
  AND2X1 C80 ( .A(a[6]), .B(b[1]), .Y(\pp[1][7] ) );
  AND2X1 C81 ( .A(a[5]), .B(b[1]), .Y(\pp[1][6] ) );
  AND2X1 C82 ( .A(a[4]), .B(b[1]), .Y(\pp[1][5] ) );
  AND2X1 C83 ( .A(a[3]), .B(b[1]), .Y(\pp[1][4] ) );
  AND2X1 C84 ( .A(a[2]), .B(b[1]), .Y(\pp[1][3] ) );
  AND2X1 C85 ( .A(a[1]), .B(b[1]), .Y(\pp[1][2] ) );
  AND2X1 C86 ( .A(a[0]), .B(b[1]), .Y(\pp[1][1] ) );
  AND2X1 C87 ( .A(a[7]), .B(b[2]), .Y(\pp[2][9] ) );
  AND2X1 C88 ( .A(a[6]), .B(b[2]), .Y(\pp[2][8] ) );
  AND2X1 C89 ( .A(a[5]), .B(b[2]), .Y(\pp[2][7] ) );
  AND2X1 C90 ( .A(a[4]), .B(b[2]), .Y(\pp[2][6] ) );
  AND2X1 C91 ( .A(a[3]), .B(b[2]), .Y(\pp[2][5] ) );
  AND2X1 C92 ( .A(a[2]), .B(b[2]), .Y(\pp[2][4] ) );
  AND2X1 C93 ( .A(a[1]), .B(b[2]), .Y(\pp[2][3] ) );
  AND2X1 C94 ( .A(a[0]), .B(b[2]), .Y(\pp[2][2] ) );
  AND2X1 C95 ( .A(a[7]), .B(b[3]), .Y(\pp[3][10] ) );
  AND2X1 C96 ( .A(a[6]), .B(b[3]), .Y(\pp[3][9] ) );
  AND2X1 C97 ( .A(a[5]), .B(b[3]), .Y(\pp[3][8] ) );
  AND2X1 C98 ( .A(a[4]), .B(b[3]), .Y(\pp[3][7] ) );
  AND2X1 C99 ( .A(a[3]), .B(b[3]), .Y(\pp[3][6] ) );
  AND2X1 C100 ( .A(a[2]), .B(b[3]), .Y(\pp[3][5] ) );
  AND2X1 C101 ( .A(a[1]), .B(b[3]), .Y(\pp[3][4] ) );
  AND2X1 C102 ( .A(a[0]), .B(b[3]), .Y(\pp[3][3] ) );
  AND2X1 C103 ( .A(a[7]), .B(b[4]), .Y(\pp[4][11] ) );
  AND2X1 C104 ( .A(a[6]), .B(b[4]), .Y(\pp[4][10] ) );
  AND2X1 C105 ( .A(a[5]), .B(b[4]), .Y(\pp[4][9] ) );
  AND2X1 C106 ( .A(a[4]), .B(b[4]), .Y(\pp[4][8] ) );
  AND2X1 C107 ( .A(a[3]), .B(b[4]), .Y(\pp[4][7] ) );
  AND2X1 C108 ( .A(a[2]), .B(b[4]), .Y(\pp[4][6] ) );
  AND2X1 C109 ( .A(a[1]), .B(b[4]), .Y(\pp[4][5] ) );
  AND2X1 C110 ( .A(a[0]), .B(b[4]), .Y(\pp[4][4] ) );
  AND2X1 C111 ( .A(a[7]), .B(b[5]), .Y(\pp[5][12] ) );
  AND2X1 C112 ( .A(a[6]), .B(b[5]), .Y(\pp[5][11] ) );
  AND2X1 C113 ( .A(a[5]), .B(b[5]), .Y(\pp[5][10] ) );
  AND2X1 C114 ( .A(a[4]), .B(b[5]), .Y(\pp[5][9] ) );
  AND2X1 C115 ( .A(a[3]), .B(b[5]), .Y(\pp[5][8] ) );
  AND2X1 C116 ( .A(a[2]), .B(b[5]), .Y(\pp[5][7] ) );
  AND2X1 C117 ( .A(a[1]), .B(b[5]), .Y(\pp[5][6] ) );
  AND2X1 C118 ( .A(a[0]), .B(b[5]), .Y(\pp[5][5] ) );
  AND2X1 C119 ( .A(a[7]), .B(b[6]), .Y(\pp[6][13] ) );
  AND2X1 C120 ( .A(a[6]), .B(b[6]), .Y(\pp[6][12] ) );
  AND2X1 C121 ( .A(a[5]), .B(b[6]), .Y(\pp[6][11] ) );
  AND2X1 C122 ( .A(a[4]), .B(b[6]), .Y(\pp[6][10] ) );
  AND2X1 C123 ( .A(a[3]), .B(b[6]), .Y(\pp[6][9] ) );
  AND2X1 C124 ( .A(a[2]), .B(b[6]), .Y(\pp[6][8] ) );
  AND2X1 C125 ( .A(a[1]), .B(b[6]), .Y(\pp[6][7] ) );
  AND2X1 C126 ( .A(a[0]), .B(b[6]), .Y(\pp[6][6] ) );
  AND2X1 C127 ( .A(a[7]), .B(b[7]), .Y(\pp[7][14] ) );
  AND2X1 C128 ( .A(a[6]), .B(b[7]), .Y(\pp[7][13] ) );
  AND2X1 C129 ( .A(a[5]), .B(b[7]), .Y(\pp[7][12] ) );
  AND2X1 C130 ( .A(a[4]), .B(b[7]), .Y(\pp[7][11] ) );
  AND2X1 C131 ( .A(a[3]), .B(b[7]), .Y(\pp[7][10] ) );
  AND2X1 C132 ( .A(a[2]), .B(b[7]), .Y(\pp[7][9] ) );
  AND2X1 C133 ( .A(a[1]), .B(b[7]), .Y(\pp[7][8] ) );
  AND2X1 C134 ( .A(a[0]), .B(b[7]), .Y(\pp[7][7] ) );
endmodule

