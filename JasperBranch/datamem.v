


module datamem(clk,MemWrite,MemRead,Addr,Wdata,Rdata);

	input clk;
	input [31:0] Addr;
	input MemWrite;
	input MemRead;
	input [31:0] Wdata;
	output reg [31:0] Rdata;

	reg [31:0] mem [32'h00100000 : 32'h00100004];	

	initial begin
		$readmemh("inputmem.hex", mem);
	end

	//memory write
	always@(posedge clk)
	begin
		if(MemWrite)
		begin
			//$display("Writing %d -> Addr: %d",Wdata,Addr);
			mem[Addr] <= Wdata; 
			// Perhaps, need to change later
			$writememh("inputmem.hex", mem);
		end

		if(MemRead)
			Rdata <= mem[Addr];
	end


endmodule
