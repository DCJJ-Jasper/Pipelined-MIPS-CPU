
module syscall(input [31:0] registers [31:0],input [31:0] instfile [32'h00100000:32'h00100100],input sys);
   reg [31:0] loc = registers[4];
	 //reg cont = 1;
	 //string	   [800:0] printString;
   reg 	    counter = 0;
   reg 	    i;
   always begin
   if(sys == 1)begin
      if(registers[2] == 1)begin//int
	 $display("%d",registers[4]);
	 
      end
      if(registers[2] == 4)begin//string
	 
	 
	 
	 while(instfile[loc] != 0)begin
	    //for(i=0; i<4; i = i+1)begin
	       //printString.putc(counter,instfile[loc][(8*(i+1)-1):(i*8)]);
	       //counter = counter + 1;
	    //end
	    $display("%s",instfile[loc]);
	    loc = loc + 1;
	    
	 end
	 //$display("%s",printString);
	 
      end
      else if(registers[2] == 10)begin//exit
	 $finish;
      end
      

   end // if (sys == 1)
   end // always begin
   
endmodule
