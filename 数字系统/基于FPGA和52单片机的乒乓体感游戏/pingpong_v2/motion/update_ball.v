module update_ball (
    input Value_select, 
    input [21:0] location_feedback,
    input [31:0] velocity_feedback,
    input [16:0] angle_feedback,
    input [16:0] rand_angle,
    input [21:0] rand_location,
    input [31:0] rand_velocity,
    output [31:0] velocity_out,
    output [21:0] location_out,
    output [16:0] angle_out
);
mux mux_v(.sw(Value_select), .in0(rand_velocity), .in1(velocity_feedback), .out(velocity_out));
mux mux_l(.sw(Value_select), .in0(rand_location), .in1(location_feedback), .out(location_out));
mux mux_a(.sw(Value_select), .in0(rand_angle), .in1(angle_feedback), .out(angle_out));
endmodule