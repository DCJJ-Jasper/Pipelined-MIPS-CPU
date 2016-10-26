//Stores all values coming out of the Memory stage and outputs them on the next tick of the clock to the writeback stage
module MtoW(clk, RegWriteM, MemtoRegM, ReadDataM, ALUOutM, WriteRegM, PCPlus4M, JalM, sysM, regvM, regaM, RegWriteW, MemtoRegW, ReadDataW, ALUOutW, WriteRegW, PCPlus4W, JalW, sysW, regvW, regaW); 

    input clk;
    input RegWriteM;
    input MemtoRegM;
    input [31:0] ReadDataM;
    input [31:0] ALUOutM;
    input [4:0] WriteRegM;
    input [31:0] PCPlus4M;
    input JalM;
    input [31:0] regvM;
    input [31:0] regaM;
    input sysM;

    output reg RegWriteW;
    output reg MemtoRegW;
    output reg [31:0] ReadDataW;
    output reg [31:0] ALUOutW;
    output reg [4:0] WriteRegW;
    output reg [31:0] PCPlus4W;
    output reg JalW;
    output reg [31:0] regvW;
    output reg [31:0] regaW;
    output reg sysW;

    initial begin 
        RegWriteW = 0;
        MemtoRegW = 0;
        ReadDataW = 0;
        ALUOutW = 0;
        WriteRegW = 0;
        PCPlus4W = 0;
        JalW = 0;
		regvW = 0;
        regaW = 0;
        sysW = 0;
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
		regvW <= regvM;
        regaW <= regaM;
        sysW <= sysM;
    end

endmodule
