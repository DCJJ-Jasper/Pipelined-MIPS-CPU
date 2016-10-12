module shiftleft2(input [31:0] instr,output [31:0] newinstr);
   assign newinstr = instr*4;

endmodule // extend
