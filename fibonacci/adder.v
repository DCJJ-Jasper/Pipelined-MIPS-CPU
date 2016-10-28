// Adder module

// This module adds 4 to the input PC address.

module adder(addr_in, addr_out);

	input [31:0] addr_in; 
	output [31:0] addr_out;

	assign addr_out = addr_in + 4;

endmodule
