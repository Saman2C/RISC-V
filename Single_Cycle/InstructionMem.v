module instruction_memory(A, RD);
	
	input [31:0] A;
	output [31:0] RD;
	
	reg [31:0] instructions [0:255];
	
	initial $readmemb("instructions.txt", instructions);
	
	assign RD = instructions[A >> 2];
	
endmodule