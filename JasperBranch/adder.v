
module adder(pc_out, pc_in);

	input [31:0] pc_out; 
	output [31:0] pc_in;

	assign pc_in = pc_out + 4;

endmodule
