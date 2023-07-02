//小球运动的顶层模块
module TOP_MOTION (
    input start,
    input clk,
    input rst_n,
    input swing,
    input Clear,
    input Stall,
    input [21:0] pat_location,
    output flag,
    output [10:0] x_vga,
    output [10:0] y_vga,
    output Break,
    output [3:0] score
);
wire collide; wire [1:0] edg;   //反馈信号
wire Initial_ball, Value_select, Compute_alter, Compute_collide, Halt; //控制字
wire clk_1, clk_24;
wire [8:0] cnt;                 //计数
parameter period = 9'b1111_11111;//计数周期，即计数最大值

//为了配合vga的显示，把时钟周期（主频）先放大了25000倍，再根据所需得到24倍分频时钟
clk_did #(.N(25000)) cd_10MS(.clk(clk), .rst_n(rst_n), .oclk(clk_1));
clk_did cd_24(.clk(clk_1), .rst_n(rst_n), .oclk(clk_24));

//小球运动的状态机
FSM_motion fm(.clk(clk_24), .rst_n(rst_n), .start(start), .collide(collide), .edg(edg), .Break(Break), 
              .Initial_ball(Initial_ball), .Value_select(Value_select), .Compute_alter(Compute_alter),
              .Compute_collide(Compute_collide), .Halt(Halt));
//随机算法需要的计数器              
counter #(.period(period)) cntr(.clk(clk), .rst_n(rst_n), .cnt_out(cnt), .activate(Halt));

//小球运动的数据通路
dp_motion dm(.Compute_alter(Compute_alter), .Compute_collide(Compute_collide), .Initial_ball(Initial_ball), .swing(swing), 
             .Activate_cntr(Halt), .Value_select(Value_select), .clk_1(clk_1), .clk_24(clk_24), .rst_n(rst_n), .Break(Break),
             .collide(collide), .edg(edg), .flag(flag), .x_vga(x_vga), .y_vga(y_vga), .pat_location(pat_location), .cnt(cnt),.score(score));

endmodule