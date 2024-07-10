`define I 3'b000
`define S 3'b001
`define B 3'b010
`define U 3'b011
`define J 3'b100


module ImmExtension(Inst, ImmSrc, w);

	input [24:0] Inst;
	input [2:0] ImmSrc;
	output reg [31:0] w;
	
	always @(Inst, ImmSrc) begin
		case (ImmSrc)
			`I: w <= {{20{Inst[24]}}, Inst[24:13]};
			`S: w <= {{20{Inst[24]}}, Inst[24:18], Inst[4:0]};
			`B: w <= {{20{Inst[24]}}, Inst[0], Inst[23:18], Inst[4:1], 1'b0};
			`U: w <= {Inst[24:5], 12'b0};
			`J: w <= {{12{Inst[24]}}, Inst[12:5], Inst[13], Inst[23:14], 1'b0};
			default: w <= 32'b0;
		endcase
	end
	
endmodule