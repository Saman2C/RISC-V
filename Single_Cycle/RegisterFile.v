module register_file(clk, A1, A2, A3, WD3, WE3, RD1, RD2);

	input clk;
	input [4:0] A1, A2, A3;
	input [31:0] WD3;
	input WE3;
	
	output [31:0] RD1, RD2;
	
	reg [31:0] registers [0:31];
	
	initial 
		registers[0] = 32'b0;
	
	always @(posedge clk) begin
		if (WE3 == 1'b1)
			registers[A3] <= WD3;
	end 
	
	
	assign RD1 = registers[A1];
	assign RD2 = registers[A2];
	
endmodule