module counter (
    input clk,
    input rst_n,
    input activate,  //使能信号, enable signal
    output reg [8:0] cnt_out
);
reg [8:0] cnt;
parameter period = 1'b1;   //计数最大值，即计数周期  maximum of a counter.
initial begin
    cnt = 0;
end

always @(posedge clk) begin
    if(rst_n)
        cnt <= 0;
    else if(activate) begin
        cnt <= cnt+1;
        if(cnt == period - 1)
            cnt <= 0;
    end    
end

always @(*) begin
        cnt_out = cnt;
end
endmodule