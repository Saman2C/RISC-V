module tb();
	reg clk, rst;
	datapath DP(clk, rst);
	
	always #5 clk = ~clk;
	
	initial begin
		clk = 1'b0;
		rst = 1'b0;
		#2
		rst = 1'b1;
		#2
		rst = 1'b0;
		#2000 $stop;
	end
	
endmodule