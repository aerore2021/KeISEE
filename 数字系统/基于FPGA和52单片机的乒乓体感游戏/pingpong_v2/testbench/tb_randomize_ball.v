//~ `New testbench
`timescale  1ns / 1ps

module tb_random_ball;

// random_ball Parameters
parameter PERIOD = 10 ;
parameter N  = 183;

reg clk;
reg rst_n;

// random_ball Inputs
reg   en                                   = 0 ;
reg   [8:0]  cnt                           = 0 ;

// random_ball Outputs
wire  [21:0]  ball_location                ;
wire  [15:0]  ball_velocity                ;
wire  [15:0]  ball_angle                   ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end


random_ball #(
    .N ( N ))
 u_random_ball (
    .en                      ( en                    ),
    .cnt                     ( cnt            [8:0]  ),

    .ball_location           ( ball_location  [21:0] ),
    .ball_velocity           ( ball_velocity  [15:0] ),
    .ball_angle              ( ball_angle     [15:0] )
);

initial
begin
    en = 1;
    #10 
    cnt = 9'b1_1101_0101;

    #30
    cnt = 9'b1_1111_0101;
    $finish;
    $finish;
end

endmodule
