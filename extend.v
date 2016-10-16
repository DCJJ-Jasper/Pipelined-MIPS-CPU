module extend(input [15:0] immediate,output [31:0] extened);
   wire [31:0] all1 = 32'hffff0000;
   
   assign extened = (immediate[15]==0) ? immediate : immediate+all1;

endmodule // extend

     
module test();
   reg [15:0]immed = 16'h8241;
   wire [31:0] extend;
   initial begin
     immed = 16'h4241;
      
      
   end
    initial
     $monitor("immed:%b extend:%b",immed,extend);
   extend e(immed,extend);
   
endmodule // test

   
