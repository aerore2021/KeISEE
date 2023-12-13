// conditional sum adder unit
`timescale 1ns/10ps
module csau (
    input [3:0] a,
    input [3:0] b,
    input ci,
    output [3:0] s,
    output co
);
    wire [3:0]s1, s0;
    wire co0, co1;
    adder_4bits a0(.a(a), .b(b), .ci(0), .s(s0), .co(co0));
    adder_4bits a1(.a(a), .b(b), .ci(1), .s(s1), .co(co1));

    mux_4bits mux(.a(s1), .b(s0), .sw(ci), .out(s));
    assign co = co0 || (co1 && ci);
endmodule