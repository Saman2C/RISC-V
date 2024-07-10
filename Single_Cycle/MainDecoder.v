`define R_T 7'b0110011
`define I_T 7'b0010011
`define LW_T 7'b0000011
`define JALR_T 7'b1100111
`define S_T 7'b0100011
`define B_T 7'b1100011
`define J_T 7'b1101111
`define U_T 7'b0110111

module main_decoder (op, ResultSrc, MemWrite, ALUSrc, ImmSrc, RegWrite);

	input [6:0] op;
	output reg [1:0] ResultSrc;
	output reg MemWrite, ALUSrc, RegWrite;
	output reg [2:0] ImmSrc;

	always @(op) begin
		{ResultSrc, MemWrite, ALUSrc, ImmSrc, RegWrite} = 11'b0;
		case (op)
			`R_T: RegWrite = 1'b1;
			`I_T: begin
				RegWrite = 1'b1;
				ALUSrc = 1'b1;
			end
			`LW_T: begin
				ResultSrc = 2'b01;
				ALUSrc = 1'b1;
				RegWrite = 1'b1;
			end
			`JALR_T: begin
				ResultSrc = 2'b10;
				ALUSrc = 1'b1;
				RegWrite = 1'b1;
			end
			`S_T: begin
				MemWrite = 1'b1;
				ALUSrc = 1'b1;
				ImmSrc = 3'b001;
				RegWrite = 1'b0;
			end
			`J_T: begin
				ResultSrc = 2'b10;
				ImmSrc = 3'b100;
				RegWrite = 1'b1;
			end
			`B_T: ImmSrc = 3'b010;
			`U_T: begin
				ResultSrc = 2'b11;
				ImmSrc = 3'b011;
				RegWrite = 1'b1;
			end
		endcase
	end
	
endmodule