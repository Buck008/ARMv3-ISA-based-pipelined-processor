module PCLogic (
    input [3:0] Rd,
    input       Branch,
    input       RegW,

    output      PCS
);

assign PCS = ((Rd == 15) & RegW) | Branch;

endmodule //PCLogic