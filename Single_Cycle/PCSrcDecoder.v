`define R_T 7'b0110011
`define I_T 7'b0010011
`define LW_T 7'b0000011
`define JALR_T 7'b1100111
`define S_T 7'b0100011
`define B_T 7'b1100011
`define J_T 7'b1101111
`define U_T 7'b0110111


`define BEQ 3'b000
`define BNE 3'b001
`define BLT 3'b100
`define BGE 3'b101


module pc_src_decoder(op, funct3, zero, PCSrc);
	
	input [6:0] op;
	input [2:0] funct3;
	input zero;
	output reg [1:0] PCSrc;
	
	always @(op, funct3, zero) begin
		case (op)
			`JALR_T: PCSrc = 2'b10;
			`J_T: PCSrc = 2'b01;
			`B_T: PCSrc = ((funct3 == `BNE | funct3 == `BLT) ^ zero) ? 2'b01 : 2'b00;
			default: PCSrc = 2'b00;
		endcase
	end
	
endmodule