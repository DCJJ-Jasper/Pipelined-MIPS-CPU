//Multiplexer will select between the two inputs based on the control(select) signal. 1 dictates input 1 and 0 dictates input 2
module mux(in1, in2, select, out);

	input [31:0] in1;
	input [31:0] in2; 
	input select; 
	output [31:0] out;

	assign out = (select)? in1 : in2;

endmodule
