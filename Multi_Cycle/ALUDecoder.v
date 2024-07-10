`define ADD 3'b000
`define SUB 3'b001
`define AND 3'b010
`define OR  3'b011
`define XOR 3'b100
`define SLT 3'b101

module alu_decoder (ALUOp, funct3, funct7, ALUControl);

    input [1:0] ALUOp;
    input [2:0] funct3;
    input [6:0] funct7;
    output reg [2:0] ALUControl;

    always @(ALUOp, funct3, funct7) begin
        case (ALUOp)
            2'b00: ALUControl = `ADD;
            2'b01: ALUControl = (funct3 == 3'd0 | funct3 == 3'd1) ? `SUB : `SLT;
            2'b10: ALUControl = (funct3 == 3'd0) ? ((funct7 == 3'd0) ? `ADD : `SUB) : 
                                (funct3 == 3'd4) ? `XOR : 
                                (funct3 == 3'd6) ? `OR : 
                                (funct3 == 3'd7) ? `AND : 
                                (funct3 == 3'd2 | funct3 == 3'd3) ? `SLT : 3'bz;
            2'b11: ALUControl = (funct3 == 3'd0) ? `ADD : 
                                (funct3 == 3'd4) ? `XOR : 
                                (funct3 == 3'd6) ? `OR : 
                                (funct3 == 3'd7) ? `AND : 
                                (funct3 == 3'd2 | funct3 == 3'd3) ? `SLT : 3'bz;
            default: ALUControl = 3'bz;
        endcase
    end

endmodule