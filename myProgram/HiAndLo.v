// HiAndLo module

// This module implements div and mult arithmetic for our pipeline cpu.
// Also, it contains the Hi and Lo, these two registers.

// Based on mfE signals, this module will output the corresponding value which is requested from the instruction.


module HiAndLo(SrcAE, SrcBE, divE, multE, mfE, Out);

	input [31:0] SrcAE;
	input [31:0] SrcBE; 
	input divE;
	input multE;
	input [1:0] mfE;
	output reg [31:0] Out;

	reg [31:0] Hi;
	reg [31:0] Lo;

	reg [63:0] multOut;

	// Initialize for the beginning 
	initial begin
		Out = 0;
		Hi = 0;
		Lo = 0;
	end

	always@ (SrcAE, SrcBE, divE, multE, mfE)
	begin
		// If there is a div, does div
		if(divE)
		begin
			Hi = SrcAE % SrcBE;
			Lo = SrcAE / SrcBE;
		end

		// If there is a mult, does mult
		if(multE)
		begin
			multOut = SrcAE * SrcBE;
			Hi = multOut[63:32];
			Lo = multOut[31:0];
		end

		// Pass through the corresponding output
		if (mfE == 2'b00)	// Do nothing
			Out = 0;
		else if (mfE == 2'b10)	// mfhi
			Out = Hi;
		else if (mfE == 2'b11)	// mflo
			Out = Lo;
	end

endmodule
