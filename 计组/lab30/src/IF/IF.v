module IF (
    input clk, reset, Branch, Jump, IFWrite,
    input [31:0] JumpAddr, 
    output [31:0] Instruction_if, 
    output [31:0] PC,
    output IF_flush
);
wire [31:0] CurrentPC, NextPC, NextPC_if;
InstructionROM IROM(
    .addr(NextPC[7:2]),
    .dout(Instruction_if)
);

PCRegister PCR(
    .clk(clk), .rst(reset), .PC(CurrentPC), 
    .NextPC(NextPC), .En(IFWrite)
);
assign NextPC_if= NextPC+32'd4; 
assign PC= NextPC;
assign IF_flush= Branch || Jump;
assign CurrentPC= (IF_flush == 1'b0)?NextPC_if:JumpAddr;
endmodule