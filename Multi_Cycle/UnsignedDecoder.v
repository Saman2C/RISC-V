`define EX1 5'b00010
`define EX2 5'b00011

module unsigned_decoder (ps, funct3, UnsignedSig);
	
	input [4:0] ps;
	input [2:0] funct3;
	output UnsignedSig;
	
	assign UnsignedSig = ((ps == `EX1 | ps == `EX2) & (funct3 == 3'b011)) ? 1'b1 : 1'b0;
	
endmodule