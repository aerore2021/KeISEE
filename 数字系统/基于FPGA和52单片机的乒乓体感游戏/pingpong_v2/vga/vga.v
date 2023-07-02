`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/26 13:46:05
// Design Name: 
// Module Name: vga
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


module vga(clk,reset,hsync,vsync,hcnt,vcnt);
    input clk,reset;
    output reg hsync,vsync;
    output reg[10:0]hcnt,vcnt;
    
    always@(posedge clk)begin
        if(reset)begin
            hcnt<=0;vcnt<=0;
        end
        else begin
            if(hcnt>=11'd1679&&vcnt>=11'd827)begin
                hcnt<=0;vcnt<=0;
            end
            else if(hcnt>=11'd1679)begin
                hcnt<=0;vcnt<=vcnt+1'b1;
            end
            else
                hcnt<=hcnt+1'b1;
        end
    end
    
    always@*begin
        if(hcnt>=11'd1344&&hcnt<=11'd1479)hsync=0;
        else hsync=1'b1;
        if(vcnt>=11'd801&&vcnt<=11'd802)vsync=0;
        else vsync=1'b1;
    end
endmodule
