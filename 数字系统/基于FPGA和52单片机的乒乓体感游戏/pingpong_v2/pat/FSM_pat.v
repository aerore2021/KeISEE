module FSM_pat (
    input clk,
    input rst_n,
    input start, 
    input Break,
    output reg Initial_pat,
    output reg Fetch,
    output reg Update_pat,
    output reg Halt
);
parameter INITIAL_PAT     = 0; parameter FETCH               = 1;
parameter UPDATE_LOCATION = 2; parameter WAIT_FOR_NEXT_GAME  = 3; 

reg [1:0] state, state_next;

//state shift
always @(posedge clk) begin
    if(rst_n)
        state = WAIT_FOR_NEXT_GAME;
    else
        state = state_next;
end

//next state logic
always @(*) begin
    case (state)
        INITIAL_PAT: state_next = FETCH;
        FETCH:begin
            if(Break) state_next = WAIT_FOR_NEXT_GAME;
            else state_next = UPDATE_LOCATION;
        end 
        UPDATE_LOCATION: state_next = FETCH;
        WAIT_FOR_NEXT_GAME:begin
            if(start) state_next = INITIAL_PAT;
            else state_next = WAIT_FOR_NEXT_GAME;
        end
    endcase
end

//response
always @(*) begin
    case (state)
        INITIAL_PAT: begin
        Initial_pat = 1; Fetch = 0;
        Update_pat  = 0; Halt  = 0;
        end
        FETCH:begin
        Initial_pat = 0; Fetch = 1;
        Update_pat  = 0; Halt  = 0;
        end
        UPDATE_LOCATION:begin
        Initial_pat = 0; Fetch = 0;
        Update_pat  = 1; Halt  = 0;
        end
        WAIT_FOR_NEXT_GAME:begin
        Initial_pat = 0; Fetch = 0;
        Update_pat  = 0; Halt  = 1;
        end
    endcase
end
endmodule