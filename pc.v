module pc (input clk,input [31:0] nextPC,output [31:0] PC);
   reg [31:0] temp;
   initial
     temp = 31'h00100000;//temporary start

   assign  PC = temp;
   

   always @(posedge clk)
     temp = nextPC;
   
endmodule
