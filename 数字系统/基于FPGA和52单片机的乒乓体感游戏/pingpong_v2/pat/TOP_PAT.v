module TOP_PAT (
    input clk,
    input rst_n, 
    input start,
    input Break,
    input code,
    output [21:0] pat_location,
    output swing,
    output Clear,
    output Stall
);
wire Initial_pat, Fetch, Update_pat, Halt;
wire [15:0] Code;
wire clk_1, clk_24, clk_bit;
clk_did #(.N(25000)) cd_10MS(.clk(clk), .rst_n(rst_n), .oclk(clk_1));
clk_did cd_24(.clk(clk_1), .rst_n(rst_n), .oclk(clk_24));
clk_div_2ms #(.delay(104000)) Clk_bit(.clk(clk), .reset(rst_n), .clk_2ms(clk_bit));
Code_prcs cp(.clk(clk_bit), .code(code), .Code(Code));
dp_pat dp(.clk(clk_24), .rst_n(rst_n), .Initial_pat(Initial_pat), .Fetch(Fetch), .Update_pat(Update_pat), .Code(Code), .pat_location(pat_location), .swing(swing), .Clear(Clear), .Stall(Stall));
FSM_pat fp(.clk(clk_24), .rst_n(rst_n), .start(start), .Break(Break), .Initial_pat(Initial_pat), .Fetch(Fetch), .Update_pat(Update_pat), .Halt(Halt));

endmodule