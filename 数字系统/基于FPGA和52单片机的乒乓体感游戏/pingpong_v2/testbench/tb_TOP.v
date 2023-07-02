//~ `New testbench
`timescale  1ns / 1ps

module tb_TOP;

// TOP Parameters
parameter PERIOD  = 10;



// TOP Inputs
reg   clk                                  = 0 ;
reg   rst_n                                = 0 ;
reg   start                                = 0 ;

// TOP Outputs
wire  flag                                 ;
wire  hsync                                ;
wire  vsync                                ;
wire  [11:0]  color                        ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end


TOP  u_TOP (
    .clk                     ( clk           ),
    .rst_n                   ( rst_n         ),
    .start                   ( start         ),

    .flag                    ( flag          ),
    .hsync                   ( hsync         ),
    .vsync                   ( vsync         ),
    .color                   ( color  [11:0] )
);

initial
begin
    rst_n = 1;
    #10
    rst_n = 0;
    #50
    start = 1;
    $finish;
end

endmodule
