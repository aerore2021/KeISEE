//~ `New testbench
`timescale  1ns / 1ps

module tb_clk_did;

// clk_did Parameters
parameter PERIOD = 10;
parameter N  = 24;

// clk_did Inputs
reg   clk                                  = 0 ;
reg   rst_n                                = 0 ;

// clk_did Outputs
wire  oclk                                 ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*200) rst_n  =  1;
end

clk_did #(
    .N ( N ))
 u_clk_did (
    .clk                     ( clk     ),
    .rst_n                   ( rst_n   ),

    .oclk                    ( oclk    )
);

initial
begin
    rst_n = 1;
    #10
    rst_n = 0;
    $finish;
end

endmodule
