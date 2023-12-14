module PCRegister (
    input clk, rst, En,
    input [31:0] PC,
    output reg [31:0] NextPC
);
always @(posedge clk) begin
    if(rst)
        NextPC<= 32'b0;
    else if(En)
        NextPC<= PC;
    else
        NextPC<= NextPC;
end
endmodule