module datapath (clk, rst);
	
	input clk, rst;
	wire [31:0] PCNext, PC, Instr, Four, PCPlus4, Result, 
				DataA, DataB, ImmExt, SrcA, PreSrcB, SrcB,
				ALUResult, PCTarget, ReadData;
	wire RegWrite, ALUSrc, UnsignedSig, zero,
		 MemWrite;
	wire [2:0] ImmSrc, ALUControl;
	wire [1:0] ResultSrc, PCSrc;
	
	assign Four = 32'b100;
	
	pc PCM (clk, rst, PCNext, PC);
	instruction_memory IM (.A(PC), .RD(Instr));
	adder ADD1 (.a(PC), .b(Four), .w(PCPlus4));
	register_file RF (
		.clk(clk), .A1(Instr[19:15]), .A2(Instr[24:20]),
		.A3(Instr[11:7]), .WD3(Result), .WE3(RegWrite),
		.RD1(DataA), .RD2(DataB)
		);
	extend EXT(.Inst(Instr[31:7]), .ImmSrc(ImmSrc), .w(ImmExt));
	mux_2_to_1 MUX2(.a(DataB), .b(ImmExt), .sel(ALUSrc), .w(PreSrcB));
	unsigned_module UM1(.a(DataA), .UnsignedSig(UnsignedSig), .w(SrcA));
	unsigned_module UM2(.a(PreSrcB), .UnsignedSig(UnsignedSig), .w(SrcB));
	alu ALU(SrcA, SrcB, ALUControl, zero, ALUResult);
	adder ADD2 (.a(PC), .b(ImmExt), .w(PCTarget));
	data_memory DM (
		.clk(clk), .A(ALUResult), .WD(DataB),
		.WE(MemWrite), .RD(ReadData)
		);
	mux_4_to_1 MUX4(
		.a(ALUResult), .b(ReadData), .c(PCPlus4),
		.d(ImmExt), .sel(ResultSrc), .w(Result)
		);
	mux_3_to_1 MUX3(.a(PCPlus4), .b(PCTarget), .c(ALUResult), .sel(PCSrc), .w(PCNext));
	
	controller CU(
		.op(Instr[6:0]), .funct3(Instr[14:12]), .funct7(Instr[31:25]),
		.zero(zero), .PCSrc(PCSrc), .ResultSrc(ResultSrc),
		.MemWrite(MemWrite), .ALUControl(ALUControl), .ALUSrc(ALUSrc), 
		.ImmSrc(ImmSrc), .RegWrite(RegWrite), .UnsignedSig(UnsignedSig)
		);
	
	
endmodule