module instruction(input [31:0] counter, input [31:0] regv, input [31:0] rega, input sys, input [29:0] pc,output reg [31:0] inst);
   
    reg [31:0] instfile [32'h00100000:32'h00100100];//32 32-bit registers

    initial
    begin
        $readmemh("mem.in", instfile);
    end

    always @(*) 
    begin
        inst = instfile[pc];
    end
   
    //Adding Syscall
    reg [31:0] loc;

    //reg cont = 1;
    //string	   [800:0] printString;

    reg i;

    always @(sys) begin
        if(sys == 1) begin
            if(regv == 1) begin //int
                $display("%d",rega);
            end

            if(regv == 4) begin//string
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

            else if(regv == 10)begin//exit
                $display("Number of instruction:%d", counter );
                $display("Number of cycles:%d", ($time/100) );
                $display("IPC: %.16f", (counter/($time/100.0)) );
                $finish;
            end
      

        end // if (sys == 1)
   end // always begin
   
endmodule // instruction


/*

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
