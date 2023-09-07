`define EQ 4'b0000 
`define NE 4'b0001 
`define CS 4'b0010
`define CC 4'b0011
`define MI 4'b0100 
`define PL 4'b0101  
`define VS 4'b0110 
`define VC 4'b0111
`define HI 4'b1000  
`define LS 4'b1001 
`define GE 4'b1010
`define LT 4'b1011 
`define GT 4'b1100
`define LE 4'b1101 
`define AL 4'b1110    

module CondCheck (
    input [3:0] Flags,
    input [3:0] Cond,
    output reg  CondEx 
);
    wire N,Z,C,V;
    assign {N,Z,C,V} = Flags; 

    always @(*) begin
        case (Cond)
            `EQ:CondEx = Z;
            `NE:CondEx = ~Z;
            `CS:CondEx = C;
            `CC:CondEx = ~C;
            `MI:CondEx = N;
            `PL:CondEx = ~N;
            `VS:CondEx = V;
            `VC:CondEx = ~V;
            `HI:CondEx = (~Z)&C;
            `LS:CondEx = Z | (~C);
            `GE:CondEx = ~(N^V);
            `LT:CondEx = N^V;
            `GT:CondEx = (~Z)&(~(N^V));
            `LE:CondEx = Z | (N^V);
            `AL:CondEx = 1'b1;
            default : CondEx=1'bx;
                
        endcase
    end


endmodule //ConditionCheck