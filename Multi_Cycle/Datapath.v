module datapath(clk, rst);

    input clk, rst;

    wire [1:0] resultSrc, ALUSrcA, ALUSrcB ;
    wire [2:0] ALUControl, immSrc;
    wire [6:0] op, func7;
    wire [2:0] func3;
    wire zero, neg, PCWrite, IRWrite, adrSrc, memWrite, unsignedsig;
    wire [31:0] PC, Adr, ReadData, OldPC;
    wire [31:0] ImmExt, instr, Data;
    wire [31:0] RD1, RD2, A, B, SrcA, SrcB, USrcA, USrcB;
    wire [31:0] ALUResult, ALUOut, Result;

    Register R1(.in(Result), .en(PCWrite), .rst(rst), .clk(clk), .out(PC));
    Register R2(.in(PC), .en(IRWrite), .rst(1'b0), .clk(clk), .out(OldPC));
    Register R3(.in(ReadData), .en(IRWrite), .rst(1'b0), .clk(clk), .out(instr));
    Register R4(.in(ReadData), .en(1'b1), .rst(1'b0), .clk(clk), .out(Data));
    Register R5(.in(RD1), .en(1'b1), .rst(1'b0), .clk(clk), .out(A));
    Register R6(.in(RD2), .en(1'b1), .rst(1'b0), .clk(clk), .out(B));
    Register R7(.in(ALUResult), .en(1'b1), .rst(1'b0), .clk(clk), .out(ALUOut));
    mux_2_to_1 Mux1(.sel(adrSrc), .a(PC), .b(Result), .w(Adr));
    mux_3_to_1 Mux2(.sel(ALUSrcA), .a(PC), .b(OldPC), .c(A), .w(SrcA));
    mux_3_to_1 Mux3(.sel(ALUSrcB), .a(B), .b(ImmExt), .c(32'd4), .w(SrcB));
    mux_4_to_1 Mux4(.sel(resultSrc), .a(ALUOut), .b(Data), .c(ALUResult), .d(ImmExt), .w(Result));
    unsigned_module Unsigned1(.UnsignedSig(unsignedsig), .a(SrcA), .w(USrcA));
    unsigned_module Unsigned2(.UnsignedSig(unsignedsig), .a(SrcB), .w(USrcB));
    ImmExtension Extend(
        .ImmSrc(immSrc), .Inst(instr[31:7]), .w(ImmExt)
    );
    ALU AI(
        .ALUCtrl(ALUControl), .SrcA(USrcA), .SrcB(USrcB), 
        .zero(zero), .ALUResult(ALUResult)
    );
    InstrDataMemory DM(
        .memAdr(Adr), .writeData(B), .clk(clk), 
        .memWrite(memWrite), .readData(ReadData)
    );
    register_file RF(
        .clk(clk), 
        .WE3(regWrite),
        .WD3(Result), 
        .RD1(RD1), .RD2(RD2),
        .A1(instr[19:15]), 
        .A2(instr[24:20]),
        .A3(instr[11:7])
    );
    controller CTRL(clk, rst, instr[6:0], instr[14:12], instr[31:25], zero, PCWrite,
                adrSrc, memWrite, IRWrite, resultSrc, ALUControl, 
                ALUSrcB, ALUSrcA, immSrc, regWrite, unsignedsig
    );

endmodule