module Register(in, en, rst, clk, out);
    parameter N = 32;

    input [N-1:0] in;
    input en, clk, rst;

    output reg [N-1:0] out;

    always @(posedge clk or posedge rst) begin
        if(rst)
            out <= {N{1'b0}};
        else if(en)
            out <= in;
    end

endmodule

module RegFD(clk, rst, en, clr, instrF, PCF, 
                PCPlus4F, PCPlus4D,
                instrD, PCD);
    
    input clk, rst, clr, en;
    input [31:0] instrF, PCF, PCPlus4F;

    output reg [31:0] instrD, PCD, PCPlus4D;
    
    always @(posedge clk or posedge rst) begin
        
        if(rst || clr) begin
            instrD   <= 32'b0;
            PCD      <= 32'b0;
            PCPlus4D <= 3'b0;
        end 

        else if(en) begin
            instrD   <= instrF;
            PCD      <= PCF;
            PCPlus4D <= PCPlus4F;
        end
        
    end

endmodule

module RegDE(clk, rst, clr, regWriteD, resultSrcD, memWriteD, jumpD,
                branchD, ALUControlD, ALUSrcD, RD1D, RD2D, PCD,Rs1D,
                Rs2D,RdD, extImmD,PCPlus4D, luiD,
                regWriteE, ALUSrcE, memWriteE, jumpE, luiE,
                branchE, ALUControlE, resultSrcE, RD1E, RD2E, PCE,Rs1E,
                Rs2E,RdE, extImmE,PCPlus4E, UnsignedSigE, UnsignedSigD);

    input clk, rst, clr, ALUSrcD, luiD, regWriteD, memWriteD, UnsignedSigD;
    input [31:0] RD1D, RD2D, PCD;
    input [31:0] PCPlus4D, extImmD;
    input [4:0] Rs1D, Rs2D,RdD;
    input [2:0] ALUControlD;
    input [1:0] branchD, jumpD, resultSrcD;
    output reg ALUSrcE ,luiE, regWriteE, memWriteE, UnsignedSigE;
    output reg [31:0] RD1E, RD2E, PCE;
    output reg [31:0] PCPlus4E, extImmE;
    output reg [4:0] Rs1E, Rs2E,RdE;
    output reg [2:0] ALUControlE;
    output reg [1:0] branchE, jumpE, resultSrcE;
    
    always @(posedge clk or posedge rst) begin
        if (rst || clr) begin
            regWriteE <= 1'b0;
            memWriteE <= 1'b0;
            ALUControlE <= 3'b000;
            RD1E <= 32'b0;
            RD2E <= 32'b0;
            PCE <= 32'b0;
            PCPlus4E <= 32'b0;
            extImmE <= 32'b0;
            Rs1E <= 5'b0;
            Rs2E <= 5'b0;
            RdE <= 5'b0;
            branchE <= 2'b0;
            jumpE <= 2'b0;
            ALUSrcE <= 1'b0;
            resultSrcE <= 2'b00;
            luiE <= 1'b0;
            UnsignedSigE <= 1'b0;
        end
        else begin
            regWriteE <= regWriteD;
            memWriteE <= memWriteD;
            ALUControlE <= ALUControlD;
            RD1E <= RD1D;
            RD2E <= RD2D;
            PCE <= PCD;
            PCPlus4E <= PCPlus4D;
            extImmE <= extImmD;
            Rs1E <= Rs1D;
            Rs2E <= Rs2D;
            RdE <= RdD;
            branchE <= branchD;
            jumpE <= jumpD;
            ALUSrcE <= ALUSrcD;
            resultSrcE <= resultSrcD;
            luiE <= luiD;
            UnsignedSigE <= UnsignedSigD;
        end
    end

endmodule

module RegEM(clk, rst, regWriteE, resultSrcE, memWriteE,
                 ALUResultE, writeDataE, RdE, PCPlus4E, luiE, extImmE,
                 regWriteM, resultSrcM, memWriteM, ALUResultM,
                 writeDataM, RdM, PCPlus4M, luiM,extImmM);

    input clk, rst, memWriteE, regWriteE, luiE;
    input [1:0] resultSrcE;
    input [4:0] RdE;
    input [31:0] ALUResultE, writeDataE, PCPlus4E, extImmE;
    
    output reg  memWriteM, regWriteM , luiM;
    output reg [1:0] resultSrcM;
    output reg [4:0] RdM;
    output reg [31:0] ALUResultM, writeDataM, PCPlus4M, extImmM;

    always @(posedge clk or posedge rst) begin

        if (rst) begin
            ALUResultM <= 32'b0;
            writeDataM <= 32'b0;
            PCPlus4M   <= 32'b0;
            extImmM    <= 32'b0;
            RdM        <= 5'b0;
            memWriteM  <= 1'b0;
            regWriteM  <= 1'b0;
            resultSrcM <= 2'b0;
            luiM       <= 1'b0;
        end 
        
        else begin
            ALUResultM <= ALUResultE;
            writeDataM <= writeDataE;
            PCPlus4M   <= PCPlus4E;
            RdM        <= RdE;
            memWriteM  <= memWriteE;
            regWriteM  <= regWriteE;
            resultSrcM <= resultSrcE;
            luiM       <= luiE;
            extImmM    <= extImmE;
        end

    end

endmodule

module RegMW(clk, rst, regWriteM, resultSrcM,
                 ALUResultM, RDM, RdM, PCPlus4M,
                extImmM, extImmW, regWriteW, resultSrcW,
                ALUResultW, RDW, RdW, PCPlus4W);
    
    input clk, rst, regWriteM;
    input [1:0] resultSrcM;
    input [4:0] RdM;
    input [31:0] ALUResultM, RDM, PCPlus4M, extImmM;

    output reg regWriteW;
    output reg [1:0] resultSrcW;
    output reg [4:0] RdW;
    output reg [31:0] ALUResultW, RDW, PCPlus4W, extImmW;

    always @(posedge clk or posedge rst) begin
        
        if (rst) begin
            regWriteW  <= 32'b0;
            ALUResultW <= 32'b0;
            PCPlus4W   <= 32'b0;
            RDW        <= 32'b0;
            RdW        <= 5'b0;
            resultSrcW <= 2'b0;
            extImmW    <= 32'b0;
        end 
        
        else begin
            regWriteW  <= regWriteM; 
            ALUResultW <= ALUResultM;
            PCPlus4W   <= PCPlus4M;
            RDW        <= RDM;
            RdW        <= RdM;
            resultSrcW <= resultSrcM;
            extImmW    <= extImmM;
        end
        
    end

endmodule
