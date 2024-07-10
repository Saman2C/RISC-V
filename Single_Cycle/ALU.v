`define ADD 3'b000
`define SUB 3'b001
`define AND 3'b010
`define OR  3'b011
`define XOR 3'b100
`define SLT 3'b101


module alu(SrcA, SrcB, ALUCtrl, zero, ALUResult);
	
	input signed [31:0] SrcA, SrcB;
	input [2:0] ALUCtrl;
	output zero;
	output reg [31:0] ALUResult;
	
	
	always @(SrcA, SrcB, ALUCtrl) begin
		case (ALUCtrl)
			`ADD: ALUResult = SrcA + SrcB;
			`SUB: ALUResult = SrcA - SrcB;
			`AND: ALUResult = SrcA & SrcB;
			`OR : ALUResult = SrcA | SrcB;
			`XOR: ALUResult = SrcA ^ SrcB;
			`SLT: ALUResult = (SrcA < SrcB) ? 32'b1 : 32'b0;
			default: ALUResult = 32'bz;
		endcase
	end
	
	assign zero = (ALUResult === 32'b0) ? 1'b1 : 1'b0;
	
endmodule