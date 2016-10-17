module MtoW(clk, RegWriteM, MemtoRegM, ReadDataM, ALUOutM, WriteRegM, RegWriteW, MemtoRegW, ReadDataW, ALUOutW, WriteRegW); 

    input clk;
    input RegWriteM;
    input MemtoRegM;
    input [31:0] ReadDataM;
    input [31:0] ALUOutM;
    input [4:0] WriteRegM;

    output reg RegWriteW;
    output reg MemtoRegW;
    output reg [31:0] ReadDataW;
    output reg [31:0] ALUOutW;
    output reg [4:0] WriteRegW;

    initial begin 
        RegWriteW = 0;
        MemtoRegW = 0;
        ReadDataW = 0;
        ALUOutW = 0;
        WriteRegW = 0;
    end 

    always@(posedge clk)
    begin      
        RegWriteW <= RegWriteM;
        MemtoRegW <= MemtoRegM;
        ReadDataW <= ReadDataM;
        ALUOutW <= ALUOutM;
        WriteRegW <= WriteRegM;
    end

endmodule