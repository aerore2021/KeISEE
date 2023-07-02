// 根据Initial_ball，随机获得小球的初始信息，再把速度分解为v_x + v_y
// According to signal Initial_ball, randomly derive ball's original information, and seperate velocity into x/y coordinations. 
module dp_rand_ball (
    input clk_1,
    input rst_n,
    input Initial_ball,
    input [8:0] cnt,
    output [31:0] ball_velocity,
    output [21:0] ball_location,
    output [16:0] ball_angle
);
//数据格式 data format 是原先最稳妥的设计，后来时间紧张把angle的格式改了。 
//velocity：                    signed 12Q4
//coordinations:                unsigned 22       
//angle(scaled radians, -1~1):  signed 3Q13   
//sin and cos:                  signed 2Q14


wire [15:0] ball_velocity_0;
random_ball rand(.en(Initial_ball), .cnt(cnt), .ball_velocity(ball_velocity_0), .ball_location(ball_location), .ball_angle(ball_angle));
//速度分解需要21个时钟周期，这里采用24倍分频 velocity processing need 21 periods, here we use 24x divider.
velocity_prcs prcs(.clk(clk_1), .ball_velocity(ball_velocity_0), .ball_angle(ball_angle), .ball_velocity_modified(ball_velocity));

endmodule