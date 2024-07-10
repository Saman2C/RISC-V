`define R_T 7'b0110011
`define I_T 7'b0010011
`define LW_T 7'b0000011
`define JALR_T 7'b1100111
`define S_T 7'b0100011
`define B_T 7'b1100011
`define J_T 7'b1101111
`define U_T 7'b0110111

module main_decoder (op, RegWrite, ResultSrc, MemWrite, Jump, ALUSrc, ImmSrc, Lui);
	
	input [6:0] op;
	output reg RegWrite, MemWrite, ALUSrc, Lui;
	output reg [1:0] ResultSrc, Jump;
	output reg [2:0] ImmSrc;

	always @(op) begin
		{RegWrite, ResultSrc, MemWrite, Jump, ALUSrc, ImmSrc, Lui} = 11'b0;
		case (op)
			`R_T: RegWrite = 1'b1;
			`I_T: begin 
				RegWrite = 1'b1;
				ALUSrc = 1'b1;
				ImmSrc = 3'b000;
			end
			`LW_T: begin
				RegWrite = 1'b1;
				ResultSrc = 2'b01;
				ALUSrc = 1'b1;
				ImmSrc = 3'b000;
			end
			`JALR_T: begin 
				RegWrite = 1'b1;
				ResultSrc = 2'b10;
				ALUSrc = 1'b1;
				ImmSrc = 3'b000;
				Jump = 2'b11;
			end
			`S_T: begin 
				MemWrite = 1'b1;
				ALUSrc = 1'b1;
				ImmSrc = 3'b001;
			end
			`J_T: begin 
				RegWrite = 1'b1;
				ResultSrc = 2'b10;
				ImmSrc = 3'b100;
				Jump = 2'b10;
			end
			`B_T: ImmSrc = 3'b010;
			`U_T: begin 
				RegWrite = 1'b1;
				ResultSrc = 2'b11;
				ImmSrc = 3'b011;
				Lui = 1'b1;
			end
			default: ;
		endcase
	end
	
endmodule