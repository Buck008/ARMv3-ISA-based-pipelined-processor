module ALUDecoder (
    input [4:0]      Funct,
    input            ALUOp,
    output reg [1:0] ALUControl,
    output reg [1:0] FlagW
);
    always @(*) begin
        casex ({ALUOp,Funct})
            6'b0xxxxx:begin
                ALUControl = 2'b00; FlagW = 2'b00;
            end
            6'b101000:begin
                ALUControl = 2'b00; FlagW = 2'b00;
            end
            6'b101001:begin
                ALUControl = 2'b00; FlagW = 2'b11;
            end
            6'b100100:begin
                ALUControl = 2'b01; FlagW = 2'b00;
            end
            6'b100101:begin
                ALUControl = 2'b01; FlagW = 2'b11;
            end
            6'b100000:begin
                ALUControl = 2'b10; FlagW = 2'b00;
            end
            6'b100001:begin
                ALUControl = 2'b10; FlagW = 2'b10;
            end
            6'b111000:begin
                ALUControl = 2'b11; FlagW = 2'b00;
            end
            6'b111001:begin
                ALUControl = 2'b11; FlagW = 2'b10;
            end
            default:begin
                ALUControl = 2'bxx; FlagW = 2'bxx;
            end
        endcase
    
    end
endmodule //ALUOp