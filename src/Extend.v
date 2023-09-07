module Extend (
    input       [23:0]   Instrlmm,
    input       [1:0]    Immsrc,
    output reg  [31:0]   Extlmm 
);

    always @(*) begin
        if(Immsrc == 2'b00) 
            Extlmm = {{24{1'b0}},Instrlmm[7:0]};
        else if(Immsrc == 2'b01)
            Extlmm = {{20{1'b0}},Instrlmm[11:0]};
        else if(Immsrc == 2'b10)
            Extlmm = {{6{Instrlmm[23]}},Instrlmm,{2{1'b0}}};
        else
            Extlmm = 32'hxxxxxxxx;
    end

endmodule //Extend