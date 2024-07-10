module hazard_unit (StallF, StallD, FlushD, Rs1D, Rs2D, FlushE, RdE, Rs2E, Rs1E, PCSrcE, ForwardAE, ForwardBE, ResultSrcE, RdM, RegWriteM, RdW, RegWriteW);

	output StallF, StallD, FlushD, FlushE;
	output reg [1:0] ForwardAE, ForwardBE;
	input RegWriteW, RegWriteM;
	input [4:0] Rs1D, Rs2D, RdE, Rs2E, Rs1E, RdM, RdW;
	input [1:0] PCSrcE, ResultSrcE;

	always @(Rs1E, RdM, RegWriteM, RdW, RegWriteW) begin
		if (((Rs1E == RdM) && RegWriteM) && (Rs1E != 5'b0))
			ForwardAE = 2'b10;
		else if (((Rs1E == RdW) && RegWriteW) && (Rs1E != 5'b0))
			ForwardAE = 2'b01;
		else
			ForwardAE = 2'b00;
	end
	
	always @(Rs2E, RdM, RegWriteM, RdW, RegWriteW) begin
		if (((Rs2E == RdM) && RegWriteM) && (Rs2E != 5'b0))
			ForwardBE = 2'b10;
		else if (((Rs2E == RdW) && RegWriteW) && (Rs2E != 5'b0))
			ForwardBE = 2'b01;
		else
			ForwardBE = 2'b00;
	end
	
	wire lwStall;
	assign lwStall = (((Rs1D == RdE) || (Rs2D == RdE)) && (ResultSrcE == 2'b01));
	assign StallD = lwStall;
	assign StallF = lwStall;
	
	assign FlushD = (PCSrcE != 2'b00);
	assign FlushE = (lwStall || (PCSrcE != 2'b00));
	
	
endmodule