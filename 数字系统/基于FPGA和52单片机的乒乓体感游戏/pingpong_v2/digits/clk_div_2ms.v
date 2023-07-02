`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/29 23:50:35
// Design Name: 
// Module Name: clk_div_2ms
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


module clk_div_2ms(
    input clk,
    input reset,
    output reg clk_2ms
    );
    reg[100:0] count = 0;
    parameter delay=200000;
    always@(posedge clk or posedge reset)
    begin
    if(reset) begin
    count <= 0;
    clk_2ms <= 0;
    end
    else if(count==delay) begin
    clk_2ms <= ~clk_2ms;
    count <= 0;
    end
    else if(count<delay) begin
    count <= count+1;
    end
    end
endmodule
