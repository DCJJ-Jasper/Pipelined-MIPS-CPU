// mux5 module

// This module helps to select which of the two inputs would be taken based on the selected signal. In this case, two inputs are 5 bits instead.


module mux5(in1, in2, select, out);

	input [4:0] in1;
	input [4:0] in2; 
	input select; 
	output [4:0] out;

	assign out = (select)? in1 : in2;

endmodule
