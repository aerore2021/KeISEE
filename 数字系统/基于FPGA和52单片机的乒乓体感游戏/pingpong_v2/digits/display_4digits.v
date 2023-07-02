`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/30 00:02:57
// Design Name: 
// Module Name: display_4digits
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module display_4digits(
    input clk,      // clock signal
    input rst,      // reset signal
    input [7:0] score,
    output reg [10:0] display_led 
);

reg [1:0] count; // counter
reg [6:0] seg1 = 0; // segment signal
reg [6:0] seg2 = 0;
reg [6:0] seg3 = 0;
reg [6:0] seg4 = 0;
//Attention!!!!!!!!wire cannot be assigned
//reg [3:0] digit_sel; // digits selection
wire clk_2ms;

// 数字对应的段选信号 binary value corresponing to different number
parameter [6:0] word0 = 7'b1111_110;
parameter [6:0] word1 = 7'b0110_000;
parameter [6:0] word2 = 7'b1101_101;
parameter [6:0] word3 = 7'b1111_001;
parameter [6:0] word4 = 7'b0110_011;
parameter [6:0] word5 = 7'b1011_011;
parameter [6:0] word6 = 7'b1011_111;
parameter [6:0] word7 = 7'b1110_000;
parameter [6:0] word8 = 7'b1111_111;
parameter [6:0] word9 = 7'b1111_011;
//////////////////////////////////////////////////////////////////////////////////
//将动态显示的时间改为2ms  change display period into 2ms
clk_div_2ms clk2ms(.clk(clk),.reset(rst),.clk_2ms(clk_2ms));
//segment s1(.hex_display((score % 10)>0?$unsigned(score % 10):4'b0000),.seg(seg1)); // 个位
//segment s2(.hex_display((score / 10) % 10>0?$unsigned((score / 10) % 10):4'b0000),.seg(seg2)); // 十位
//segment s3(.hex_display((score / 100) % 10>0?$unsigned((score / 100) % 10):4'b0000),.seg(seg3)); // 百位
//segment s4($unsigned((score / 1000) % 10),seg4); // 千位
//////////////////////////////////////////////////////////////////////////////////
//对个位进行提取  extract the unit
always@(*)
begin
if($unsigned(score % 10)==0)
seg1 <= word0;
else if($unsigned(score % 10)==1)
seg1 <= word1;
else if($unsigned(score % 10)==2)
seg1 <= word2;
else if($unsigned(score % 10)==3)
seg1 <= word3;
else if($unsigned(score % 10)==4)
seg1 <= word4;
else if($unsigned(score % 10)==5)
seg1 <= word5;
else if($unsigned(score % 10)==6)
seg1 <= word6;
else if($unsigned(score % 10)==7)
seg1 <= word7;
else if($unsigned(score % 10)==8)
seg1 <= word8;
else 
seg1 <= word9;
end
//////////////////////////////////////////////////////////////////////////////////
//对十位进行提取 extract the decade
always@(*)
begin
if($unsigned((score / 10) % 10)==0)
seg2 <= word0;
else if($unsigned((score / 10) % 10)==1)
seg2 <= word1;
else if($unsigned((score / 10) % 10)==2)
seg2 <= word2;
else if($unsigned((score / 10) % 10)==3)
seg2 <= word3;
else if($unsigned((score / 10) % 10)==4)
seg2 <= word4;
else if($unsigned((score / 10) % 10)==5)
seg2 <= word5;
else if($unsigned((score / 10) % 10)==6)
seg2 <= word6;
else if($unsigned((score / 10) % 10)==7)
seg2 <= word7;
else if($unsigned((score / 10) % 10)==8)
seg2 <= word8;
else 
seg2 <= word9;
end
//////////////////////////////////////////////////////////////////////////////////
//对百位进行提取 extract the hundred
always@(*)
begin
if($unsigned((score / 100) % 10)==0)
seg3 <= word0;
else if($unsigned((score / 100) % 10)==1)
seg3 <= word1;
else if($unsigned((score / 100) % 10)==2)
seg3 <= word2;
else if($unsigned((score / 100) % 10)==3)
seg3 <= word3;
else if($unsigned((score / 100) % 10)==4)
seg3 <= word4;
else if($unsigned((score / 100) % 10)==5)
seg3 <= word5;
else if($unsigned((score / 100) % 10)==6)
seg3 <= word6;
else if($unsigned((score / 100) % 10)==7)
seg3 <= word7;
else if($unsigned((score / 100) % 10)==8)
seg3 <= word8;
else 
seg3 <= word9;
end
//////////////////////////////////////////////////////////////////////////////////
//对千位进行提取 extract the thousand
always@(*)
begin
if($unsigned((score / 1000) % 10)==0)
seg4 <= word0;
else if($unsigned((score / 1000) % 10)==1)
seg4 <= word1;
else if($unsigned((score / 1000) % 10)==2)
seg4 <= word2;
else if($unsigned((score / 1000) % 10)==3)
seg4 <= word3;
else if($unsigned((score / 1000) % 10)==4)
seg4 <= word4;
else if($unsigned((score / 1000) % 10)==5)
seg4 <= word5;
else if($unsigned((score / 1000) % 10)==6)
seg4 <= word6;
else if($unsigned((score / 1000) % 10)==7)
seg4 <= word7;
else if($unsigned((score / 1000) % 10)==8)
seg4 <= word8;
else 
seg4 <= word9;
end
//////////////////////////////////////////////////////////////////////////////////
//进行动态显示 dynamic display
always @(posedge clk_2ms or posedge rst) 
    if (rst) begin
        count <= 0;
        display_led <= {4'b1111,7'b0111111};
    end
//////////////////////////////////////////////////////////////////////////////////
//一个轮转周期为8ms period of displaying a number: 8ms 
    else 
        if(count == 0)
        begin
        display_led <= {4'b0001,seg1}; // 个位
        count <= count + 1;
        end
        else if(count == 1)
        begin
        display_led <= {4'b0010,seg2}; // 十位
        count <= count + 1;
        end
        else if(count == 2)
        begin
        display_led <= {4'b0100,seg3}; // 百位
        count <= count + 1;
        end
        else if(count == 3)
        begin
        display_led <= {4'b1000,seg4}; // 千位
        count <= count + 1;
        end
        else
        begin
        count <= 0;
        end


endmodule
