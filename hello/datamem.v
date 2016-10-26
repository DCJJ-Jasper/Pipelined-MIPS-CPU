//Data memory takes in the clock, MemWrite signal, 32 bit Address, as well as Wdada and Rdata signals as input. At every signal from the clock the write signal is checked and if it is a write, the specific address is assigned to the data value. 


module datamem(clk, MemWrite, Addr, Wdata, Rdata);

	input clk;
	input [31:0] Addr;
	input MemWrite;
	input [31:0] Wdata;
	output [31:0] Rdata;

	reg [31:0] mem [32'hFFFFFFFF : 32'hFFFFFF00];

	integer i;	

	initial begin
        for(i=32'hFFFFFFFF; i>=32'hFFFFFF00; i=i-1)
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
	end

	assign Rdata = mem[Addr];
	//$display("mem: % ", mem);



endmodule
