// ECE 527 PR_2 Task A
// 2-bit full adder: basic block shared by rca4_pipe (Fig 1) and csa4_pipe (Fig 2).

module fa2 (
    input  logic [1:0] a, b,
    input  logic       cin,
    output logic [1:0] s,
    output logic       cout
);
    assign {cout, s} = a + b + cin;
endmodule
