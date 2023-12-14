module ALU (
    input [31:0] A, B,
    input [3:0] ALUCode,
    output reg [31:0] ALUResult
);
wire Binvert= ~(ALUCode==0);
wire [31:0] b= {32{Binvert}}^B;
reg signed[31:0] A_reg;
wire [31:0] sum;
adder_32bits adder(
    .a(A), .b(b), .ci(Binvert), .s(sum)
);
always @(*) begin
    A_reg= A;
end
wire isLT= (A[31]&&(~B[31]))||((A[31]~^B[31]) && sum[31]);
wire isLTU= ((~A[31])&&B[31])||((A[31]~^B[31]) && sum[31]);
always @(*) begin
    case(ALUCode)
        4'b0000: ALUResult= sum;
        4'b0001: ALUResult= sum;
        4'b0010: ALUResult= B;
        4'b0011: ALUResult= A&B;
        4'b0100: ALUResult= A^B;
        4'b0101: ALUResult= A|B;
        4'b0110: ALUResult= A<<B;
        4'b0111: ALUResult= A>>B;
        4'b1000: ALUResult= A_reg>>>B;
        4'b1001: ALUResult= (isLT==1'b1)?32'd1:32'd0;
        4'b1010: ALUResult= (isLTU==1'b1)?32'd1:32'd0;
        default: ALUResult= sum;
    endcase
end
endmodule