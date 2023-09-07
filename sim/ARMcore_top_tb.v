`timescale 1ns/1ps

module ARMcore_top_tb();
reg CLK;
reg Reset;

initial begin
    CLK = 1'b0;
    forever #10 CLK = ~ CLK;
end

initial begin
    #0 Reset =1'b1;
    #25 Reset = 1'b0;
    #5500;
    $stop;
end

ARMcore_top ARMcore0(
    .CLK(CLK),
    .Reset(Reset) 
);

endmodule