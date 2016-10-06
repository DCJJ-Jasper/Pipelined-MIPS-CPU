//Terence McHugh
module register(input[4:0] register1,input[4:0] register2,input[4:0] writeregister,input[31:0] data,input regWrite,output[31:0]data1,output[31:0]data2);
   
   reg [31:0] mymem [5'b11111 : 5'b00000];//array of 32 indexes with 32 bit numbers as values
   integer i;
   initial begin
      for(i=5'b0; i<5'b11111; i=i+1)begin //set mem values to 0
	 mymem[i]=0;
      end
   end
   
   assign data1 = mymem[register1];//read regester1 to data 1
   assign data2 = mymem[register2];//read register 2 to data 2
   
   always @(posedge regWrite) //when the control goes on it knows to write
     begin
	if(regWrite ==1)//if write is on write to writeregister
	  begin
	     mymem[writeregister]=data;
	  end
     end
endmodule // register

