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

module main_decoder (ps, PCUpdate, AdrSrc, MemWrite, IRWrite, ResultSrc, ALUSrcB, ALUSrcA, ImmSrc, RegWrite, ALUOp, branch);

    input [4:0] ps;
    output reg PCUpdate, AdrSrc, MemWrite, IRWrite, RegWrite, branch;
    output reg [1:0] ResultSrc, ALUSrcB, ALUSrcA, ALUOp;
    output reg [2:0] ImmSrc;

    always @(ps) begin
        {PCUpdate, AdrSrc, MemWrite, IRWrite, ResultSrc, ALUSrcB, ALUSrcA, ImmSrc, RegWrite, ALUOp, branch} = 17'b0;
        case (ps)
            `IF: begin
                AdrSrc = 1'b0;
                IRWrite = 2'b01;
                ALUSrcA = 2'b00;
                ALUSrcB = 2'b10;
                ResultSrc = 2'b10;
                PCUpdate = 1'b1;
                ALUOp = 2'b00;
            end
            `ID: begin
                ALUSrcA = 2'b01;
                ALUSrcB = 2'b01;
                ImmSrc = 3'b010;
                ALUOp = 2'b00;
            end
            `EX1: begin
                ALUSrcA = 2'b10;
                ALUSrcB = 2'b00;
                ALUOp = 2'b10;
            end
            `EX2: begin
                ALUSrcA = 2'b10;
                ALUSrcB = 2'b01;
                ImmSrc = 3'b000;
                ALUOp = 2'b11;
            end
            `EX3: begin
                ALUSrcA = 2'b10;
                ALUSrcB = 2'b01;
                ImmSrc = 3'b000;
                ALUOp = 2'b00;
            end
            `EX4: begin
                ALUSrcA = 2'b01;
                ALUSrcB = 2'b10;
                ALUOp = 2'b00;
            end
            `EX5: begin
                ALUSrcA = 2'b10;
                ALUSrcB = 2'b01;
                ImmSrc = 3'b000;
                RegWrite = 1'b1;
                ResultSrc = 2'b00;
                ALUOp = 2'b00;
            end
            `EX6: begin
                ResultSrc = 2'b00;
                PCUpdate = 1'b1;
            end
            `EX7: begin
                ALUSrcA = 2'b10;
                ALUSrcB = 2'b01;
                ImmSrc = 3'b001;
                ALUOp = 2'b00;
            end
            `EX8: begin
                ALUSrcA = 2'b01;
                ALUSrcB = 2'b10;
                ALUOp = 2'b00;
            end
            `EX9: begin
                ALUSrcA = 2'b01;
                ALUSrcB = 2'b01;
                RegWrite = 1'b1;
                ImmSrc = 3'b100;
                ResultSrc = 2'b00;
                ALUOp = 2'b00;
            end
            `EX10: begin
                ResultSrc = 2'b00;
                PCUpdate = 1'b1;
            end
            `EX11: begin
                ALUSrcA = 2'b10;
                ALUSrcB = 2'b00;
                ImmSrc = 3'b000;
                ALUOp = 2'b01;
                branch = 1'b1;
            end
            `MEM1: begin
                ResultSrc = 2'b00;
                RegWrite = 1'b1;
            end
            `MEM2: begin
                ResultSrc = 2'b00;
                RegWrite = 1'b1;
            end
            `MEM3: begin
                ResultSrc = 2'b00;
                AdrSrc = 1'b1;
            end
            `MEM4: begin
                ResultSrc = 2'b00;
                MemWrite = 1'b1;
                AdrSrc = 1'b1;
            end
            `MEM5: begin
                ResultSrc = 2'b11;
                RegWrite = 1'b1;
                ImmSrc = 3'b001;
            end
            `WB: begin
                ResultSrc = 2'b01;
                RegWrite = 1'b1;
            end
            
        endcase
    end

endmodule