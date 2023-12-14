module ALUCoder (
    input R_type, I_type, LUI,
    input [2:0] func3,
    input func7,
    output reg [3:0] ALUCode
);
always @(*) begin
    if((R_type==1 && I_type==0 && LUI==0)||(R_type==0 && I_type==1 && LUI==0))begin
        if(func3==3'o0 && (R_type==1 && I_type==0))
            ALUCode= (func7==1'b0)?4'd0:4'd1;
        else if(func3==3'o0 && (R_type==0 && I_type==1))
            ALUCode= 4'd0;
        else if(func3==3'o1)
            ALUCode= 4'd6;
        else if(func3==3'o2)
            ALUCode= 4'd9;
        else if(func3==3'o3)
            ALUCode= 4'd10;
        else if(func3==3'o4)
            ALUCode= 4'd4;
        else if(func3==3'o5)
            ALUCode= (func7==1'b0)?4'd7:4'd8;
        else if(func3==3'o6)
            ALUCode= 4'd5;
        else if(func3==3'o7)
            ALUCode= 4'd3;
    end
    else if(R_type==0 && I_type==0 && LUI==1)
            ALUCode= 4'd0;
end
endmodule