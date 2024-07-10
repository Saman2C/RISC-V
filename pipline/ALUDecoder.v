`define R_T 7'b0110011
`define I_T 7'b0010011
`define LW_T 7'b0000011
`define JALR_T 7'b1100111
`define S_T 7'b0100011
`define B_T 7'b1100011
`define J_T 7'b1101111
`define U_T 7'b0110111

`define ADD 3'b000
`define SUB 3'b001
`define AND 3'b010
`define OR  3'b011
`define XOR 3'b100
`define SLT 3'b101


module alu_decoder(op, funct3, funct7, ALUControl);

	input [6:0] op;
	input [2:0] funct3;
	input funct7;
	output reg [2:0] ALUControl;
	
	always @(op, funct3, funct7) begin
		case (funct3)
			3'b000: //add->ADD, sub->SUB, addi->ADD, beq->SUB, jalr->ADD
				ALUControl = ((op == `R_T & funct7 == 1'b0) | (op == `I_T)) ? `ADD : `SUB;
			3'b001: //bne->SUB
				ALUControl = `SUB;
			3'b010: //slt->SLT, slti->SLT, lw->ADD, sw->ADD
				ALUControl = (op == `R_T | op == `I_T) ? `SLT : `ADD;
			3'b011: //sltu->SLT, sltiu->SLT
				ALUControl = `SLT;
			3'b100: //blt->SLT, xori->XOR
				ALUControl = (op == `B_T) ? `SLT : `XOR;
			3'b101: //bge->SLT
				ALUControl = `SLT;
			3'b110: //or->OR, ori->OR
				ALUControl = `OR;
			3'b111: //and->AND, andi->AND
				ALUControl = `AND;
			default:
				ALUControl = 3'b000;
		endcase
	end
	

endmodule