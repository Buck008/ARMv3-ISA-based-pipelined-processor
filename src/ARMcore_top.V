module ARMcore_top (
    input CLK,
    input Reset
);

wire [31:0] PCF;

reg [31:0] InstrD;

reg [3:0] WA3E;
reg [31:0] ExtlmmE;
reg PCSE;
reg RegWE;
reg MemWE;
reg [1:0] FlagWE;
reg [1:0] ALUControlE;
reg MemtoRegE;
reg ALUSrcE;
reg [3:0] CondE;
reg [31:0] RD1E;
reg [31:0] RD2E;
reg [3:0] RA1E;
reg [3:0] RA2E;

reg [3:0] WA3M;
reg [31:0] ALUOutM;
reg [31:0] WriteDataM;
reg RegWriteM;
reg MemWriteM;
reg MemtoRegM;
reg [3:0] RA2M;

reg RegWriteW;
reg [3:0] WA3W;
reg MemtoRegW;
reg [31:0] ReadDataW;
reg [31:0] ALUOutW;

wire [31:0] PC_;

wire [31:0] PCPlus4F;
wire [31:0] InstrF;
wire StallF;

wire StallD;
wire FlushD;
wire [1:0] RegSrcD;
wire [3:0] RA1D;
wire [3:0] RA2D;
wire [31:0] RD1D;
wire [31:0] RD2D;
wire [1:0] ImmsrcD;
wire [31:0] ExtlmmD;
wire MemtoRegD;
wire MemWD;
wire ALUSrcD;
wire [1:0] ALUControlD;
wire [1:0] FlagWD;
wire RegWD;
wire PCSD;

wire PCSrcE;
wire [31:0] ALUResultE;
wire FlushE;
wire [31:0] SrcAE;
wire [31:0] SrcBE;
wire [1:0] ForwardAE;
wire [1:0] ForwardBE;
wire [31:0] WriteDataE;
wire [3:0] ALUFlagsE;
wire RegWriteE;
wire MemWriteE;

wire [31:0]WDM;
wire ForwardM;
wire [31:0] ReadDataM;

wire [31:0] ResultW;

assign RA1D = RegSrcD[0] ? 4'd15 : InstrD[19:16];
assign RA2D = RegSrcD[1] ? InstrD[15:12] : InstrD[3:0]; 
assign SrcAE = (ForwardAE == 2'b00) ? RD1E :
               (ForwardAE == 2'b01) ? ResultW :
               (ForwardAE == 2'b10) ? ALUOutM : 32'bx;
assign WriteDataE = (ForwardBE == 2'b00) ? RD2E :
                    (ForwardBE == 2'b01) ? ResultW :
                    (ForwardBE == 2'b10) ? ALUOutM : 32'bx;
assign SrcBE = ALUSrcE ? ExtlmmE : WriteDataE;      
assign WDM = ForwardM ? ResultW : WriteDataM;
assign ResultW = MemtoRegW ? ReadDataW : ALUOutW;

always @(posedge CLK or posedge Reset) begin //F_D寄存器
    if(Reset)
        InstrD<=0;
    else begin
        if(FlushD)
            InstrD<=0;
        else begin
            if(StallD)
                InstrD<=InstrD;
            else
                InstrD<=InstrF; 
        end
    end
end

always @(posedge CLK or posedge Reset) begin //D_E寄存器
    if(Reset) begin
        ExtlmmE<=0;
        WA3E<=0;
        PCSE<=0;
        RegWE<=0;
        MemWE<=0;
        FlagWE<=0;
        ALUControlE<=0;
        MemtoRegE<=0;
        ALUSrcE<=0;
        CondE<=0;
        RD1E<=0;
        RD2E<=0;
        RA1E<=0;
        RA2E<=0;
    end
    else begin
        if(FlushE)begin
            ExtlmmE<=0;
            WA3E<=0;
            PCSE<=0;
            RegWE<=0;
            MemWE<=0;
            FlagWE<=0;
            ALUControlE<=0;
            MemtoRegE<=0;
            ALUSrcE<=0;
            CondE<=0;
            RD1E<=0;
            RD2E<=0;
            RA1E<=0;
            RA2E<=0;
        end
        else begin
            WA3E<=InstrD[15:12];
            ExtlmmE<=ExtlmmD;
            PCSE<=PCSD;
            RegWE<=RegWD;
            MemWE<=MemWD;
            FlagWE<=FlagWD;
            ALUControlE<=ALUControlD;
            MemtoRegE<=MemtoRegD;
            ALUSrcE<=ALUSrcD;
            CondE<=InstrD[31:28];
            RD1E<=RD1D;
            RD2E<=RD2D;
            RA1E<=RA1D;
            RA2E<=RA2D;
        end
    end
    
end

always @(posedge CLK or posedge Reset) begin//E_M寄存器
    if(Reset) begin
        ALUOutM <= 0;
        WA3M<=0;
        WriteDataM<=0;
        RegWriteM<=0;
        MemWriteM<=0;
        MemtoRegM<=0;
        RA2M<=0;
    end
    else begin
        ALUOutM<=ALUResultE;
        WA3M<=WA3E; 
        WriteDataM<=WriteDataE;
        RegWriteM<=RegWriteE;
        MemWriteM<=MemWriteE;
        MemtoRegM<=MemtoRegE;
        RA2M<=RA2E;
    end
end

always @(posedge CLK or posedge Reset) begin//M_W寄存器
    if(Reset)begin
        RegWriteW<=0;
        WA3W<=0;
        MemtoRegW<=0;
        ReadDataW<=0;
        ALUOutW<=0;
    end
    else begin
        RegWriteW<=RegWriteM;
        WA3W<=WA3M;
        MemtoRegW<=MemtoRegM;
        ReadDataW<=ReadDataM;
        ALUOutW<=ALUOutM;
    end
end

Instr_mem u_Instr_mem(
    .PC(PCF),
    .Instr(InstrF)	
);

RegisterFile u_RegisterFile(
    .Reset(Reset),
    .CLK(CLK),
    .WE3(RegWriteW),
    .A1(RA1D),
    .A2(RA2D),
    .A3(WA3W),
    .WD3(ResultW),
    .R15(PCPlus4F),
    .RD1(RD1D),
    .RD2(RD2D)
);

Extend u_Extend(
    .Instrlmm(InstrD[23:0]),
    .Immsrc(ImmsrcD),
    .Extlmm(ExtlmmD)
);

ControlUnit u_ControlUnit(
    .Instr(InstrD),
    .MemtoReg(MemtoRegD),
    .MemW(MemWD),
    .ALUSrc(ALUSrcD),
    .ImmSrc(ImmsrcD),
    .RegW(RegWD),
    .RegSrc(RegSrcD),
    .ALUControl(ALUControlD),
    .FlagW(FlagWD),
    .PCS(PCSD)
);

ALU u_ALU(
    .A(SrcAE),
    .B(SrcBE),
    .ALUControl(ALUControlE),
    .Result(ALUResultE),
    .ALUFlags(ALUFlagsE)
);

ProgramCounter u_ProgramCountr(
    .CLK(CLK),
    .Reset(Reset),
    .PCSrc(PCSrcE),
    .Result(ALUResultE),
    .current_PC(PCF),
    .PC_Plus_4(PCPlus4F),
    .Stall(StallF)
);

CondUnit u_CondUnit(
    .CLK(CLK),
    .PCS(PCSE),
    .RegW(RegWE),
    .MemW(MemWE),
    .FlagW(FlagWE),
    .Cond(CondE),
    .ALUFlags(ALUFlagsE),
    .Reset(Reset),
    .PCSrc(PCSrcE),
    .RegWrite(RegWriteE),
    .MemWrite(MemWriteE)
);

Data_mem u_Data_mem(
    .CLK(CLK),
    .Address(ALUOutM),
    .WE(MemWriteM),    
    .WD(WDM),    
    .ReadData(ReadDataM)
);

HazardUnit u_HazardUnit(
    .RA1D(RA1D),
    .RA2D(RA2D),
    .WA3E(WA3E),
    .MemtoRegE(MemtoRegE),
    .RegWriteE(RegWriteE),
    .PCSrcE(PCSrcE),
    .RA1E(RA1E),
    .RA2E(RA2E),
    .WA3M(WA3M),
    .WA3W(WA3W),
    .RegWriteM(RegWriteM),
    .RegWriteW(RegWriteW),
    .StallF(StallF),
    .StallD(StallD),
    .FlushE(FlushE),
    .FlushD(FlushD),
    .ForwardAE(ForwardAE),
    .ForwardBE(ForwardBE),
    .RA2M(RA2M),
    .ForwardM(ForwardM),
    .MemWriteM(MemWriteM),
    .MemtoRegW(MemtoRegW),
    .RegSrcD_1(RegSrcD[1])
);
endmodule //ARMcore_top