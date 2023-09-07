module CondUnit(
    input       CLK,
    input       PCS,
    input       RegW,
    input       MemW,
    input [1:0] FlagW,
    input [3:0] Cond,
    input [3:0] ALUFlags,
    input       Reset,

    output      PCSrc,
    output      RegWrite,
    output      MemWrite
    );

    wire [1:0] FlagWrite;
    wire CondEx ;
    reg N = 1'b0, Z = 1'b0, C = 1'b0, V = 1'b0 ;

    CondCheck u_CondCheck(
        .Flags({N,Z,C,V}),
        .Cond(Cond),
        .CondEx(CondEx)
    );

    assign FlagWrite = FlagW & {2{CondEx}};
    assign PCSrc = PCS & CondEx;
    assign RegWrite = RegW & CondEx;
    assign MemWrite = MemW & CondEx;

    always @(posedge CLK or posedge Reset) begin
        if(Reset) begin
            N<=0;
            Z<=0;
        end
        else begin
            if(FlagWrite[1])begin
                N<=ALUFlags[3];
                Z<=ALUFlags[2];
            end
            else begin
                N<=N;
                Z<=Z; 
            end
        end           
    end

    always @(posedge CLK or posedge Reset) begin
        if(Reset)begin
            C<=0;
            V<=0;
        end
        else begin
            if(FlagWrite[0])begin
                C<=ALUFlags[1];
                V<=ALUFlags[0];
            end
            else begin
                C<=C;
                V<=V; 
            end 
        end              
    end     
endmodule













