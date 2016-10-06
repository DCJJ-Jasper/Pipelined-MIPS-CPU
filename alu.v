//Ari Faust 9/29
//operation ALU for Single Cycle CPU 
module alu( input [2:0] opcode, input [31:0] rs, input [31:0] rt,output [31:0] out);
   reg [31:0] temp;

   always@(*)begin
      
   case(opcode)//STARTCASE
     3'b000://and
     begin
	temp = rs & rt;
	
     end
     3'b001://or
     begin
	temp = rs | rt;
	
     end
     3'b010://add
     begin
	temp = rs + rt;
	
     end
     3'b110://sub
     begin
	temp = rs-rt;
	
     end
     3'b111://slt
     begin
	if(rs<rt)
	  begin
	     temp = 1;
	  end
        else
	  temp = 0;
	
     end
     
   default: temp = 0;
     
   endcase//ENDCASE
   
   end // always@ (*)
   
   assign out = temp;
   
endmodule

module test();
   
   reg [2:0] opcode = 3'b001;
   reg [31:0] rs = 32'b100;
   reg [31:0] rt = 32'b11;
   wire       [31:0] out;

   initial begin
      //#10 opcode = 3'b110;
      #10 rs = 11;
      #10 rt = 7;
   end

   initial
     $monitor("rs:%b rt:%b out:%b",rs,rt,out );

   alu one(opcode,rs,rt,out);
   
      
      
endmodule
