// Control module

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
	ALUop, 
	regWrite,
	ALUSrc,
	memWrite,
	memWriteSB,
	sys,
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
	output reg [2:0] ALUop;
	output reg regWrite;
	output reg ALUSrc;
	output reg memWrite;
	output reg memWriteSB;
	output reg sys;
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
		ALUop = 2'b00;
		ALUop = 3'bxxx;
		regWrite = 1'b0;
		ALUSrc = 1'b0;
		memWrite = 1'b0;
		memWriteSB = 1'b0;
		sys = 1'b0;
		jr = 1'b0;
		jal = 1'b0;
	end

	always @(*) begin
		case (opcode)
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
					   ALUop <= 3'b010;
					   regWrite <= 1'b1;
					   ALUSrc <= 1'b0;
					   memWrite <= 1'b0;
					   memWriteSB <= 1'b0;
					   sys <= 1'b0;
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
					   ALUop <= 3'b010;
					   regWrite <= 1'b1;
					   ALUSrc <= 1'b0;
					   memWrite <= 1'b0;
					   memWriteSB <= 1'b0;
					   sys <= 1'b0;
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
					   ALUop <= 3'b000;
					   regWrite <= 1'b1;
					   ALUSrc <= 1'b0;
					   memWrite <= 1'b0;
					   memWriteSB <= 1'b0;
					   sys <= 1'b0;
					   jr <= 1'b0;
					   jal <= 1'b0;
					end 			// case: `AND

					`JR: begin
					   regDst <= 1'bx;
					   jump <= 1'b0;
					   branch <= 1'b0;
					   branchne <= 1'b0;
					   branchLT <= 1'b0;
					   memRead <= 1'b0; 
					   memToReg <= 1'b0; 
					   Shift <= 2'b00;
					   ALUop <= 3'bxxx;
					   regWrite <= 1'b0;
					   ALUSrc <= 1'bx;
					   memWrite <= 1'b0;
					   memWriteSB <= 1'b0;
					   sys <= 1'b0;
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
					   ALUop <= 3'b001;
					   regWrite <= 1'b1;
					   ALUSrc <= 1'b0;
					   memWrite <= 1'b0;
					   memWriteSB <= 1'b0;
					   sys <= 1'b0;
					   jr <= 1'b0;
					   jal <= 1'b0;
					end 			// case: `OR

					`SLL: begin
					   regDst <= 1'b0;
					   jump <= 1'b0;
					   branch <= 1'b0;
					   branchne <= 1'b0;
					   branchLT <= 1'b0;
					   memRead <= 1'b0; 
					   memToReg <= 1'b0;
					   Shift <= 2'b10; 
					   ALUop <= 3'bxxx;
					   regWrite <= 1'b0;
					   ALUSrc <= 1'b0;
					   memWrite <= 1'b0;
					   memWriteSB <= 1'b0;
					   sys <= 1'b0;
					   jr <= 1'b0;
					   jal <= 1'b0;

					end 			// case: `SLl
					`SRA: begin
					   regDst <= 1'b0;
					   jump <= 1'b0;
					   branch <= 1'b0;
					   branchne <= 1'b0;
					   branchLT <= 1'b0;
					   memRead <= 1'b0; 
					   memToReg <= 1'b0;
					   Shift <= 2'b01; 
					   ALUop <= 3'bxxx;
					   regWrite <= 1'b0;
					   ALUSrc <= 1'b0;
					   memWrite <= 1'b0;
					   memWriteSB <= 1'b0;
					   sys <= 1'b0;
					   jr <= 1'b0;
					   jal <= 1'b0;
					end 			// case: `SLl

					`SLT: begin
					   regDst <= 1'b1;
					   jump <= 1'b0;
					   branch <= 1'b0;
					   branchne <= 1'b0;
					   branchLT <= 1'b0;
					   memRead <= 1'b0; 
					   memToReg <= 1'b0; 
					   Shift <= 2'b00;
					   ALUop <= 3'b111;
					   regWrite <= 1'b1;
					   ALUSrc <= 1'b0;
					   memWrite <= 1'b0;
					   memWriteSB <= 1'b0;
					   sys <= 1'b0;
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
					   ALUop <= 3'b110;
					   regWrite <= 1'b1;
					   ALUSrc <= 1'b0;
					   memWrite <= 1'b0;
					   memWriteSB <= 1'b0;
					   sys <= 1'b0;
					   jr <= 1'b0;
					   jal <= 1'b0;
					end  

					`SYSCALL: begin
						regDst <= 1'b0;
					   	jump <= 1'b0;
					   	branch <= 1'b0;
					    branchne <= 1'b0;
					    branchLT <= 1'b0;
					   	memRead <= 1'b0; 
					   	memToReg <= 1'b0; 
					    Shift <= 2'b00;
					   	ALUop <= 3'bxxx;
					   	regWrite <= 1'b0;
					   	ALUSrc <= 1'b0;
					   	memWrite <= 1'b0;
					    memWriteSB <= 1'b0;
					    sys <= 1'b1;
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
				ALUop <= 3'b010;
				regWrite <= 1'b1;
				ALUSrc <= 1'b1;
				memWrite <= 1'b0;
				memWriteSB <= 1'b0;
				sys <= 1'b0;
				jr <= 1'b0;
				jal <= 1'b0;
			end 		
		   
			`LUI: begin
				regDst <= 1'b0;
				jump <= 1'b0;
				branch <= 1'b0;
				branchne <= 1'b0;
				branchLT <= 1'b0;
				memRead <= 1'b0; 
				memToReg <= 1'b0; 
				Shift <= 2'b00;
				ALUop <= 3'b011;
				regWrite <= 1'b1;
				ALUSrc <= 1'b1;
				memWrite <= 1'b0;
				memWriteSB <= 1'b0;
				sys <= 1'b0;
				jr <= 1'b0;
				jal <= 1'b0;
			end

		    `ADDIU: begin
				regDst <= 1'b0;
				jump <= 1'b0;
				branch <= 1'b0;
				branchne <= 1'b0;
				branchLT <= 1'b0;
				memRead <= 1'b0; 
				memToReg <= 1'b0; 
				Shift <= 2'b00;
				ALUop <= 3'b010;
				regWrite <= 1'b1;
				ALUSrc <= 1'b1;
				memWrite <= 1'b0;
				memWriteSB <= 1'b0;
				sys <= 1'b0;
				jr <= 1'b0;
				jal <= 1'b0;
			end	
			`ANDI: begin
				regDst <= 1'b0;
				jump <= 1'b0;
				branch <= 1'b0;
				branchne <= 1'b0;
				branchLT <= 1'b0;
				memRead <= 1'b0; 
			    memToReg <= 1'b0; 
				Shift <= 2'b00;
			    ALUop <= 3'b000;
			    regWrite <= 1'b1;
			    ALUSrc <= 1'b1;
			    memWrite <= 1'b0;
				memWriteSB <= 1'b0;
			    sys <= 1'b0;
			    jr <= 1'b0;
			    jal <= 1'b0;
			end 			// case: `AND

			`ORI: begin
				regDst <= 1'b0;
				jump <= 1'b0;
				branch <= 1'b0;
				branchne <= 1'b0;
				branchLT <= 1'b0;
				memRead <= 1'b0; 
				memToReg <= 1'b0; 
				Shift <= 2'b00;
				ALUop <= 3'b001;
				regWrite <= 1'b1;
				ALUSrc <= 1'b1;
				memWrite <= 1'b0;
				memWriteSB <= 1'b0;
				sys <= 1'b0;
				jr <= 1'b0;
				jal <= 1'b0;
			end

			`LW: begin
				regDst <= 1'b0;
				jump <= 1'b0;
				branch <= 1'b0;
				branchne <= 1'b0;
				branchLT <= 1'b0;
				memRead <= 1'b1; 
				memToReg <= 1'b1; 
				Shift <= 2'b00;
				ALUop <= 3'b010;
				regWrite <= 1'b1;
				ALUSrc <= 1'b1;
				memWrite <= 1'b0;
				memWriteSB <= 1'b0;
				sys <= 1'b0;
				jr <= 1'b0;
				jal <= 1'b0;
			end

			`SW: begin
				regDst <= 1'b0;
				jump <= 1'b0;
				branch <= 1'b0;
				branchne <= 1'b0;
				branchLT <= 1'b0;
				memRead <= 1'b0; 
				memToReg <= 1'b0; 
				Shift <= 2'b00;
				ALUop <= 3'b010;
				regWrite <= 1'b0;
				ALUSrc <= 1'b1;
				memWrite <= 1'b1;
				memWriteSB <= 1'b0;
				sys <= 1'b0;
				jr <= 1'b0;
				jal <= 1'b0;
			end
			`SB: begin
				regDst <= 1'b0;
				jump <= 1'b0;
				branch <= 1'b0;
				branchne <= 1'b0;
				branchLT <= 1'b0;
				memRead <= 1'b0; 
				memToReg <= 1'b0; 
				Shift <= 2'b00;
				ALUop <= 3'b010;
				regWrite <= 1'b0;
				ALUSrc <= 1'b1;
				memWrite <= 1'b0;
				memWriteSB <= 1'b1;
				sys <= 1'b0;
				jr <= 1'b0;
				jal <= 1'b0;
			end

			`BEQ: begin
				regDst <= 1'bx;
				jump <= 1'b0;
				branch <= 1'b1;
				branchne <= 1'b0;
				branchLT <= 1'b0;
				memRead <= 1'b0; 
				memToReg <= 1'b0; 
				Shift <= 2'b00;
				ALUop <= 3'b110;
				regWrite <= 1'b0;
				ALUSrc <= 1'b0;
				memWrite <= 1'b0;
				memWriteSB <= 1'b0;
				sys <= 1'b0;
				jr <= 1'b0;
				jal <= 1'b0;
			end

			`BNE: begin
				regDst <= 1'bx;
				jump <= 1'b0;
				branch <= 1'b0;
				branchne <= 1'b1;
				branchLT <= 1'b0;
				memRead <= 1'b0; 
				memToReg <= 1'b0; 
				Shift <= 2'b00;
				ALUop <= 3'b110;
				regWrite <= 1'b0;
				ALUSrc <= 1'b0;
				memWrite <= 1'b0;
				memWriteSB <= 1'b0;
				sys <= 1'b0;
				jr <= 1'b0;
				jal <= 1'b0;
			end

			`BLTZ: begin
				regDst <= 1'bx;
				jump <= 1'b0;
				branch <= 1'b0;
				branchne <= 1'b0;
				branchLT <= 1'b1;
				memRead <= 1'b0; 
				memToReg <= 1'b0; 
				Shift <= 2'b00;
				ALUop <= 3'b110;
				regWrite <= 1'b0;
				ALUSrc <= 1'b0;
				memWrite <= 1'b0;
				memWriteSB <= 1'b0;
				sys <= 1'b0;
				jr <= 1'b0;
				jal <= 1'b0;
			end//noBLT?

			`J: begin
				regDst <= 1'bx;
				jump <= 1'b1;
				branch <= 1'b0;
				branchne <= 1'b0;
				branchLT <= 1'b0;
				memRead <= 1'b0; 
				memToReg <= 1'b0; 
				Shift <= 2'b00;
				ALUop <= 3'bxxx;
				regWrite <= 1'b0;
				ALUSrc <= 1'bx;
				memWrite <= 1'b0;
				memWriteSB <= 1'b0;
				sys <= 1'b0;
				jr <= 1'b0;
				jal <= 1'b0;
			end
			
       		`JAL: begin
				regDst <= 1'b1;
				jump <= 1'b1;
				branch <= 1'b0;
				branchne <= 1'b0;
				branchLT <= 1'b0;
				memRead <= 1'b0; 
				memToReg <= 1'b0; 
				Shift <= 2'b00;
				ALUop <= 3'bxxx;
				regWrite <= 1'b1;
				ALUSrc <= 1'bx;
				memWrite <= 1'b0;
				memWriteSB <= 1'b0;
				sys <= 1'b0;
				jr <= 1'b0;
				jal <= 1'b1;
			end

			default: begin
				regDst <= 1'b0;
				jump <= 1'b0;
				branch <= 1'b0;
				branchne <= 1'b0;
				branchLT <= 1'b0;
				memRead <= 1'b0; 
				memToReg <= 1'b0; 
				Shift <= 2'b00;
				ALUop <= 3'b000;
				regWrite <= 1'b0;
				ALUSrc <= 1'b0;
				memWrite <= 1'b0;
				memWriteSB <= 1'b0;
				sys <= 1'b0;
				jr <= 1'b0;
				jal <= 1'b0;
			end
		endcase 
	end
endmodule
