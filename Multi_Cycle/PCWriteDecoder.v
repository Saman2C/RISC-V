`define BEQ 3'b000
`define BNE 3'b001
`define BLT 3'b100
`define BGE 3'b101


module pcwrite_decoder(PCUpdate, branch, funct3, zero, PCWrite);

    input PCUpdate, branch, zero;
	input [2:0] funct3;
    output PCWrite;

    assign PCWrite = PCUpdate | ( branch & ((funct3 == `BNE | funct3 == `BLT) ^ zero) );

endmodule