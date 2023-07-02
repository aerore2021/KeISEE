module update_pat (
    input clk,
    input rst_n,
    input Update_pat,
    input [31:0] pat_velocity,
    input direction_x,
    input direction_y,
    input [21:0] pat_location,
    output reg [21:0] new_pat_location
);

always @(posedge clk) begin
    if (rst_n) begin
        new_pat_location = 22'b001_1000_1011_100_0100_1100;
    end
    else if(Update_pat)
    begin 
    case (direction_x)
        1: new_pat_location[21:11] = pat_location[21:11]+pat_velocity[30:20];
        0: new_pat_location[21:11] = pat_location[21:11]-pat_velocity[30:20];    
    endcase
    case (direction_y)
        1: new_pat_location[10:0] = pat_location[10:0]-pat_velocity[14:4];
        0: new_pat_location[10:0] = pat_location[10:0]+pat_velocity[14:4];
    endcase
    end
end

endmodule