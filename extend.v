module extend(input [15:0] immediate,output [31:0] extened);
   assign extened = immediate;

endmodule // extend

     
module test();
   wire [15:0]immed = 16'h 4241;
   wire [31:0] extend;
   
    initial
     $monitor("immed:%h extend:%h",immed,extend);
   extend e(immed,extend);
   
endmodule // test

   
