module adder (a, b, w);
	
	input [31:0] a, b;
	output [31:0] w;
	
	assign w = a + b;
	
endmodule