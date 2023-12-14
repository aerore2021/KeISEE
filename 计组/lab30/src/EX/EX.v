module EX (
    input [3:0] ALUCode_ex,
    input ALUSrcA_ex, RegWrite_mem, RegWrite_wb, 
    input [1:0] ALUSrcB_ex,
    input [31:0] Imm_ex, rs1Data_ex, rs2Data_ex, PC_ex, RegWriteData_wb, 
                 ALUResult_mem,
    input [4:0] rs1Addr_ex, rs2Addr_ex, rdAddr_mem, rdAddr_wb, 
    output [31:0] ALUResult_ex, MemWriteData_ex, 
    output reg [31:0] ALU_A, ALU_B
);
// deciding ALU_A and ALU_B
reg [31:0] A_0, B_0;
wire [1:0] ForwardA, ForwardB;
always @(*) begin
    case (ForwardA)
        2'b00: A_0= rs1Data_ex;
        2'b01: A_0= RegWriteData_wb;
        2'b10: A_0= ALUResult_mem; 
    endcase
    case (ForwardB)
        2'b00: B_0= rs2Data_ex;
        2'b01: B_0= RegWriteData_wb;
        2'b10: B_0= ALUResult_mem;
    endcase
end
always @(*) begin
    ALU_A= (ALUSrcA_ex)?PC_ex:A_0;
    ALU_B= (ALUSrcB_ex==2'b00)?B_0:((ALUSrcB_ex==2'b01)?Imm_ex:32'd4);
end

ALU ALU(
    .A(ALU_A), .B(ALU_B), 
    .ALUCode(ALUCode_ex), .ALUResult(ALUResult_ex)
);

Forwarding Forwarding(
    .RegWrite_wb(RegWrite_wb), .RegWrite_mem(RegWrite_mem),
    .rdAddr_wb(rdAddr_wb), .rdAddr_mem(rdAddr_mem), 
    .rs1Addr_ex(rs1Addr_ex), .rs2Addr_ex(rs2Addr_ex),
    .ForwardA(ForwardA), .ForwardB(ForwardB)
);

assign MemWriteData_ex= B_0;

endmodule