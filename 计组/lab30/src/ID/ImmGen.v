module ImmGen (
    input [31:0] inst,
    input [2:0] func3,
    input I_type, LW, JALR, SW, JAL, LUI, AUIPC, SB_type,
    output reg [31:0] immediate,
    output reg [31:0] offset
);
wire shift= (func3==3'd1) || (func3==3'd5);
always @(*) begin
    if(I_type)begin
        immediate= (shift==1'b1)?{26'd0, inst[25:20]}:{{20{inst[31]}}, inst[31:20]};
        offset= 32'bx;
    end
    else if(LW)begin
        immediate= {{20{inst[31]}}, inst[31:20]};
        offset= 32'bx;
    end
    else if(JALR)begin
        immediate= 32'bx;
        offset= {{20{inst[31]}}, inst[31:20]};
        end
    else if(SW)begin
        offset= 32'bx;
        immediate= {{20{inst[31]}}, inst[31:25], inst[11:7]};
    end
    else if(JAL)begin
        offset= {{11{inst[31]}}, inst[31], inst[19:12], inst[20], inst[30:21], 1'b0};
        immediate= 32'bx;
    end
    else if(LUI || AUIPC)begin
        immediate= {inst[31:12], 12'd0};
        offset= 32'bx;
    end
    else if(SB_type)begin
        offset= {{19{inst[31]}}, inst[31], inst[7], inst[30:25], inst[11:8], 1'b0};
        immediate= 32'bx;
    end
    else begin
        immediate= 32'bx;
        offset= 32'bx;
    end
end
endmodule