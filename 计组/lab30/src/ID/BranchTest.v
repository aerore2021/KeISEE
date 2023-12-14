module BranchTest (
    input [31:0] rs1Data, rs2Data,
    input [31:0] Instruction,
    output reg Branch
);
wire [31:0] sum= rs1Data+(~rs2Data)+1;
wire isLT= rs1Data[31] && (~rs2Data[31]) ||(rs1Data[31]~^rs2Data[31]) && sum[31];
wire isLTU= (~rs1Data[31]) && rs2Data[31] ||(rs1Data[31]~^rs2Data[31]) && sum[31];
wire [2:0] func3= Instruction[14:12];
wire SB_type= (Instruction[6:0]==7'b1100011);
parameter beq_func3= 3'o0;    parameter bne_func3= 3'o1;    
parameter blt_func3= 3'o4;    parameter bge_func3= 3'o5;
parameter bltu_func3= 3'o6;   parameter bgeu_func3= 3'o7;
always @(*) begin
    if(SB_type) begin
        case(func3)
            beq_func3: Branch= ~(|sum[31:0]);
            bne_func3: Branch= |sum[31:0];
            blt_func3: Branch= isLT;
            bge_func3: Branch= ~isLT;
            bltu_func3: Branch= isLTU;
            bgeu_func3: Branch= ~isLTU;
            default: Branch= 0;
        endcase
    end
    else 
        Branch= 1'b0;
end
endmodule