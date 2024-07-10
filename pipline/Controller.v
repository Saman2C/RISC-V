module controller (op, funct3, funct7, RegWrite, ResultSrc, MemWrite, Jump, Branch, ALUControl, ALUSrc, ImmSrc, UnsignedSig, Lui);

	input [6:0] op;
	input [2:0] funct3;
	input funct7;
	
	output MemWrite, ALUSrc, RegWrite, UnsignedSig, Lui;
	output [1:0] ResultSrc, Jump, Branch;
	output [2:0] ALUControl, ImmSrc;

	main_decoder MD(op, RegWrite, ResultSrc, MemWrite, Jump, ALUSrc, ImmSrc, Lui);
	alu_decoder AD(op, funct3, funct7, ALUControl);
	unsigned_decoder UD(op, funct3, UnsignedSig);
	branch_decoder BD(op, funct3, Branch);
	

endmodule
