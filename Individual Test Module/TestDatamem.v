

module TestDatamem;

	reg clk;
	reg [31:0] Addr;
	reg MemWrite;
	reg MemRead;
	reg [31:0] Wdata;

	wire [31:0] Rdata;

	datamem DMem(clk,MemWrite,MemRead,Addr,Wdata,Rdata);

	initial begin
		clk = 0;
		Addr = 'h00100001;
		MemWrite = 0;
		MemRead = 0;
		Wdata = 0;

		# 50
		clk = 1;
		# 50 
		clk = 0;

		MemRead = 1;

		# 50
		clk = 1;
		# 50 
		clk = 0;

		# 50
		MemRead = 0;
		MemWrite = 1;

		Wdata = 'h0000000F;

		# 50
		clk = 1;
		# 50 
		clk = 0;

		MemRead = 1;
		MemWrite = 0;

		# 50
		clk = 1;
		# 50 
		clk = 0;

		#1000 $finish;

	end

	initial 
	begin 
		$monitor($time, "in %m, Rdata = %08x, Wdata = %08x" , Rdata, Wdata);
	end

	always #50 clk = ~clk;

endmodule