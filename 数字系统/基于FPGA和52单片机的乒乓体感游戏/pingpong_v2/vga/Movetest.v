`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/26 23:51:00
// Design Name: 
// Module Name: Movetest
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


module Movetest(
    input clk,reset,
    //input [7:0] xball,//???????????
    //input [7:0] ypat,//???????????
    input [10:0] xball,
    input [10:0] ypat,
    input [10:0] yball,
    input [10:0] xpat,
    output hsync,vsync,
    output [11:0] color,
    output reg led
   // output wire pwm
    );
    //????????i???????????????
    reg [10:0] yballi,xpati;
    reg [10:0] xballi,ypati;//???????????
    wire clk1s;
    reg leds;
    //wire pwms;
    clk_1s c1(.clk(clk),.clk_1s(clk1s));
    initial
    begin
    xballi <= xball;
    //xballi <= {3'b000,xball};//???????????????????
    //xball1 <= 50;//??????????????
    yballi <= yball;
    //yball1 <= yball;
    xpati <= xpat;
    //ypat1 <= 50;//??????????????
    //ypati = {3'b000,ypat};//???????????????????
    ypati = ypat;//??????
    leds <= 0;//?????????????
    end
    always@(posedge clk1s or posedge reset)
    if(reset||clk1s)
    begin
    //xballi <= {3'b000,xball};
    xballi <= xball;
    //xball1 <= 50;//??????????????
    yballi <= yball;
     //yball1 <= yball;
    xpati <= xpat;
    //ypati <= {3'b000,ypat};
    //ypati <= 50;//??????????????
    ypati = ypat;//??????
    leds <= ~leds;
    end
//////////////////////////////////////////////////////// 
//????????????????   
//    else if(xball1>=600||ypat1>=600)
//    begin
//    xball1 <= 0;
//    ypat1 <= 0;
//    end
//    else
//    begin
//    xball1 <= xball1+1;
//    ypat1 <= ypat1+1;
//    leds <= ~leds;
//    led <= leds;
//    end
////////////////////////////////////////////////////////////
    owner o(.clk(clk),.reset(reset),.hsync(hsync),.vsync(vsync),.xball(xballi),.yball(yballi),.xpat(xpati),.ypat(ypati),.color(color));
    //music1 mm(.clk(clk),.reset(reset),.pwmh(pwms));//?????????????????????????????????
    //assign pwm = pwms;
    
endmodule
