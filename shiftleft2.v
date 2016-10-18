module shiftleft2(input [25:0] instr,output [27:0] newinstr);
   assign newinstr = instr*4;

endmodule // extend

/*
module test();
   wire [31:0]instr = 32'h 86000031;
   wire [31:0] newin;
   
    initial
     $monitor("immed:%h extend:%h",instr,newin);
  shiftleft2 s(instr,newin);
   
endmodule // test
*/
