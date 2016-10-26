//Takes in all values leaving the execute stage, stores them for clock cycle, and then outputs them in the next cycle.
module EtoM(clk, RegWriteE, MemtoRegE, MemWriteE, ALUInE, WriteDataE, WriteRegE, PCPlus4E, JalE, sysE, regvE, regaE, RegWriteM, MemtoRegM, MemWriteM, ALUOutM, WriteDataM, WriteRegM, PCPlus4M, JalM, sysM, regvM, regaM); 

    input clk;
    input RegWriteE;
    input MemtoRegE;
    input MemWriteE;
    input [31:0] ALUInE;
    input [31:0] WriteDataE;
    input [4:0] WriteRegE;
    input [31:0] PCPlus4E;
    input JalE;
    input [31:0] regvE;
    input [31:0] regaE;
    input sysE;

    output reg RegWriteM;
    output reg MemtoRegM;
    output reg MemWriteM;
    output reg [31:0] ALUOutM;
    output reg [31:0] WriteDataM;
    output reg [4:0] WriteRegM;
    output reg [31:0] PCPlus4M;
    output reg JalM;
    output reg [31:0] regvM;
    output reg [31:0] regaM;
    output reg sysM;
    
    initial begin 
        RegWriteM = 0;
        MemtoRegM = 0;
        MemWriteM = 0;
        ALUOutM = 0;
        WriteDataM = 0;
        WriteRegM = 0;
        PCPlus4M = 0;
        JalM = 0;
		regvM = 0;
        regaM = 0;
        sysM = 0;

    end 

    always@(posedge clk)
    begin      
        RegWriteM <= RegWriteE;
        MemtoRegM <= MemtoRegE;
        MemWriteM <= MemWriteE;
        ALUOutM <= ALUInE;
        WriteDataM <= WriteDataE;
        WriteRegM <= WriteRegE;
        PCPlus4M <= PCPlus4E;
        JalM <= JalE;
		regvM <= regvE;
        regaM <= regaE;
        sysM <= sysE;

    end

endmodule
