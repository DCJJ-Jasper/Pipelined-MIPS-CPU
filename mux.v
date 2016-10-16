module mux(in1, in2, select, out);

	input [31:0] in1;
	input [31:0] in2; 
	input select; 
	output [31:0] out;

	assign out = (select)? in1 : in2;

endmodule
