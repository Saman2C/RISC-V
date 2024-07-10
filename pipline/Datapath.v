module datapath(clk, rst);

    input clk, rst;

    wire regWriteD, memWriteD, ALUSrcD, luiD;
    wire  [1:0] resultSrcD, branchD, jumpD;
    wire  [2:0] ALUControlD, immSrcD;
    wire [6:0] op;
    wire [2:0] funct3;
    wire funct7;
    wire regWriteW, regWriteM, memWriteM, luiE, 
         luiM, regWriteE, 
         ALUSrcE, memWriteE, flushE, zero,
         stallF, stallD, flushD, UnsignedSigE, UnsignedSigD;
    wire [1:0] resultSrcW, resultSrcM, jumpE, PCSrcE, resultSrcE, forwardAE, branchE, forwardBE;
    wire [2:0] ALUControlE;
    wire [4:0] RdW, RdM, Rs1E, Rs2E, RdE, Rs1D, Rs2D, RdD;
    wire [31:0] ALUResultM, writeDataM, PCPlus4M, extImmM, RDM,
                resultW, extImmW, ALUResultW, PCPlus4W, RDW,
                RD1E, RD2E, PCE, SrcAE, SrcBE, writeDataE,        
                PCTargetE, extImmE, PCPlus4E, ALUResultE, 
                PCPlus4D, instrD, PCD, RD1D, RD2D, extImmD,
                PCF_Prime, PCF, instrF, PCPlus4F,
                ResultM, USrcAE, USrcBE;
    
    assign op = instrD[6:0];
    assign RdD = instrD[11:7];
    assign funct3 = instrD[14:12];
    assign Rs1D =  instrD[19:15];
    assign Rs2D = instrD[24:20];
    assign funct7 = instrD[30];

    adder ADD1(.a(PCF), .b(32'd4), .w(PCPlus4F));
    Register Reg1(
        .in(PCF_Prime), .clk(clk), .en(~stallF), 
        .rst(rst), .out(PCF)
    );
    instruction_memory IM(.A(PCF), .RD(instrF));
    mux_3_to_1 MUX1(
        .sel(PCSrcE), .a(PCPlus4F), .b(PCTargetE), 
        .c(ALUResultE), .w(PCF_Prime)
    );
    RegFD REG1(
        .clk(clk), .rst(rst), 
        .en(~stallD), .clr(flushD),.PCF(PCF),.PCD(PCD),
        .PCPlus4F(PCPlus4F),.PCPlus4D(PCPlus4D),
        .instrF(instrF),.instrD(instrD)
    );
    register_file RF(
        .clk(clk), .WE3(regWriteW),.A3(RdW), 
        .WD3(resultW),.RD1(RD1D), .RD2(RD2D),
        .A1(instrD[19:15]),.A2(instrD[24:20])
    );
    ImmExtension IE(.ImmSrc(immSrcD), .w(extImmD),.Inst(instrD[31:7]));
    ALU A(
        .ALUCtrl(ALUControlE), .SrcA(USrcAE), .SrcB(USrcBE), 
        .zero(zero), .ALUResult(ALUResultE)
    );
    RegDE REG2(
        .clk(clk), .rst(rst), .clr(flushE), 
        .regWriteD(regWriteD),.regWriteE(regWriteE), 
        .PCD(PCD),.PCE(PCE),.Rs1D(Rs1D),.Rs1E(Rs1E),
        .Rs2D(Rs2D),.Rs2E(Rs2E),.RdD(RdD),.RdE(RdE),
        .RD1D(RD1D),.RD1E(RD1E),.RD2D(RD2D),.RD2E(RD2E), 
        .resultSrcD(resultSrcD),.resultSrcE(resultSrcE),
        .memWriteD(memWriteD),.memWriteE(memWriteE),
        .jumpD(jumpD),.jumpE(jumpE),.branchD(branchD),.branchE(branchE),
        .ALUControlD(ALUControlD),.ALUControlE(ALUControlE), 
        .ALUSrcD(ALUSrcD),.ALUSrcE(ALUSrcE),.extImmD(extImmD),
        .extImmE(extImmE),.luiD(luiD),.luiE(luiE),
        .PCPlus4D(PCPlus4D),.PCPlus4E(PCPlus4E) ,
        .UnsignedSigD(UnsignedSigD),.UnsignedSigE(UnsignedSigE)
    );
    mux_3_to_1 MUX2(.sel(forwardAE), .a(RD1E), .b(resultW), .c(ResultM), .w(SrcAE));
    mux_3_to_1 MUX3(.sel(forwardBE), .a(RD2E), .b(resultW), .c(ResultM), .w(writeDataE));
    mux_2_to_1 MUX4(.sel(ALUSrcE), .a(writeDataE), .b(extImmE), .w(SrcBE));

    adder ADD2(.a(PCE), .b(extImmE), .w(PCTargetE));

    RegEM regEXMEM(
        .clk(clk), .rst(rst),.PCPlus4M(PCPlus4M),.PCPlus4E(PCPlus4E),
        .resultSrcE(resultSrcE),.resultSrcM(resultSrcM),
        .writeDataE(writeDataE),.writeDataM(writeDataM),.luiE(luiE),.luiM(luiM),
        .regWriteE(regWriteE),.regWriteM(regWriteM), .RdE(RdE),.RdM(RdM),
        .memWriteE(memWriteE),.memWriteM(memWriteM),.ALUResultE(ALUResultE),
        .ALUResultM(ALUResultM),.extImmE(extImmE),.extImmM(extImmM)
    );
    data_memory DM(
        .A(ALUResultM), .WD(writeDataM), 
        .WE(memWriteM), .clk(clk), .RD(RDM)
    );
    mux_2_to_1 MUX5(.sel(luiM), .a(ALUResultM), .b(extImmM), .w(ResultM));
    RegMW REG3(
        .clk(clk), .rst(rst),.regWriteM(regWriteM),.regWriteW(regWriteW),
        .ALUResultM(ALUResultM),.ALUResultW(ALUResultW),
        .RDM(RDM),.RDW(RDW),.RdM(RdM),.RdW(RdW),.resultSrcM(resultSrcM),
        .resultSrcW(resultSrcW),.PCPlus4M(PCPlus4M),.PCPlus4W(PCPlus4W),
        .extImmM(extImmM),.extImmW(extImmW)
    );
    mux_4_to_1 MUX6(
        .sel(resultSrcW), .a(ALUResultW), .b(RDW), 
        .c(PCPlus4W), .d(extImmW), .w(resultW)
    );
    hazard_unit HZ(
        .StallF(stallF), .StallD(stallD), .FlushD(flushD), 
        .Rs1D(Rs1D), .Rs2D(Rs2D), .FlushE(flushE), .RdE(RdE),
        .Rs2E(Rs2E), .Rs1E(Rs1E), .PCSrcE(PCSrcE), .ForwardAE(forwardAE), 
        .ForwardBE(forwardBE), .ResultSrcE(resultSrcE), .RdM(RdM),
        .RegWriteM(regWriteM), .RdW(RdW), .RegWriteW(regWriteW)
    );
    branch_controller BC(
        .Branch(branchE), .Jump(jumpE),
        .Zero(zero), .PCSrc(PCSrcE)
    );
    controller CTRL(
        .op(op), .funct3(funct3), .funct7(funct7), .RegWrite(regWriteD),
        .ResultSrc(resultSrcD), .MemWrite(memWriteD), 
        .Jump(jumpD), .Branch(branchD), .ALUControl(ALUControlD), 
        .ALUSrc(ALUSrcD), .ImmSrc(immSrcD), .UnsignedSig(UnsignedSigD), .Lui(luiD)
    );
    unsigned_module UM1(.a(SrcAE), .UnsignedSig(UnsignedSigE), .w(USrcAE));
    unsigned_module UM2(.a(SrcBE), .UnsignedSig(UnsignedSigE), .w(USrcBE));

endmodule