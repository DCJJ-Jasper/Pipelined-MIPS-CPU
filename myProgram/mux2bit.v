module mux2bit(in1, in2, in3, select, out);

	input [31:0] in1;
	input [31:0] in2; 
	input [31:0] in3;
	input [1:0] select; 
	output reg [31:0] out;

	always@ (in1,in2,in3,select)
	begin
		if (select == 2'b00)
			out <= in1;
		else if (select == 2'b01)
			out <= in2;
		else if (select == 2'b10)
			out <= in3;
	end

endmodule