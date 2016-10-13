module DtoE(clk, FlushE, RegWriteD, MemtoRegD, MemWriteD, ALUControlD, ALUSrcD, RegDstD, BranchD, RsD, RtD, RdD, SignImmD, RegWriteE, MemtoRegE, MemWriteE, ALUControlE, ALUSrcE, RegDstE, RsE, RtE, RdE, SignImmE); 

    input clk;
    input FlushE;
    input RegWriteD;
    input MemtoRegD;
    input MemWriteD;
    input [2:0] ALUControlD;
    input ALUSrcD;
    input RegDstD;
    input [4:0] RsD;
    input [4:0] RtD;
    input [4:0] RdD;

    input [31:0] SignImmD;

    output reg RegWriteE;
    output reg MemtoRegE;
    output reg MemWriteE;
    output reg [2:0] ALUControlE;
    output reg ALUSrcE;
    output reg RegDstE;
    output reg [4:0] RsE;
    output reg [4:0] RtE;
    output reg [4:0] RdE;

    output reg [31:0] SignImmE;

    always(@posedge clk)
    begin
        if(FlushE)
        begin
            RegWriteE <= 0;
            MemtoRegE <= 0;
            MemWriteE <= 0;
            ALUControlE <= 0;
            ALUSrcE <= 0;
            RegDstE <= 0;
            RsE <= 0;
            RtE <= 0;
            RdE <= 0;

            SignImmE <= 0;
        end
        else
        begin
            RegWriteE <= RegWriteD;
            MemtoRegE <= MemtoRegD;
            MemWriteE <= MemWriteD;
            ALUControlE <= ALUControlD;
            ALUSrcE <= ALUSrcD;
            RegDstE <= RegDstD;
            RsE <= RsD;
            RtE <= RtD;
            RdE <= RdD;

            SignImmE <= SignImmD;
        end
    end

endmodule