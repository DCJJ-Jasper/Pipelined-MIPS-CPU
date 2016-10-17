module FtoD(clk, StallD, PCSrcD, InstrF, PCPlus4F, InstrD, PCPlus4D); 

    input clk;
    input StallD;
    input PCSrcD;
    input [31:0] InstrF;
    input [31:0] PCPlus4F;

    output reg [31:0] InstrD;
    output reg [31:0] PCPlus4D;

    initial begin 
        InstrD = 0;
        PCPlus4D = 32'h00100000; // Is it correct?
    end 

    always@(posedge clk)
    begin      
        if(!StallD)
        begin
            if(PCSrcD)
            begin
                InstrD <= 0;
                PCPlus4D <= 32'h00100000; 
            end
            else
            begin
                InstrD <= InstrF;
                PCPlus4D <= PCPlus4F; 
            end
        end
    end

endmodule