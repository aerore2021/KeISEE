module Risc5CPU (
    input clk, reset,
    output [1:0] JumpFlag,
    output [31:0] ALU_A, ALU_B, ALUResult_ex, PC, MemDout_mem,
    output reg [31:0] Instruction_id,
    output Stall
);

// input
wire MemtoReg_id, RegWrite_id, MemWrite_id, MemRead_id, ALUSrcA_id,
     Branch, Jump;
wire [3:0] ALUCode_id;  wire [1:0] ALUSrcB_id; 
wire [4:0] rdAddr_id, rs1Addr_id, rs2Addr_id;
wire [31:0] Imm_id, rs1Data_id, rs2Data_id;  
reg [31:0] PC_id; 
wire [31:0] MemWriteData_ex;
reg MemtoReg_ex, RegWrite_ex, MemWrite_ex, MemRead_ex, ALUSrcA_ex;
reg [3:0] ALUCode_ex;  reg [1:0] ALUSrcB_ex; 
reg [4:0] rdAddr_ex, rs1Addr_ex, rs2Addr_ex;
reg [31:0] Imm_ex, rs1Data_ex, rs2Data_ex, PC_ex; 

reg [31:0] MemDout_wb, ALUResult_wb;
reg [4:0] rdAddr_wb;
reg MemtoReg_wb, RegWrite_wb;
wire [31:0] RegWriteData_wb;
wire IF_flush;
wire [31:0] Instruction_if, JumpAddr;

reg MemtoReg_mem, RegWrite_mem, MemWrite_mem;
reg [31:0] ALUResult_mem, MemWriteData_mem;
reg [4:0] rdAddr_mem;

IF IF(
    clk, reset, Branch, Jump, IFWrite,
    JumpAddr, 
    Instruction_if, PC,
    IF_flush
);

// IF/ID Register
always @(posedge clk) begin
    if((IF_flush|reset)==1'b1)begin
        PC_id<= 32'b0;
        Instruction_id<= 32'b0;
    end
    else if(IFWrite==1'b1) begin
        PC_id<= PC;
        Instruction_id<= Instruction_if;
    end
    else begin
        PC_id<= PC_id;
        Instruction_id<= Instruction_id;
    end
end

ID ID (
    clk, RegWrite_wb, MemRead_ex,
    Instruction_id, PC_id, RegWriteData_wb,
    rdAddr_wb, rdAddr_ex,
    MemtoReg_id, RegWrite_id, MemWrite_id, MemRead_id,
    ALUSrcA_id, Stall, Branch, Jump, IFWrite,   
    ALUCode_id,
    ALUSrcB_id,
    JumpAddr, Imm_id, rs1Data_id, rs2Data_id,
    rdAddr_id, rs1Addr_id, rs2Addr_id
);

// ID/EX Register 
always @(posedge clk) begin
    if((Stall|reset)==1'b1) begin
        MemtoReg_ex<=0; RegWrite_ex<=0; MemWrite_ex<=0; 
        MemRead_ex<=0; ALUSrcA_ex<=0;
        ALUCode_ex<=4'b0;  ALUSrcB_ex<=2'b0; 
        rdAddr_ex<=5'b0; 
        rs1Addr_ex<=5'b0; rs2Addr_ex<=5'b0;
        Imm_ex<=32'b0; PC_ex<=32'b0;
        rs1Data_ex<=32'b0; rs2Data_ex<=32'b0;  
    end
    else begin
        MemtoReg_ex<=MemtoReg_id; RegWrite_ex<=RegWrite_id; 
        MemWrite_ex<=MemWrite_id; MemRead_ex<=MemRead_id; 
        ALUSrcA_ex<=ALUSrcA_id; ALUSrcB_ex<=ALUSrcB_id; 
        ALUCode_ex<=ALUCode_id;  
        rdAddr_ex<=rdAddr_id; 
        rs1Addr_ex<=rs1Addr_id; rs2Addr_ex<=rs2Addr_id;
        rs1Data_ex<=rs1Data_id; rs2Data_ex<=rs2Data_id;
        Imm_ex<=Imm_id;  PC_ex<=PC_id;  
    end
end

EX EX (
    ALUCode_ex,
    ALUSrcA_ex, RegWrite_mem, RegWrite_wb, 
    ALUSrcB_ex,
    Imm_ex, rs1Data_ex, rs2Data_ex, PC_ex, RegWriteData_wb, ALUResult_mem,
    rs1Addr_ex, rs2Addr_ex, rdAddr_mem, rdAddr_wb, 
    ALUResult_ex, MemWriteData_ex, ALU_A, ALU_B
);

// EX/MEM Register
always @(posedge clk) begin
    MemtoReg_mem<=MemtoReg_ex; RegWrite_mem<=RegWrite_ex; 
    MemWrite_mem<=MemWrite_ex; 
    ALUResult_mem<=ALUResult_ex; MemWriteData_mem<=MemWriteData_ex;
    rdAddr_mem<=rdAddr_ex;
end

DataRAM DataRAM (
  .a(ALUResult_mem[7:2]),      
  .d(MemWriteData_mem),
  .clk(clk),  
  .we(MemWrite_mem),    
  .spo(MemDout_mem)      
);

// MEM/WB Register
always @(posedge clk) begin
    MemtoReg_wb<=MemtoReg_mem; RegWrite_wb<=RegWrite_mem;
    MemDout_wb<=MemDout_mem; ALUResult_wb<=ALUResult_mem;
    rdAddr_wb<=rdAddr_mem;
end

// WB
assign RegWriteData_wb= (MemtoReg_wb)?MemDout_wb:ALUResult_wb;
assign JumpFlag[0]= Branch;
assign JumpFlag[1]= Jump;
endmodule