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

	initial begin
		Out = 0;
		Hi = 0;
		Lo = 0;
	end

	always@ (SrcAE, SrcBE, divE, multE, mfE)
	begin
		if(divE)
		begin
			Hi = SrcAE % SrcBE;
			Lo = SrcAE / SrcBE;
		end

		if(multE)
		begin
			multOut = SrcAE * SrcBE;
			Hi = multOut[63:32];
			Lo = multOut[31:0];
		end

		if (mfE == 2'b00)
			Out = 0;
		else if (mfE == 2'b10)
			Out = Hi;
		else if (mfE == 2'b11)
			Out = Lo;
	end

endmodule
