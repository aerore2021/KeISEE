//使用了Xilinx Vivado的cordic IP core 和 muliplier IP core


module velocity_prcs (
    input clk,
    input [15:0] ball_velocity,
    input [16:0] ball_angle,
    output [31:0] ball_velocity_modified
);

wire [31:0] sin_and_cos;
wire [31:0] vx, vy;

//latency = 20 period
cordic_0 sin_cos (
  .aclk(clk),                          // input wire aclk
  .s_axis_phase_tvalid(1),             // input wire s_axis_phase_tvalid
  .s_axis_phase_tdata(ball_angle[15:0]),     // input wire [15 : 0] s_axis_phase_tdata
  .m_axis_dout_tdata(sin_and_cos)      // output wire [31 : 0] m_axis_dout_tdata
);

//lanteny = 1 period
mult_gen_0 get_new_vx (
  .CLK(clk),                // input wire CLK
  .A(ball_velocity),        // input wire [15 : 0] A  signed
  .B(sin_and_cos[31:16]),   // input wire [15 : 0] B  signed sin
  .P(vx)                    // output wire [31 : 0] P
);

mult_gen_0 get_new_vy (
  .CLK(clk),                // input wire CLK
  .A(ball_velocity),        // input wire [15 : 0] A  signed
  .B(sin_and_cos[15:0]),    // input wire [15 : 0] B  signed cos
  .P(vy)                    // output wire [31 : 0] P
);

assign ball_velocity_modified = {vx[31:16], vy[31:16]};

endmodule