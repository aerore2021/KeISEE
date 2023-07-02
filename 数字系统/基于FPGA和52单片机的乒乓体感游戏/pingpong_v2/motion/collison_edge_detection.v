module Co_Ed_detec (
    input [21:0] ball_location,
    input [31:0] ball_velocity,
    input [21:0] pat_location,
    input swing,  //挥拍信号
    output reg collide,
    output reg [1:0] edg
);
parameter ball_radius = 20; parameter pat_radius = 60;
//Edge detection 球桌边缘检测
always @(*) begin
    if(ball_location[21:11] <= 1 || ball_location[21:11] > 790)
    begin
        if(ball_location[10:0] > 640)
            edg = 2'b01;
        else
            edg = 2'b10;
    end
    else if(ball_location[10:0] > 1280)
        edg = 2'b01;
    else if(ball_location[10:0] <= 1 && ball_velocity[15] == 1)
        edg = 2'b10;
    else
        edg = 2'b0;
end

//Collide detection 碰撞检测
reg [10:0] distance_x, distance_y, distance_r;
reg [22:0] distance, distance_rsqure; 
always @(*) begin
    if(swing)begin //如果挥拍了，判定距离是否在碰撞范围内，如果在，collide = 1.
        distance_x = ball_location[21:11]-pat_location[21:11];
        distance_y = ball_location[10:0]-pat_location[10:0];
        distance = distance_x*distance_x + distance_y*distance_y;
        distance_r = ball_radius + pat_radius;
        distance_rsqure = distance_r*distance_r;
        if(distance_rsqure > distance)
            collide = 1;
        else
            collide = 0;
    end
    
end

endmodule