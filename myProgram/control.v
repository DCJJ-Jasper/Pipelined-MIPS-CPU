// Control module

// This module controls the main signals which go through the pipeline registers and tell the mux or alu or datamem to operate in which way or to take which value depending on the opcode and func value.

`include "mips.h"
`timescale 1ns/1ns

module control(opcode,
	func,
	regDst, 
	jump, 
	branch, 
	branchne, 
	branchLT, 
	memRead, 
	memToReg, 
	Shift, 
	div,
	mult,
	mf,
	ALUop, 
	regWrite,
	ALUSrc,
	memWrite,
	memWriteSB,
	sys,
	break,
	jr,
	jal
);

	input [5:0] opcode;
	input [5:0] func;
	output reg regDst;
	output reg jump;
	output reg branch;
	output reg branchne;
	output reg branchLT;
	output reg memRead;
	output reg memToReg;
	output reg [1:0] Shift;
	output reg div;
	output reg mult;
	output reg [1:0] mf;
	output reg [2:0] ALUop;
	output reg regWrite;
	output reg ALUSrc;
	output reg memWrite;
	output reg memWriteSB;
	output reg sys;
	output reg break;
	output reg jr;
	output reg jal;

	// Initialization
	initial begin
		regDst = 1'b0;
		jump = 1'b0;
		branch = 1'b0;
		branchne = 1'b0;
		branchLT = 1'b0;
		memRead = 1'b0; 
		memToReg = 1'b0; 
		Shift = 2'b00;
		div = 1'b0;
		mult = 1'b0;
		mf = 2'b00;
		ALUop = 3'bxxx;
		regWrite = 1'b0;
		ALUSrc = 1'b0;
		memWrite = 1'b0;
		memWriteSB = 1'b0;
		sys = 1'b0;
		break = 1'b0;
		jr = 1'b0;
		jal = 1'b0;
	end

	// Always block to control the outputs for the given opcode and func input
	always @(*) begin
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

					`ADDU: begin 
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
					end 			// case: `ADDU

					`AND: begin
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
					   ALUop <= 3'b000;
					   regWrite <= 1'b1;
					   ALUSrc <= 1'b0;
					   memWrite <= 1'b0;
					   memWriteSB <= 1'b0;
					   sys <= 1'b0;
					   break <= 1'b0;
					   jr <= 1'b0;
					   jal <= 1'b0;
					end 			// case: `AND

					`MULT: begin
						regDst <= 1'b1;
						jump <= 1'b0;
						branch <= 1'b0;
						branchne <= 1'b0;
						branchLT <= 1'b0;
						memRead <= 1'b0; 
						memToReg <= 1'b0; 
						Shift <= 2'b00;
						div <= 1'b0;
						mult <= 1'b1;
						mf <= 2'b00;
						ALUop <= 3'b010;
						regWrite <= 1'b0;
						ALUSrc <= 1'b0;
						memWrite <= 1'b0;
						memWriteSB <= 1'b0;
						sys <= 1'b0;
						break <= 1'b0;
						jr <= 1'b0;
						jal <= 1'b0;
					end 			// case: `MULT

					`DIV: begin
						regDst <= 1'b1;
						jump <= 1'b0;
						branch <= 1'b0;
						branchne <= 1'b0;
						branchLT <= 1'b0;
						memRead <= 1'b0; 
						memToReg <= 1'b0; 
						Shift <= 2'b00;
						div <= 1'b1;
						mult <= 1'b0;
						mf <= 2'b00;
						ALUop <= 3'b010;
						regWrite <= 1'b0;
						ALUSrc <= 1'b0;
						memWrite <= 1'b0;
						memWriteSB <= 1'b0;
						sys <= 1'b0;
						break <= 1'b0;
						jr <= 1'b0;
						jal <= 1'b0;
					end 			// case: `DIV

					`MFHI: begin
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
						mf <= 2'b10;
						ALUop <= 3'b010;
						regWrite <= 1'b1;
						ALUSrc <= 1'b0;
						memWrite <= 1'b0;
						memWriteSB <= 1'b0;
						sys <= 1'b0;
						break <= 1'b0;
						jr <= 1'b0;
						jal <= 1'b0;
					end 			// case: `MFHI

					`MFLO: begin
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
						mf <= 2'b11;
						ALUop <= 3'b010;
						regWrite <= 1'b1;
						ALUSrc <= 1'b0;
						memWrite <= 1'b0;
						memWriteSB <= 1'b0;
						sys <= 1'b0;
						break <= 1'b0;
						jr <= 1'b0;
						jal <= 1'b0;
					end 			// case: `MFLO

					`JR: begin
						regDst <= 1'bx;
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
						ALUop <= 3'bxxx;
						regWrite <= 1'b0;
						ALUSrc <= 1'bx;
						memWrite <= 1'b0;
						memWriteSB <= 1'b0;
						sys <= 1'b0;
						break <= 1'b0;
						jr <= 1'b1;
						jal <= 1'b0;
					end 			// case: `JR

					`OR: begin
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
						ALUop <= 3'b001;
						regWrite <= 1'b1;
						ALUSrc <= 1'b0;
						memWrite <= 1'b0;
						memWriteSB <= 1'b0;
						sys <= 1'b0;
						break <= 1'b0;
						jr <= 1'b0;
						jal <= 1'b0;
					end 			// case: `OR

					`SLL: begin
						regDst <= 1'b1;
						jump <= 1'b0;
						branch <= 1'b0;
						branchne <= 1'b0;
						branchLT <= 1'b0;
						memRead <= 1'b0; 
						memToReg <= 1'b0;
						Shift <= 2'b10; 
						div <= 1'b0;
						mult <= 1'b0;
						mf <= 2'b00;
						ALUop <= 3'bxxx;
						regWrite <= 1'b1;
						ALUSrc <= 1'b0;
						memWrite <= 1'b0;
						memWriteSB <= 1'b0;
						sys <= 1'b0;
						break <= 1'b0;
						jr <= 1'b0;
						jal <= 1'b0;
					end 			// case: `SLL

					`SRA: begin
						regDst <= 1'b1;
						jump <= 1'b0;
						branch <= 1'b0;
						branchne <= 1'b0;
						branchLT <= 1'b0;
						memRead <= 1'b0; 
						memToReg <= 1'b0;
						Shift <= 2'b01; 
						div <= 1'b0;
						mult <= 1'b0;
						mf <= 2'b00;
						ALUop <= 3'bxxx;
						regWrite <= 1'b1;
						ALUSrc <= 1'b0;
						memWrite <= 1'b0;
						memWriteSB <= 1'b0;
						sys <= 1'b0;
						break <= 1'b0;
						jr <= 1'b0;
						jal <= 1'b0;
					end 			// case: `SRA

					`SLT: begin
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
						ALUop <= 3'b111;
						regWrite <= 1'b1;
						ALUSrc <= 1'b0;
						memWrite <= 1'b0;
						memWriteSB <= 1'b0;
						sys <= 1'b0;
						break <= 1'b0;
						jr <= 1'b0;
						jal <= 1'b0;
					end 			// case: `SLT

					`SUB: begin
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
						ALUop <= 3'b110;
						regWrite <= 1'b1;
						ALUSrc <= 1'b0;
						memWrite <= 1'b0;
						memWriteSB <= 1'b0;
						sys <= 1'b0;
						break <= 1'b0;
						jr <= 1'b0;
						jal <= 1'b0;
					end  			// case: `SUB

					`BREAK: begin
						regDst <= 1'b0;
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
						ALUop <= 3'bxxx;
						regWrite <= 1'b0;
						ALUSrc <= 1'b0;
						memWrite <= 1'b0;
						memWriteSB <= 1'b0;
						sys <= 1'b1;
						break <= 1'b1;
						jr <= 1'b0;
						jal <= 1'b0;
					end 			// case: `BREAK

					`SYSCALL: begin
						regDst <= 1'b0;
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
						ALUop <= 3'bxxx;
						regWrite <= 1'b0;
						ALUSrc <= 1'b0;
						memWrite <= 1'b0;
						memWriteSB <= 1'b0;
						sys <= 1'b1;
						break <= 1'b0;
						jr <= 1'b0;
					    jal <= 1'b0;
					end
				endcase 
		    end 					// end for SPECIAL

			`ADDI: begin
				regDst <= 1'b0;
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
				ALUSrc <= 1'b1;
				memWrite <= 1'b0;
				memWriteSB <= 1'b0;
				sys <= 1'b0;
				break <= 1'b0;
				jr <= 1'b0;
				jal <= 1'b0;
			end 			// case: `ADDI
		   
			`LUI: begin
				regDst <= 1'b0;
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
				ALUop <= 3'b011;
				regWrite <= 1'b1;
				ALUSrc <= 1'b1;
				memWrite <= 1'b0;
				memWriteSB <= 1'b0;
				sys <= 1'b0;
				break <= 1'b0;
				jr <= 1'b0;
				jal <= 1'b0;
			end  				// case: `LUI

		    `ADDIU: begin
				regDst <= 1'b0;
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
				ALUSrc <= 1'b1;
				memWrite <= 1'b0;
				memWriteSB <= 1'b0;
				sys <= 1'b0;
				break <= 1'b0;
				jr <= 1'b0;
				jal <= 1'b0;	
			end	   			// case: `ANDIU

			`ANDI: begin
				regDst <= 1'b0;
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
			    ALUop <= 3'b000;
			    regWrite <= 1'b1;
			    ALUSrc <= 1'b1;
			    memWrite <= 1'b0;
				memWriteSB <= 1'b0;
			    sys <= 1'b0;
			    break <= 1'b0;
			    jr <= 1'b0;
			    jal <= 1'b0;
			end 			// case: `ANDI

			`ORI: begin
				regDst <= 1'b0;
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
				ALUop <= 3'b001;
				regWrite <= 1'b1;
				ALUSrc <= 1'b1;
				memWrite <= 1'b0;
				memWriteSB <= 1'b0;
				sys <= 1'b0;
				break <= 1'b0;
				jr <= 1'b0;
				jal <= 1'b0;
			end    			// case: `ORI

			`LW: begin
				regDst <= 1'b0;
				jump <= 1'b0;
				branch <= 1'b0;
				branchne <= 1'b0;
				branchLT <= 1'b0;
				memRead <= 1'b1; 
				memToReg <= 1'b1; 
				Shift <= 2'b00;
				div <= 1'b0;
				mult <= 1'b0;
				mf <= 2'b00;
				ALUop <= 3'b010;
				regWrite <= 1'b1;
				ALUSrc <= 1'b1;
				memWrite <= 1'b0;
				memWriteSB <= 1'b0;
				sys <= 1'b0;
				break <= 1'b0;
				jr <= 1'b0;
				jal <= 1'b0;
			end    			// case: `LW

			`SW: begin
				regDst <= 1'b0;
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
				regWrite <= 1'b0;
				ALUSrc <= 1'b1;
				memWrite <= 1'b1;
				memWriteSB <= 1'b0;
				sys <= 1'b0;
				break <= 1'b0;
				jr <= 1'b0;
				jal <= 1'b0;
			end   			// case: `SW

			`SB: begin
				regDst <= 1'b0;
				jump <= 1'b0;
				branch <= 1'b0;
				branchne <= 1'b0;
				branchLT <= 1'b0;
				memRead <= 1'b0; 
				memToReg <= 1'b0; 
				Shift <= 2'b00;
				div <= 1'b0;
				mf <= 2'b00;
				ALUop <= 3'b010;
				regWrite <= 1'b0;
				ALUSrc <= 1'b1;
				memWrite <= 1'b0;
				memWriteSB <= 1'b1;
				sys <= 1'b0;
				break <= 1'b0;
				jr <= 1'b0;
				jal <= 1'b0;
			end  			// case: `SB

			`BEQ: begin
				regDst <= 1'bx;
				jump <= 1'b0;
				branch <= 1'b1;
				branchne <= 1'b0;
				branchLT <= 1'b0;
				memRead <= 1'b0; 
				memToReg <= 1'b0; 
				Shift <= 2'b00;
				div <= 1'b0;
				mult <= 1'b0;
				mf <= 2'b00;
				ALUop <= 3'b110;
				regWrite <= 1'b0;
				ALUSrc <= 1'b0;
				memWrite <= 1'b0;
				memWriteSB <= 1'b0;
				sys <= 1'b0;
				break <= 1'b0;
				jr <= 1'b0;
				jal <= 1'b0;
			end   			// case: `BEQ

			`BNE: begin
				regDst <= 1'bx;
				jump <= 1'b0;
				branch <= 1'b0;
				branchne <= 1'b1;
				branchLT <= 1'b0;
				memRead <= 1'b0; 
				memToReg <= 1'b0; 
				Shift <= 2'b00;
				div <= 1'b0;
				mult <= 1'b0;
				mf <= 2'b00;
				ALUop <= 3'b110;
				regWrite <= 1'b0;
				ALUSrc <= 1'b0;
				memWrite <= 1'b0;
				memWriteSB <= 1'b0;
				sys <= 1'b0;
				break <= 1'b0;
				jr <= 1'b0;
				jal <= 1'b0;
			end   			// case: `BNE

			`BLTZ: begin
				regDst <= 1'bx;
				jump <= 1'b0;
				branch <= 1'b0;
				branchne <= 1'b0;
				branchLT <= 1'b1;
				memRead <= 1'b0; 
				memToReg <= 1'b0; 
				Shift <= 2'b00;
				div <= 1'b0;
				mult <= 1'b0;
				mf <= 2'b00;
				ALUop <= 3'b110;
				regWrite <= 1'b0;
				ALUSrc <= 1'b0;
				memWrite <= 1'b0;
				memWriteSB <= 1'b0;
				sys <= 1'b0;
				break <= 1'b0;
				jr <= 1'b0;
				jal <= 1'b0;
			end 			// case: `BLTZ

			`J: begin
				regDst <= 1'bx;
				jump <= 1'b1;
				branch <= 1'b0;
				branchne <= 1'b0;
				branchLT <= 1'b0;
				memRead <= 1'b0; 
				memToReg <= 1'b0; 
				Shift <= 2'b00;
				div <= 1'b0;
				mult <= 1'b0;
				mf <= 2'b00;
				ALUop <= 3'bxxx;
				regWrite <= 1'b0;
				ALUSrc <= 1'bx;
				memWrite <= 1'b0;
				memWriteSB <= 1'b0;
				sys <= 1'b0;
				break <= 1'b0;
				jr <= 1'b0;
				jal <= 1'b0;
			end  			// case: `J
			
       		`JAL: begin
				regDst <= 1'b1;
				jump <= 1'b1;
				branch <= 1'b0;
				branchne <= 1'b0;
				branchLT <= 1'b0;
				memRead <= 1'b0; 
				memToReg <= 1'b0; 
				Shift <= 2'b00;
				div <= 1'b0;
				mult <= 1'b0;
				mf <= 2'b00;
				ALUop <= 3'bxxx;
				regWrite <= 1'b1;
				ALUSrc <= 1'bx;
				memWrite <= 1'b0;
				memWriteSB <= 1'b0;
				sys <= 1'b0;
				break <= 1'b0;
				jr <= 1'b0;
				jal <= 1'b1;
			end  			// case: `JAL

			default: begin
				regDst <= 1'b0;
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
				ALUop <= 3'b000;
				regWrite <= 1'b0;
				ALUSrc <= 1'b0;
				memWrite <= 1'b0;
				memWriteSB <= 1'b0;
				sys <= 1'b0;
				break <= 1'b0;
				jr <= 1'b0;
				jal <= 1'b0;
			end   			// case: default
		endcase 
	end
endmodule
