module ALU(
input [31:0]        A,
input [31:0]        B,
input [1:0]         ALUControl,
output reg [31:0]   Result,
output [3:0]        ALUFlags
);
    wire Cin, Cout;
    wire [31:0] Sum;
    wire [31:0] temp_B;

    wire V;
    wire C;
    wire N;
    wire Z;

    wire [31:0] Or;
    wire [31:0] And;

    assign ALUFlags = {N,Z,C,V};
    assign Cin = ALUControl[0];

    assign temp_B = ALUControl[0]? ~B:B;
    assign {Cout,Sum} = A + temp_B + Cin;

    assign V = (~(A[31]^B[31]^ALUControl[0]))&
               (A[31]^Sum[31])&
               (~ALUControl[1]);
    assign C = (~ALUControl[1]) & Cout;
    assign N = Result[31];
    assign Z = &(~Result);

    assign Or = A | B;
    assign And = A & B;

    always @(*) begin
        case (ALUControl)
            2'b11: Result = Or;
            2'b10: Result = And;
            2'b01: Result = Sum;
            2'b00: Result = Sum;
            default :Result = 32'bx;
        endcase
    end
endmodule