// datamem module

// This module mainly handles the memory read and memory write problem (sw, lw & sb).

// Also, if the system requests a print syscall (when sys is 1) and the given address is within the ram, then print the corresponding content.

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

	// Initialize mem
	initial begin
        for(i=32'hFFFFFFFF; i>=32'hFFFF0000; i=i-1)
        begin 
            mem[i]=0;
        end
    end

    // Initialize ram
    initial begin
        for(i=32'h00108000; i>=32'h00100000; i=i-1)
        begin 
            ram[i]=0;
        end
    end

    // Mem write (sw & sb)
	always@(posedge clk)
	begin
		if(MemWrite)
		begin
			if(Addr > 32'h00420000)
			begin
				mem[Addr] = Wdata; 
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
			end
			else	// else write to ram
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

	// Read the data with the given address
	assign Rdata = Addr > 32'h00420000 ? mem[Addr] : ram[Addr2];

	// Handling the part of syscall
    reg [31:0] loc;

    always @(sys) begin
        if(sys == 1) begin
            if(regv == 4 && (rega <32'h00400000 || rega > 32'h00400400))
            begin
                loc = rega >> 2;
	 
                while(ram[loc] != 0) begin
                    $write("%s%s%s%s",ram[loc][7:0],ram[loc][15:8],ram[loc][23:16],ram[loc][31:24]);

                    loc = loc + 1;
                end 
            end
        end 		// if (sys == 1)
   end 				// always begin
   

endmodule
