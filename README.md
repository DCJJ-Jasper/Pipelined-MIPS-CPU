# Pipelined MIPS CPU
#### CSCI 320 Project 2
##### Ari Faust, Terence McHugh, Jasper Ding
----
## Jump Logic

## Branch Logic

## SLL

## SRA

## DIV

----
## MODULES
#### Instruction Memory
```
module instruction(input [31:0] regv, input [31:0] rega, input sys, input [29:0] pc,output reg [31:0] inst);
```
Our instruction memory module takes in the program count and outputs the 32 bit instruction. We also have the value of our v0, a0, and  syscall control signal as input. Here the instruction is stored and at the tick of every clock the new program count is used to output a new instruction.

Our instruction file is represented as an array 
``` 
reg [31:0] instfile [32'h00100000:32'h00100100];
```
Which is read in from a file using readmemh

##### System Calls
These as explained are handled within the instruction module.
We support print integer, print string, and exit system calls based on the $v0 value. 
Exit calls a simple $finish command.
Integer prints the value at $a0
String will iterate through the characters and use $write to write each one

#### Registers
```
module register(input clk,input[4:0] register1,input[4:0] register2,input[4:0] writeregister,input[31:0] data,input regWrite,output reg [31:0]data1,output reg [31:0]data2,output [31:0]regv,output [31:0]rega);
```
Our register module takes as input the clock, the two source registers, regwrite signal, the destination register, data(an immediate value), the registers are also output with two different 32 bit values immediates (data1 and data2) coming from either the alu or memory. This module functions to store the values of all of our 32 bit registers used to compute in our processor. In the case of a register write the module responds will respond to the signal comming from the writeback stage and write to the appropriate register.

This is the representation of hardware storage from the register module:
```
reg [31:0] mymem [5'b11111 : 5'b00000];
```

This is what occurs when a 32 bit value is stored in a register:
```
if(regWrite == 1)
        begin
            mymem[writeregister]=data;
        end
```
#### Control Unit
```
module control(opcode,func,regDst, jump, branch, memRead, memToReg, ALUop, regWrite,ALUSrc,memWrite,sys,jr,jal);
```
The control module takes in the opcode and function code for every instruction. Many wires are output, the majority being simple 1-bit wires. the alu code is longer because it specifies what operation to form. These signals are what control the flow of our processor defining the behavior. The signals incorporate jump logic, changing memory, register reading and writing, and system calls. Case statements are used identify the type of instruction.

```
	always @(*) begin
		case (opcode)
	        `SPECIAL: begin
	            case (func)
					`ADD: begin
					regDst <= 1'b1;
					   jump <= 1'b0;
					   branch <= 1'b0;
					   memRead <= 1'b0; 
					   memToReg <= 1'b0; 
					   ALUop <= 3'b010;
					   regWrite <= 1'b1;
					   ALUSrc <= 1'b0;
					   memWrite <= 1'b0;
					   sys <= 1'b0;
					   jr <= 1'b0;
					   jal <= 1'b0;
					end 	

```
Here we can see that there is a second case imbedded to handle special cases when the opcode is all 0.
Additionally all signals are initialized to 0 and the ALUop xxx

#### Multiplexers
Multiplexer will select between the two inputs based on the control(select) signal. 1 dictates input 1 and 0 dictates input 2
```
module mux(in1, in2, select, out);
```
The cpu also makes use of multiple two bit multiplexers:
```
module mux2bit(in1, in2, in3, select, out);
```
The two bit functions in a similar way however there are 3 potential values and one more statement to handle with the select. The signal (select) is two bits. This is very effective for us to impliment our forwarding logic.



#### ALU
```
module alu(opcode, rs, rt, out);
```
The alu takes in the 3 bit opcode, rs value, rt value, and outputs a single 32 bit value. Alu has a case statement that takes in the opcode and depending on the opcode value a different operation is performed on the two value registers.

```
always@(*) begin
        case(opcode)   
            3'b000:    
            begin
                temp = rs & rt;
            end

            3'b001:    
            begin
                temp = rs | rt;
            end
```
And continues in this format for +, <<,and -




#### Data Memory
Data memory is represented as:
```
reg [31:0] mem [32'hFFFFFFFF : 32'hFFFFFF00];
```
Data memory takes in the clock, MemWrite signal, 32 bit Address, as well as Wdada and Rdata signals. At every signal from the clock the write signal is checked and if it is a write, the specific address is assigned to the data value. 
```
mem[Addr] = Wdata;
```
Read values are constantly assigned and later are only used if called for.

#### Hazard Unit
```
module HazardUnit(BranchD, WriteRegE, MemtoRegE, RegWriteE, WriteRegM, MemtoRegM, RegWriteM, WriteRegW, RegWriteW, RsD, RtD, RsE, RtE, StallF, StallD, FlushE, ForwardAD, ForwardBD, ForwardAE, ForwardBE); 
```
The hazard unit handles many different signals. It takes in the registers that are to be written to at stages Execution, Memory, and Write as well input signals regarding writing wrtiging data from memory. The registers used in the decode stage as sources are also inputs for the hazard unit.
The hazard unit outputs 7 different wires, these regard stalling at if there are any data hazards which can be identified with the inputs. If it is possible to forward, the hazard units has logic to output to the multiplexers that the forwarded value should be used for a given cycle.

For instance our AD forward case:
```
always@(RegWriteM, WriteRegM, RsD)
    begin      
        if (RegWriteM & (RsD == WriteRegM) & (RsD != 0))
            ForwardAD = 1;  
        else
            ForwardAD = 0; 
    end
``
This particular forward will enable us to forward one execution stage to the next so that the Rs from that stage is replaced with the forwarded value. This is how we allow the program to run without stalls.

Stalling occurs in the instance where we have conflicting rt registers in the execute and decode stage or the rs for the instruction at decode matches that of rt value in execute. We cannot carry through so the program outputs stall signals and flushes like such:
```
if (MemtoRegE & ((RtE == RtD)|(RtE == RsD)))   
        begin
            StallF = 1;
            StallD = 1;
            FlushE = 1;
        end
```


#### Pipleline Registers
All of our registers function in that they take all of the values output in a particular stage and store them until the tick of the next clock cycle. At this point they are assigned to output and continue on to the next stage.

This is what the functionality within the registers looks like, this particular example is our Memory to Write register:
```
 always@(posedge clk)
    begin      
        RegWriteW <= RegWriteM;
        MemtoRegW <= MemtoRegM;
        ReadDataW <= ReadDataM;
        ALUOutW <= ALUOutM;
        WriteRegW <= WriteRegM;
        PCPlus4W <= PCPlus4M;
        JalW <= JalM;
		regvW <= regvM;
        regaW <= regaM;
        sysW <= sysM;
    end
```

Fetch to decode register
```
module FtoD(clk, StallD, PCSrcD, InstrF, PCPlus4F, InstrD, PCPlus4D); 
```

Decode to Execute register
```
module DtoE(clk, FlushE, RegWriteD, MemtoRegD, MemWriteD, ALUControlD, ALUSrcD, RegDstD, data1D, data2D, RsD, RtD, RdD, SignImmD, PCPlus4D, JalD, sysD, regvD, regaD, RegWriteE, MemtoRegE, MemWriteE, ALUControlE, ALUSrcE, RegDstE, data1E, data2E, RsE, RtE, RdE, SignImmE, PCPlus4E, JalE, sysE, regvE, regaE); 
```

Execute to Memory register
```
module EtoM(clk, RegWriteE, MemtoRegE, MemWriteE, ALUInE, WriteDataE, WriteRegE, PCPlus4E, JalE, sysE, regvE, regaE, RegWriteM, MemtoRegM, MemWriteM, ALUOutM, WriteDataM, WriteRegM, PCPlus4M, JalM, sysM, regvM, regaM); 
```

Memory to Writeback register
```
module MtoW(clk, RegWriteM, MemtoRegM, ReadDataM, ALUOutM, WriteRegM, PCPlus4M, JalM, sysM, regvM, regaM, RegWriteW, MemtoRegW, ReadDataW, ALUOutW, WriteRegW, PCPlus4W, JalW, sysW, regvW, regaW); 
```

