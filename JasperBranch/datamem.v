


module datamem(clk, MemWriteEight, MemWrite, Addr, Wdata, Rdata);

	input clk;
	input [31:0] Addr;
	input MemWriteEight;
	input MemWrite;
	input [31:0] Wdata;
	output [31:0] Rdata;

	reg [31:0] mem [32'hFFFFFFFF : 32'hFFFF0000];

	integer i;	

	initial begin
        for(i=32'hFFFFFFFF; i>=32'hFFFF0000; i=i-1)
        begin 
            mem[i]=0;
        end
    end

	/*
	initial begin
		$readmemh("inputmem.hex", mem);
	end
	*/

	//memory write
	always@(posedge clk)
	begin
		if(MemWrite)
		begin
			//$display("Writing %0x -> Addr: %0x",Wdata,Addr);

			mem[Addr] = Wdata; 

			// $writememh("inputmem.hex", mem);

			//$display("double check mem[addr]: %0x", mem[Addr]);
		end

		if(MemWriteEight)
		begin
			mem[Addr][7:0] = Wdata[7:0];
		end
		
	end

	assign Rdata = mem[Addr];
	//$display("mem: % ", mem);



endmodule
