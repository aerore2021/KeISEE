`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/30 19:31:44
// Design Name: 
// Module Name: music_player
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

module music_player(
input	clk,					
output	beep,				//蜂鸣器输出 output of buzzer
output  sd);	
reg	beep_r;	
reg[8:0] state;				//乐谱状态机 state machine of Music Score 
reg[16:0]count,count1;
reg[25:0]count2;  
assign sd=1'b1;         
parameter  //(G大调乐谱参数) note value of G major
                L_1 = 18'd127552,   //低音1 low pitch 1
                L_2 = 18'd113636,	//低音2 low pitch 2
				L_3 = 18'd101236,	//低音3 low pitch 3
				L_4 = 18'd95548,	//低音4 low pitch 4
				L_5 = 18'd85136,	//低音5 low pitch 5
				L_6 = 18'd75838,	//低音6 low pitch 6
				L_7 = 18'd67567,    //低音7 low pitch 7
				M_1 = 18'd63776,	//中音1 middle pitch 1
				M_2 = 18'd56818,    //中音2 middle pitch 2
				M_3 = 18'd50607,	//中音3 middle pitch 3
				M_4 = 18'd47778,    //中音4 middle pitch 4
				M_5 = 18'd42553,    //中音5 middle pitch 5
				M_6 = 18'd37936,    //中音6 middle pitch 6
				M_7 = 18'd33783;    //中音7 middle pitch 7
				
parameter	TIME = 15555555;	//每种音阶持续时长为156ms	each scale lasts for 156ms	 							
assign beep = beep_r;			
always@(posedge clk) begin
	count <= count + 1'b1;		
	if(count == count1) begin	
		count <= 17'h0;			
		beep_r <= !beep_r;		//实际上每个周期分别包括等时长的高电位和低电位，一高一低反复循环，形成不同频率的声音
	end
end

always @(posedge clk) begin
   if(count2 < TIME)            
      count2 = count2 + 1'b1;
   else begin
      count2 = 26'd0;
      if(state == 9'd350) 
         state = 9'd0;
      else
         state = state + 1'b1;
   case(state)//《等你来》曲谱
    8'D0:count1 = M_3;  
	8'D1:count1=M_3;
	8'D2:count1=M_1;
	8'D3:count1=M_1;
	8'D4:count1=M_1;
	8'D5:count1=M_1;
	8'D6:count1=M_1;
	8'D7:count1=M_1;
	8'D8:count1=L_5;
	8'D9:count1=L_5;
	8'D10:count1=M_3;
	8'D11:count1=M_3;
	8'D12:count1=M_2;
	8'D13:count1=M_2;
	8'D14:count1=M_3;
	8'D15:count1=M_4;
	8'D16:count1=M_5;
	8'D17:count1=M_5;
	8'D18:count1=M_4;
	8'D19:count1=M_4;
	8'D20:count1=M_3;
	8'D21:count1=M_3;
	8'D22:count1=M_1;
	8'D23:count1=M_1;
	8'D24:count1=M_1;
	8'D25:count1=M_2;
	8'D26:count1=M_3;
	8'D27:count1=M_2;
	8'D28:count1=L_2;
	8'D29:count1=M_2;
	8'D30:count1=M_2;
	8'D31:count1=M_2;
//////////////////////////////////////////////////////////////////////////////////
    8'D32:count1=M_3;
    8'D33:count1=M_3;
    8'D34:count1=M_1;
    8'D35:count1=M_1;
    8'D36:count1=M_1;
    8'D37:count1=M_1;
    8'D38:count1=M_1;
    8'D39:count1=M_1;
    8'D40:count1=L_5;
    8'D41:count1=L_5;
    8'D42:count1=M_3;
    8'D43:count1=M_3;
    8'D44:count1=M_2;
    8'D45:count1=M_2;
    8'D46:count1=M_3;
    8'D47:count1=M_4;
    8'D48:count1=M_5;
    8'D49:count1=M_5;
    8'D50:count1=M_4;
    8'D51:count1=M_4;
    8'D52:count1=M_3;
    8'D53:count1=M_3;
    8'D54:count1=M_1;
    8'D55:count1=M_1;
    8'D56:count1=M_3;
    8'D57:count1=M_4;
    8'D58:count1=M_6;
    8'D59:count1=M_5;
    8'D60:count1=M_5;
    8'D61:count1=M_5;
    8'D62:count1=M_5;
    8'D63:count1=M_5;
//////////////////////////////////////////////////////////////////////////////////
    8'D64:count1=M_3;
    8'D65:count1=M_3;
    8'D66:count1=M_1;
    8'D67:count1=M_1;
    8'D68:count1=M_1;
    8'D69:count1=M_1;
    8'D70:count1=M_1;
    8'D71:count1=M_1;
    8'D72:count1=L_5;
    8'D73:count1=L_5;
    8'D74:count1=M_3;
    8'D75:count1=M_3;
    8'D76:count1=M_2;
    8'D77:count1=M_3;
    8'D78:count1=M_3;
    8'D79:count1=M_4;
    8'D80:count1=M_5;
    8'D81:count1=M_5;
    8'D82:count1=M_4;
    8'D83:count1=M_4;
    8'D84:count1=M_3;
    8'D85:count1=M_3;
    8'D86:count1=M_1;
    8'D87:count1=M_1;
    8'D88:count1=M_1;
    8'D89:count1=L_5;
    8'D90:count1=L_5;
    8'D91:count1=M_3;
    8'D92:count1=M_3;
    8'D93:count1=M_3;
    8'D94:count1=M_3;
    8'D95:count1=M_3;
//////////////////////////////////////////////////////////////////////////////////
    8'D96:count1=M_3;
    8'D97:count1=M_3;
    8'D98:count1=M_1;
    8'D99:count1=M_1;
    8'D100:count1=M_1;
    8'D101:count1=M_1;
    8'D102:count1=M_1;
    8'D103:count1=M_1;
    8'D104:count1=L_5;
    8'D105:count1=M_3;
    8'D106:count1=M_3;
    8'D107:count1=M_2;
    8'D108:count1=0;
    8'D109:count1=M_3;
    8'D110:count1=M_3;
    8'D111:count1=M_4;
    8'D112:count1=M_5;
    8'D113:count1=M_5;
    8'D114:count1=M_4;
    8'D115:count1=M_3;
    8'D116:count1=0;
    8'D117:count1=M_1;
    8'D118:count1=M_1;
    8'D119:count1=M_1;
    8'D120:count1=M_4;
    8'D121:count1=M_4;
    8'D122:count1=0;
    8'D123:count1=M_3;
    8'D124:count1=M_3;
    8'D125:count1=M_3;
    8'D126:count1=M_2;
    8'D127:count1=M_1;
    8'D128:count1=M_1;
    8'D129:count1=M_1;
    8'D130:count1=M_1;
    8'D131:count1=M_1;
    8'D132:count1=M_1;
    8'D133:count1=M_1;
    8'D134:count1=M_1;
    8'D135:count1=M_1;
    8'D136:count1=M_1;
    8'D137:count1=M_1;
    8'D138:count1=M_1;
    8'D139:count1=M_1;
    8'D140:count1=M_1;
    8'D141:count1=M_1;
    8'D142:count1=M_1;
    8'D143:count1=M_1;
//////////////////////////////////////////////////////////////////////////////////
    8'D144:count1=M_1;
    8'D145:count1=M_1;
    8'D146:count1=L_7;
    8'D147:count1=M_1;
    8'D148:count1=M_1;
    8'D149:count1=M_1;
    8'D150:count1=0;
    8'D151:count1=0;
    8'D152:count1=0;
    8'D153:count1=L_5;
    8'D154:count1=M_1;
    8'D155:count1=M_2;
    8'D156:count1=M_3;
    8'D157:count1=M_2;
    8'D158:count1=M_1;
    8'D159:count1=L_7;
    8'D160:count1=M_1;
    8'D161:count1=L_7;
    8'D162:count1=M_1;
    8'D163:count1=M_3;
    8'D164:count1=0;
    8'D165:count1=L_6;
    8'D166:count1=L_6;
    8'D167:count1=L_6;
    8'D168:count1=0;
    8'D169:count1=M_1;
    8'D170:count1=L_7;
    8'D171:count1=M_1;
    8'D172:count1=M_2;
    8'D173:count1=M_1;
    8'D174:count1=L_7;
    8'D175:count1=L_6;
    8'D176:count1=L_7;
    8'D177:count1=M_2;
    8'D178:count1=M_2;
    8'D179:count1=L_5;
    8'D180:count1=L_5;
    8'D181:count1=L_5;
    8'D182:count1=0;
    8'D183:count1=L_5;
//////////////////////////////////////////////////////////////////////////////////
    8'D184:count1=L_7;
    8'D185:count1=L_7;
    8'D186:count1=M_1;
    8'D187:count1=M_1;
    8'D188:count1=0;
    8'D189:count1=0;
    8'D190:count1=0;
    8'D191:count1=L_6;
    8'D192:count1=L_5;
    8'D193:count1=L_7;
    8'D194:count1=L_7;
    8'D195:count1=M_1;
    8'D196:count1=M_1;
    8'D197:count1=M_1;
    8'D198:count1=0;
    8'D199:count1=M_3;
    8'D200:count1=M_4;
    8'D201:count1=M_4;
    8'D202:count1=M_3;
    8'D203:count1=M_2;
    8'D204:count1=M_2;
    8'D205:count1=M_1;
    8'D206:count1=0;
    8'D207:count1=M_1;
    8'D208:count1=M_3;
    8'D209:count1=M_4;
    8'D210:count1=M_4;
    8'D211:count1=M_2;
    8'D212:count1=M_2;
    8'D213:count1=M_2;
    8'D214:count1=M_2;
    8'D215:count1=M_2;
//////////////////////////////////////////////////////////////////////////////////
    8'D216:count1=M_1;
    8'D217:count1=M_1;
    8'D218:count1=L_7;
    8'D219:count1=M_1;
    8'D220:count1=M_1;
    8'D221:count1=M_1;
    8'D222:count1=0;
    8'D223:count1=0;
    8'D224:count1=0;
    8'D225:count1=L_5;
    8'D226:count1=M_1;
    8'D227:count1=M_2;
    8'D228:count1=M_3;
    8'D229:count1=M_2;
    8'D230:count1=M_1;
    8'D231:count1=L_7;
    8'D232:count1=M_1;
    8'D233:count1=L_7;
    8'D234:count1=M_1;
    8'D235:count1=M_3;
    8'D236:count1=0;
    8'D237:count1=L_6;
    8'D238:count1=L_6;
    8'D239:count1=L_6;
    8'D240:count1=0;
    8'D241:count1=M_1;
    8'D242:count1=L_7;
    8'D243:count1=M_1;
    8'D244:count1=M_2;
    8'D245:count1=M_1;
    8'D246:count1=L_7;
    8'D247:count1=L_6;
    8'D248:count1=L_7;
    8'D249:count1=M_2;
    8'D250:count1=M_2;
    8'D251:count1=L_5;
    8'D252:count1=L_5;
    8'D253:count1=L_5;
    8'D254:count1=0;
    8'D255:count1=L_5;
//////////////////////////////////////////////////////////////////////////////////
    9'D256: count1 = L_7;
    9'D257: count1 = L_7;
    9'D258: count1 = M_1;
    9'D259: count1 = M_1;
    9'D260: count1 = 0;
    9'D261: count1 = 0;
    9'D262: count1 = 0;
    9'D263: count1 = M_3;
    9'D264: count1 = M_4;
    9'D265: count1 = M_5;
    9'D266: count1 = M_5;
    9'D267: count1 = M_1;
    9'D268: count1 = M_1;
    9'D269: count1 = M_1;
    9'D270: count1 = M_2;
    9'D271: count1 = M_3;
    9'D272: count1 = M_4;
    9'D273: count1 = M_4;
    9'D274: count1 = M_3;
    9'D275: count1 = M_3;
    9'D276: count1 = M_2;
    9'D277: count1 = M_1;
    9'D278: count1 = 0;
    9'D279: count1 = M_3;
    9'D280: count1 = M_3;
    9'D281: count1 = M_4;
    9'D282: count1 = M_4;
    9'D283: count1 = M_2;
    9'D284: count1 = M_2;
    9'D285: count1 = M_2;
    9'D286: count1 = M_2;
    9'D287: count1 = M_2;
//////////////////////////////////////////////////////////////////////////////////
    9'D288: count1 = L_7;
    9'D289: count1 = L_7;
    9'D290: count1 = 0;
    9'D291: count1 = M_1;
    9'D292: count1 = M_1;
    9'D293: count1 = L_5;
    9'D294: count1 = L_5;
    9'D295: count1 = L_5;
    9'D296: count1 = M_5;
    9'D297: count1 = M_5;
    9'D298: count1 = 0;
    9'D299: count1 = M_5;
    9'D300: count1 = M_5;
    9'D301: count1 = M_4;
    9'D302: count1 = M_3;
    9'D303: count1 = M_4;
    9'D304: count1 = M_5;
    9'D305: count1 = M_5;
    9'D306: count1 = M_1;
    9'D307: count1 = M_1;
    9'D308: count1 = 0;
    9'D309: count1 = L_5;
    9'D310: count1 = L_5;
    9'D311: count1 = M_3;
    9'D312: count1 = M_3;
    9'D313: count1 = M_3;
    9'D314: count1 = M_3;
    9'D315: count1 = M_3;
    9'D316: count1 = M_3;
    9'D317: count1 = M_3;
    9'D318: count1 = M_3;
    9'D319: count1 = M_3;
    9'D320: count1 = M_3;
    9'D321: count1 = M_3;
    9'D322: count1 = M_3;
    9'D323: count1 = M_3;
    9'D324: count1 = M_3;
    9'D325: count1 = M_3;
    9'D326: count1 = M_3;
    9'D327: count1 = M_3;
//////////////////////////////////////////////////////////////////////////////////
    9'D328: count1 = L_7;
    9'D329: count1 = L_7;
    9'D330: count1 = 0;
    9'D331: count1 = M_1;
    9'D332: count1 = M_1;
    9'D333: count1 = L_5;
    9'D334: count1 = L_5;
    9'D335: count1 = L_5;
    9'D336: count1 = M_3;
    9'D337: count1 = M_3;
    9'D338: count1 = 0;
    9'D339: count1 = M_3;
    9'D340: count1 = M_4;
    9'D341: count1 = M_3;
    9'D342: count1 = M_2;
    9'D343: count1 = M_1;
    9'D344: count1 = M_2;
    9'D345: count1 = M_2;
    9'D346: count1 = M_1;
    9'D347: count1 = M_1;
    9'D348: count1 = 0;
    9'D349: count1 = L_5;
    9'D350: count1 = L_5;
    9'D351: count1 = M_2;
    9'D352: count1 = M_2;
    9'D353: count1 = M_2;
    9'D354: count1 = M_2;
    9'D355: count1 = M_2;
    9'D356: count1 = M_2;
    9'D357: count1 = M_2;
    9'D358: count1 = M_2;
    9'D359: count1 = M_2;
    9'D360: count1 = M_2;
    9'D361: count1 = M_2;
    9'D362: count1 = M_2;
    9'D363: count1 = M_2;
    9'D364: count1 = M_2;
    9'D365: count1 = M_2;
    9'D366: count1 = M_2;
    9'D367: count1 = M_2;
    
   default: count1 = 16'h0;
   endcase
   end
end
endmodule
