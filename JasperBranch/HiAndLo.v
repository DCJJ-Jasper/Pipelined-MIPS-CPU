module HiAndLo(SrcAE, SrcBE, divE, mfE, Out);

	input [31:0] SrcAE;
	input [31:0] SrcBE; 
	input divE;
	input [1:0] mfE;
	output reg [31:0] Out;

	reg [31:0] Hi;
	reg [31:0] Lo;

	initial begin
		Out = 0;
		Hi = 0;
		Lo = 0;
	end

	always@ (SrcAE, SrcBE, divE, mfE)
	begin
		if(divE)
		begin
			Hi = SrcAE % SrcBE;
			Lo = SrcAE / SrcBE;
		end

		if (mfE == 2'b00)
			Out = 0;
		else if (mfE == 2'b10)
			Out = Hi;
		else if (mfE == 2'b11)
			Out = Lo;
	end

endmodule
