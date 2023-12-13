`timescale 1ns/10ps
module adder_4bits (
    input [3:0] a,
    input [3:0] b,
    input ci,
    output [3:0] s,
    output co
);
    wire g0, g1, g2, g3;
    wire p0, p1, p2, p3;
    //5.12(2) acquire g[i], p[i]
    assign g0 = a[0]&b[0];
    assign g1 = a[1]&b[1];
    assign g2 = a[2]&b[2];
    assign g3 = a[3]&b[3];
    assign p0 = a[0]|b[0];
    assign p1 = a[1]|b[1];
    assign p2 = a[2]|b[2];
    assign p3 = a[3]|b[3];
    wire c0, c1, c2, c3;
    //5.13 acquire c[i]
    assign c0 = g0 || (p0&&ci);
    assign c1 = g1 || (p1&&c0);
    assign c2 = g2 || (p2&&c1);
    assign c3 = g3 || (p3&&c2);
    assign co = c3; //output
    //5.12(1) acquire s[i]
    assign s[0] = (p0&&(!g0))^ci;
    assign s[1] = (p1&&(!g1))^c0;
    assign s[2] = (p2&&(!g2))^c1;
    assign s[3] = (p3&&(!g3))^c2;
endmodule