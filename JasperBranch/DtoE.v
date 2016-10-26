module DtoE(clk, FlushE, RegWriteD, MemtoRegD, MemWriteD, MemWriteSBD, ALUControlD, ALUSrcD, RegDstD, data1D, data2D, RsD, RtD, RdD, SignImmD, PCPlus4D, JalD, sysD, regvD, regaD, RegWriteE, MemtoRegE, MemWriteE, MemWriteSBE, ALUControlE, ALUSrcE, RegDstE, data1E, data2E, RsE, RtE, RdE, SignImmE, PCPlus4E, JalE, sysE, regvE, regaE); 

    input clk;
    input FlushE;
    input RegWriteD;
    input MemtoRegD;
    input MemWriteD;
    input MemWriteSBD;
    input [2:0] ALUControlD;
    input ALUSrcD;
    input RegDstD;
    input [31:0] data1D;
    input [31:0] data2D;
    input [4:0] RsD;
    input [4:0] RtD;
    input [4:0] RdD;
    input [31:0] SignImmD;
    input [31:0] PCPlus4D;
    input JalD;
    input [31:0] regvD;
    input [31:0] regaD;
    input sysD;

    output reg RegWriteE;
    output reg MemtoRegE;
    output reg MemWriteE;
    output reg MemWriteSBE;
    output reg [2:0] ALUControlE;
    output reg ALUSrcE;
    output reg RegDstE;
    output reg [31:0] data1E;
    output reg [31:0] data2E;
    output reg [4:0] RsE;
    output reg [4:0] RtE;
    output reg [4:0] RdE;
    output reg [31:0] SignImmE;
    output reg [31:0] PCPlus4E;
    output reg JalE;
    output reg [31:0] regvE;
    output reg [31:0] regaE;
    output reg sysE;

    always@(posedge clk)
    begin
        if(FlushE)
        begin
            RegWriteE <= 0;
            MemtoRegE <= 0;
            MemWriteE <= 0;
            MemWriteSBE <= 0;
            ALUControlE <= 0;
            ALUSrcE <= 0;
            RegDstE <= 0;
            data1E <= 0;
            data2E <= 0;
            RsE <= 0;
            RtE <= 0;
            RdE <= 0;
            SignImmE <= 0;
            PCPlus4E <= 0;
            JalE <= 0;
			regvE <= 0;
            regaE <= 0;
            sysE <= 0;
        end
        else
        begin
            RegWriteE <= RegWriteD;
            MemtoRegE <= MemtoRegD;
            MemWriteE <= MemWriteD;
            MemWriteSBE <= MemWriteSBD;
            ALUControlE <= ALUControlD;
            ALUSrcE <= ALUSrcD;
            RegDstE <= RegDstD;
            data1E <= data1D;
            data2E <= data2D;
            RsE <= RsD;
            RtE <= RtD;
            RdE <= RdD;
            SignImmE <= SignImmD;
            PCPlus4E <= PCPlus4D;
            JalE <= JalD;
			regvE <= regvD;
            regaE <= regaD;
            sysE <= sysD;
        end
    end
endmodule
