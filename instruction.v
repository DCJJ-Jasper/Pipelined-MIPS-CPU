module instruction(input [29:0] pc,output reg [31:0] inst);
   
   reg [31:0] instfile[32h'00100000:32h'00200000];//32 32-bit registers
   initial
     begin
	$readmemh("mem.in", instfile);
     end

   always @(*) 
     begin
	insttemp = mymem[pc];
     end
   
endmodule // instruction