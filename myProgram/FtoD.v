// FtoD modules

// This module is one of the pipeline register module which passes through PC address and instruction within the fetch state to decode state every clock cycle.

// Also, it would stall, if the hazard control unit gives StallD == 1.

module FtoD(clk, StallD, PCSrcD, InstrF, PCPlus4F, InstrD, PCPlus4D); 

    input clk;
    input StallD;
    input PCSrcD;
    input [31:0] InstrF;
    input [31:0] PCPlus4F;

    output reg [31:0] InstrD;
    output reg [31:0] PCPlus4D;

    // Initialize for the beginning.
    initial begin 
        InstrD = 0;
        PCPlus4D = 32'h00100000; 
    end 

    always@(posedge clk)
    begin      
        // If there is no stall, pass through PC address and instruction
        if(!StallD) 
        begin
            InstrD <= InstrF;
            PCPlus4D <= PCPlus4F; 
        end
    end

endmodule