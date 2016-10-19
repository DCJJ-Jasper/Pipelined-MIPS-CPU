module PC_StallF(clk, StallF, PC, PCF); 

    input clk;
    input StallF;
    input [31:0] PC;

    output reg [31:0] PCF;

    initial begin 
        PCF = 32'h00400030; // Is it correct?
    end 

    always@(posedge clk)
    begin      
        if(!StallF)
        begin
            PCF <= PC;
        end
        else 
        begin
            // Is it correct? Stay the same as what professor told me 
            PCF <= PCF; 
        end
    end

endmodule
