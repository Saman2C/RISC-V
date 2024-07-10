`define IF 5'b00000
`define ID 5'b00001
`define EX1 5'b00010
`define EX2 5'b00011
`define EX3 5'b00100
`define EX4 5'b00101
`define EX5 5'b00110
`define EX6 5'b00111
`define EX7 5'b01000
`define EX8 5'b01001
`define EX9 5'b01010
`define EX10 5'b01011
`define EX11 5'b01100
`define MEM1 5'b01101
`define MEM2 5'b01110
`define MEM3 5'b01111
`define MEM4 5'b10000
`define MEM5 5'b10001
`define WB 5'b10010

`define R_T 7'b0110011
`define I_T 7'b0010011
`define LW_T 7'b0000011
`define JALR_T 7'b1100111
`define S_T 7'b0100011
`define B_T 7'b1100011
`define J_T 7'b1101111
`define U_T 7'b0110111


module controller (clk, rst, op, funct3, funct7, zero, PCWrite, AdrSrc, MemWrite, IRWrite, ResultSrc, ALUControl, ALUSrcB, ALUSrcA, ImmSrc, RegWrite, UnsignedSig);

    input clk, rst;
	input [6:0] op;
	input [2:0] funct3;
	input [6:0] funct7;
	input zero;

    output PCWrite, AdrSrc, MemWrite, IRWrite, RegWrite, UnsignedSig;
    output [1:0] ResultSrc, ALUSrcB, ALUSrcA;
    output [2:0] ALUControl, ImmSrc;

    wire branch, PCUpdate;
    wire [1:0] ALUOp;

    reg [4:0] ps, ns;

    always @(posedge clk, posedge rst) begin
        if (rst)
            ps <= `IF;
        else
            ps <= ns;
    end
  
    always @(ps, op) begin
        case (ps)
            `IF: ns = `ID;
            `ID: ns = ((op == `R_T) ? `EX1 : 
                        (op == `I_T) ? `EX2 : 
                        (op == `LW_T) ? `EX3 : 
                        (op == `JALR_T) ? `EX4 :
                        (op == `S_T) ? `EX7 : 
                        (op == `J_T) ? `EX8 : 
                        (op == `B_T) ? `EX11 : 
                        (op == `U_T) ? `MEM5 :  5'bz);
            `EX1: ns = `MEM1;
            `EX2: ns = `MEM2;
            `EX3: ns = `MEM3;
            `EX4: ns = `EX5;
            `EX5: ns = `EX6;
            `EX6: ns = `IF;
            `EX7: ns = `MEM4;
            `EX8: ns = `EX9;
            `EX9: ns = `EX10;
            `EX10: ns = `IF;
            `EX11: ns = `IF;
            `MEM1: ns = `IF;
            `MEM2: ns = `IF;
            `MEM3: ns = `WB;
            `MEM4: ns = `IF;
            `MEM5: ns = `IF;
            `WB: ns = `IF;
            default: ns = 5'bz;
        endcase
    end

    main_decoder MD(ps, PCUpdate, AdrSrc, MemWrite, IRWrite, ResultSrc, ALUSrcB, ALUSrcA, ImmSrc, RegWrite, ALUOp, branch);
    alu_decoder AD(ALUOp, funct3, funct7, ALUControl);
    unsigned_decoder UD(ps, funct3, UnsignedSig);
    pcwrite_decoder PD(PCUpdate, branch, funct3, zero, PCWrite);


endmodule 