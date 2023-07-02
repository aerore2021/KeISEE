//默认24倍分频  24x divider by default
module clk_did (
    input clk,
    input rst_n,
    output reg oclk
);
    
parameter N = 24;
reg [31:0] cnt;

initial begin
    cnt = 0;
    oclk = 0;
end

always @(posedge clk) begin
    if(rst_n)
    begin
        cnt <= 0;
        oclk <= 0;           
    end
    else if(cnt == N/2 - 1)
    begin
        oclk <= ~oclk;
        cnt <= 0;
    end
    else cnt <= cnt + 1'b1;
end

endmodule