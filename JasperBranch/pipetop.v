`timescale 1ns/1ns
`include "mips.h"

module pipetop; //(input wire clk)


    // wire

    reg clk;

    wire PCSrcD;

    wire [31:0] PCPlus4F;

    wire [31:0] InstrD;
    wire [31:0] PCPlus4D;

    wire [31:0] PCF;
    wire [31:0] instrF;

    wire RegWriteD;
    wire MemtoRegD;
    wire MemWriteD;
    wire [2:0] ALUControlD;
    wire ALUSrcD;
    wire RegDstD;
    wire [31:0] data1D;
    wire [31:0] data2D;
    wire [4:0] RsD;
    wire [4:0] RtD;
    wire [4:0] RdD;
    wire [31:0] SignImmD;

    wire RegWriteE;
    wire MemtoRegE;
    wire MemWriteE;
    wire [2:0] ALUControlE;
    wire ALUSrcE;
    wire RegDstE;
    wire [31:0] data1E;
    wire [31:0] data2E;
    wire [4:0] RsE;
    wire [4:0] RtE;
    wire [4:0] RdE;
    wire [31:0] SignImmE;

    wire [31:0] ALUInE;
    wire [31:0] WriteDataE;
    wire [4:0] WriteRegE;

    wire MemWriteM;  
    wire [31:0] WriteDataM;

    wire BranchD;

    wirewire [4:0] WriteRegE;
    wirewire MemtoRegE;
    wirewire RegWriteE;

    wirewire [4:0] WriteRegM;
    wirewire MemtoRegM;
    wirewire RegWriteM;

    wire [31:0] ReadDataM;
    wire [31:0] ALUOutM;
    wire [4:0] WriteRegM;

    wire RegWriteW;
    wire MemtoRegW;
    wire [31:0] ReadDataW;
    wire [31:0] ALUOutW;
    wire [4:0] WriteRegW;

    wire StallF;
    wire StallD;
    wire FlushE;
    wire ForwardAD; 
    wire ForwardBD;
    wire [1:0] ForwardAE;
    wire [1:0] ForwardBE;

    wire [31:0] ResultW;
    wire [31:0] SrcAE;
    wire [31:0] SrcBE;

    wire [31:0] PCBranchD;
    wire [31:0] PC;
    wire [31:0] ShiftBeforeADD; 

    wire sys;
    wire MemRead;
    wire BranchD;
    wire Jump;

    wire [31:0] regv;
    wire [31:0] rega;

    wire [31:0] RD1Eq;
    wire [31:0] RD2Eq;

    wire EqualD;
    wire [31:0] JumpPc;
    wire [31:0] PCMid;


    // module

    // modify first 3 
    instruction instructionMem(regv, rega, sys, PCF[31:2], instrF);

    mux muxforPC(PCBranchD, PCPlus4F, PCSrcD, PCMid);

    assign JumpPc = (PCPlus4D[31:28] << 28) + (instrD[25:0] << 2);

    mux muxforJumpLog(JumpPc, PCMid, Jump, PC);

    PC_StallF thePCwithStallF(clk, StallF, PC, PCF);

    extend theExtend(instrD[15:0], SignImmD);

    assign ShiftBeforeADD = SignImmD << 2;
    assign PCBranchD = ShiftBeforeADD + PCPlus4D;

    control(InstrD[31:26], InstrD[5:0], RegDstD, Jump, BranchD, MemRead, MemToRegD, ALUControlD, RegWriteD, ALUSrcD, MemWriteD, sys);

    register theRegister(clk,InstrD[25:21], InstrD[20:16], WriteRegW, ResultW, RegWriteW, RD1, RD2, regv, rega);

    assign RsD = InstrD[25:21];
    assign RtD = InstrD[20:16];
    assign RdD = InstrD[15:11];

    adder add4toPCF(PCF, PCPlus4F);

    FtoD theFtoD(clk, StallD, PCSrcD, InstrF, PCPlus4F, InstrD, PCPlus4D);

    register Registers(clk, rs, rt, writereg, data, regwrite, data1D, data2D, regv, rega);

    mux muxforRD1(ALUOutM, data1D, ForwardAD, RD1Eq);
    mux muxforRD1(ALUOutM, data2D, ForwardBD, RD2Eq);

    // If == does not work, write a small module for it
    assign EqualD = (RD1Eq == RD2Eq);

    assign PCSrcD = (BranchD & EqualD);

    DtoE theDtoE(clk, FlushE, RegWriteD, MemtoRegD, MemWriteD, ALUControlD, ALUSrcD, RegDstD, data1D, data2D, RsD, RtD, RdD, SignImmD, RegWriteE, MemtoRegE, MemWriteE, ALUControlE, ALUSrcE, RegDstE, data1E, data2E, RsE, RtE, RdE, SignImmE); 

    mux5 muxForRtEandRdE(RdE, RtE, RegDstE, WriteRegE);

    mux2bit muxfordata1E(data1E, ResultW, ALUOutM, ForwardAE, SrcAE);
    mux2bit muxfordata2E(data2E, ResultW, ALUOutM, ForwardBE, WriteDataE);

    mux muxforSrcBE( SignImmE, WriteDataE, ALUSrcE, SrcBE);

    EtoM theEtoM(clk, RegWriteE, MemtoRegE, MemWriteE, ALUInE, WriteDataE, WriteRegE, RegWriteM, MemtoRegM, MemWriteM, ALUOutM, WriteDataM, WriteRegM); 

    datamem theDataMem(clk, MemWriteM, ALUOutM, WriteDataM, ReadDataM);

    MtoW theMtoW(clk, RegWriteM, MemtoRegM, ReadDataM, ALUOutM, WriteRegM, RegWriteW, MemtoRegW, ReadDataW, ALUOutW, WriteRegW); 

    mux muxforMemtoReg(ReadDataW, ALUOutW, MemtoRegW, ResultW);

    HazardUnit theHazardUnit(BranchD, WriteRegE, MemtoRegE, RegWriteE, WriteRegM, MemtoRegM, RegWriteM, WriteRegW, RegWriteW, RsD, RtD, RsE, RtE, StallF, StallD, FlushE, ForwardAD, ForwardBD, ForwardAE, ForwardBE); 

endmodule // top


