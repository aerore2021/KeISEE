module dp_pat (
    input clk,
    input rst_n,
    input Initial_pat,
    input Fetch,
    input Update_pat,
    input [15:0] Code,
    output [21:0] pat_location,
    output reg swing,
    output Clear,
    output Stall
);
wire [1:0] direction;
wire [31:0] pat_velocity, ini_velocity, temp_velocity;
wire [10:0] ini_location, temp_location;
initial_pat ip(.pat_location(ini_location));
mux mux_l(.sw(Initial_pat), .in0(pat_location), .in1(ini_location), .out(temp_location));
decoder de(.Code(Code), .Fetch(Fetch), .direction_x(direction_x), .direction_y(direction_y), .pat_velocity(pat_velocity), .Clear(Clear), .Stall(Stall));
update_pat up(.clk(clk), .rst_n(rst_n), .Update_pat(Update_pat), .pat_velocity(pat_velocity), .pat_location(temp_location),
              .direction_x(direction_x), .direction_y(direction_y), .new_pat_location(pat_location));
always @(*) begin
    if(direction_y == 1)
        swing = 1;
    else swing = 0;
end

endmodule