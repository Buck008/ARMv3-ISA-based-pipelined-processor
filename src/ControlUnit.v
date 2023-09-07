module ControlUnit(
    input [31:0]   Instr,
 
    output         MemtoReg,
    output         MemW,
    output         ALUSrc,
    output [1:0]   ImmSrc,
    output         RegW,
    output [1:0]   RegSrc,
    output [1:0]   ALUControl, 
    output [1:0]   FlagW,
    output         PCS
);
    wire ALUOp ;
    wire Branch ;
    //Main Decoder
    MainDecoder u_MainDecoder(
        .Op(Instr[27:26]),
        .Funct_0(Instr[20]),
        .Funct_5(Instr[25]),
        .Branch(Branch),
        .RegW(RegW),
        .MemW(MemW),
        .MemtoReg(MemtoReg),
        .ALUSrc(ALUSrc),
        .ALUOp(ALUOp),
        .ImmSrc(ImmSrc),
        .RegSrc(RegSrc)
    );
    //ALU Decoder
    ALUDecoder u_ALUDecoder(
        .Funct(Instr[24:20]),
        .ALUOp(ALUOp),
        .ALUControl(ALUControl),
        .FlagW(FlagW)
    );
    //PC Logic
    PCLogic u_PCLOgic(
        .Rd(Instr[15:12]),
        .Branch(Branch),
        .RegW(RegW),
        .PCS(PCS)
    );
endmodule