


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

	reg [31:0] ram [32'h00108000 : 32'h00100000];
	wire [31:0] Addr2;

	integer i;	

	assign Addr2 = Addr >> 2;

	initial begin
        for(i=32'hFFFFFFFF; i>=32'hFFFF0000; i=i-1)
        begin 
            mem[i]=0;
        end
    end

    initial begin
        for(i=32'h00108000; i>=32'h00100000; i=i-1)
        begin 
            ram[i]=0;
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
			if(Addr > 32'h00420000)
			begin
				//$display("Writing %0x -> Addr: %0x",Wdata,Addr);

				mem[Addr] = Wdata; 

				// $writememh("inputmem.hex", mem);

				//$display("double check mem[addr]: %0x", mem[Addr]);
			end
			else
			begin 
				ram[Addr2] = Wdata; 
			end
		end

		if(MemWriteEight)
		begin
			if(Addr > 32'h00420000)
			begin
				//$display("Writing %0x -> Addr: %0x",Wdata,Addr);
				case(Addr[1:0])
					2'b11: begin
						mem[Addr][7:0] = Wdata[7:0]; 
					end
					2'b10: begin
						mem[Addr][15:8] = Wdata[7:0]; 
					end
					2'b01: begin
						mem[Addr][23:16] = Wdata[7:0]; 
					end
					2'b00: begin
						mem[Addr][31:24] = Wdata[7:0]; 
					end

				endcase 
				mem[Addr][7:0] = Wdata[7:0]; 

				// $writememh("inputmem.hex", mem);

				//$display("double check mem[addr]: %0x", mem[Addr]);
			end
			else
			begin 
				case(Addr[1:0])
					2'b11: begin
						ram[Addr2][31:24] = Wdata[7:0]; 
					end
					2'b10: begin
						ram[Addr2][23:16] = Wdata[7:0]; 
					end
					2'b01: begin
						ram[Addr2][15:8] = Wdata[7:0]; 
					end
					2'b00: begin
						ram[Addr2][7:0] = Wdata[7:0]; 
					end

				endcase 
			end
		end
		
	end

	assign Rdata = Addr > 32'h00420000 ? mem[Addr] : ram[Addr2];



	//$display("mem: % ", mem);

	//Adding Syscall
    reg [31:0] loc;

    always @(sys) begin
        if(sys == 1) begin
            if(regv == 4) begin//string
                loc = rega >> 2;
	 
                while(ram[loc] != 0) begin
                    //for(i=0; i<4; i = i+1)begin
                    //printString.putc(counter,instfile[loc][(8*(i+1)-1):(i*8)]);
                    //counter = counter + 1;
                    //end
                    $write("%s%s%s%s",ram[loc][7:0],ram[loc][15:8],ram[loc][23:16],ram[loc][31:24]);
                    loc = loc + 1;
                end

                //$display("%s",printString);
                $display("");
	 
            end
      

        end // if (sys == 1)
   end // always begin
   

endmodule
