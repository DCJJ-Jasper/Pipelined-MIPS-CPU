`timescale 1ns/1ns
`include "mips.h"

module pipetop; //(input wire clk)

    wire [31:0] instruction;

    wire [4:0] rs = instruction[`rs];
    wire [4:0] rt = instruction[`rt];
    wire [4:0] rd = instruction[`rd];

    wire [5:0] opcode = instruction[`op];
    wire [5:0] func = instruction[`function];
    wire [2:0] ALUOp; 
    wire [25:0] instr32 = instruction[`target]; 
    wire [27:0] leftinstr32; 
    wire [31:0] fullinstr32=leftinstr32; 
    wire [15:0] immediate = instruction[`immediate];
    wire [31:0] immediate32; 
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
    wire regWrite;
    wire ALUSrc;
    wire MemWrite;
    wire MemRead;
    wire MemtoReg;
    wire Jump;
    wire Branch;
    wire RegDst;
    wire sys;

    wire [27:0] lowerjump = instruction[`target];
    wire [31:0] upperjump = pcPlus - pcPlus[27:0];
    wire [31:0] jump = upperjump + lowerjump;
    wire [31:0] regv;
    wire [31:0] rega;
    wire [31:0]     aluresult;

    // Here is the part for pipetop
    wire clk;
    wire StallD;
    wire PCSrcD;

    wire [31:0] InstrF;
    wire [31:0] PCPlus4F;

    wire [31:0] InstrD;
    wire [31:0] PCPlus4D;

    wire [31:0] PCF;
    wire [31:0] instrF;

    wire clk;
    wire FlushE;
    wire RegWriteD;
    wire MemtoRegD;
    wire MemWriteD;
    wire [2:0] ALUControlD;
    wire ALUSrcD;
    wire RegDstD;
    wire [4:0] RsD;
    wire [4:0] RtD;
    wire wire[4:0] RdD;
    wire [31:0] SignImmD;

    wire RegWriteE;
    wire MemtoRegE;
    wire MemWriteE;
    wire [2:0] ALUControlE;
    wire ALUSrcE;
    wire RegDstE;
    wire [4:0] RsE;
    wire [4:0] RtE;
    wire [4:0] RdE;
    wire [31:0] SignImmE;



    // Why does instruction module there are 2 inputs for instruction module
    // syscall?

    // According to the graph, there should be only one input and one output
    instruction instructionMem(PCF, instrF);
    instruction instructionMem(regv, rega, sys, PC[31:2], instruction);

    // 
    adder add4toPCF(PCF, PCPlus4F);
    FtoD theFtoD(clk, StallD, PCSrcD, InstrF, PCPlus4F, InstrD, PCPlus4D);

    register Registers(clk, rs, rt, writereg, data, regwrite, data1, data2, regv, rega);

    DtoE theDtoE(clk, FlushE, RegWriteD, MemtoRegD, MemWriteD, ALUControlD, ALUSrcD, RegDstD, BranchD, RsD, RtD, RdD, SignImmD, RegWriteE, MemtoRegE, MemWriteE, ALUControlE, ALUSrcE, RegDstE, RsE, RtE, RdE, SignImmE); 









    // Here is the old part

   
    mux5 muxInstr(rt,rd,RegDst,writereg);

    control theControl(opcode,func,regDst,Jump,Branch,MemRead,MemtoReg,ALUOp,regWrite,ALUSrc,MemWrite,sys);

    pc thePC(clk,nextPC,PC);

    register Registers(clk,rs,rt,writereg,data,regwrite,data1,data2,regv,rega);

    alu theALU(ALUOp,data1,aludata2,aluresult);

    mux mux1(data2,immediate32,ALUSrc,aludata2);

    datamem mem(clk,MemWrite,MemRead,aluresult,data2,ReadData);

    mux mux2(aluresult,ReadData,MemtoReg,data);

    instruction instructionMem(regv,rega,sys,PC[31:2],instruction);

    adder Adder(PC,pcPlus);

    mux muxJump(branchPC,jump,Jump,nextPC);

    extend extender(immediate,immediate32);     //Not built yet
    shiftleft2 sl(instr32,leftinstr32);         //Not built yet

    alu jumpALU(3'b000,fullinstr32,pcPlus,jumpPC);
    //uses ALUOp of 0 for add
    //shiftleft2 sl(instruction[`target],); may have to implement? confused with wires merging top shift left 2

    mux muxBranch(pcPlus,jumpPC,Branch,branchPC);

  


endmodule // top


