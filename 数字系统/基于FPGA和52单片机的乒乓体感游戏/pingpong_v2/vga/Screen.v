`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/26 13:51:25
// Design Name: 
// Module Name: Screen
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

/*��ʾģ�飬������õ���if-else��䣬�����ӿ���ͨ�����ص������С�����ƻ�ͼ��
���������﷨�и��ô������ǿ���ǿ��ͼ����Ⱥ�˳���Ȼ��Ƶ����ȼ��ߣ�����Ƶ����ȼ��ͣ���������ͼ�㸲�ǵ�Ч����
��������ȼ��Ļ��Ƶ�����ֻ�õ��������Ⱥ󼴿ɣ��ǳ�����*/
module Screen(clk,reset,hsync,vsync,xball,yball,xpat,ypat,colors);
    input clk,reset;
    input [10:0]xball,yball,xpat,ypat;
    output hsync,vsync;
    output reg [11:0]colors;
    reg [2:0]color;
    wire [10:0]hcnt,vcnt;
//    begin 
//    xball = 11'b300;
//    yball = 11'b395;
//    end
//    parameter xball = 300;
//    parameter yball = 395; 
    parameter rball = 20;
//    begin 
//    xpat = 11'b1100;
//    ypat = 11'b395;
//    end
//    parameter xpat = 1100;
//    parameter ypat = 395;
    parameter r = 60;
//////////////////////////////////////////////////////////////////////////////////
//VGAģ��������ã���Ϊˢ���ʺͷֱ����Ѿ������ˣ������Ҫ�ı���棬ֱ���ڲ��������ɣ������
   vga VGA(clk,reset,hsync,vsync,hcnt,vcnt);
//////////////////////////////////////////////////////////////////////////////////
    always@(posedge clk)begin
//////////////////////////////////////////////////////////////////////////////////
//���׵�RGB����ɫ������Ч�����ã���˷�������ɾ�ɲ�ɾ
        colors[8]=color[2];//red
        colors[4]=color[1];//green
        colors[0]=color[0];//blue
//////////////////////////////////////////////////////////////////////////////////
//���ȼ�1����Ļ���
        if((hcnt-xball)*(hcnt-xball)+(vcnt-yball)*(vcnt-yball)<=rball*rball)
            colors=12'b1111_1000_0000;
        else if((hcnt-xball)*(hcnt-xball)+(vcnt-yball)*(vcnt-yball)<=(rball+2)*(rball+2))
            colors=12'b1111_1111_1111;
//////////////////////////////////////////////////////////////////////////////////     
//���ȼ�2�����ӵĻ���       
        else if((hcnt-xpat)*(hcnt-xpat)+(vcnt-ypat)*(vcnt-ypat)<=r*r)
            colors=12'b1111_0000_0000;
        else if((hcnt-xpat<=11'd110&&hcnt-xpat>=11'd50)&&((vcnt-ypat)*(vcnt-ypat)<=20*20))
            colors=12'b0000_1111_0000;
        else if(
        ((hcnt-xpat)*(hcnt-xpat)+(vcnt-ypat)*(vcnt-ypat)>r*r&&(hcnt-xpat)*(hcnt-xpat)+(vcnt-ypat)*(vcnt-ypat)<=(r+5)*(r+5))||
        ((hcnt-xpat<=11'd115&&hcnt-xpat>=11'd50)&&((vcnt-ypat)*(vcnt-ypat)<=25*25))
        )
        colors=12'b1111_1111_1111;
//////////////////////////////////////////////////////////////////////////////////
//���ȼ�3���ڱ߿�Ļ���
        else if(vcnt>=11'd740||vcnt<=11'd50||(hcnt>=11'd0&&hcnt<=11'd50)||(hcnt>=11'd1230&&hcnt<=11'd1280))
            colors=12'b0000_0000_0000;
//////////////////////////////////////////////////////////////////////////////////
//���ȼ�4�������Ļ���
        else if(
        ((hcnt>=11'd58&&hcnt<=11'd118))&&((vcnt>=11'd345&&vcnt<=11'd445))
        )
            colors = 12'b1111_1111_0000;
//////////////////////////////////////////////////////////////////////////////////
//���ȼ�5������������ɫ����
        else if(
        ((hcnt>=11'd58&&hcnt<=11'd524)||(hcnt>=11'd644&&hcnt<=11'd1222))&&((vcnt>=11'd58&&vcnt<=11'd400)||(vcnt>=11'd401&&vcnt<=11'd732))
        )
            colors = 12'b0000_0000_1111;
//////////////////////////////////////////////////////////////////////////////////
//���ȼ�6���м�����Ļ���
        else if(
        (
        (hcnt>=11'd51&&hcnt<=11'd57)||
        (hcnt>=11'd525&&hcnt<=11'd531)||
        (hcnt>=11'd637&&hcnt<=11'd643)||
        (hcnt>=11'd562&&hcnt<=11'd569)||
        (hcnt>=11'd599&&hcnt<=11'd606)||
        (hcnt>=11'd1223&&hcnt<=11'd1229)
        )
        )
            colors = 12'b1111_1111_0000;
        else if(
        (
            (vcnt>=11'd51&&vcnt<=11'd57)||
            (vcnt>=11'd137&&vcnt<=11'd143)||
            (vcnt>=11'd223&&vcnt<=11'd229)||
            (vcnt>=11'd309&&vcnt<=11'd315)||
            (vcnt>=11'd395&&vcnt<=11'd401)||
            (vcnt>=11'd481&&vcnt<=11'd487)||
            (vcnt>=11'd567&&vcnt<=11'd573)||
            (vcnt>=11'd653&&vcnt<=11'd659)||
            (vcnt>=11'd733&&vcnt<=11'd739)
                )
        )
        colors = 12'b1111_1111_0000;
        else
            colors = 12'b0000_0000_1111;
////////////////////////////////////////////////////////////////////////////////

    end
endmodule
