//处理从单片机得到的信号
module Code_prcs (
    input code,
    input clk,
    output reg [31:0] Code
);
reg [63:0] t;
reg [7:0] cnt;

initial begin
    cnt = 4'b0;
end

always @(posedge clk) begin
    if(cnt<48)begin
        t[cnt] = code;
        cnt = cnt+1;
    end
    else begin
        t[23:16] = t[23:16] - 30;
        t[15:8]  = t[15:8]  - 30;
        t[47:40] = t[47:40] - 30;
        t[39:32] = t[39:32] - 30;
        Code = {t[23:8], t[47:32]};
        cnt = 0;
    end
end

endmodule