// EtoM modules

// This module is one of the pipeline register module which passes through all necessary information within the execute state to memory state every clock cycle.


module EtoM(clk, RegWriteE, MemtoRegE, MemWriteE, MemWriteSBE, ALUInE, WriteDataE, WriteRegE, PCPlus4E, JalE, sysE, breakE, regvE, regaE, RegWriteM, MemtoRegM, MemWriteM, MemWriteSBM, ALUOutM, WriteDataM, WriteRegM, PCPlus4M, JalM, sysM, breakM, regvM, regaM); 

    input clk;
    input RegWriteE;
    input MemtoRegE;
    input MemWriteE;
    input MemWriteSBE;
    input [31:0] ALUInE;
    input [31:0] WriteDataE;
    input [4:0] WriteRegE;
    input [31:0] PCPlus4E;
    input JalE;
    input [31:0] regvE;
    input [31:0] regaE;
    input sysE;
    input breakE;

    output reg RegWriteM;
    output reg MemtoRegM;
    output reg MemWriteM;
    output reg MemWriteSBM;
    output reg [31:0] ALUOutM;
    output reg [31:0] WriteDataM;
    output reg [4:0] WriteRegM;
    output reg [31:0] PCPlus4M;
    output reg JalM;
    output reg [31:0] regvM;
    output reg [31:0] regaM;
    output reg sysM;
    output reg breakM;
    
    // Initialize all outputs for the beginning.
    initial begin 
        RegWriteM = 0;
        MemtoRegM = 0;
        MemWriteM = 0;
        MemWriteSBM = 0;
        ALUOutM = 0;
        WriteDataM = 0;
        WriteRegM = 0;
        PCPlus4M = 0;
        JalM = 0;
		regvM = 0;
        regaM = 0;
        sysM = 0;
        breakM = 0;
    end 

    // For each posedge of clk, pass through the signals.
    always@(posedge clk)
    begin      
        RegWriteM <= RegWriteE;
        MemtoRegM <= MemtoRegE;
        MemWriteM <= MemWriteE;
        MemWriteSBM <= MemWriteSBE;
        ALUOutM <= ALUInE;
        WriteDataM <= WriteDataE;
        WriteRegM <= WriteRegE;
        PCPlus4M <= PCPlus4E;
        JalM <= JalE;
		regvM <= regvE;
        regaM <= regaE;
        sysM <= sysE;
        breakM <= breakE;
    end

endmodule
