module EtoM(clk, RegWriteE, MemtoRegE, MemWriteE, ALUInE, WriteDataE, WriteRegE, PCPlus4E, JalE, RegWriteM, MemtoRegM, MemWriteM, ALUOutM, WriteDataM, WriteRegM, PCPlus4M, JalM); 

    input clk;
    input RegWriteE;
    input MemtoRegE;
    input MemWriteE;
    input [31:0] ALUInE;
    input [31:0] WriteDataE;
    input [4:0] WriteRegE;
    input [31:0] PCPlus4E;
    input JalE;

    output reg RegWriteM;
    output reg MemtoRegM;
    output reg MemWriteM;
    output reg [31:0] ALUOutM;
    output reg [31:0] WriteDataM;
    output reg [4:0] WriteRegM;
    output reg [31:0] PCPlus4M;
    output reg JalM;
    
    initial begin 
        RegWriteM = 0;
        MemtoRegM = 0;
        MemWriteM = 0;
        ALUOutM = 0;
        WriteDataM = 0;
        WriteRegM = 0;
        PCPlus4M = 0;
        JalM = 0;
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
    end

endmodule