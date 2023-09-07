module RegisterFile (
    input               CLK,//input Reset,//high active
    input               WE3,  //high active
    input [3:0]         A1, //Read index1
    input [3:0]         A2, //Read index2
    input [3:0]         A3, //Write index 
    input [31:0]        WD3,//Write data
    input [31:0]        R15, //R15 Data in
    input               Reset,

    output reg [31:0]   RD1, // Read data1
    output reg [31:0]   RD2  //Read data2
);

    reg [31:0] RegBankCore [0:14];
    integer  i;

    always @(negedge CLK or posedge Reset) begin
        if(Reset) begin
                for(i=0;i<=14;i=i+1)begin
                    RegBankCore[i]<=0;
                end
        end
        else begin
            if(WE3)
                RegBankCore[A3] <= WD3;
            else
                RegBankCore[A3] <=RegBankCore[A3]; 
        end
    end

    always @(*) begin
        if(A1==32'd15)
            RD1=R15;
        else
            RD1=RegBankCore[A1];
    end

     always @(*) begin
        if(A2==32'd15)
            RD2=R15;
        else
            RD2=RegBankCore[A2];
    end

endmodule //RegiterFile

