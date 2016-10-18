module pc (input clk,input [31:0] nextPC,output [31:0] PC);

	reg [31:0] temp;
	initial
	temp = 31'h0010000c;//temporary start

	assign PC = temp;
   

	always @(posedge clk)
		temp = nextPC;
   
endmodule
