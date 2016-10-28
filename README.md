# Pipelined MIPS CPU
#### CSCI 320 Project 2
##### Ari Faust, Terence McHugh, Jasper Ding
----

## First of all, here is the broad picture of our pipelined misp cpu:

![alt
text](broad_picture.png)

(Notes: The colored parts are the parts which are added by us for the extra logic, and all the diagrams shown below are color related to this broad picture.)

----
## Here are the main logic we added beyond the picture above

### Jump Logic
We first added logic for the basic jump that to find the address for that should be the next PC inside the Decode stage of the pipeline.

![alt
text](jump_green2.png)

After, we realized that Jal and Jr needed to read and write to registers instead of just jumping so we needed to add special cases for them. First, we handled Jr by making a control signal that controls a mux that changes the next PC to be the data coming out of the register modlue for the value out of register Rs.

![alt
text](jump_green1.png)

Next, we handled Jal by adding a control signal that changes the WriteRegW and the ResultW with a mux so that WriteRegW is changed to $ra or 31 and ResultW is set to PCplus4W and have it still jump in the Decode stage.

## Branch Logic

We started with the basic logic and handled Bypass when an instruction before the branch changes a register that is being compared in the Decode stage. Next we basically combined all of the different types of branches into one control signal that will tell the branch mux whether or not to change the PC. So we compare if the register values are Equal, Not Equal or Less Than as well as their coresponding control signals notifying if it is actually that instruction in the decode section of the pipeline.

![alt
text](branch_orange.png)

## SLL and SRA

We handled SLL and SRA outside of our ALU because we thought we were out of control bits because we started with only a 3 bit ALUControl, in case that we don't want to take the risks of breaking the original logic which has already worked. Instead of changing ALU module, we just always shift the Rt register based on the Shamt part of the instruction and we have a 2 bit control signal to pick if it was SLL, SRA or the output of ALU.

## DIV and MULT

We also handled Div and mult outside of the ALU just out of convenience because we added it later. We pass in SrcAE and SrcBE into a module HiAndLow that handels the mult div and the mfhi and mflo. On the divE control it stores the value of SrcAE divided by SrcBE into a register in the module as Hi. Then div stores SrcAE mod SrcBE into a register Lo. So on mfhi and mflo turns the mf control to notify the HiAndLow module to push either the Hi or Low register to be muxed with the output of the ALU and check the upper bit of mf to see if it is trying to read those values. The mult does a similar thing but stores the the value of Rs * Rt as a 64 bit value and store the upper 32 bits into Hi and lower 32 bits into Lo.

![alt
text](divAndmult_purple.png)

----
## MODULES
#### Instruction Memory
```
module instruction(input [31:0] counter, input [31:0] regv, input [31:0] rega, input sys, input break, input [29:0] pc,output reg [31:0] inst);
```
Our instruction memory module takes in the program count and outputs the 32 bit instruction. We also have the value of our v0, a0, and  syscall control signal as input. Here the instruction is stored and at the tick of every clock the new program count is used to output a new instruction.

Our instruction file is represented as an array
```
reg [31:0] instfile [32'h00100000:32'h00100100];
```
Which is read in from a file using readmemh

In instruction module, we also handled some part of the system call which would explain in the System Calls part.

##### System Calls

These as explained are handled within the instruction module and datamem module.
We support print integer, print string, and exit system calls based on the $v0 value.

In instruction module, we handled:

1. Exit calls a simple $finish command.
2. Integer prints the value at $a0.
3. String will iterate through the characters and use $write to write each one
4. Break instruction

![alt
text](instr_blue.png)

(Notes: a print syscall in instruction module would happen only when the content is within the instruction memory chunk)

In datamem module, we handled the print syscall only when the content is within the ram or mem memory chunk we defined in datamem module.

#### Registers
```
module register(input clk, input[4:0] register1, input[4:0] register2, input[4:0] writeregister, input[31:0] data, input regWrite, output reg [31:0] data1, output reg [31:0] data2, output [31:0]regv, output [31:0]rega);
```
Our register module takes as input the clock, the two source registers, regwrite signal, the destination register, data(an immediate value), the registers are also output with two different 32 bit values immediates (data1 and data2) coming from either the alu or memory.This module functions to store the values of all of our 32 bit registers used to compute in our processor. In the case of a register write the module responds will respond to the signal comming from the writeback stage and write to the appropriate register.

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
![alt
text](control_red.png)

The control module takes in the opcode and function code for every instruction. Many wires are output, the majority being simple 1-bit wires. the alu code is longer because it specifies what operation to form. These signals are what control the flow of our processor defining the behavior. The signals incorporate jump logic, changing memory, register reading and writing, system calls and so on. Case statements are used identify the type of instruction.

```
case (opcode)
			// For special
      `SPECIAL: begin
          case (func)
        	`ADD: begin
        		regDst <= 1'b1;
        		jump <= 1'b0;
        		branch <= 1'b0;
        		branchne <= 1'b0;
        		branchLT <= 1'b0;
        		memRead <= 1'b0;
        		memToReg <= 1'b0;
        		Shift <= 2'b00;
        		div <= 1'b0;
        		mult <= 1'b0;
        		mf <= 2'b00;
        		ALUop <= 3'b010;
        		regWrite <= 1'b1;
        		ALUSrc <= 1'b0;
        		memWrite <= 1'b0;
        		memWriteSB <= 1'b0;
        		sys <= 1'b0;
        		break <= 1'b0;
        		jr <= 1'b0;
        		jal <= 1'b0;
        	end 			// case: `ADD

            ...
      ...
```
Here we can see that there is a second case imbedded to handle special cases when the opcode is all 0.
Additionally all signals are initialized to 0 and the ALUop xxx.



#### Multiplexers
Multiplexer will select between the two inputs based on the control(select) signal. 1 dictates input1 and 0 dictates input2
```
module mux(in1, in2, select, out);
```
Sometimes, two inputs are 5 bits instead.
```
module mux5(in1, in2, select, out);
```
The cpu also makes use of multiple two bit multiplexers:
```
module mux2bit(in1, in2, in3, select, out);
```
The two bit functions in a similar way however there are 3 potential values and one more statement to handle with the select.The signal (select) is two bits. This is very effective for us to implement our forwarding logic.



#### ALU
```
module alu(opcode, rs, rt, out);
```
The alu takes in the 3 bit opcode, rs value, rt value, and outputs a single 32 bit value. Alu has a case statement that takes in the opcode, and depending on the opcode, it will take different operations performed on the value of two given registers.

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
And continues in this format for +, <<, - and so on.




#### Data Memory
![alt
text](datamem_blue.png)

Data memory takes in the clock, MemWrite signal, 32 bit Address, as well as Wdada and Rdata signals. At every signal from the clock the write signal is checked and if it is a write, the content in specific address is assigned to the data value. And readdataW would already be mem[addr] or ram[addr], it will be decided to be taken or not later by the mux.

In our datamem module, we also handled a part of print syscall as explained in System Calls session.


#### Hazard Unit
```
module HazardUnit(BranchD, NotBranchD, BranchLTD, WriteRegE, MemtoRegE, RegWriteE, WriteRegM, MemtoRegM, RegWriteM, WriteRegW, RegWriteW, RsD, RtD, RsE, RtE, StallF, StallD, FlushE, ForwardAD, ForwardBD, ForwardAE, ForwardBE);
```
The hazard unit handles many different signals. It takes in the registers that are to be written to at stages Execution, Memory, and Write as well input signals regarding writing wrtiging data from memory. The registers used in the decode stage as sources are also inputs for the hazard unit.

The hazard unit outputs 7 different wires, these regard stalling at if there are any data hazards which can be identified with the inputs. If it is possible to forward, the hazard units has logic to output to the multiplexers that the forwarded value should be used for a given cycle.

For instance our AD forward case:
```
    // Control ForwardAD
    always@(RegWriteM, WriteRegM, RsD)
    begin      
        if (RegWriteM & (RsD == WriteRegM) & (RsD != 0))
            ForwardAD = 1;  
        else
            ForwardAD = 0;
    end
```
This particular forward will enable us to forward one execution stage to the next so that the Rs from that stage is replaced with the forwarded value. This is how we allow the program to run without stalls.

Stalling occurs in the instance where we have conflicting rt registers in the execute and decode stage or the rs for the instruction at decode matches that of rt value in execute. Also, we need to handle the branchstall issue which is talked above, when branch instruction request the registers which are not written back yet. We cannot carry through so the program outputs stall signals and flushes like such:

```
if ((MemtoRegE & ((RtE == RtD)|(RtE == RsD)))||((BranchTotal && RegWriteE && (WriteRegE == RsD || WriteRegE == RtD)) || (BranchTotal && MemtoRegM && (WriteRegM == RsD || WriteRegM == RtD))))   
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
        breakW <= breakM;
    end
```

Fetch to decode register
```
module FtoD(clk, StallD, PCSrcD, InstrF, PCPlus4F, InstrD, PCPlus4D);
```

Decode to Execute register
```
module DtoE(clk, FlushE, RegWriteD, MemtoRegD, MemWriteD, MemWriteSBD, ShiftD, divD, multD, mfD, ALUControlD, ALUSrcD, RegDstD, data1D, data2D, RsD, RtD, RdD, shamtD, SignImmD, PCPlus4D, JalD, sysD, breakD, regvD, regaD, RegWriteE, MemtoRegE, MemWriteE, MemWriteSBE, ShiftE, divE, multE, mfE, ALUControlE, ALUSrcE, RegDstE, data1E, data2E, RsE, RtE, RdE, shamtE, SignImmE, PCPlus4E, JalE, sysE, breakE, regvE, regaE);
```

Execute to Memory register
```
module EtoM(clk, RegWriteE, MemtoRegE, MemWriteE, MemWriteSBE, ALUInE, WriteDataE, WriteRegE, PCPlus4E, JalE, sysE, breakE, regvE, regaE, RegWriteM, MemtoRegM, MemWriteM, MemWriteSBM, ALUOutM, WriteDataM, WriteRegM, PCPlus4M, JalM, sysM, breakM, regvM, regaM);
```

Memory to Writeback register
```
module MtoW(clk, RegWriteM, MemtoRegM, ReadDataM, ALUOutM, WriteRegM, PCPlus4M, JalM, sysM, breakM, regvM, regaM, RegWriteW, MemtoRegW, ReadDataW, ALUOutW, WriteRegW, PCPlus4W, JalW, sysW, breakW, regvW, regaW);
```

## Compilation

In order to compile our pipelined cpu:
```
iverilog -o test -c helper.txt
```
We include a helper.txt which helps to compile our pipelined cpu.

For fib and myprogram, if you want to test with other values. You can modify the .c file and run make, copy the content in .v output file to mem.in

Finally, run the command shown above.

## Execution and sample runs

In order to execute:
```
vvp test
```

#### Here are the outputs for each program:

###### 1. hello

```
[cd032@linuxremote1 ~/csci320_project2/hello]$ vvp test
VCD info: dumpfile test.vcd opened for output.
Hello world!
Number of instruction:        28
Number of cycles:             27
IPC: 1.0181818181818181

```

###### 2. fib(12)

```
[cd032@linuxremote1 ~/csci320_project2/fibonacci]$ vvp test
VCD info: dumpfile test.vcd opened for output.
Result is:  
    144

Number of instruction:     15670
Number of cycles:          16648
IPC: 0.9412259362705349

```

###### 3. myProgram

```
[cd032@linuxremote1 ~/csci320_project2/myProgram]$ vvp test
VCD info: dumpfile test.vcd opened for output.
Result is:  
     12

Number of instruction:      1855
Number of cycles:           1992
IPC: 0.9309912170639900


```


## Submission

We include each program in a separate folder with appropriate name.

For testing, you can cd into each folder and run vvp test. The sample run is shown above.

## MyProgram

Here are the 26 instrunctions we included in myProgram:
1. addiu
2. addu
3. andi
4. b
5. bltz
6. bne
7. bnez
8. break
9. div
10. jal
11. jr
12. li
13. lui
14. lw
15. mfhi
16. mflo
17. move
18. or
19. sb
20. sll
21. sra
22. subu
23. sw
24. and
25. beqz
26. mult

## Testing methodology

#### 1. gtkwave

![alt
text](gtkwave.png)

Following the gtkwave and pulling out desired wires with corresponding values helps us a lot when we are debugging. Even though it really takes time, we have to follow step by step in order to find the place where we made the mistakes on.

Mainly, if the program did not touch exit system call, we will pull out the instrD which is the instruction of the system is going to take for each cycle.

#### 2. Instruction Flow
Here is a part of the instruction flow which is generated from the given command:

```
[cd032@linuxremote1 ~/csci320_project2/myProgram]$ mipsel-linux-objdump -d fool

fool:     file format elf32-tradlittlemips


Disassembly of section .text:

004000b0 <_ftext>:
  4000b0: 24020004  li  v0,4
  4000b4: 0000000c  syscall
  4000b8: 03e00008  jr  ra
  4000bc: 00000000  nop

004000c0 <__start>:
  4000c0: 3c1d7fff 0c100066 37bdfffc 2402000a     ...<f......7...$
  4000d0: 0000000c 00000000 00000000 00000000     ................

004000e0 <fool>:
  4000e0: 27bdfff8  addiu sp,sp,-8
  4000e4: afbe0004  sw  s8,4(sp)
  4000e8: 03a0f021  move  s8,sp
  4000ec: afc40008  sw  a0,8(s8)
  4000f0: afc5000c  sw  a1,12(s8)
  4000f4: 8fc30008  lw  v1,8(s8)
  4000f8: 24020001  li  v0,1
  4000fc: 14620004  bne v1,v0,400110 <fool+0x30>
  400100: 00000000  nop

  ...
```

If the program exits, we will mainly follow the instruction flow we generate based on the given command and Makefile. Checking each branch instruction with correct behavior and appropriate registers' values. If something goes wrong, check the related signal and move one step previously until you find the place with the bug.
