//Read before write Registers
module RBWRegisters (
    input [4:0] ReadRegister1,ReadRegister2, WriteRegister,
    input clk, RegWrite,
    input [31:0] WriteData, 
    output [31:0] ReadData1, ReadData2
);
reg [31:0] regs [31:0]; //define a 32*32 registers
assign ReadData1= (ReadRegister1==5'b0)?32'b0:regs[ReadRegister1]; //rs1Data
assign ReadData2= (ReadRegister2==5'b0)?32'b0:regs[ReadRegister2]; //rs2Data
always @(posedge clk) begin
    if(RegWrite)
        regs[WriteRegister]<=WriteData; //act as a decoder
end
endmodule