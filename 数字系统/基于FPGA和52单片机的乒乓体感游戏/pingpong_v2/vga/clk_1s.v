`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/26 23:49:12
// Design Name: 
// Module Name: clk_1s
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

//并不是一定是1s，可以通过改变delay的值来改变整个刷新率
module clk_1s(
    input clk,
    input reset,
    output reg clk_1s
    );
    reg[100:0] count = 0;
    parameter delay=2500000;
    always@(posedge clk or posedge reset)
    begin
    if(reset) begin
    count <= 0;
    clk_1s <= 0;
    end
    else if(count==delay) begin
    clk_1s <= ~clk_1s;
    count <= 0;
    end
    else if(count<delay) begin
    count <= count+1;
    end
    end
endmodule
