module data_memory (clk, A, WD, WE, RD);

	input [31:0] A, WD;
	input clk, WE;
	output [31:0] RD;
	
	reg [31:0] memory [0:255];
	
	initial $readmemb("memory.txt", memory);
	
	always @(posedge clk) begin
		if (WE == 1'b1)
			memory[A >> 2] <= WD;
	end
		
	assign RD = memory[A >> 2];
	
endmodule