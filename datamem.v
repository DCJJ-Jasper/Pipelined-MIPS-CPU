


module datamem(MemWrite,MemRead,Addr,Wdata,Rdata);

	input [31:0] Addr;
	input MemWrite;
	input MemRead;
	input [31:0] Wdata;
	output reg [31:0] Rdata;

	reg [31:0] regfile[511:0];	//32 32-bit registers

	//memory write
	always@(MemWrite,Addr,Wdata)
		if(MemWrite)
		begin
			$display("Writing %d -> Addr: %d",Wdata,Addr);
			regfile[Addr] <= Wdata; 
		end

	//memory read
	always@(MemRead,Addr)
		if(MemRead)
			Rdata <= regfile[Addr];	
endmodule
