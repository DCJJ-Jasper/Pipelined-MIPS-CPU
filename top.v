`include "mips.h"

module top(input wire clk);
  reg [31:0] instruction;
  wire [4:0] rs = instruction[`rs];
  wire [4:0] rt = instruction[`rt];
  wire [4:0] rd = instruction[`rd];
  wire [5:0] opcode = instruction[`op];
  wire [2:0] ALUOp; 
  wire [15:0] immediate = instruction[`immediate];
  wire [15:0] immediate32; 
  wire [31:0] PC;
  wire [31:0] nextPC;
  wire [31:0] pcPlus;//pc +4 value
  wire [31:0] jumpPC;
  wire [31:0] branchPC;
  wire [31:0] data;
  wire [31:0] data1;
  wire [31:0] data2;
  wire [31:0] aludata2;
  wire [31:0] ReadData; //reg or wire?
  wire [4:0]  writereg;
  wire       regWrite;
  wire       ALUSrc;
  wire       MemWrite;
  wire       MemRead;
  wire       MemtoReg;
  wire       Jump;
  wire       Branch;
  wire      RegDst;
  wire [27:0] lowerjump = instruction[`target];
  wire [31:0] upperjump = pcPlus - pcPlus[27:0];
  wire [31:0] jump = upperjump + lowerjump;

      
  wire [2:0] ALUOp;   
  wire [31:0]     aluresult;
   
   mux muxInstr(rt,rd,RegDst,writereg);
   control theControl(opcode,regDst,Jump,Branch,MemRead,MemtoReg,ALUOp,regWrite,ALUSrc,MemWrite);
   pc thePC(clk,nextPC,PC);
   register Registers(rs,rt,writereg,data,regwrite,data1,data2);
   alu theALU(ALUOp,data1,aludata2,aluresult);
   mux mux1(data2,immediate32,ALUSrc,aludata2);	    
   datamem mem(clk,MemWrite,MemRead,aluresult,data2,ReadData);
   mux mux2(aluresult,ReadData,MemtoReg,data);
   instruction instructionMem(PC[31:2],instruction);
   adder Adder(PC,pcPlus);
   mux muxJump(branchPC,jump,Jump,nextPC);
   extend extender(immediate,immediate32);//Not built yet
   shiftleft2 sl(instr32,leftinstr32);//Not built yet
   alu jumpALU(0,leftinstr32,pcPlus,jumpPC);//uses ALUOp of 0 for add
   //shiftleft2 sl(instruction[`target],); may have to implement? confused with wires merging top shift left 2
   mux muxBranch(pcPlus,jumpPC,Branch,branchPC)
endmodule
