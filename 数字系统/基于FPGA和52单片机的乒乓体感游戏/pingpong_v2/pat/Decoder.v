module decoder (
    input [31:0] Code,
    input Fetch,
    output reg direction_x,
    output reg direction_y,
    output reg [31:0] pat_velocity,
    output reg Stall,
    output reg Clear
);

parameter F_FAST = 16'hFF00; parameter F_NORMAL = 16'hF000; parameter F_SLOW = 16'h0F00;
parameter B_FAST = 16'hAA00; parameter B_NORMAL = 16'hA000; parameter B_SLOW = 16'h0A00;
parameter L_FAST = 16'h00FF; parameter L_NORMAL = 16'h00F0; parameter L_SLOW = 16'h000F;
parameter R_FAST = 16'h00AA; parameter R_NORMAL = 16'h00A0; parameter R_SLOW = 16'h000A;
parameter STALL  = 16'h0080; parameter CLEAR    = 16'h0000;
parameter LEFT = 2'b00; parameter RIGHT = 2'b01; parameter FORWARD = 2'b10; parameter BACKWARD = 2'b11;

initial begin
    Stall = 0;
    Clear = 0;
    direction_y = 1'bz;
    direction_x = 1'bz;
    pat_velocity = 32'b0;
end

always @(*) begin
    if(Fetch)
    begin
        case (Code[31:16]) 
            F_FAST: begin
                direction_y = 1;
                pat_velocity[15:0] = 16'b0_000_0010_1101_0000; //fast = 45
            end  
            F_NORMAL: begin
                direction_y = 1;
                pat_velocity[15:0] = 16'b0_000_0001_1110_0000; //normal = 30
            end
            F_SLOW: begin
                direction_y = 1;
                pat_velocity[15:0] = 16'b0_000_0000_1111_0000; //slow = 15
            end
            B_FAST: begin
                direction_y = 0;
                pat_velocity[15:0] = 16'b0_000_0010_1101_0000; //fast = 45
            end  
            B_NORMAL: begin
                direction_y = 0;
                pat_velocity[15:0] = 16'b0_000_0001_1110_0000; //normal = 30
            end
            B_SLOW: begin
                direction_y = 0;
                pat_velocity[15:0] = 16'b0_000_0000_1111_0000; //slow = 15
            end
        endcase
        case (Code[15:0])
            L_FAST: begin
                direction_x = 1;
                pat_velocity[31:16] = 16'b0_000_0010_1101_0000; //fast = 45
            end  
            L_NORMAL: begin
                direction_x = 1;
                pat_velocity[31:16] = 16'b0_000_0001_1110_0000; //normal = 30
            end
            L_SLOW: begin
                direction_x = 1;
                pat_velocity[31:16] = 16'b0_000_0000_1111_0000; //slow = 15
            end
            R_FAST: begin
                direction_x = 0;
                pat_velocity[31:16] = 16'b0_000_0010_1101_0000; //fast = 45
            end  
            R_NORMAL: begin
                direction_x = 0;
                pat_velocity[31:16] = 16'b0_000_0001_1110_0000; //normal = 30
            end
            R_SLOW: begin
                direction_x = 0;
                pat_velocity[31:16] = 16'b0_000_0000_1111_0000; //slow = 15
            end
        endcase
    end
end
endmodule