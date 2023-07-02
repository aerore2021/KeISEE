//~ `New testbench
`timescale  1ns / 1ps

module tb_velocity_prcs;

// velocity_prcs Parameters
parameter PERIOD  = 10;


reg rst_n = 0;

// velocity_prcs Inputs
reg   clk                                  = 0 ;
reg   [15:0]  ball_velocity                = 0 ;
reg   [15:0]  ball_angle                   = 0 ;

// velocity_prcs Outputs
wire  [31:0]  ball_velocity_modified       ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*200) rst_n  =  1;
end

velocity_prcs  u_velocity_prcs (
    .clk                     ( clk                            ),
    .ball_velocity           ( ball_velocity           [15:0] ),
    .ball_angle              ( ball_angle              [15:0] ),

    .ball_velocity_modified  ( ball_velocity_modified  [31:0] )
);

initial
begin
    
    rst_n = 1;
    #10 
    rst_n  =0; 
    ball_velocity = 16'b0_00000001111_0000; //v0 = 15
    ball_angle = 16'b0;      //vx = 0, vy = 15

    #210
    ball_angle = 16'b00_00010_1010_1010_1; //30度

    #210
    ball_angle = 16'b00_00101_0101_0101_0; //60度
    $finish;
end

endmodule
//~ `New testbench
`timescale  1ns / 1ps

module tb_velocity_prcs;

// velocity_prcs Parameters
parameter PERIOD  = 10;


reg clk;
reg rst_n;

// velocity_prcs Inputs
reg   clk                                  = 0 ;
reg   [15:0]  ball_velocity                = 0 ;
reg   [15:0]  ball_angle                   = 0 ;

// velocity_prcs Outputs
wire  [31:0]  ball_velocity_modified       ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rst_n  =  1;
end

velocity_prcs  u_velocity_prcs (
    .clk                     ( clk                            ),
    .ball_velocity           ( ball_velocity           [15:0] ),
    .ball_angle              ( ball_angle              [15:0] ),

    .ball_velocity_modified  ( ball_velocity_modified  [31:0] )
);

initial
begin

    $finish;
end

endmodule
