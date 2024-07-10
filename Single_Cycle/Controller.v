

module controller (op, funct3, funct7, zero, PCSrc, ResultSrc, MemWrite, ALUControl, ALUSrc, ImmSrc, RegWrite, UnsignedSig);
	
	input [6:0] op;
	input [2:0] funct3;
	input [6:0] funct7;
	input zero;
	
	output MemWrite, ALUSrc, RegWrite, UnsignedSig;
	output [1:0] PCSrc, ResultSrc;
	output [2:0] ALUControl, ImmSrc;
	
	main_decoder MD(op, ResultSrc, MemWrite, ALUSrc, ImmSrc, RegWrite);
	pc_src_decoder PD(op, funct3, zero, PCSrc);
	alu_decoder AD(op, funct3, funct7, ALUControl);
	unsigned_decoder UD(op, funct3, UnsignedSig);
	
endmodule