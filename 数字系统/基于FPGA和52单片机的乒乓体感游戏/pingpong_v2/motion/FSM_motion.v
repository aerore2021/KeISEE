module FSM_motion (
    input collide,
    input [1:0] edg,
    input Break,
    input start, //游戏开始的信号
    input clk,
    input rst_n,
    output reg Initial_ball,
    output reg Value_select,
    output reg Compute_alter,
    output reg Compute_collide,
    output reg Halt
);

parameter INITIAL     = 0; parameter UPDATE1     = 1;
parameter ALTER_COOR1 = 2; parameter ALTER_COOR2 = 3; 
parameter COLLIDE_PRCS= 4; parameter UPDATE2     = 5; 
parameter WAIT_FOR_NEXT_GAME = 6;
reg [2:0] state, state_next;

//初始状态为等待游戏
initial begin
    state = WAIT_FOR_NEXT_GAME;
end

//next state logic
always @(*) begin
    case (state)
        INITIAL: state_next = UPDATE1;
        UPDATE1: state_next = ALTER_COOR1;      
        ALTER_COOR1: begin
            state_next = COLLIDE_PRCS; 
        end
        COLLIDE_PRCS: state_next = UPDATE2;
        UPDATE2:begin
            if(Break == 0) state_next = ALTER_COOR2;
            else state_next = WAIT_FOR_NEXT_GAME;
        end
        ALTER_COOR2: begin
            if(edg) state_next = WAIT_FOR_NEXT_GAME;
            else state_next = COLLIDE_PRCS;
        end
        WAIT_FOR_NEXT_GAME: begin
            if(start) state_next = INITIAL;
            else state_next = WAIT_FOR_NEXT_GAME;
        end
    endcase
end

//state shift
always @(posedge clk) begin
    if(rst_n) state = WAIT_FOR_NEXT_GAME;
    else state = state_next;
end

//corresponding
always @(*) begin
    case (state)
        INITIAL:begin
            Initial_ball   = 1; Value_select    = 0;
            Compute_alter  = 0; Compute_collide = 0;
            Halt           = 0; 
        end
        UPDATE1:begin
            Initial_ball   = 0; Value_select    = 0;
            Compute_alter  = 0; Compute_collide = 0;
            Halt           = 0; 
        end
        ALTER_COOR1:begin
            Initial_ball   = 0; Value_select    = 0;
            Compute_alter  = 1; Compute_collide = 0;
            Halt           = 0; 
        end
        ALTER_COOR2:begin
            Initial_ball   = 0; Value_select    = 1;
            Compute_alter  = 1; Compute_collide = 0;
            Halt           = 0; 
        end
        COLLIDE_PRCS:begin
            Initial_ball   = 0; Value_select    = 1;
            Compute_alter  = 0; 
            if(collide) Compute_collide = 1;
            else Compute_collide = 0;
            Halt           = 0; 
        end
        UPDATE2:begin
            Initial_ball   = 0; Value_select    = 1;
            Compute_alter  = 0; Compute_collide = 0;
            Halt           = 0; 
        end
        WAIT_FOR_NEXT_GAME:begin
            Initial_ball   = 0; Value_select    = 1;
            Compute_alter  = 0; Compute_collide = 0;
            Halt           = 1; 
        end
    endcase
end

endmodule