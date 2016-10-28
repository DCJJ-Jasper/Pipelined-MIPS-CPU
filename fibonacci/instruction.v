// Instruction module

// This module finds and passes the instruction based on the given PC address.

// Also, it does the part of the syscall logic:
//      1. exit
//      2. print (When the content is within the instruction mem)
//      3. break (Even though it is not touched in this case)

module instruction(input [31:0] counter, input [31:0] regv, input [31:0] rega, input sys, input break, input [29:0] pc,output reg [31:0] inst);
   
    reg [31:0] instfile [32'h00100000:32'h00100100];//32 32-bit registers

    // Initialize it 
    initial
    begin
        $readmemh("mem.in", instfile);
    end

    // Pass the instruction with the given PC address
    always @(*) 
    begin
        inst = instfile[pc];
    end
   
    // Adding Syscall logic
    reg [31:0] loc;
    reg i;

    always @(sys) begin
        if(sys == 1) begin
            //int
            if(regv == 1) 
            begin 
                $display("%d",rega);
            end

            // Break
            if (break == 1) begin
                $error("Someone told me to break it.");
            end

            // Print syscall
            if(regv == 4 && rega >32'h00400000 && rega < 32'h00400400) begin//string
                loc = rega>>2;
	 
                while(instfile[loc] != 0) begin
                    $write("%s%s%s%s",instfile[loc][7:0],instfile[loc][15:8],instfile[loc][23:16],instfile[loc][31:24]);

                    loc = loc + 1;
                end

	 
            end

            // Exit syscall
            else if(regv == 10)
            begin
                $display("");
                $display("Number of instruction:%d", counter );
                $display("Number of cycles:%d", ($time/100) );
                $display("IPC: %.16f", (counter/($time/100.0)) );
                $finish;
            end
      

        end         // if (sys == 1)
   end              // always begin
   
endmodule 


/* 
// Inidividual test module
module test();
   reg [29:0] pc = 32'h00100000;
   wire [31:0] inst;
   reg [31:0]   regv = 4;
   reg [31:0] 	rega = 32'h00100024;
   reg 		sys = 0;
   
   
 
   initial begin
      sys=1;
      
      #10  pc = 32'h00100000;
      #10  pc = 32'h00100001;
      #10  pc = 32'h00100002;
      #10  pc = 32'h00100003;
      
   end

   initial
     $monitor("oppc:%h inst:%h",pc,inst);

   instruction one(regv,rega,sys,pc,inst);
   
      
      
endmodule
*/
