module Score (
    input Accum,
    input clk,
    input [3:0] score0,
    output reg [3:0] score
);
always @(posedge clk) begin
    if(Accum)
        score = score0+1;
    else score = score;
end
endmodule