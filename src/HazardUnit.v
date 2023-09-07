module HazardUnit (
    input [3:0]      RA1D,
    input [3:0]      RA2D,
    input [3:0]      WA3E,
    input            MemtoRegE,
    input            RegWriteE,
    input            PCSrcE,
    input [3:0]      RA1E,
    input [3:0]      RA2E,
    input [3:0]      RA2M,
    input [3:0]      WA3M,
    input [3:0]      WA3W,
    input            RegWriteM,
    input            RegWriteW,
    input            MemWriteM,
    input            MemtoRegW,
    input            RegSrcD_1,

    output           StallF,
    output           StallD,
    output           FlushE,
    output           FlushD,
    output reg [1:0] ForwardAE,
    output reg [1:0] ForwardBE,
    output           ForwardM 
);

wire Match_12D_E;
wire ldrstall;
wire Match_1E_M;
wire Match_2E_M;
wire Match_1E_W;
wire Match_2E_W;

assign ForwardM = (RA2M == WA3W) & MemWriteM & MemtoRegW & RegWriteW;
assign Match_1E_W = (RA1E == WA3W);
assign Match_2E_W = (RA2E == WA3W);
assign Match_1E_M = (RA1E == WA3M);
assign Match_2E_M = (RA2E == WA3M);
assign Match_12D_E = (RA1D == WA3E) || (RA2D == WA3E);
assign ldrstall = Match_12D_E & MemtoRegE & RegWriteE & (~RegSrcD_1);
assign StallF = ldrstall;
assign StallD = ldrstall;
assign FlushE = ldrstall || PCSrcE;
assign FlushD = PCSrcE;

always @(*) begin
    if (Match_1E_M & RegWriteM) ForwardAE = 10;
    else if (Match_1E_W & RegWriteW) ForwardAE = 01;
    else ForwardAE = 00;
end

always @(*) begin
    if (Match_2E_M & RegWriteM) ForwardBE = 10;
    else if (Match_2E_W & RegWriteW) ForwardBE = 01;
    else ForwardBE = 00;
end

endmodule //HazardUnit