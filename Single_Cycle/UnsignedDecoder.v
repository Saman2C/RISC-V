`define I_T 7'b0010011
`define R_T 7'b0110011

module unsigned_decoder(op, funct3, UnsignedSig);
	
	input [6:0] op;
	input [2:0] funct3;
	output UnsignedSig;
	
	assign UnsignedSig = ((op == `I_T | op == `R_T) & (funct3 == 3'b011)) ? 1'b1 : 1'b0;
	
endmodule