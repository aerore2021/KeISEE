module random_ball (
    input en,
    input [8:0] cnt,
    output reg [21:0] ball_location,
    output reg [15:0] ball_velocity,  
    output reg [16:0] ball_angle
);

//数据格式 data format
//velocity：                    signed 12Q4
//coordinations:                unsigned 22       
//angle(scaled radians, -1~1):  signed 3Q13
//sin and cos:                  signed 2Q14

parameter N = 183;
parameter X = 675;
//reg [7:0] n;
reg [9:0] x;   
reg [12:0] a;
reg [12:0] n;
reg [2:0] t;
always @(*) begin
    if(en)
    begin
    //这只是一个非常基础的随机算法。
    //range of radians: 感觉法，没计算
    n = cnt % N;
    t = cnt % 5;
    a = 915 - N*t; //1225
    x = 395;
    if(t == 1 || t == 0)
        ball_angle = {1'b0, 3'b0, a};
    else
        // /x = 50 - n; 4'b1000
        ball_angle = {1'b1, 3'b0, a};
    
    ball_location = {x, 11'b0000_0110010};
    ball_velocity = 16'b0_000_0010_0100_0000;
    end
end

endmodule