module mux (
    input [31:0] in0,
    input [31:0] in1,
    input sw,
    output reg [31:0] out
);
    
always @(*) begin
    out = (sw?in1:in0);
end

endmodule