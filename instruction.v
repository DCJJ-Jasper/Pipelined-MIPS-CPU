module instruction(input [29:0] pc,output reg [31:0] inst);
   
   reg [31:0] instfile [32'h00100000:32'h00100100];//32 32-bit registers
   initial
     begin
	$readmemh("mem.in", instfile);
     end

   always @(*) 
     begin
	inst = instfile[pc];
     end
   
endmodule // instruction

module test();
   reg [29:0] pc = 32'h00100000;
   wire [31:0] inst;
   
 
   initial begin
      #10  pc = 32'h00100000;
      #10  pc = 32'h00100001;
      #10  pc = 32'h00100002;
      #10  pc = 32'h00100003;
      
   end

   initial
     $monitor("oppc:%h inst:%h",pc,inst);

   instruction one(pc,inst);
   
      
      
endmodule
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
