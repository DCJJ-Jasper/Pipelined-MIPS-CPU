#Pipelined MIPS CPU
####CSCI 320 Project 2
##### Ari Faust, Terence McHugh, Jasper Ding
----
##MODULES
####Instruction Memory
Our instruction memory module takes in the program count and outputs the 32 bit instruction. We also have the value of our v0 and a0 regsiters as well as a syscall control signal.
```
module instruction(input [31:0] regv, input [31:0] rega, input sys, input [29:0] pc,output reg [31:0] inst);
```
Our instruction file is represented as an array 
``` 
reg [31:0] instfile [32'h00100000:32'h00100100];
```

####Registers


####Control Unit


####Multiplexer



####ALU



####Data Memory


####Hazard Unit


####Pipleline Registers