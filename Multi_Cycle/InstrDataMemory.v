module InstrDataMemory (memAdr, writeData, memWrite, clk, readData);
    input [31:0] memAdr, writeData;
    input memWrite, clk;
    output [31:0] readData;
    reg [31:0] readData;

    reg [31:0] dataMem [0:511];

    initial $readmemb("memory.txt", dataMem);

    always @(posedge clk) begin
        if (memWrite)
            dataMem[memAdr >> 2] <= writeData;
    end
    
    assign readData = dataMem[memAdr >> 2];
    
endmodule