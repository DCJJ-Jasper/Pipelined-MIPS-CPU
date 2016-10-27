


module datamem(clk, regv, rega, sys, MemWriteEight, MemWrite, Addr, Wdata, Rdata);

	input clk;
	input [31:0] regv;
	input [31:0] rega;
	input sys;
	input [31:0] Addr;
	input MemWriteEight;
	input MemWrite;
	input [31:0] Wdata;
	output reg [31:0] Rdata;

	reg [31:0] mem [32'hFFFFFFFF : 32'hFFFF0000];

 	reg [31:0] instfile [32'h00100000:32'h00105000];//32 32-bit registers

	integer x;	
	reg [31:0] Addr2;

	initial begin

        $readmemh("mem.in", instfile);
        for(x=32'hFFFFFFFF; x>=32'hFFFF0000; x=x-1)
        begin 
            mem[x]=0;
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
			if(Addr>32'hFFFF0000)
			begin
				mem[Addr] = Wdata; 
			end
			else
			begin
				Addr2 = Addr >> 2;
				instfile[Addr2] = Wdata; 
			end
			// $writememh("inputmem.hex", mem);

			//$display("double check mem[addr]: %0x", mem[Addr]);
		end
		if(Addr>32'hFFFF0000)
		begin
			if(MemWriteEight)
			begin
				mem[Addr][7:0] = Wdata[7:0];
			end	
			else
				Rdata = mem[Addr];
		end
		else
		begin
			Addr2 = Addr >> 2;
			if(MemWriteEight)
			begin
				instfile[Addr2][7:0] = Wdata[7:0];
			end	
			else
				Rdata = instfile[Addr2];
		end
	end

	//assign Rdata = mem[Addr];
	//$display("mem: % ", mem);


	//syscall

	reg [31:0] loc;

    //reg cont = 1;
    //string	   [800:0] printString;
    reg counter = 0;
    reg i;
 	always @(sys) begin
        if(sys == 1) begin
            if(regv == 1) begin //int
                $display("%d",rega);
            end

            if(regv == 4) begin//string
				if(Addr>32'hFFFF0000)
				begin
	 
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
				else
				begin
					loc = rega>>2;
	 
               		while(instfile[loc] != 0) begin
                    //for(i=0; i<4; i = i+1)begin
                    //printString.putc(counter,instfile[loc][(8*(i+1)-1):(i*8)]);
                    //counter = counter + 1;
                    //end
                    	$write("%s%s%s%s",instfile[loc][7:0],instfile[loc][15:8],instfile[loc][23:16],instfile[loc][31:24]);
                    	loc = loc + 1;
               		end

                	//$display("%s",printString);
                	$display("");
				end
	 
            end

            else if(regv == 10)begin//exit
               $finish;
            end
      

        end // if (sys == 1)
   end // always begin





endmodule
