module initial_pat (
    output reg [21:0] pat_location
);
always @(*) begin
        pat_location = 22'b001_1000_1011_100_0100_1100;
end
endmodule