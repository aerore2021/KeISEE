`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/26 13:49:45
// Design Name: 
// Module Name: owner
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

//�˶δ�����ֻ��Ϊ�˲����ڲ��ı�����Ի����Ӱ���ã����ڿ���ֱ������Screen���������ǲ�����ˣ��ͻ��ǰ���ԭ������
module owner(clk,reset,hsync,vsync,xball,yball,xpat,ypat,color);
    input clk,reset;
    input [10:0] xball,yball,xpat,ypat;
    output hsync,vsync;
    output [11:0] color;
//////////////////////////////////////////////////////////////////////////////////
//    reg [10:0] xball,yball,xpat,ypat;//��ʱΪ���ڲ������ã�����ֻ������¼
//    always@(*)
//    begin
//    xball <= 11'd400;
//    yball <= 11'd395;
   
//    parameter xball = 300;
//    parameter yball = 395; 
    
//    xpat <= 11'd1100;
//    ypat <= 11'd495;
//    end
//////////////////////////////////////////////////////////////////////////////////
    Screen pingpong(.clk(clk),.reset(reset),.hsync(hsync),.vsync(vsync),.xball(xball),.yball(yball),.xpat(xpat),.ypat(ypat),.colors(color));
endmodule
