module alter_location (
    input clk,
    input rst_n,
    input Compute_alter,
    input [31:0] ball_velocity,
    input [21:0] ball_location,
    input [16:0] ball_angle,
    output reg [21:0] new_ball_location,
    output reg [10:0] new_x,
    output reg [10:0] new_y // for vga
);
    
always @(posedge clk) begin
    if(rst_n)
    begin
        new_ball_location = 22'b001_1000_1011_000_0000_0000; //初始化球的位置
    end
    //根据速度改变小球的位置
    else if(Compute_alter)begin
        if(ball_angle[16] == 1)
        begin
            if(ball_velocity[15] == 0)
                new_ball_location = {ball_location[21:11]-ball_velocity[30:20], ball_location[10:0]+ball_velocity[14:4]};
            else
                new_ball_location = {ball_location[21:11]-ball_velocity[30:20], ball_location[10:0]-ball_velocity[14:4]};
        end
        else if(ball_angle[16] == 0)
        begin
            if(ball_velocity[15] == 0)    
                new_ball_location = {ball_location[21:11]+ball_velocity[30:20], ball_location[10:0]+ball_velocity[14:4]};
            else
                new_ball_location = {ball_location[21:11]+ball_velocity[30:20], ball_location[10:0]-ball_velocity[14:4]};
        end
    end
end
//传给vga
always @(*) begin
    new_x = new_ball_location[21:11];
    new_y = new_ball_location[10:0];
end

endmodule