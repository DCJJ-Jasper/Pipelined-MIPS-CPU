module EtoM(clk, RegWriteE, MemtoRegE, MemWriteE, ALUInE, WriteDataE, WriteRegE, RegWriteM, MemtoRegM, MemWriteM, ALUOutM, WriteDataM, WriteRegM); 

    input clk;
    input RegWriteE;
    input MemtoRegE;
    input MemWriteE;
    input [31:0] ALUInE;
    input [31:0] WriteDataE;
    input [4:0] WriteRegE;

    output reg RegWriteM;
    output reg MemtoRegM;
    output reg MemWriteM;
    output reg [31:0] ALUOutM;
    output reg [31:0] WriteDaraM;
    output reg [4:0] WriteRegM;
    

    always(@posedge clk)
    begin      
        RegWriteM <= RegWriteE;
        MemtoRegM <= MemtoRegE;
        MemWriteM <= MemWriteE;
        ALUOutM <= ALUInE;
        WriteDataM <= WriteDataE;
        WriteRegM <= WriteRegE;
    end

endmodule