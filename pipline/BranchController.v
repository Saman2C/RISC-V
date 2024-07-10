module branch_controller(Branch, Jump, Zero, PCSrc);
	
    input [1:0] Branch, Jump;
    input Zero;
    output [1:0] PCSrc;
	
	assign PCSrc = (Jump[1]) ? (Jump[0] ? 2'b10 : 2'b01) : 
                    (Branch[1] && (Branch[0] ^ Zero)) ? 2'b01 : 2'b00;

endmodule