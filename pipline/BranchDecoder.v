`define B_T 7'b1100011
`define BEQ 3'b000
`define BNE 3'b001
`define BLT 3'b100
`define BGE 3'b101

module branch_decoder(op, funct3, Branch);
	
	input [6:0] op;
	input [2:0] funct3;
	output [1:0] Branch;
	
	assign Branch = ((op == `B_T) ? ({1'b1, (funct3 == `BNE || funct3 == `BLT)}) : 2'b0);
	
endmodule