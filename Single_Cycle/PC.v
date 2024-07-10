module pc(clk, rst, PCNext, PC);
	
	input clk, rst;
	input [31:0] PCNext;
	output reg [31:0] PC;
	
	always @(posedge clk, posedge rst) begin
		if (rst)
			PC <= 32'b0;
		else
			PC <= PCNext;
	end
	
endmodule