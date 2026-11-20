/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : L-2016.03-SP3
// Date      : Tue Nov 17 15:04:51 2026
/////////////////////////////////////////////////////////////


module csa_0 ( a, b, c, sum, carry );
  input [15:0] a;
  input [15:0] b;
  input [15:0] c;
  output [15:0] sum;
  output [15:0] carry;
  wire   n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29,
         n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43,
         n44, n45, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14,
         n15, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58,
         n59, n60;
  assign carry[0] = 1'b0;

  XOR2X1 U17 ( .A(n53), .B(n16), .Y(sum[9]) );
  XOR2X1 U18 ( .A(n54), .B(n17), .Y(sum[8]) );
  XOR2X1 U19 ( .A(n55), .B(n18), .Y(sum[7]) );
  XOR2X1 U20 ( .A(n56), .B(n19), .Y(sum[6]) );
  XOR2X1 U21 ( .A(n57), .B(n20), .Y(sum[5]) );
  XOR2X1 U22 ( .A(n58), .B(n21), .Y(sum[4]) );
  XOR2X1 U23 ( .A(n59), .B(n22), .Y(sum[3]) );
  XOR2X1 U24 ( .A(n60), .B(n23), .Y(sum[2]) );
  XOR2X1 U25 ( .A(n47), .B(n24), .Y(sum[1]) );
  FAX1 U26 ( .A(c[15]), .B(b[15]), .C(a[15]), .YS(sum[15]) );
  XOR2X1 U27 ( .A(n52), .B(n25), .Y(sum[14]) );
  XOR2X1 U28 ( .A(n51), .B(n26), .Y(sum[13]) );
  XOR2X1 U29 ( .A(n50), .B(n27), .Y(sum[12]) );
  XOR2X1 U30 ( .A(n49), .B(n28), .Y(sum[11]) );
  XOR2X1 U31 ( .A(n48), .B(n29), .Y(sum[10]) );
  XOR2X1 U32 ( .A(n46), .B(n30), .Y(sum[0]) );
  OAI21X1 U33 ( .A(n17), .B(n54), .C(n7), .Y(carry[9]) );
  XNOR2X1 U35 ( .A(a[8]), .B(b[8]), .Y(n17) );
  OAI21X1 U36 ( .A(n18), .B(n55), .C(n8), .Y(carry[8]) );
  XNOR2X1 U38 ( .A(a[7]), .B(b[7]), .Y(n18) );
  OAI21X1 U39 ( .A(n19), .B(n56), .C(n9), .Y(carry[7]) );
  XNOR2X1 U41 ( .A(a[6]), .B(b[6]), .Y(n19) );
  OAI21X1 U42 ( .A(n20), .B(n57), .C(n10), .Y(carry[6]) );
  XNOR2X1 U44 ( .A(a[5]), .B(b[5]), .Y(n20) );
  OAI21X1 U45 ( .A(n21), .B(n58), .C(n11), .Y(carry[5]) );
  XNOR2X1 U47 ( .A(a[4]), .B(b[4]), .Y(n21) );
  OAI21X1 U48 ( .A(n22), .B(n59), .C(n12), .Y(carry[4]) );
  XNOR2X1 U50 ( .A(a[3]), .B(b[3]), .Y(n22) );
  OAI21X1 U51 ( .A(n23), .B(n60), .C(n13), .Y(carry[3]) );
  XNOR2X1 U53 ( .A(a[2]), .B(b[2]), .Y(n23) );
  OAI21X1 U54 ( .A(n24), .B(n47), .C(n4), .Y(carry[2]) );
  XNOR2X1 U56 ( .A(a[1]), .B(b[1]), .Y(n24) );
  OAI21X1 U57 ( .A(n30), .B(n46), .C(n3), .Y(carry[1]) );
  XNOR2X1 U59 ( .A(a[0]), .B(b[0]), .Y(n30) );
  OAI21X1 U60 ( .A(n25), .B(n52), .C(n1), .Y(carry[15]) );
  XNOR2X1 U62 ( .A(a[14]), .B(b[14]), .Y(n25) );
  OAI21X1 U63 ( .A(n26), .B(n51), .C(n2), .Y(carry[14]) );
  XNOR2X1 U65 ( .A(a[13]), .B(b[13]), .Y(n26) );
  OAI21X1 U66 ( .A(n27), .B(n50), .C(n14), .Y(carry[13]) );
  XNOR2X1 U68 ( .A(a[12]), .B(b[12]), .Y(n27) );
  OAI21X1 U69 ( .A(n28), .B(n49), .C(n15), .Y(carry[12]) );
  XNOR2X1 U71 ( .A(a[11]), .B(b[11]), .Y(n28) );
  OAI21X1 U72 ( .A(n29), .B(n48), .C(n5), .Y(carry[11]) );
  XNOR2X1 U74 ( .A(a[10]), .B(b[10]), .Y(n29) );
  OAI21X1 U75 ( .A(n16), .B(n53), .C(n6), .Y(carry[10]) );
  XNOR2X1 U77 ( .A(a[9]), .B(b[9]), .Y(n16) );
  AND2X1 U2 ( .A(a[14]), .B(b[14]), .Y(n40) );
  INVX1 U3 ( .A(n40), .Y(n1) );
  AND2X1 U4 ( .A(a[13]), .B(b[13]), .Y(n41) );
  INVX1 U5 ( .A(n41), .Y(n2) );
  AND2X1 U6 ( .A(a[0]), .B(b[0]), .Y(n39) );
  INVX1 U7 ( .A(n39), .Y(n3) );
  AND2X1 U8 ( .A(a[1]), .B(b[1]), .Y(n38) );
  INVX1 U9 ( .A(n38), .Y(n4) );
  AND2X1 U10 ( .A(a[10]), .B(b[10]), .Y(n44) );
  INVX1 U11 ( .A(n44), .Y(n5) );
  AND2X1 U12 ( .A(a[9]), .B(b[9]), .Y(n45) );
  INVX1 U13 ( .A(n45), .Y(n6) );
  AND2X1 U14 ( .A(a[8]), .B(b[8]), .Y(n31) );
  INVX1 U15 ( .A(n31), .Y(n7) );
  AND2X1 U16 ( .A(a[7]), .B(b[7]), .Y(n32) );
  INVX1 U34 ( .A(n32), .Y(n8) );
  AND2X1 U37 ( .A(a[6]), .B(b[6]), .Y(n33) );
  INVX1 U40 ( .A(n33), .Y(n9) );
  AND2X1 U43 ( .A(a[5]), .B(b[5]), .Y(n34) );
  INVX1 U46 ( .A(n34), .Y(n10) );
  AND2X1 U49 ( .A(a[4]), .B(b[4]), .Y(n35) );
  INVX1 U52 ( .A(n35), .Y(n11) );
  AND2X1 U55 ( .A(a[3]), .B(b[3]), .Y(n36) );
  INVX1 U58 ( .A(n36), .Y(n12) );
  AND2X1 U61 ( .A(a[2]), .B(b[2]), .Y(n37) );
  INVX1 U64 ( .A(n37), .Y(n13) );
  AND2X1 U67 ( .A(a[12]), .B(b[12]), .Y(n42) );
  INVX1 U70 ( .A(n42), .Y(n14) );
  AND2X1 U73 ( .A(a[11]), .B(b[11]), .Y(n43) );
  INVX1 U76 ( .A(n43), .Y(n15) );
  INVX1 U78 ( .A(c[2]), .Y(n60) );
  INVX1 U79 ( .A(c[3]), .Y(n59) );
  INVX1 U80 ( .A(c[4]), .Y(n58) );
  INVX1 U81 ( .A(c[5]), .Y(n57) );
  INVX1 U82 ( .A(c[6]), .Y(n56) );
  INVX1 U83 ( .A(c[7]), .Y(n55) );
  INVX1 U84 ( .A(c[8]), .Y(n54) );
  INVX1 U85 ( .A(c[9]), .Y(n53) );
  INVX1 U86 ( .A(c[0]), .Y(n46) );
  INVX1 U87 ( .A(c[1]), .Y(n47) );
  INVX1 U88 ( .A(c[10]), .Y(n48) );
  INVX1 U89 ( .A(c[11]), .Y(n49) );
  INVX1 U90 ( .A(c[12]), .Y(n50) );
  INVX1 U91 ( .A(c[13]), .Y(n51) );
  INVX1 U92 ( .A(c[14]), .Y(n52) );
endmodule


module csa_5 ( a, b, c, sum, carry );
  input [15:0] a;
  input [15:0] b;
  input [15:0] c;
  output [15:0] sum;
  output [15:0] carry;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n46,
         n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60,
         n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72, n73, n74,
         n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85, n86, n87, n88,
         n89, n90;
  assign carry[0] = 1'b0;

  XOR2X1 U17 ( .A(n56), .B(n90), .Y(sum[9]) );
  XOR2X1 U18 ( .A(n57), .B(n89), .Y(sum[8]) );
  XOR2X1 U19 ( .A(n58), .B(n88), .Y(sum[7]) );
  XOR2X1 U20 ( .A(n59), .B(n87), .Y(sum[6]) );
  XOR2X1 U21 ( .A(n60), .B(n86), .Y(sum[5]) );
  XOR2X1 U22 ( .A(n50), .B(n85), .Y(sum[4]) );
  XOR2X1 U23 ( .A(n49), .B(n84), .Y(sum[3]) );
  XOR2X1 U24 ( .A(n48), .B(n83), .Y(sum[2]) );
  XOR2X1 U25 ( .A(n47), .B(n82), .Y(sum[1]) );
  FAX1 U26 ( .A(c[15]), .B(b[15]), .C(a[15]), .YS(sum[15]) );
  XOR2X1 U27 ( .A(n52), .B(n81), .Y(sum[14]) );
  XOR2X1 U28 ( .A(n51), .B(n80), .Y(sum[13]) );
  XOR2X1 U29 ( .A(n53), .B(n79), .Y(sum[12]) );
  XOR2X1 U30 ( .A(n54), .B(n78), .Y(sum[11]) );
  XOR2X1 U31 ( .A(n55), .B(n77), .Y(sum[10]) );
  XOR2X1 U32 ( .A(n46), .B(n76), .Y(sum[0]) );
  OAI21X1 U33 ( .A(n89), .B(n57), .C(n3), .Y(carry[9]) );
  XNOR2X1 U35 ( .A(a[8]), .B(b[8]), .Y(n89) );
  OAI21X1 U36 ( .A(n88), .B(n58), .C(n12), .Y(carry[8]) );
  XNOR2X1 U38 ( .A(a[7]), .B(b[7]), .Y(n88) );
  OAI21X1 U39 ( .A(n87), .B(n59), .C(n4), .Y(carry[7]) );
  XNOR2X1 U41 ( .A(a[6]), .B(b[6]), .Y(n87) );
  OAI21X1 U42 ( .A(n86), .B(n60), .C(n13), .Y(carry[6]) );
  XNOR2X1 U44 ( .A(a[5]), .B(b[5]), .Y(n86) );
  OAI21X1 U45 ( .A(n85), .B(n50), .C(n5), .Y(carry[5]) );
  XNOR2X1 U47 ( .A(a[4]), .B(b[4]), .Y(n85) );
  OAI21X1 U48 ( .A(n84), .B(n49), .C(n14), .Y(carry[4]) );
  XNOR2X1 U50 ( .A(a[3]), .B(b[3]), .Y(n84) );
  OAI21X1 U51 ( .A(n83), .B(n48), .C(n6), .Y(carry[3]) );
  XNOR2X1 U53 ( .A(a[2]), .B(b[2]), .Y(n83) );
  OAI21X1 U54 ( .A(n82), .B(n47), .C(n9), .Y(carry[2]) );
  XNOR2X1 U56 ( .A(a[1]), .B(b[1]), .Y(n82) );
  OAI21X1 U57 ( .A(n76), .B(n46), .C(n1), .Y(carry[1]) );
  XNOR2X1 U59 ( .A(a[0]), .B(b[0]), .Y(n76) );
  OAI21X1 U60 ( .A(n81), .B(n52), .C(n15), .Y(carry[15]) );
  XNOR2X1 U62 ( .A(a[14]), .B(b[14]), .Y(n81) );
  OAI21X1 U63 ( .A(n80), .B(n51), .C(n8), .Y(carry[14]) );
  XNOR2X1 U65 ( .A(a[13]), .B(b[13]), .Y(n80) );
  OAI21X1 U66 ( .A(n79), .B(n53), .C(n7), .Y(carry[13]) );
  XNOR2X1 U68 ( .A(a[12]), .B(b[12]), .Y(n79) );
  OAI21X1 U69 ( .A(n78), .B(n54), .C(n10), .Y(carry[12]) );
  XNOR2X1 U71 ( .A(a[11]), .B(b[11]), .Y(n78) );
  OAI21X1 U72 ( .A(n77), .B(n55), .C(n2), .Y(carry[11]) );
  XNOR2X1 U74 ( .A(a[10]), .B(b[10]), .Y(n77) );
  OAI21X1 U75 ( .A(n90), .B(n56), .C(n11), .Y(carry[10]) );
  XNOR2X1 U77 ( .A(a[9]), .B(b[9]), .Y(n90) );
  AND2X1 U2 ( .A(a[0]), .B(b[0]), .Y(n67) );
  INVX1 U3 ( .A(n67), .Y(n1) );
  AND2X1 U4 ( .A(a[10]), .B(b[10]), .Y(n62) );
  INVX1 U5 ( .A(n62), .Y(n2) );
  AND2X1 U6 ( .A(a[8]), .B(b[8]), .Y(n75) );
  INVX1 U7 ( .A(n75), .Y(n3) );
  AND2X1 U8 ( .A(a[6]), .B(b[6]), .Y(n73) );
  INVX1 U9 ( .A(n73), .Y(n4) );
  AND2X1 U10 ( .A(a[4]), .B(b[4]), .Y(n71) );
  INVX1 U11 ( .A(n71), .Y(n5) );
  AND2X1 U12 ( .A(a[2]), .B(b[2]), .Y(n69) );
  INVX1 U13 ( .A(n69), .Y(n6) );
  AND2X1 U14 ( .A(a[12]), .B(b[12]), .Y(n64) );
  INVX1 U15 ( .A(n64), .Y(n7) );
  AND2X1 U16 ( .A(a[13]), .B(b[13]), .Y(n65) );
  INVX1 U34 ( .A(n65), .Y(n8) );
  AND2X1 U37 ( .A(a[1]), .B(b[1]), .Y(n68) );
  INVX1 U40 ( .A(n68), .Y(n9) );
  AND2X1 U43 ( .A(a[11]), .B(b[11]), .Y(n63) );
  INVX1 U46 ( .A(n63), .Y(n10) );
  AND2X1 U49 ( .A(a[9]), .B(b[9]), .Y(n61) );
  INVX1 U52 ( .A(n61), .Y(n11) );
  AND2X1 U55 ( .A(a[7]), .B(b[7]), .Y(n74) );
  INVX1 U58 ( .A(n74), .Y(n12) );
  AND2X1 U61 ( .A(a[5]), .B(b[5]), .Y(n72) );
  INVX1 U64 ( .A(n72), .Y(n13) );
  AND2X1 U67 ( .A(a[3]), .B(b[3]), .Y(n70) );
  INVX1 U70 ( .A(n70), .Y(n14) );
  AND2X1 U73 ( .A(a[14]), .B(b[14]), .Y(n66) );
  INVX1 U76 ( .A(n66), .Y(n15) );
  INVX1 U78 ( .A(c[5]), .Y(n60) );
  INVX1 U79 ( .A(c[6]), .Y(n59) );
  INVX1 U80 ( .A(c[7]), .Y(n58) );
  INVX1 U81 ( .A(c[8]), .Y(n57) );
  INVX1 U82 ( .A(c[9]), .Y(n56) );
  INVX1 U83 ( .A(c[10]), .Y(n55) );
  INVX1 U84 ( .A(c[11]), .Y(n54) );
  INVX1 U85 ( .A(c[12]), .Y(n53) );
  INVX1 U86 ( .A(c[0]), .Y(n46) );
  INVX1 U87 ( .A(c[1]), .Y(n47) );
  INVX1 U88 ( .A(c[2]), .Y(n48) );
  INVX1 U89 ( .A(c[3]), .Y(n49) );
  INVX1 U90 ( .A(c[4]), .Y(n50) );
  INVX1 U91 ( .A(c[13]), .Y(n51) );
  INVX1 U92 ( .A(c[14]), .Y(n52) );
endmodule


module csa_4 ( a, b, c, sum, carry );
  input [15:0] a;
  input [15:0] b;
  input [15:0] c;
  output [15:0] sum;
  output [15:0] carry;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n46,
         n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60,
         n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72, n73, n74,
         n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85, n86, n87, n88,
         n89, n90;
  assign carry[0] = 1'b0;

  XOR2X1 U17 ( .A(n53), .B(n90), .Y(sum[9]) );
  XOR2X1 U18 ( .A(n54), .B(n89), .Y(sum[8]) );
  XOR2X1 U19 ( .A(n55), .B(n88), .Y(sum[7]) );
  XOR2X1 U20 ( .A(n56), .B(n87), .Y(sum[6]) );
  XOR2X1 U21 ( .A(n57), .B(n86), .Y(sum[5]) );
  XOR2X1 U22 ( .A(n58), .B(n85), .Y(sum[4]) );
  XOR2X1 U23 ( .A(n59), .B(n84), .Y(sum[3]) );
  XOR2X1 U24 ( .A(n60), .B(n83), .Y(sum[2]) );
  XOR2X1 U25 ( .A(n47), .B(n82), .Y(sum[1]) );
  FAX1 U26 ( .A(c[15]), .B(b[15]), .C(a[15]), .YS(sum[15]) );
  XOR2X1 U27 ( .A(n52), .B(n81), .Y(sum[14]) );
  XOR2X1 U28 ( .A(n51), .B(n80), .Y(sum[13]) );
  XOR2X1 U29 ( .A(n50), .B(n79), .Y(sum[12]) );
  XOR2X1 U30 ( .A(n49), .B(n78), .Y(sum[11]) );
  XOR2X1 U31 ( .A(n48), .B(n77), .Y(sum[10]) );
  XOR2X1 U32 ( .A(n46), .B(n76), .Y(sum[0]) );
  OAI21X1 U33 ( .A(n89), .B(n54), .C(n9), .Y(carry[9]) );
  XNOR2X1 U35 ( .A(a[8]), .B(b[8]), .Y(n89) );
  OAI21X1 U36 ( .A(n88), .B(n55), .C(n10), .Y(carry[8]) );
  XNOR2X1 U38 ( .A(a[7]), .B(b[7]), .Y(n88) );
  OAI21X1 U39 ( .A(n87), .B(n56), .C(n11), .Y(carry[7]) );
  XNOR2X1 U41 ( .A(a[6]), .B(b[6]), .Y(n87) );
  OAI21X1 U42 ( .A(n86), .B(n57), .C(n12), .Y(carry[6]) );
  XNOR2X1 U44 ( .A(a[5]), .B(b[5]), .Y(n86) );
  OAI21X1 U45 ( .A(n85), .B(n58), .C(n13), .Y(carry[5]) );
  XNOR2X1 U47 ( .A(a[4]), .B(b[4]), .Y(n85) );
  OAI21X1 U48 ( .A(n84), .B(n59), .C(n14), .Y(carry[4]) );
  XNOR2X1 U50 ( .A(a[3]), .B(b[3]), .Y(n84) );
  OAI21X1 U51 ( .A(n83), .B(n60), .C(n15), .Y(carry[3]) );
  XNOR2X1 U53 ( .A(a[2]), .B(b[2]), .Y(n83) );
  OAI21X1 U54 ( .A(n82), .B(n47), .C(n5), .Y(carry[2]) );
  XNOR2X1 U56 ( .A(a[1]), .B(b[1]), .Y(n82) );
  OAI21X1 U57 ( .A(n76), .B(n46), .C(n4), .Y(carry[1]) );
  XNOR2X1 U59 ( .A(a[0]), .B(b[0]), .Y(n76) );
  OAI21X1 U60 ( .A(n81), .B(n52), .C(n1), .Y(carry[15]) );
  XNOR2X1 U62 ( .A(a[14]), .B(b[14]), .Y(n81) );
  OAI21X1 U63 ( .A(n80), .B(n51), .C(n2), .Y(carry[14]) );
  XNOR2X1 U65 ( .A(a[13]), .B(b[13]), .Y(n80) );
  OAI21X1 U66 ( .A(n79), .B(n50), .C(n3), .Y(carry[13]) );
  XNOR2X1 U68 ( .A(a[12]), .B(b[12]), .Y(n79) );
  OAI21X1 U69 ( .A(n78), .B(n49), .C(n6), .Y(carry[12]) );
  XNOR2X1 U71 ( .A(a[11]), .B(b[11]), .Y(n78) );
  OAI21X1 U72 ( .A(n77), .B(n48), .C(n7), .Y(carry[11]) );
  XNOR2X1 U74 ( .A(a[10]), .B(b[10]), .Y(n77) );
  OAI21X1 U75 ( .A(n90), .B(n53), .C(n8), .Y(carry[10]) );
  XNOR2X1 U77 ( .A(a[9]), .B(b[9]), .Y(n90) );
  AND2X1 U2 ( .A(a[14]), .B(b[14]), .Y(n66) );
  INVX1 U3 ( .A(n66), .Y(n1) );
  AND2X1 U4 ( .A(a[13]), .B(b[13]), .Y(n65) );
  INVX1 U5 ( .A(n65), .Y(n2) );
  AND2X1 U6 ( .A(a[12]), .B(b[12]), .Y(n64) );
  INVX1 U7 ( .A(n64), .Y(n3) );
  AND2X1 U8 ( .A(a[0]), .B(b[0]), .Y(n67) );
  INVX1 U9 ( .A(n67), .Y(n4) );
  AND2X1 U10 ( .A(a[1]), .B(b[1]), .Y(n68) );
  INVX1 U11 ( .A(n68), .Y(n5) );
  AND2X1 U12 ( .A(a[11]), .B(b[11]), .Y(n63) );
  INVX1 U13 ( .A(n63), .Y(n6) );
  AND2X1 U14 ( .A(a[10]), .B(b[10]), .Y(n62) );
  INVX1 U15 ( .A(n62), .Y(n7) );
  AND2X1 U16 ( .A(a[9]), .B(b[9]), .Y(n61) );
  INVX1 U34 ( .A(n61), .Y(n8) );
  AND2X1 U37 ( .A(a[8]), .B(b[8]), .Y(n75) );
  INVX1 U40 ( .A(n75), .Y(n9) );
  AND2X1 U43 ( .A(a[7]), .B(b[7]), .Y(n74) );
  INVX1 U46 ( .A(n74), .Y(n10) );
  AND2X1 U49 ( .A(a[6]), .B(b[6]), .Y(n73) );
  INVX1 U52 ( .A(n73), .Y(n11) );
  AND2X1 U55 ( .A(a[5]), .B(b[5]), .Y(n72) );
  INVX1 U58 ( .A(n72), .Y(n12) );
  AND2X1 U61 ( .A(a[4]), .B(b[4]), .Y(n71) );
  INVX1 U64 ( .A(n71), .Y(n13) );
  AND2X1 U67 ( .A(a[3]), .B(b[3]), .Y(n70) );
  INVX1 U70 ( .A(n70), .Y(n14) );
  AND2X1 U73 ( .A(a[2]), .B(b[2]), .Y(n69) );
  INVX1 U76 ( .A(n69), .Y(n15) );
  INVX1 U78 ( .A(c[4]), .Y(n58) );
  INVX1 U79 ( .A(c[2]), .Y(n60) );
  INVX1 U80 ( .A(c[3]), .Y(n59) );
  INVX1 U81 ( .A(c[5]), .Y(n57) );
  INVX1 U82 ( .A(c[6]), .Y(n56) );
  INVX1 U83 ( .A(c[7]), .Y(n55) );
  INVX1 U84 ( .A(c[8]), .Y(n54) );
  INVX1 U85 ( .A(c[9]), .Y(n53) );
  INVX1 U86 ( .A(c[0]), .Y(n46) );
  INVX1 U87 ( .A(c[1]), .Y(n47) );
  INVX1 U88 ( .A(c[10]), .Y(n48) );
  INVX1 U89 ( .A(c[11]), .Y(n49) );
  INVX1 U90 ( .A(c[12]), .Y(n50) );
  INVX1 U91 ( .A(c[14]), .Y(n52) );
  INVX1 U92 ( .A(c[13]), .Y(n51) );
endmodule


module csa_3 ( a, b, c, sum, carry );
  input [15:0] a;
  input [15:0] b;
  input [15:0] c;
  output [15:0] sum;
  output [15:0] carry;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n46,
         n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60,
         n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72, n73, n74,
         n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85, n86, n87, n88,
         n89, n90;
  assign carry[0] = 1'b0;

  XOR2X1 U17 ( .A(n57), .B(n90), .Y(sum[9]) );
  XOR2X1 U18 ( .A(n58), .B(n89), .Y(sum[8]) );
  XOR2X1 U19 ( .A(n59), .B(n88), .Y(sum[7]) );
  XOR2X1 U20 ( .A(n60), .B(n87), .Y(sum[6]) );
  XOR2X1 U21 ( .A(n51), .B(n86), .Y(sum[5]) );
  XOR2X1 U22 ( .A(n50), .B(n85), .Y(sum[4]) );
  XOR2X1 U23 ( .A(n49), .B(n84), .Y(sum[3]) );
  XOR2X1 U24 ( .A(n48), .B(n83), .Y(sum[2]) );
  XOR2X1 U25 ( .A(n47), .B(n82), .Y(sum[1]) );
  FAX1 U26 ( .A(c[15]), .B(b[15]), .C(a[15]), .YS(sum[15]) );
  XOR2X1 U27 ( .A(n52), .B(n81), .Y(sum[14]) );
  XOR2X1 U28 ( .A(n53), .B(n80), .Y(sum[13]) );
  XOR2X1 U29 ( .A(n54), .B(n79), .Y(sum[12]) );
  XOR2X1 U30 ( .A(n55), .B(n78), .Y(sum[11]) );
  XOR2X1 U31 ( .A(n56), .B(n77), .Y(sum[10]) );
  XOR2X1 U32 ( .A(n46), .B(n76), .Y(sum[0]) );
  OAI21X1 U33 ( .A(n89), .B(n58), .C(n9), .Y(carry[9]) );
  XNOR2X1 U35 ( .A(a[8]), .B(b[8]), .Y(n89) );
  OAI21X1 U36 ( .A(n88), .B(n59), .C(n10), .Y(carry[8]) );
  XNOR2X1 U38 ( .A(a[7]), .B(b[7]), .Y(n88) );
  OAI21X1 U39 ( .A(n87), .B(n60), .C(n11), .Y(carry[7]) );
  XNOR2X1 U41 ( .A(a[6]), .B(b[6]), .Y(n87) );
  OAI21X1 U42 ( .A(n86), .B(n51), .C(n12), .Y(carry[6]) );
  XNOR2X1 U44 ( .A(a[5]), .B(b[5]), .Y(n86) );
  OAI21X1 U45 ( .A(n85), .B(n50), .C(n13), .Y(carry[5]) );
  XNOR2X1 U47 ( .A(a[4]), .B(b[4]), .Y(n85) );
  OAI21X1 U48 ( .A(n84), .B(n49), .C(n14), .Y(carry[4]) );
  XNOR2X1 U50 ( .A(a[3]), .B(b[3]), .Y(n84) );
  OAI21X1 U51 ( .A(n83), .B(n48), .C(n15), .Y(carry[3]) );
  XNOR2X1 U53 ( .A(a[2]), .B(b[2]), .Y(n83) );
  OAI21X1 U54 ( .A(n82), .B(n47), .C(n5), .Y(carry[2]) );
  XNOR2X1 U56 ( .A(a[1]), .B(b[1]), .Y(n82) );
  OAI21X1 U57 ( .A(n76), .B(n46), .C(n3), .Y(carry[1]) );
  XNOR2X1 U59 ( .A(a[0]), .B(b[0]), .Y(n76) );
  OAI21X1 U60 ( .A(n81), .B(n52), .C(n1), .Y(carry[15]) );
  XNOR2X1 U62 ( .A(a[14]), .B(b[14]), .Y(n81) );
  OAI21X1 U63 ( .A(n80), .B(n53), .C(n2), .Y(carry[14]) );
  XNOR2X1 U65 ( .A(a[13]), .B(b[13]), .Y(n80) );
  OAI21X1 U66 ( .A(n79), .B(n54), .C(n4), .Y(carry[13]) );
  XNOR2X1 U68 ( .A(a[12]), .B(b[12]), .Y(n79) );
  OAI21X1 U69 ( .A(n78), .B(n55), .C(n6), .Y(carry[12]) );
  XNOR2X1 U71 ( .A(a[11]), .B(b[11]), .Y(n78) );
  OAI21X1 U72 ( .A(n77), .B(n56), .C(n7), .Y(carry[11]) );
  XNOR2X1 U74 ( .A(a[10]), .B(b[10]), .Y(n77) );
  OAI21X1 U75 ( .A(n90), .B(n57), .C(n8), .Y(carry[10]) );
  XNOR2X1 U77 ( .A(a[9]), .B(b[9]), .Y(n90) );
  AND2X1 U2 ( .A(a[14]), .B(b[14]), .Y(n66) );
  INVX1 U3 ( .A(n66), .Y(n1) );
  AND2X1 U4 ( .A(a[13]), .B(b[13]), .Y(n65) );
  INVX1 U5 ( .A(n65), .Y(n2) );
  AND2X1 U6 ( .A(a[0]), .B(b[0]), .Y(n67) );
  INVX1 U7 ( .A(n67), .Y(n3) );
  AND2X1 U8 ( .A(a[12]), .B(b[12]), .Y(n64) );
  INVX1 U9 ( .A(n64), .Y(n4) );
  AND2X1 U10 ( .A(a[1]), .B(b[1]), .Y(n68) );
  INVX1 U11 ( .A(n68), .Y(n5) );
  AND2X1 U12 ( .A(a[11]), .B(b[11]), .Y(n63) );
  INVX1 U13 ( .A(n63), .Y(n6) );
  AND2X1 U14 ( .A(a[10]), .B(b[10]), .Y(n62) );
  INVX1 U15 ( .A(n62), .Y(n7) );
  AND2X1 U16 ( .A(a[9]), .B(b[9]), .Y(n61) );
  INVX1 U34 ( .A(n61), .Y(n8) );
  AND2X1 U37 ( .A(a[8]), .B(b[8]), .Y(n75) );
  INVX1 U40 ( .A(n75), .Y(n9) );
  AND2X1 U43 ( .A(a[7]), .B(b[7]), .Y(n74) );
  INVX1 U46 ( .A(n74), .Y(n10) );
  AND2X1 U49 ( .A(a[6]), .B(b[6]), .Y(n73) );
  INVX1 U52 ( .A(n73), .Y(n11) );
  AND2X1 U55 ( .A(a[5]), .B(b[5]), .Y(n72) );
  INVX1 U58 ( .A(n72), .Y(n12) );
  AND2X1 U61 ( .A(a[4]), .B(b[4]), .Y(n71) );
  INVX1 U64 ( .A(n71), .Y(n13) );
  AND2X1 U67 ( .A(a[3]), .B(b[3]), .Y(n70) );
  INVX1 U70 ( .A(n70), .Y(n14) );
  AND2X1 U73 ( .A(a[2]), .B(b[2]), .Y(n69) );
  INVX1 U76 ( .A(n69), .Y(n15) );
  INVX1 U78 ( .A(c[6]), .Y(n60) );
  INVX1 U79 ( .A(c[7]), .Y(n59) );
  INVX1 U80 ( .A(c[8]), .Y(n58) );
  INVX1 U81 ( .A(c[9]), .Y(n57) );
  INVX1 U82 ( .A(c[10]), .Y(n56) );
  INVX1 U83 ( .A(c[11]), .Y(n55) );
  INVX1 U84 ( .A(c[5]), .Y(n51) );
  INVX1 U85 ( .A(c[12]), .Y(n54) );
  INVX1 U86 ( .A(c[1]), .Y(n47) );
  INVX1 U87 ( .A(c[2]), .Y(n48) );
  INVX1 U88 ( .A(c[3]), .Y(n49) );
  INVX1 U89 ( .A(c[13]), .Y(n53) );
  INVX1 U90 ( .A(c[14]), .Y(n52) );
  INVX1 U91 ( .A(c[4]), .Y(n50) );
  INVX1 U92 ( .A(c[0]), .Y(n46) );
endmodule


module csa_2 ( a, b, c, sum, carry );
  input [15:0] a;
  input [15:0] b;
  input [15:0] c;
  output [15:0] sum;
  output [15:0] carry;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n46,
         n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60,
         n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72, n73, n74,
         n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85, n86, n87, n88,
         n89, n90;
  assign carry[0] = 1'b0;

  XOR2X1 U17 ( .A(n57), .B(n90), .Y(sum[9]) );
  XOR2X1 U18 ( .A(n58), .B(n89), .Y(sum[8]) );
  XOR2X1 U19 ( .A(n59), .B(n88), .Y(sum[7]) );
  XOR2X1 U20 ( .A(n60), .B(n87), .Y(sum[6]) );
  XOR2X1 U21 ( .A(n51), .B(n86), .Y(sum[5]) );
  XOR2X1 U22 ( .A(n50), .B(n85), .Y(sum[4]) );
  XOR2X1 U23 ( .A(n49), .B(n84), .Y(sum[3]) );
  XOR2X1 U24 ( .A(n48), .B(n83), .Y(sum[2]) );
  XOR2X1 U25 ( .A(n47), .B(n82), .Y(sum[1]) );
  FAX1 U26 ( .A(c[15]), .B(b[15]), .C(a[15]), .YS(sum[15]) );
  XOR2X1 U27 ( .A(n52), .B(n81), .Y(sum[14]) );
  XOR2X1 U28 ( .A(n53), .B(n80), .Y(sum[13]) );
  XOR2X1 U29 ( .A(n54), .B(n79), .Y(sum[12]) );
  XOR2X1 U30 ( .A(n55), .B(n78), .Y(sum[11]) );
  XOR2X1 U31 ( .A(n56), .B(n77), .Y(sum[10]) );
  XOR2X1 U32 ( .A(n46), .B(n76), .Y(sum[0]) );
  OAI21X1 U33 ( .A(n89), .B(n58), .C(n12), .Y(carry[9]) );
  XNOR2X1 U35 ( .A(a[8]), .B(b[8]), .Y(n89) );
  OAI21X1 U36 ( .A(n88), .B(n59), .C(n7), .Y(carry[8]) );
  XNOR2X1 U38 ( .A(a[7]), .B(b[7]), .Y(n88) );
  OAI21X1 U39 ( .A(n87), .B(n60), .C(n13), .Y(carry[7]) );
  XNOR2X1 U41 ( .A(a[6]), .B(b[6]), .Y(n87) );
  OAI21X1 U42 ( .A(n86), .B(n51), .C(n8), .Y(carry[6]) );
  XNOR2X1 U44 ( .A(a[5]), .B(b[5]), .Y(n86) );
  OAI21X1 U45 ( .A(n85), .B(n50), .C(n14), .Y(carry[5]) );
  XNOR2X1 U47 ( .A(a[4]), .B(b[4]), .Y(n85) );
  OAI21X1 U48 ( .A(n84), .B(n49), .C(n9), .Y(carry[4]) );
  XNOR2X1 U50 ( .A(a[3]), .B(b[3]), .Y(n84) );
  OAI21X1 U51 ( .A(n83), .B(n48), .C(n15), .Y(carry[3]) );
  XNOR2X1 U53 ( .A(a[2]), .B(b[2]), .Y(n83) );
  OAI21X1 U54 ( .A(n82), .B(n47), .C(n3), .Y(carry[2]) );
  XNOR2X1 U56 ( .A(a[1]), .B(b[1]), .Y(n82) );
  OAI21X1 U57 ( .A(n76), .B(n46), .C(n10), .Y(carry[1]) );
  XNOR2X1 U59 ( .A(a[0]), .B(b[0]), .Y(n76) );
  OAI21X1 U60 ( .A(n81), .B(n52), .C(n1), .Y(carry[15]) );
  XNOR2X1 U62 ( .A(a[14]), .B(b[14]), .Y(n81) );
  OAI21X1 U63 ( .A(n80), .B(n53), .C(n4), .Y(carry[14]) );
  XNOR2X1 U65 ( .A(a[13]), .B(b[13]), .Y(n80) );
  OAI21X1 U66 ( .A(n79), .B(n54), .C(n2), .Y(carry[13]) );
  XNOR2X1 U68 ( .A(a[12]), .B(b[12]), .Y(n79) );
  OAI21X1 U69 ( .A(n78), .B(n55), .C(n5), .Y(carry[12]) );
  XNOR2X1 U71 ( .A(a[11]), .B(b[11]), .Y(n78) );
  OAI21X1 U72 ( .A(n77), .B(n56), .C(n11), .Y(carry[11]) );
  XNOR2X1 U74 ( .A(a[10]), .B(b[10]), .Y(n77) );
  OAI21X1 U75 ( .A(n90), .B(n57), .C(n6), .Y(carry[10]) );
  XNOR2X1 U77 ( .A(a[9]), .B(b[9]), .Y(n90) );
  AND2X1 U2 ( .A(a[14]), .B(b[14]), .Y(n66) );
  INVX1 U3 ( .A(n66), .Y(n1) );
  AND2X1 U4 ( .A(a[12]), .B(b[12]), .Y(n64) );
  INVX1 U5 ( .A(n64), .Y(n2) );
  AND2X1 U6 ( .A(a[1]), .B(b[1]), .Y(n68) );
  INVX1 U7 ( .A(n68), .Y(n3) );
  AND2X1 U8 ( .A(a[13]), .B(b[13]), .Y(n65) );
  INVX1 U9 ( .A(n65), .Y(n4) );
  AND2X1 U10 ( .A(a[11]), .B(b[11]), .Y(n63) );
  INVX1 U11 ( .A(n63), .Y(n5) );
  AND2X1 U12 ( .A(a[9]), .B(b[9]), .Y(n61) );
  INVX1 U13 ( .A(n61), .Y(n6) );
  AND2X1 U14 ( .A(a[7]), .B(b[7]), .Y(n74) );
  INVX1 U15 ( .A(n74), .Y(n7) );
  AND2X1 U16 ( .A(a[5]), .B(b[5]), .Y(n72) );
  INVX1 U34 ( .A(n72), .Y(n8) );
  AND2X1 U37 ( .A(a[3]), .B(b[3]), .Y(n70) );
  INVX1 U40 ( .A(n70), .Y(n9) );
  AND2X1 U43 ( .A(a[0]), .B(b[0]), .Y(n67) );
  INVX1 U46 ( .A(n67), .Y(n10) );
  AND2X1 U49 ( .A(a[10]), .B(b[10]), .Y(n62) );
  INVX1 U52 ( .A(n62), .Y(n11) );
  AND2X1 U55 ( .A(a[8]), .B(b[8]), .Y(n75) );
  INVX1 U58 ( .A(n75), .Y(n12) );
  AND2X1 U61 ( .A(a[6]), .B(b[6]), .Y(n73) );
  INVX1 U64 ( .A(n73), .Y(n13) );
  AND2X1 U67 ( .A(a[4]), .B(b[4]), .Y(n71) );
  INVX1 U70 ( .A(n71), .Y(n14) );
  AND2X1 U73 ( .A(a[2]), .B(b[2]), .Y(n69) );
  INVX1 U76 ( .A(n69), .Y(n15) );
  INVX1 U78 ( .A(c[5]), .Y(n51) );
  INVX1 U79 ( .A(c[6]), .Y(n60) );
  INVX1 U80 ( .A(c[7]), .Y(n59) );
  INVX1 U81 ( .A(c[8]), .Y(n58) );
  INVX1 U82 ( .A(c[9]), .Y(n57) );
  INVX1 U83 ( .A(c[10]), .Y(n56) );
  INVX1 U84 ( .A(c[11]), .Y(n55) );
  INVX1 U85 ( .A(c[12]), .Y(n54) );
  INVX1 U86 ( .A(c[2]), .Y(n48) );
  INVX1 U87 ( .A(c[3]), .Y(n49) );
  INVX1 U88 ( .A(c[4]), .Y(n50) );
  INVX1 U89 ( .A(c[1]), .Y(n47) );
  INVX1 U90 ( .A(c[13]), .Y(n53) );
  INVX1 U91 ( .A(c[14]), .Y(n52) );
  INVX1 U92 ( .A(c[0]), .Y(n46) );
endmodule


module csa_1 ( a, b, c, sum, carry );
  input [15:0] a;
  input [15:0] b;
  input [15:0] c;
  output [15:0] sum;
  output [15:0] carry;
  wire   n92, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15,
         n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60,
         n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72, n73, n74,
         n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85, n86, n87, n88,
         n89, n90, n91;
  assign carry[0] = 1'b0;

  XOR2X1 U17 ( .A(n61), .B(n91), .Y(sum[9]) );
  XOR2X1 U18 ( .A(n58), .B(n90), .Y(sum[8]) );
  XOR2X1 U19 ( .A(n57), .B(n89), .Y(sum[7]) );
  XOR2X1 U20 ( .A(n53), .B(n88), .Y(sum[6]) );
  XOR2X1 U21 ( .A(n52), .B(n87), .Y(sum[5]) );
  XOR2X1 U22 ( .A(n51), .B(n86), .Y(sum[4]) );
  XOR2X1 U23 ( .A(n50), .B(n85), .Y(sum[3]) );
  XOR2X1 U24 ( .A(n49), .B(n84), .Y(sum[2]) );
  XOR2X1 U25 ( .A(n47), .B(n83), .Y(sum[1]) );
  FAX1 U26 ( .A(c[15]), .B(b[15]), .C(a[15]), .YS(sum[15]) );
  XOR2X1 U27 ( .A(n54), .B(n82), .Y(sum[14]) );
  XOR2X1 U28 ( .A(n55), .B(n81), .Y(sum[13]) );
  XOR2X1 U29 ( .A(n56), .B(n80), .Y(sum[12]) );
  XOR2X1 U30 ( .A(n59), .B(n79), .Y(sum[11]) );
  XOR2X1 U31 ( .A(n60), .B(n78), .Y(sum[10]) );
  OAI21X1 U33 ( .A(n90), .B(n58), .C(n12), .Y(carry[9]) );
  XNOR2X1 U35 ( .A(a[8]), .B(b[8]), .Y(n90) );
  OAI21X1 U36 ( .A(n89), .B(n57), .C(n11), .Y(carry[8]) );
  XNOR2X1 U38 ( .A(a[7]), .B(b[7]), .Y(n89) );
  OAI21X1 U39 ( .A(n88), .B(n53), .C(n10), .Y(carry[7]) );
  XNOR2X1 U41 ( .A(a[6]), .B(b[6]), .Y(n88) );
  OAI21X1 U42 ( .A(n87), .B(n52), .C(n9), .Y(carry[6]) );
  XNOR2X1 U44 ( .A(a[5]), .B(b[5]), .Y(n87) );
  OAI21X1 U45 ( .A(n86), .B(n51), .C(n8), .Y(carry[5]) );
  XNOR2X1 U47 ( .A(a[4]), .B(b[4]), .Y(n86) );
  OAI21X1 U48 ( .A(n85), .B(n50), .C(n7), .Y(carry[4]) );
  XNOR2X1 U50 ( .A(a[3]), .B(b[3]), .Y(n85) );
  OAI21X1 U51 ( .A(n84), .B(n49), .C(n6), .Y(carry[3]) );
  XNOR2X1 U53 ( .A(a[2]), .B(b[2]), .Y(n84) );
  OAI21X1 U54 ( .A(n83), .B(n47), .C(n15), .Y(carry[2]) );
  XNOR2X1 U56 ( .A(a[1]), .B(b[1]), .Y(n83) );
  OAI21X1 U57 ( .A(n77), .B(n48), .C(n13), .Y(carry[1]) );
  XNOR2X1 U59 ( .A(a[0]), .B(b[0]), .Y(n77) );
  OAI21X1 U60 ( .A(n82), .B(n54), .C(n14), .Y(carry[15]) );
  XNOR2X1 U62 ( .A(a[14]), .B(b[14]), .Y(n82) );
  OAI21X1 U63 ( .A(n81), .B(n55), .C(n5), .Y(carry[14]) );
  XNOR2X1 U65 ( .A(a[13]), .B(b[13]), .Y(n81) );
  OAI21X1 U66 ( .A(n80), .B(n56), .C(n4), .Y(carry[13]) );
  XNOR2X1 U68 ( .A(a[12]), .B(b[12]), .Y(n80) );
  OAI21X1 U69 ( .A(n79), .B(n59), .C(n3), .Y(carry[12]) );
  XNOR2X1 U71 ( .A(a[11]), .B(b[11]), .Y(n79) );
  OAI21X1 U72 ( .A(n78), .B(n60), .C(n2), .Y(carry[11]) );
  XNOR2X1 U74 ( .A(a[10]), .B(b[10]), .Y(n78) );
  OAI21X1 U75 ( .A(n91), .B(n61), .C(n1), .Y(carry[10]) );
  XNOR2X1 U77 ( .A(a[9]), .B(b[9]), .Y(n91) );
  AND2X1 U2 ( .A(a[9]), .B(b[9]), .Y(n62) );
  INVX1 U3 ( .A(n62), .Y(n1) );
  AND2X1 U4 ( .A(a[10]), .B(b[10]), .Y(n63) );
  INVX1 U5 ( .A(n63), .Y(n2) );
  AND2X1 U6 ( .A(a[11]), .B(b[11]), .Y(n64) );
  INVX1 U7 ( .A(n64), .Y(n3) );
  AND2X1 U8 ( .A(a[12]), .B(b[12]), .Y(n65) );
  INVX1 U9 ( .A(n65), .Y(n4) );
  AND2X1 U10 ( .A(a[13]), .B(b[13]), .Y(n66) );
  INVX1 U11 ( .A(n66), .Y(n5) );
  AND2X1 U12 ( .A(a[2]), .B(b[2]), .Y(n70) );
  INVX1 U13 ( .A(n70), .Y(n6) );
  AND2X1 U14 ( .A(a[3]), .B(b[3]), .Y(n71) );
  INVX1 U15 ( .A(n71), .Y(n7) );
  AND2X1 U16 ( .A(a[4]), .B(b[4]), .Y(n72) );
  INVX1 U32 ( .A(n72), .Y(n8) );
  AND2X1 U34 ( .A(a[5]), .B(b[5]), .Y(n73) );
  INVX1 U37 ( .A(n73), .Y(n9) );
  AND2X1 U40 ( .A(a[6]), .B(b[6]), .Y(n74) );
  INVX1 U43 ( .A(n74), .Y(n10) );
  AND2X1 U46 ( .A(a[7]), .B(b[7]), .Y(n75) );
  INVX1 U49 ( .A(n75), .Y(n11) );
  AND2X1 U52 ( .A(a[8]), .B(b[8]), .Y(n76) );
  INVX1 U55 ( .A(n76), .Y(n12) );
  AND2X1 U58 ( .A(a[0]), .B(b[0]), .Y(n68) );
  INVX1 U61 ( .A(n68), .Y(n13) );
  AND2X1 U64 ( .A(a[14]), .B(b[14]), .Y(n67) );
  INVX1 U67 ( .A(n67), .Y(n14) );
  AND2X1 U70 ( .A(a[1]), .B(b[1]), .Y(n69) );
  INVX1 U73 ( .A(n69), .Y(n15) );
  XNOR2X1 U76 ( .A(n48), .B(n77), .Y(n92) );
  INVX2 U78 ( .A(n92), .Y(sum[0]) );
  INVX1 U79 ( .A(c[11]), .Y(n59) );
  INVX1 U80 ( .A(c[13]), .Y(n55) );
  INVX1 U81 ( .A(c[12]), .Y(n56) );
  INVX1 U82 ( .A(c[9]), .Y(n61) );
  INVX1 U83 ( .A(c[10]), .Y(n60) );
  INVX1 U84 ( .A(c[14]), .Y(n54) );
  INVX1 U85 ( .A(c[3]), .Y(n50) );
  INVX1 U86 ( .A(c[4]), .Y(n51) );
  INVX1 U87 ( .A(c[5]), .Y(n52) );
  INVX1 U88 ( .A(c[6]), .Y(n53) );
  INVX1 U89 ( .A(c[7]), .Y(n57) );
  INVX1 U90 ( .A(c[8]), .Y(n58) );
  INVX1 U91 ( .A(c[2]), .Y(n49) );
  INVX1 U92 ( .A(c[1]), .Y(n47) );
  INVX1 U93 ( .A(c[0]), .Y(n48) );
endmodule


module wallace_multiplier_DW01_add_0 ( A, B, CI, SUM, CO );
  input [15:0] A;
  input [15:0] B;
  output [15:0] SUM;
  input CI;
  output CO;
  wire   n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43,
         n44, \A[0] , n1, n3, n5, n7, n9, n11, n13, n15, n17, n19, n21, n23,
         n25, n29;
  wire   [15:1] carry;
  assign SUM[0] = \A[0] ;
  assign \A[0]  = A[0];

  FAX1 U1_15 ( .A(A[15]), .B(B[15]), .C(carry[15]), .YS(n30) );
  FAX1 U1_14 ( .A(A[14]), .B(B[14]), .C(carry[14]), .YC(carry[15]), .YS(n31)
         );
  FAX1 U1_13 ( .A(A[13]), .B(B[13]), .C(carry[13]), .YC(carry[14]), .YS(n32)
         );
  FAX1 U1_12 ( .A(A[12]), .B(B[12]), .C(carry[12]), .YC(carry[13]), .YS(n33)
         );
  FAX1 U1_11 ( .A(A[11]), .B(B[11]), .C(carry[11]), .YC(carry[12]), .YS(n34)
         );
  FAX1 U1_10 ( .A(A[10]), .B(B[10]), .C(carry[10]), .YC(carry[11]), .YS(n35)
         );
  FAX1 U1_9 ( .A(A[9]), .B(B[9]), .C(carry[9]), .YC(carry[10]), .YS(n36) );
  FAX1 U1_8 ( .A(A[8]), .B(B[8]), .C(carry[8]), .YC(carry[9]), .YS(n37) );
  FAX1 U1_7 ( .A(A[7]), .B(B[7]), .C(carry[7]), .YC(carry[8]), .YS(n38) );
  FAX1 U1_6 ( .A(A[6]), .B(B[6]), .C(carry[6]), .YC(carry[7]), .YS(n39) );
  FAX1 U1_5 ( .A(A[5]), .B(B[5]), .C(carry[5]), .YC(carry[6]), .YS(n40) );
  FAX1 U1_4 ( .A(A[4]), .B(B[4]), .C(carry[4]), .YC(carry[5]), .YS(n41) );
  FAX1 U1_3 ( .A(A[3]), .B(B[3]), .C(carry[3]), .YC(carry[4]), .YS(n42) );
  FAX1 U1_2 ( .A(A[2]), .B(B[2]), .C(n29), .YC(carry[3]), .YS(n43) );
  INVX1 U1 ( .A(n43), .Y(n1) );
  INVX2 U2 ( .A(n1), .Y(SUM[2]) );
  INVX1 U3 ( .A(n42), .Y(n3) );
  INVX2 U4 ( .A(n3), .Y(SUM[3]) );
  INVX1 U5 ( .A(n41), .Y(n5) );
  INVX2 U6 ( .A(n5), .Y(SUM[4]) );
  INVX1 U7 ( .A(n40), .Y(n7) );
  INVX2 U8 ( .A(n7), .Y(SUM[5]) );
  INVX1 U9 ( .A(n39), .Y(n9) );
  INVX2 U10 ( .A(n9), .Y(SUM[6]) );
  INVX1 U11 ( .A(n38), .Y(n11) );
  INVX2 U12 ( .A(n11), .Y(SUM[7]) );
  INVX1 U13 ( .A(n37), .Y(n13) );
  INVX2 U14 ( .A(n13), .Y(SUM[8]) );
  INVX1 U15 ( .A(n36), .Y(n15) );
  INVX2 U16 ( .A(n15), .Y(SUM[9]) );
  INVX1 U17 ( .A(n35), .Y(n17) );
  INVX2 U18 ( .A(n17), .Y(SUM[10]) );
  INVX1 U19 ( .A(n34), .Y(n19) );
  INVX2 U20 ( .A(n19), .Y(SUM[11]) );
  INVX1 U21 ( .A(n33), .Y(n21) );
  INVX2 U22 ( .A(n21), .Y(SUM[12]) );
  INVX1 U23 ( .A(n32), .Y(n23) );
  INVX2 U24 ( .A(n23), .Y(SUM[13]) );
  INVX1 U25 ( .A(n31), .Y(n25) );
  INVX2 U26 ( .A(n25), .Y(SUM[14]) );
  AND2X1 U27 ( .A(B[1]), .B(A[1]), .Y(n29) );
  XNOR2X1 U28 ( .A(B[1]), .B(A[1]), .Y(n44) );
  INVX2 U29 ( .A(n44), .Y(SUM[1]) );
  BUFX2 U30 ( .A(n30), .Y(SUM[15]) );
endmodule


module wallace_multiplier ( a, b, p );
  input [7:0] a;
  input [7:0] b;
  output [15:0] p;
  wire   \pp[0][7] , \pp[0][6] , \pp[0][5] , \pp[0][4] , \pp[0][3] ,
         \pp[0][2] , \pp[0][1] , \pp[0][0] , \pp[1][8] , \pp[1][7] ,
         \pp[1][6] , \pp[1][5] , \pp[1][4] , \pp[1][3] , \pp[1][2] ,
         \pp[1][1] , \pp[2][9] , \pp[2][8] , \pp[2][7] , \pp[2][6] ,
         \pp[2][5] , \pp[2][4] , \pp[2][3] , \pp[2][2] , \pp[3][10] ,
         \pp[3][9] , \pp[3][8] , \pp[3][7] , \pp[3][6] , \pp[3][5] ,
         \pp[3][4] , \pp[3][3] , \pp[4][11] , \pp[4][10] , \pp[4][9] ,
         \pp[4][8] , \pp[4][7] , \pp[4][6] , \pp[4][5] , \pp[4][4] ,
         \pp[5][12] , \pp[5][11] , \pp[5][10] , \pp[5][9] , \pp[5][8] ,
         \pp[5][7] , \pp[5][6] , \pp[5][5] , \pp[6][13] , \pp[6][12] ,
         \pp[6][11] , \pp[6][10] , \pp[6][9] , \pp[6][8] , \pp[6][7] ,
         \pp[6][6] , \pp[7][14] , \pp[7][13] , \pp[7][12] , \pp[7][11] ,
         \pp[7][10] , \pp[7][9] , \pp[7][8] , \pp[7][7] ;
  wire   [15:0] s0;
  wire   [15:0] c0;
  wire   [15:0] s1;
  wire   [15:0] c1;
  wire   [15:0] s2;
  wire   [15:0] c2;
  wire   [15:0] s3;
  wire   [15:0] c3;
  wire   [15:0] s4;
  wire   [15:0] c4;
  wire   [15:0] s5;
  wire   [15:0] c5;
  wire   SYNOPSYS_UNCONNECTED__0, SYNOPSYS_UNCONNECTED__1, 
        SYNOPSYS_UNCONNECTED__2, SYNOPSYS_UNCONNECTED__3, 
        SYNOPSYS_UNCONNECTED__4, SYNOPSYS_UNCONNECTED__5;

  csa_0 u_csa0 ( .a({1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        \pp[0][7] , \pp[0][6] , \pp[0][5] , \pp[0][4] , \pp[0][3] , \pp[0][2] , 
        \pp[0][1] , \pp[0][0] }), .b({1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        \pp[1][8] , \pp[1][7] , \pp[1][6] , \pp[1][5] , \pp[1][4] , \pp[1][3] , 
        \pp[1][2] , \pp[1][1] , 1'b0}), .c({1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        \pp[2][9] , \pp[2][8] , \pp[2][7] , \pp[2][6] , \pp[2][5] , \pp[2][4] , 
        \pp[2][3] , \pp[2][2] , 1'b0, 1'b0}), .sum(s0), .carry({c0[15:1], 
        SYNOPSYS_UNCONNECTED__0}) );
  csa_5 u_csa1 ( .a({1'b0, 1'b0, 1'b0, 1'b0, 1'b0, \pp[3][10] , \pp[3][9] , 
        \pp[3][8] , \pp[3][7] , \pp[3][6] , \pp[3][5] , \pp[3][4] , \pp[3][3] , 
        1'b0, 1'b0, 1'b0}), .b({1'b0, 1'b0, 1'b0, 1'b0, \pp[4][11] , 
        \pp[4][10] , \pp[4][9] , \pp[4][8] , \pp[4][7] , \pp[4][6] , 
        \pp[4][5] , \pp[4][4] , 1'b0, 1'b0, 1'b0, 1'b0}), .c({1'b0, 1'b0, 1'b0, 
        \pp[5][12] , \pp[5][11] , \pp[5][10] , \pp[5][9] , \pp[5][8] , 
        \pp[5][7] , \pp[5][6] , \pp[5][5] , 1'b0, 1'b0, 1'b0, 1'b0, 1'b0}), 
        .sum(s1), .carry({c1[15:1], SYNOPSYS_UNCONNECTED__1}) );
  csa_4 u_csa2 ( .a({1'b0, 1'b0, \pp[6][13] , \pp[6][12] , \pp[6][11] , 
        \pp[6][10] , \pp[6][9] , \pp[6][8] , \pp[6][7] , \pp[6][6] , 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0}), .b({1'b0, \pp[7][14] , \pp[7][13] , 
        \pp[7][12] , \pp[7][11] , \pp[7][10] , \pp[7][9] , \pp[7][8] , 
        \pp[7][7] , 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0}), .c(s0), .sum(
        s2), .carry({c2[15:1], SYNOPSYS_UNCONNECTED__2}) );
  csa_3 u_csa3 ( .a({c0[15:1], 1'b0}), .b(s1), .c({c1[15:1], 1'b0}), .sum(s3), 
        .carry({c3[15:1], SYNOPSYS_UNCONNECTED__3}) );
  csa_2 u_csa4 ( .a(s2), .b({c2[15:1], 1'b0}), .c(s3), .sum(s4), .carry({
        c4[15:1], SYNOPSYS_UNCONNECTED__4}) );
  csa_1 u_csa5 ( .a({c3[15:1], 1'b0}), .b(s4), .c({c4[15:1], 1'b0}), .sum(s5), 
        .carry({c5[15:1], SYNOPSYS_UNCONNECTED__5}) );
  wallace_multiplier_DW01_add_0 add_46 ( .A(s5), .B({c5[15:1], 1'b0}), .CI(
        1'b0), .SUM(p) );
  AND2X1 U68 ( .A(b[1]), .B(a[3]), .Y(\pp[1][4] ) );
  AND2X1 U69 ( .A(b[1]), .B(a[0]), .Y(\pp[1][1] ) );
  AND2X1 U70 ( .A(b[1]), .B(a[1]), .Y(\pp[1][2] ) );
  AND2X1 U71 ( .A(b[1]), .B(a[2]), .Y(\pp[1][3] ) );
  AND2X1 U72 ( .A(b[4]), .B(a[0]), .Y(\pp[4][4] ) );
  AND2X1 U73 ( .A(b[4]), .B(a[1]), .Y(\pp[4][5] ) );
  AND2X1 U74 ( .A(b[1]), .B(a[4]), .Y(\pp[1][5] ) );
  AND2X1 U75 ( .A(b[4]), .B(a[2]), .Y(\pp[4][6] ) );
  AND2X1 U76 ( .A(b[1]), .B(a[5]), .Y(\pp[1][6] ) );
  AND2X1 U77 ( .A(b[4]), .B(a[3]), .Y(\pp[4][7] ) );
  AND2X1 U78 ( .A(b[1]), .B(a[6]), .Y(\pp[1][7] ) );
  AND2X1 U79 ( .A(b[4]), .B(a[4]), .Y(\pp[4][8] ) );
  AND2X1 U80 ( .A(b[1]), .B(a[7]), .Y(\pp[1][8] ) );
  AND2X1 U81 ( .A(b[4]), .B(a[5]), .Y(\pp[4][9] ) );
  AND2X1 U82 ( .A(b[4]), .B(a[6]), .Y(\pp[4][10] ) );
  AND2X1 U83 ( .A(b[4]), .B(a[7]), .Y(\pp[4][11] ) );
  AND2X1 U84 ( .A(a[0]), .B(b[7]), .Y(\pp[7][7] ) );
  AND2X1 U85 ( .A(a[1]), .B(b[7]), .Y(\pp[7][8] ) );
  AND2X1 U86 ( .A(b[7]), .B(a[2]), .Y(\pp[7][9] ) );
  AND2X1 U87 ( .A(a[3]), .B(b[7]), .Y(\pp[7][10] ) );
  AND2X1 U88 ( .A(a[4]), .B(b[7]), .Y(\pp[7][11] ) );
  AND2X1 U89 ( .A(a[5]), .B(b[7]), .Y(\pp[7][12] ) );
  AND2X1 U90 ( .A(a[7]), .B(b[7]), .Y(\pp[7][14] ) );
  AND2X1 U91 ( .A(a[6]), .B(b[7]), .Y(\pp[7][13] ) );
  AND2X1 U92 ( .A(b[0]), .B(a[0]), .Y(\pp[0][0] ) );
  AND2X1 U93 ( .A(b[0]), .B(a[1]), .Y(\pp[0][1] ) );
  AND2X1 U94 ( .A(b[0]), .B(a[2]), .Y(\pp[0][2] ) );
  AND2X1 U95 ( .A(b[3]), .B(a[0]), .Y(\pp[3][3] ) );
  AND2X1 U96 ( .A(b[0]), .B(a[3]), .Y(\pp[0][3] ) );
  AND2X1 U97 ( .A(b[3]), .B(a[1]), .Y(\pp[3][4] ) );
  AND2X1 U98 ( .A(b[0]), .B(a[4]), .Y(\pp[0][4] ) );
  AND2X1 U99 ( .A(b[3]), .B(a[2]), .Y(\pp[3][5] ) );
  AND2X1 U100 ( .A(b[0]), .B(a[5]), .Y(\pp[0][5] ) );
  AND2X1 U101 ( .A(b[3]), .B(a[3]), .Y(\pp[3][6] ) );
  AND2X1 U102 ( .A(b[0]), .B(a[6]), .Y(\pp[0][6] ) );
  AND2X1 U103 ( .A(b[3]), .B(a[4]), .Y(\pp[3][7] ) );
  AND2X1 U104 ( .A(b[0]), .B(a[7]), .Y(\pp[0][7] ) );
  AND2X1 U105 ( .A(b[3]), .B(a[5]), .Y(\pp[3][8] ) );
  AND2X1 U106 ( .A(b[3]), .B(a[6]), .Y(\pp[3][9] ) );
  AND2X1 U107 ( .A(b[3]), .B(a[7]), .Y(\pp[3][10] ) );
  AND2X1 U108 ( .A(b[6]), .B(a[0]), .Y(\pp[6][6] ) );
  AND2X1 U109 ( .A(b[6]), .B(a[1]), .Y(\pp[6][7] ) );
  AND2X1 U110 ( .A(b[6]), .B(a[2]), .Y(\pp[6][8] ) );
  AND2X1 U111 ( .A(b[6]), .B(a[3]), .Y(\pp[6][9] ) );
  AND2X1 U112 ( .A(b[6]), .B(a[4]), .Y(\pp[6][10] ) );
  AND2X1 U113 ( .A(b[6]), .B(a[5]), .Y(\pp[6][11] ) );
  AND2X1 U114 ( .A(b[6]), .B(a[6]), .Y(\pp[6][12] ) );
  AND2X1 U115 ( .A(b[6]), .B(a[7]), .Y(\pp[6][13] ) );
  AND2X1 U116 ( .A(b[2]), .B(a[0]), .Y(\pp[2][2] ) );
  AND2X1 U117 ( .A(b[2]), .B(a[1]), .Y(\pp[2][3] ) );
  AND2X1 U118 ( .A(b[2]), .B(a[2]), .Y(\pp[2][4] ) );
  AND2X1 U119 ( .A(b[5]), .B(a[0]), .Y(\pp[5][5] ) );
  AND2X1 U120 ( .A(b[2]), .B(a[3]), .Y(\pp[2][5] ) );
  AND2X1 U121 ( .A(b[5]), .B(a[1]), .Y(\pp[5][6] ) );
  AND2X1 U122 ( .A(b[2]), .B(a[4]), .Y(\pp[2][6] ) );
  AND2X1 U123 ( .A(b[5]), .B(a[2]), .Y(\pp[5][7] ) );
  AND2X1 U124 ( .A(b[2]), .B(a[5]), .Y(\pp[2][7] ) );
  AND2X1 U125 ( .A(b[5]), .B(a[3]), .Y(\pp[5][8] ) );
  AND2X1 U126 ( .A(b[2]), .B(a[6]), .Y(\pp[2][8] ) );
  AND2X1 U127 ( .A(b[5]), .B(a[4]), .Y(\pp[5][9] ) );
  AND2X1 U128 ( .A(b[2]), .B(a[7]), .Y(\pp[2][9] ) );
  AND2X1 U129 ( .A(b[5]), .B(a[5]), .Y(\pp[5][10] ) );
  AND2X1 U130 ( .A(b[5]), .B(a[6]), .Y(\pp[5][11] ) );
  AND2X1 U131 ( .A(b[5]), .B(a[7]), .Y(\pp[5][12] ) );
endmodule

