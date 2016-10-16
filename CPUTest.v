module test();
   reg clk =0;
   top cpu(clk);
   initial begin
      
   end
   always
     clk= ~clk;
   

endmodule
