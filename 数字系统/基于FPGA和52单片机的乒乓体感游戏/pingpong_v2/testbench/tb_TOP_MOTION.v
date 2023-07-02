//~ `New testbench
`timescale  1ns / 1ps

module tb_TOP_MOTION;

// TOP_MOTION Parameters
parameter PERIOD  = 10;

// TOP_MOTION Inputs
reg   start                                = 0 ;
reg   clk                                  = 0 ;
reg   rst_n                                = 0 ;
reg   [21:0]  pat_location                 = 0 ;

// TOP_MOTION Outputs
wire  flag                                 ;
wire  [10:0]  x_vga                        ;
wire  [10:0]  y_vga                        ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

TOP_MOTION  u_TOP_MOTION (
    .start                   ( start                ),
    .clk                     ( clk                  ),
    .rst_n                   ( rst_n                ),
    .pat_location            ( pat_location  [21:0] ),

    .flag                    ( flag                 ),
    .x_vga                   ( x_vga         [10:0] ),
    .y_vga                   ( y_vga         [10:0] )
);

initial
begin
    pat_location = 22'b00011001000_10001001100;
    #200
    start = 1;

    $finish;
end

endmodule
