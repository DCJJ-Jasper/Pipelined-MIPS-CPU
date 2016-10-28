// PC_StallF

// This module passes through PC if there is no stall given from the hazard control unit.

// Also, it helps to count how many instructions the pipeline cpu has taken.

module PC_StallF(clk, StallF, PC, PCF, counter); 

    input clk;
    input StallF;
    input [31:0] PC;

    output reg [31:0] PCF;
    output reg [31:0] counter;

    // Initialize for the beginning
    initial begin 
        PCF = 32'h00400030;
        counter = 0;
    end 

    always@(posedge clk)
    begin

        if(!StallF) // If there is no stall, pass through the PC and add one to counter    
        begin
            PCF <= PC;
            counter <= counter + 1;
        end
        else        // else pass the previous value as the output
        begin
            PCF <= PCF; 
            counter <= counter;
        end
    end

endmodule
