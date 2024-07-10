module unsigned_module(a, UnsignedSig, w);

	input [31:0] a;
	input UnsignedSig;
	output [31:0] w;
	
	assign w = {UnsignedSig ^ a[31], a[30:0]};
	
endmodule