


module datamem(MemWrite,MemRead,Addr,Wdata,Rdata);
	input [31:0] Addr
	input [31:0] Wdata;
	input MemWrite;
	input MemRead;
	output [31:0] Rdata;

	reg [31:0] Rdata;

	// TODO: need change here to figure out the way of accessing the memory
	reg [31:0] regfile[511:0];//32 32-bit registers

	always@(Addr,Wdata,MemWrite,MemRead)
		if(MemWrite)
		begin
			$display("Writing %d -> Addr: %d",Wdata,Addr);
			regfile[Addr]<=Wdata; //memory write
		end

	always@(Addr,Wdata,MemWrite,MemRead)
		if(MemRead)
			Rdata <= regfile[Addr];//memory read
endmodule
