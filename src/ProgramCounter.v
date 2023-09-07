module ProgramCounter (
    input               CLK,
    input               Reset,
    input               PCSrc,
    input [31:0]        Result,
    input               Stall,

    output reg [31:0]   current_PC,
    output [31:0]       PC_Plus_4 
    
);

    wire [31:0] next_PC;

    assign next_PC = PCSrc ? Result : PC_Plus_4;

    always @(posedge CLK) begin
        if(Reset)
            current_PC <= 32'b0;
        else if(Stall)
            current_PC<=current_PC;
        else
            current_PC <= next_PC;
    end

    assign PC_Plus_4 = current_PC + 32'd4;
endmodule //ProgramCounter
