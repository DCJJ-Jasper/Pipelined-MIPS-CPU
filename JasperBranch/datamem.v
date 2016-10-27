


module datamem(clk, regv, rega, sys, MemWriteEight, MemWrite, Addr, Wdata, Rdata);

	input clk;
	input [31:0] regv;
	input [31:0] rega;
	input sys;
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

	//Adding Syscall
    reg [31:0] loc;

    always @(sys) begin
        if(sys == 1) begin
            if(regv == 4) begin//string
                loc = rega;
	 
                while(mem[loc] != 0) begin
                    //for(i=0; i<4; i = i+1)begin
                    //printString.putc(counter,instfile[loc][(8*(i+1)-1):(i*8)]);
                    //counter = counter + 1;
                    //end
                    $write("%s%s%s%s",mem[loc][7:0],mem[loc][15:8],mem[loc][23:16],mem[loc][31:24]);
                    loc = loc + 1;
                end

                //$display("%s",printString);
                $display("");
	 
            end
      

        end // if (sys == 1)
   end // always begin
   

endmodule
