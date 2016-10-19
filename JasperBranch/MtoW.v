module MtoW(clk, RegWriteM, MemtoRegM, ReadDataM, ALUOutM, WriteRegM, PCPlus4M, JalM, RegWriteW, MemtoRegW, ReadDataW, ALUOutW, WriteRegW, PCPlus4W, JalW); 

    input clk;
    input RegWriteM;
    input MemtoRegM;
    input [31:0] ReadDataM;
    input [31:0] ALUOutM;
    input [4:0] WriteRegM;
    input [31:0] PCPlus4M;
    input JalM;

    output reg RegWriteW;
    output reg MemtoRegW;
    output reg [31:0] ReadDataW;
    output reg [31:0] ALUOutW;
    output reg [4:0] WriteRegW;
    output reg [31:0] PCPlus4W;
    output reg JalW;

    initial begin 
        RegWriteW = 0;
        MemtoRegW = 0;
        ReadDataW = 0;
        ALUOutW = 0;
        WriteRegW = 0;
        PCPlus4W = 0;
        JalW = 0;
    end 

    always@(posedge clk)
    begin      
        RegWriteW <= RegWriteM;
        MemtoRegW <= MemtoRegM;
        ReadDataW <= ReadDataM;
        ALUOutW <= ALUOutM;
        WriteRegW <= WriteRegM;
        PCPlus4W <= PCPlus4M;
        JalW <= JalM;
    end

endmodule