


module datamem(clk, MemWrite, Addr, Wdata, Rdata);

	input clk;
	input [31:0] Addr;
	input MemWrite;
	input [31:0] Wdata;
	output [31:0] Rdata;

	reg [31:0] mem [32'hFFFFFFFF : 32'hFFFFFFE0];	

	initial begin
		$readmemh("inputmem.hex", mem);
	end

	//memory write
	always@(posedge clk)
	begin
		if(MemWrite)
		begin
			//$display("Writing %d -> Addr: %d",Wdata,Addr);
			mem[Addr] = Wdata; 
			// Perhaps, need to change later
			$writememh("inputmem.hex", mem);
		end
	end

	assign Rdata = mem[Addr];


endmodule
