module PC_StallF(clk, StallF, PC, PCF, counter); 

    input clk;
    input StallF;
    input [31:0] PC;

    output reg [31:0] PCF;

    output reg [31:0] counter;

    initial begin 
        PCF = 32'h00400030;
        counter = 0;
    end 

    always@(posedge clk)
    begin      
        if(!StallF)
        begin
            PCF <= PC;
            counter <= counter + 1;
        end
        else 
        begin
            PCF <= PCF; 
            counter <= counter;
        end
    end

endmodule
