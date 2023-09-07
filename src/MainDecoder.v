module MainDecoder (
    input [1:0]      Op,
    input            Funct_0,
    input            Funct_5,

    output reg       Branch,
    output reg       RegW,
    output reg       MemW,
    output reg       MemtoReg,
    output reg       ALUSrc,
    output reg       ALUOp, 
    output reg [1:0] ImmSrc,
    output reg [1:0] RegSrc
);



always @(*) begin
    casex ({Op,Funct_5,Funct_0})
        4'b000x:begin
            Branch = 0;MemtoReg = 0;MemW = 0;ALUSrc = 0;ImmSrc = 2'bxx ;RegW=1;RegSrc = 0; ALUOp = 1;
        end
        4'b001x: begin
            Branch =0;MemtoReg =0;MemW = 0;ALUSrc = 1;ImmSrc = 0;RegW = 1;RegSrc = 2'b00; ALUOp =1;
        end
        4'b01x0:begin
            Branch =0;MemtoReg =1'bx;MemW = 1;ALUSrc = 1;ImmSrc = 1;RegW = 0;RegSrc = 2'b10; ALUOp =0;
        end
        4'b01x1:begin
            Branch =0;MemtoReg =1;MemW = 0;ALUSrc = 1;ImmSrc = 1;RegW = 1;RegSrc = 2'bx0; ALUOp =0;
        end
        4'b10xx:begin
            Branch =1;MemtoReg =0;MemW = 0;ALUSrc = 1;ImmSrc = 2'b10;RegW = 0;RegSrc = 2'bx1; ALUOp =0;
        end
        default: begin
            Branch = 1'bx;MemtoReg = 1'bx;MemW = 1'bx;ALUSrc = 1'bx;ImmSrc = 2'bxx ;RegW=1'bx;RegSrc = 2'bxx; ALUOp = 1'bx;
        end
        
    endcase
end

endmodule //MainDecoder