module TOP (
    input code,
    input clk,
    input rst_n,
    input start,
    output flag,
    output hsync, 
    output vsync,
    output [11:0] color,
    output [10:0] display_led,
    output beep,
    output sd
);
wire [10:0] x_vga, y_vga;
wire [21:0] pat_location;
reg [21:0] fake_location;
wire Break, swing;
//reg [21:0] pat_location;

//initial begin
    //pat_location = {11'b00011001000, 11'b10001001100};
//end
//���ܻ���clk������
initial begin
    fake_location = 22'b001_1000_1011_100_0100_1100;
end
TOP_MOTION TM(.swing(swing), .pat_location(fake_location), .clk(clk), .rst_n(rst_n), .start(start), .flag(flag), .x_vga(x_vga), .y_vga(y_vga), .Break(Break),.score(score));
Movetest mt(.clk(clk), .reset(rst_n), .xball(y_vga), .yball(x_vga), .hsync(hsync), .vsync(vsync), .color(color), .ypat(11'b001_1000_1011), .xpat(pat_location[10:0]));
TOP_PAT TP(.clk(clk), .rst_n(rst_n), .start(start), .Break(Break), .pat_location(pat_location), .swing(swing), .code(code));
display_4digits ds(.clk(clk), .rst(rst_n), .score(score), .display_led(display_led));
music_player mp(.clk(clk), .beep(beep), .sd(sd));


endmodule