//~ `New testbench
`timescale  1ns / 1ps

module tb_dp_motion;

// dp_motion Parameters
parameter PERIOD  = 10;


// dp_motion Inputs
reg   Compute_alter                        = 0 ;
reg   Compute_collide                      = 0 ;
reg   Initial_ball                         = 0 ;
reg   Activate_cntr                        = 0 ;
reg   Value_select                         = 0 ;
reg   clk_1                                = 0 ;
reg   clk_24                               = 0 ;
reg   rst_n                                = 0 ;
reg   [21:0]  pat_location                 = 0 ;

// dp_motion Outputs
wire  collide                              ;
wire  [1:0]  edg                           ;
wire  flag                                 ;
wire  [10:0]  x_vga                        ;
wire  [10:0]  y_vga                        ;


initial
begin
    forever #(PERIOD/2)  clk_1=~clk_1;
end


dp_motion  u_dp_motion (
    .Compute_alter           ( Compute_alter           ),
    .Compute_collide         ( Compute_collide         ),
    .Initial_ball            ( Initial_ball            ),
    .Activate_cntr           ( Activate_cntr           ),
    .Value_select            ( Value_select            ),
    .clk_1                   ( clk_1                   ),
    .clk_24                  ( clk_24                  ),
    .rst_n                   ( rst_n                   ),
    .pat_location            ( pat_location     [21:0] ),

    .collide                 ( collide                 ),
    .edg                     ( edg              [1:0]  ),
    .flag                    ( flag                    ),
    .x_vga                   ( x_vga            [10:0] ),
    .y_vga                   ( y_vga            [10:0] )
);

initial
begin
    rst_n = 1;
    #10
    rst_n = 0;  
    Compute_alter     = 0 ;
    Compute_collide   = 0 ;
    Initial_ball      = 0 ;
    Activate_cntr     = 1 ;
    Value_select      = 0 ;
    #110 clk_24 = 1;
    #120 
    clk_24  = 0;
    #120
    clk_24  = 1;
    #120
    clk_24 = 0;
    #20
    //Initial
    Compute_alter     = 0 ;
    Compute_collide   = 0 ;
    Initial_ball      = 1 ;
    Activate_cntr     = 0 ;
    Value_select      = 0 ;
    #10 //Update1
    Compute_alter     = 0 ;
    Compute_collide   = 0 ;
    Initial_ball      = 0 ;
    Activate_cntr     = 0 ;
    Value_select      = 0 ;
    #10 //Alter1
    Compute_alter     = 1 ;
    Compute_collide   = 0 ;
    Initial_ball      = 0 ;
    Activate_cntr     = 0 ;
    Value_select      = 0 ;
    #10 //Collide prcs
    Compute_alter     = 0 ;
    Compute_collide   = 0 ;
    Initial_ball      = 0 ;
    Activate_cntr     = 0 ;
    Value_select      = 1 ;
    #10 //Update2
    Compute_alter     = 0 ;
    Compute_collide   = 0 ;
    Initial_ball      = 0 ;
    Activate_cntr     = 0 ;
    Value_select      = 1 ;
    #10 //Alter2
    Compute_alter     = 1 ;
    Compute_collide   = 0 ;
    Initial_ball      = 0 ;
    Activate_cntr     = 0 ;
    Value_select      = 1 ;
    #10 //Collide prcs
    Compute_alter     = 0 ;
    Compute_collide   = 0 ;
    Initial_ball      = 0 ;
    Activate_cntr     = 0 ;
    Value_select      = 1 ;
    #10 //Update2
    Compute_alter     = 0 ;
    Compute_collide   = 0 ;
    Initial_ball      = 0 ;
    Activate_cntr     = 0 ;
    Value_select      = 1 ;
    #10 //Alter2
    Compute_alter     = 1 ;
    Compute_collide   = 0 ;
    Initial_ball      = 0 ;
    Activate_cntr     = 0 ;
    Value_select      = 1 ;
    #10 //Collide prcs
    Compute_alter     = 0 ;
    Compute_collide   = 0 ;
    Initial_ball      = 0 ;
    Activate_cntr     = 0 ;
    Value_select      = 1 ;
    #10 //Update2
    clk_24 = 1;
    Compute_alter     = 0 ;
    Compute_collide   = 0 ;
    Initial_ball      = 0 ;
    Activate_cntr     = 0 ;
    Value_select      = 1 ;
    #10 //Alter2
    Compute_alter     = 1 ;
    Compute_collide   = 0 ;
    Initial_ball      = 0 ;
    Activate_cntr     = 0 ;
    Value_select      = 1 ;
    #10 //Collide prcs
    Compute_alter     = 0 ;
    Compute_collide   = 0 ;
    Initial_ball      = 0 ;
    Activate_cntr     = 0 ;
    Value_select      = 1 ;
    #10 //Update2
    Compute_alter     = 0 ;
    Compute_collide   = 0 ;
    Initial_ball      = 0 ;
    Activate_cntr     = 0 ;
    Value_select      = 1 ;
    #10 //Alter2
    Compute_alter     = 1 ;
    Compute_collide   = 0 ;
    Initial_ball      = 0 ;
    Activate_cntr     = 0 ;
    Value_select      = 1 ;
    #10 //Collide prcs
    Compute_alter     = 0 ;
    Compute_collide   = 0 ;
    Initial_ball      = 0 ;
    Activate_cntr     = 0 ;
    Value_select      = 1 ;
    #10 //Update2
    Compute_alter     = 0 ;
    Compute_collide   = 0 ;
    Initial_ball      = 0 ;
    Activate_cntr     = 0 ;
    Value_select      = 1 ;
    #10 //Alter2
    Compute_alter     = 1 ;
    Compute_collide   = 0 ;
    Initial_ball      = 0 ;
    Activate_cntr     = 0 ;
    Value_select      = 1 ;
    #10 //Collide prcs
    Compute_alter     = 0 ;
    Compute_collide   = 0 ;
    Initial_ball      = 0 ;
    Activate_cntr     = 0 ;
    Value_select      = 1 ;
    #10 //Update2
    Compute_alter     = 0 ;
    Compute_collide   = 0 ;
    Initial_ball      = 0 ;
    Activate_cntr     = 0 ;
    Value_select      = 1 ;
    #10 //Alter2
    Compute_alter     = 1 ;
    Compute_collide   = 0 ;
    Initial_ball      = 0 ;
    Activate_cntr     = 0 ;
    Value_select      = 1 ;
    #10 //Collide prcs
    Compute_alter     = 0 ;
    Compute_collide   = 0 ;
    Initial_ball      = 0 ;
    Activate_cntr     = 0 ;
    Value_select      = 1 ;
    #10 //Update2
    Compute_alter     = 0 ;
    Compute_collide   = 0 ;
    Initial_ball      = 0 ;
    Activate_cntr     = 0 ;
    Value_select      = 1 ;
    #10 //Alter2
    Compute_alter     = 1 ;
    Compute_collide   = 0 ;
    Initial_ball      = 0 ;
    Activate_cntr     = 0 ;
    Value_select      = 1 ;
    #10 //Collide prcs
    Compute_alter     = 0 ;
    Compute_collide   = 0 ;
    Initial_ball      = 0 ;
    Activate_cntr     = 0 ;
    Value_select      = 1 ;
    #10 //Update2
    Compute_alter     = 0 ;
    Compute_collide   = 0 ;
    Initial_ball      = 0 ;
    Activate_cntr     = 0 ;
    Value_select      = 1 ;
    #10 //Alter2
    Compute_alter     = 1 ;
    Compute_collide   = 0 ;
    Initial_ball      = 0 ;
    Activate_cntr     = 0 ;
    Value_select      = 1 ;
    #10 //Collide prcs
    Compute_alter     = 0 ;
    Compute_collide   = 0 ;
    Initial_ball      = 0 ;
    Activate_cntr     = 0 ;
    Value_select      = 1 ;
    #10 //Update2
    Compute_alter     = 0 ;
    Compute_collide   = 0 ;
    Initial_ball      = 0 ;
    Activate_cntr     = 0 ;
    Value_select      = 1 ;
    #10 //Alter2
    Compute_alter     = 1 ;
    Compute_collide   = 0 ;
    Initial_ball      = 0 ;
    Activate_cntr     = 0 ;
    Value_select      = 1 ;
    #10 //Collide prcs
    Compute_alter     = 0 ;
    Compute_collide   = 0 ;
    Initial_ball      = 0 ;
    Activate_cntr     = 0 ;
    Value_select      = 1 ;
    #10 //Update2
    Compute_alter     = 0 ;
    Compute_collide   = 0 ;
    Initial_ball      = 0 ;
    Activate_cntr     = 0 ;
    Value_select      = 1 ;
    #10 //Alter2
    Compute_alter     = 1 ;
    Compute_collide   = 0 ;
    Initial_ball      = 0 ;
    Activate_cntr     = 0 ;
    Value_select      = 1 ;
    #10 //Collide prcs
    Compute_alter     = 0 ;
    Compute_collide   = 0 ;
    Initial_ball      = 0 ;
    Activate_cntr     = 0 ;
    Value_select      = 1 ;
    #10 //Update2
    Compute_alter     = 0 ;
    Compute_collide   = 0 ;
    Initial_ball      = 0 ;
    Activate_cntr     = 0 ;
    Value_select      = 1 ;
    #10 //Alter2
    Compute_alter     = 1 ;
    Compute_collide   = 0 ;
    Initial_ball      = 0 ;
    Activate_cntr     = 0 ;
    Value_select      = 1 ;
    #10 //Collide prcs
    Compute_alter     = 0 ;
    Compute_collide   = 0 ;
    Initial_ball      = 0 ;
    Activate_cntr     = 0 ;
    Value_select      = 1 ;
    #10 //Update2
    Compute_alter     = 0 ;
    Compute_collide   = 0 ;
    Initial_ball      = 0 ;
    Activate_cntr     = 0 ;
    Value_select      = 1 ;
    #10 //Alter2
    Compute_alter     = 1 ;
    Compute_collide   = 0 ;
    Initial_ball      = 0 ;
    Activate_cntr     = 0 ;
    Value_select      = 1 ;
    #10 //Collide prcs
    Compute_alter     = 0 ;
    Compute_collide   = 0 ;
    Initial_ball      = 0 ;
    Activate_cntr     = 0 ;
    Value_select      = 1 ;
    #10 //Update2
    Compute_alter     = 0 ;
    Compute_collide   = 0 ;
    Initial_ball      = 0 ;
    Activate_cntr     = 0 ;
    Value_select      = 1 ;
    #10 //Alter2
    Compute_alter     = 1 ;
    Compute_collide   = 0 ;
    Initial_ball      = 0 ;
    Activate_cntr     = 0 ;
    Value_select      = 1 ;
    
    $finish;
end

endmodule
