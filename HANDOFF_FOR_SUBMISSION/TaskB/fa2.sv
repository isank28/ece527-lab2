// ECE 527 PR_2 Task A / Task B
// 2-bit full adder: basic block shared by rca4_pipe, csa4_pipe (Task A) and csa8_pipe (Task B).

module fa2 (
    input  logic [1:0] a, b,
    input  logic       cin,
    output logic [1:0] s,
    output logic       cout
);
    assign {cout, s} = a + b + cin;
endmodule
