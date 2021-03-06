`timescale 1ns/1ns
`include "mips.h"


// pipetop.v is the top module of our pipelined cpu

// This module wires up the modules and add tiny logic between modules which is not necessary to write a module for it.

module pipetop; 


    // wire

    reg clk;

    wire PCSrcD;
    wire NotBranch;
    wire Branch;
    wire BranchLT;

    wire [31:0] PCPlus4F;

    wire [31:0] InstrD;
    wire [31:0] PCPlus4D;

    wire [31:0] PCF;
    wire [31:0] InstrF;

    wire RegWriteD;
    wire MemtoRegD;
    wire MemWriteD;
    wire MemWriteSBD;
    wire [2:0] ALUControlD;
    wire divD;
    wire [1:0] mfD;
    wire [1:0] ShiftD;
    wire ALUSrcD;
    wire RegDstD;
    wire [31:0] data1D;
    wire [31:0] data2D;
    wire [4:0] RsD;
    wire [4:0] RtD;
    wire [4:0] RdD;
    wire [4:0] shamtD;
    wire [31:0] SignImmD;

    wire RegWriteE;
    wire MemtoRegE;
    wire MemWriteE;
    wire MemWriteSBE;
    wire [2:0] ALUControlE;
    wire divE;
    wire [1:0] mfE;
    wire [1:0] ShiftE;
    wire ALUSrcE;
    wire RegDstE;
    wire [31:0] data1E;
    wire [31:0] data2E;
    wire [4:0] RsE;
    wire [4:0] RtE;
    wire [4:0] RdE;
    wire [4:0] shamtE;
    wire [31:0] SignImmE;

	wire [31:0] sll;
	wire [31:0] sra;
    wire [31:0] ALUInE;
	wire [31:0] ALUOutE;
	wire [31:0] ALUOutMidE;
	wire [31:0] HLOut;
    wire [31:0] WriteDataE;
    wire [4:0] WriteRegE;

    wire MemWriteM;
    wire MemWriteSBM;  
    wire [31:0] WriteDataM;

    wire BranchD;
    wire NotBranchD;
    wire BranchLTD;

    wire [4:0] WriteRegM;
    wire MemtoRegM;
    wire RegWriteM;

    wire [31:0] ReadDataM;
    wire [31:0] ALUOutM;

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
	
	wire [31:0] MemForwardD; //testing

    wire [31:0] PCBranchD;
    wire [31:0] PC;
    wire [31:0] ShiftBeforeADD; 

    wire sysD;
	wire sysE;
	wire sysM;
	wire sysW;

    wire breakD;
    wire breakE;
    wire breakM;
    wire breakW;

    wire MemRead;

    wire Jump;

    wire [31:0] regvD;
    wire [31:0] regaD;
    wire [31:0] regvE;
    wire [31:0] regaE;
    wire [31:0] regvM;
    wire [31:0] regaM;
    wire [31:0] regvW;
    wire [31:0] regaW;

    wire [31:0] RD1Eq;
    wire [31:0] RD2Eq;

    wire EqualD;
    wire NotEqualD;
    wire [31:0] JumpPc;
    wire [31:0] PCMid1;
    wire [31:0] PCMid2;

    wire Jr;
    wire JalD;
    wire JalE;
    wire JalM;
    wire JalW;

    wire [31:0] PCPlus4E;
    wire [31:0] PCPlus4M;
    wire [31:0] PCPlus4W;

    wire [31:0] WD3;
    wire [4:0] A3;	

    wire multD;
    wire multE;

    wire [31:0] counter;


    // module

    mux muxforPC(PCBranchD, PCPlus4F, PCSrcD, PCMid1);

    assign JumpPc = (PCPlus4D[31:28] << 28) + (InstrD[25:0] << 2);

    mux muxforJump(JumpPc, PCMid1, Jump, PCMid2);

    mux muxforJr(data1D, PCMid2, Jr, PC);

    PC_StallF thePCwithStallF(clk, StallF, PC, PCF, counter);

    instruction instructionMem(counter, regvD, regaD, sysW, breakW, PCF[31:2], InstrF);

    adder add4toPCF(PCF, PCPlus4F);

    FtoD theFtoD(clk, StallD, PCSrcD, InstrF, PCPlus4F, InstrD, PCPlus4D);

    mux muxforPCPlus4W(PCPlus4W, ResultW, JalW, WD3);
    mux5 mux5forJalW(5'b11111, WriteRegW, JalW, A3);

    extend theExtend(InstrD[15:0], SignImmD);

    assign ShiftBeforeADD = SignImmD << 2;
    assign PCBranchD = ShiftBeforeADD + PCPlus4D;

    control theControl(InstrD[31:26], InstrD[5:0], RegDstD, Jump, BranchD,NotBranchD, BranchLTD,MemRead, MemtoRegD, ShiftD, divD, multD, mfD, ALUControlD, RegWriteD, ALUSrcD, MemWriteD,MemWriteSBD, sysD, breakD, Jr, JalD);

    register theRegister(clk,InstrD[25:21], InstrD[20:16], A3, WD3, RegWriteW, data1D, data2D, regvD, regaD);

    assign RsD = InstrD[25:21];
    assign RtD = InstrD[20:16];
    assign RdD = InstrD[15:11];
    assign shamtD = InstrD[10:6];

    mux muxforRD1(MemForwardD, data1D, ForwardAD, RD1Eq);
    mux muxforRD2(MemForwardD, data2D, ForwardBD, RD2Eq);

    assign EqualD = (RD1Eq == RD2Eq);
    assign NotEqualD = (RD1Eq != RD2Eq);

    assign Branch = (BranchD & EqualD);
    assign NotBranch = (NotBranchD & NotEqualD);
	assign BranchLT = (BranchLTD&RD1Eq[31] == 1);
   
    assign PCSrcD = (NotBranch | Branch |BranchLT);
   
    DtoE theDtoE(clk, FlushE, RegWriteD, MemtoRegD, MemWriteD, MemWriteSBD, ShiftD, divD, multD, mfD, ALUControlD, ALUSrcD, RegDstD, data1D, data2D, RsD, RtD, RdD, shamtD, SignImmD, PCPlus4D, JalD, sysD, breakD, regvD, regaD, RegWriteE, MemtoRegE, MemWriteE, MemWriteSBE, ShiftE, divE, multE, mfE, ALUControlE, ALUSrcE, RegDstE, data1E, data2E, RsE, RtE, RdE, shamtE, SignImmE, PCPlus4E, JalE, sysE, breakE, regvE, regaE);

    mux5 mux5ForRtEandRdE(RdE, RtE, RegDstE, WriteRegE);

    mux2bit muxfordata1E(data1E, ResultW, ALUOutM, ForwardAE, SrcAE);
    mux2bit muxfordata2E(data2E, ResultW, ALUOutM, ForwardBE, WriteDataE);

    mux muxforSrcBE( SignImmE, WriteDataE, ALUSrcE, SrcBE);

	alu aluforE( ALUControlE, SrcAE, SrcBE, ALUOutE);

	HiAndLo HiAndLoforE(SrcAE, SrcBE, divE, multE, mfE, HLOut);

	mux muxforHL(HLOut, ALUOutE, mfE[1], ALUOutMidE);

	assign sra = SrcBE >> shamtE;
	assign sll = SrcBE << shamtE;
	
	mux2bit muxforShift(ALUOutMidE, sra, sll, ShiftE, ALUInE);

    EtoM theEtoM(clk, RegWriteE, MemtoRegE, MemWriteE, MemWriteSBE, ALUInE, WriteDataE, WriteRegE, PCPlus4E, JalE, sysE, breakE, regvE, regaE, RegWriteM, MemtoRegM, MemWriteM, MemWriteSBM, ALUOutM, WriteDataM, WriteRegM, PCPlus4M, JalM, sysM, breakM, regvM, regaM);

    datamem theDataMem(clk, regvD, regaD, sysW, MemWriteSBM, MemWriteM, ALUOutM, WriteDataM, ReadDataM);

    mux muxforMemDForward(ReadDataM, ALUOutM, MemtoRegM, MemForwardD);

    MtoW theMtoW(clk, RegWriteM, MemtoRegM, ReadDataM, ALUOutM, WriteRegM, PCPlus4M, JalM, sysM, breakM, regvM, regaM, RegWriteW, MemtoRegW, ReadDataW, ALUOutW, WriteRegW, PCPlus4W, JalW, sysW, breakW, regvW, regaW); 

    mux muxforMemtoReg(ReadDataW, ALUOutW, MemtoRegW, ResultW);

    HazardUnit theHazardUnit(BranchD, NotBranchD, BranchLTD,  WriteRegE, MemtoRegE, RegWriteE, WriteRegM, MemtoRegM, RegWriteM, WriteRegW, RegWriteW, RsD, RtD, RsE, RtE, StallF, StallD, FlushE, ForwardAD, ForwardBD, ForwardAE, ForwardBE); 

    // flip the clk each 50ns
    always begin
        #50 clk = ~clk;
    end

    // Initialize the clk
    initial begin
        clk = 0;

		$dumpfile("test.vcd");
    	$dumpvars(0,pipetop);
    end

endmodule // top


