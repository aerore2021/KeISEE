//小球运动的数据通路 datapath of ball's motion
module dp_motion (
    input Compute_alter,
    input Compute_collide,
    input Initial_ball,
    input Activate_cntr,
    input Value_select,
    input clk_1,
    input clk_24,
    input rst_n,
    input [8:0] cnt,
    input [21:0] pat_location,
    input swing,          //挥拍信号
    output collide,
    output [1:0] edg,
    output reg flag,      //得分信号
    output [10:0] x_vga,
    output [10:0] y_vga,
    output Break,
    output [3:0] score
);
wire [16:0] ball_angle, rand_angle, angle_feedback; 

wire [31:0] ball_velocity, rand_velocity, velocity_feedback; 
wire [21:0] rand_location, ball_location, location_feedback;

//随机产生小球的速度、角度和坐标, randomly derive ball's velocity, angle and location.
dp_rand_ball dprb(.clk_1(clk_1), .rst_n(rst_n), .Initial_ball(Initial_ball), .cnt(cnt), 
                  .ball_angle(rand_angle), .ball_location(rand_location), .ball_velocity(rand_velocity));

//更新小球的速度、角度和坐标  update ball's velocity, angle and location
update_ball ub(.Value_select(Value_select), .location_feedback(location_feedback), .velocity_feedback(velocity_feedback),
               .angle_feedback(angle_feedback), .rand_location(rand_location), .rand_velocity(rand_velocity), .rand_angle(rand_angle),
               .velocity_out(ball_velocity), .location_out(ball_location), .angle_out(ball_angle));

//计算下一时刻小球的坐标   compute next moment's location
alter_location al(.clk(clk_24), .rst_n(rst_n), .Compute_alter(Compute_alter), .ball_location(ball_location), .ball_velocity(ball_velocity),
                  .new_ball_location(location_feedback), .new_x(x_vga), .new_y(y_vga), .ball_angle(ball_angle));

//边缘、碰撞检测 Edge and Collision decetion
Co_Ed_detec ced(.ball_location(ball_location), .ball_velocity(ball_velocity), .pat_location(pat_location), .collide(collide), .edg(edg), .swing(swing));

//计算碰撞后的小球速度、角度 Compute angle and velocity after collision
collision_prcs cp(.Compute_collide(Compute_collide), .rst_n(rst_n), .clk(clk_24), .ball_velocity(ball_velocity), .ball_angle(ball_angle),
                  .new_ball_angle(angle_feedback), .new_ball_velocity(velocity_feedback), .Break(Break));

wire [3:0] score_t;
//分数累加器 score accumlator.
mux mux_scr(.sw(Initial_ball), .in0(score), .in1(4'b0), .out(score_t));
Score scr(.Accum(Compute_collide), .clk(clk_24), .score0(score_t), .score(score));

//得分的原始版本，没有删除。
//原计划得分是在小球反弹后，达到的球桌边缘的位置来判定的。
always @(*) begin
    if(edg == 2'b10)
        flag = 1;  //得分
    else
        flag = 0;  //失分（不计分）
end
endmodule