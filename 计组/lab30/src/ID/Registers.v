//Read after write registers
module Registers (
    input clk, RegWrite,
    input [4:0] rs1Addr, rs2Addr, WriteAddr,
    input [31:0] WriteData, 
    output [31:0] rs1Data, rs2Data 
);
wire rs1Sel, rs2Sel;
wire [31:0] ReadData1, ReadData2;
RBWRegisters RBWr(
    .ReadRegister1(rs1Addr), .ReadRegister2(rs2Addr), .WriteRegister(WriteAddr),
    .clk(clk), .RegWrite(RegWrite),
    .WriteData(WriteData),
    .ReadData1(ReadData1), .ReadData2(ReadData2)
);
//forward detction
assign rs1Sel= RegWrite && (WriteAddr!=0) && (WriteAddr==rs1Addr);
assign rs2Sel= RegWrite && (WriteAddr!=0) && (WriteAddr==rs2Addr);
//output
assign rs1Data= (rs1Sel==1'b0)?ReadData1:WriteData;
assign rs2Data= (rs2Sel==1'b0)?ReadData2:WriteData;
endmodule