module collision_prcs (
    input Compute_collide,
    input clk,
    input rst_n,
    input [31:0] ball_velocity,
    input [16:0] ball_angle,
    output reg [31:0] new_ball_velocity,
    output reg [16:0] new_ball_angle,
    output reg Break  //
);

initial begin
    Break = 0;
end

always @(posedge clk) begin
    if(Compute_collide)
    begin
        //new_ball_velocity = {ball_velocity[31:16], 1'b1, ball_velocity[14:0]};
        //这只是个最简单版本的碰撞，按照我的预想小球会原路返回，再给我点时间其实能做到类似动量定理的碰撞（因为信号都给齐了，就写写算法了）
        //不过既然结课了我也懒得搞了。 有点可惜，但项目毕竟不是我一个人的，大家都累了，还是好好休息吧，不死磕了。
        new_ball_velocity = 32'b0; //停止不动
        Break = 1;
    end
    else 
    begin
        //collide=0，留存原来的信息，起寄存器的功能
        new_ball_angle = ball_angle;
        new_ball_velocity = ball_velocity;
        Break = 0;
    end
end

endmodule