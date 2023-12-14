`timescale 1ns/10ps
module mux_4bits (
    input [3:0] a,
    input [3:0] b,
    input sw,
    output reg [3:0] out
);
    always @(*) begin
        if(sw)
            out = a;
        else 
            out = b; 
    end
endmodule