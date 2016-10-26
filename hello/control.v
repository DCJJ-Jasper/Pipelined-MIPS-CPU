// Control module
// The control module takes in the opcode and function code for every instruction. Many wires are output, the majority being simple 1-bit wires. the alu code is longer because it specifies what operation to form. These signals are what control the flow of our processor defining the behavior. The signals incorporate jump logic, changing memory, register reading and writing, and system calls. Case statements are used identify the type of instruction.
`include "mips.h"
`timescale 1ns/1ns

module control(opcode,
	func,
	regDst, 
	jump, 
	branch, 
	memRead, 
	memToReg, 
	ALUop, 
	regWrite,
	ALUSrc,
	memWrite,
	sys,
	jr,
	jal
);

	input [5:0] opcode;
	input [5:0] func;
	output reg regDst;
	output reg jump;
	output reg branch;
	output reg memRead;
	output reg memToReg;
	output reg [2:0] ALUop;
	output reg regWrite;
	output reg ALUSrc;
	output reg memWrite;
	output reg sys;
	output reg jr;
	output reg jal;

	// Initialization
	initial begin
		regDst = 1'b0;
		jump = 1'b0;
		branch = 1'b0;
		memRead = 1'b0; 
		memToReg = 1'b0; 
		ALUop = 3'bxxx;
		regWrite = 1'b0;
		ALUSrc = 1'b0;
		memWrite = 1'b0;
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
					   memRead <= 1'b0; 
					   memToReg <= 1'b0; 
					   ALUop <= 3'b010;
					   regWrite <= 1'b1;
					   ALUSrc <= 1'b0;
					   memWrite <= 1'b0;
					   sys <= 1'b0;
					   jr <= 1'b0;
					   jal <= 1'b0;
					end 			// case: `ADD

					`ADDU: begin 
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
					end 			// case: `ADDU

					`AND: begin
					regDst <= 1'b1;
					   jump <= 1'b0;
					   branch <= 1'b0;
					   memRead <= 1'b0; 
					   memToReg <= 1'b0; 
					   ALUop <= 3'b000;
					   regWrite <= 1'b1;
					   ALUSrc <= 1'b0;
					   memWrite <= 1'b0;
					   sys <= 1'b0;
					   jr <= 1'b0;
					   jal <= 1'b0;
					end 			// case: `AND

					`JR: begin
					   regDst <= 1'bx;
					   jump <= 1'b0;
					   branch <= 1'b0;
					   memRead <= 1'b0; 
					   memToReg <= 1'b0; 
					   ALUop <= 3'bxxx;
					   regWrite <= 1'b0;
					   ALUSrc <= 1'bx;
					   memWrite <= 1'b0;
					   sys <= 1'b0;
					   jr <= 1'b1;
					   jal <= 1'b0;
					end 			// case: `JR

					`OR: begin
					   regDst <= 1'b1;
					   jump <= 1'b0;
					   branch <= 1'b0;
					   memRead <= 1'b0; 
					   memToReg <= 1'b0; 
					   ALUop <= 3'b001;
					   regWrite <= 1'b1;
					   ALUSrc <= 1'b0;
					   memWrite <= 1'b0;
					   sys <= 1'b0;
					   jr <= 1'b0;
					   jal <= 1'b0;
					end 			// case: `OR

					`SLL: begin
					   regDst <= 1'b0;
					   jump <= 1'b0;
					   branch <= 1'b0;
					   memRead <= 1'b0; 
					   memToReg <= 1'b0; 
					   ALUop <= 3'bxxx;
					   regWrite <= 1'b0;
					   ALUSrc <= 1'b0;
					   memWrite <= 1'b0;
					   sys <= 1'b0;
					   jr <= 1'b0;
					   jal <= 1'b0;
					end 			// case: `SLl
					
					`SLT: begin
					   regDst <= 1'b1;
					   jump <= 1'b0;
					   branch <= 1'b0;
					   memRead <= 1'b0; 
					   memToReg <= 1'b0; 
					   ALUop <= 3'b111;
					   regWrite <= 1'b1;
					   ALUSrc <= 1'b0;
					   memWrite <= 1'b0;
					   sys <= 1'b0;
					   jr <= 1'b0;
					   jal <= 1'b0;
					end 			// case: `SLT

					`SUB: begin
					   regDst <= 1'b1;
					   jump <= 1'b0;
					   branch <= 1'b0;
					   memRead <= 1'b0; 
					   memToReg <= 1'b0; 
					   ALUop <= 3'b110;
					   regWrite <= 1'b1;
					   ALUSrc <= 1'b0;
					   memWrite <= 1'b0;
					   sys <= 1'b0;
					   jr <= 1'b0;
					   jal <= 1'b0;
					end  

					`SYSCALL: begin
						regDst <= 1'b0;
					   	jump <= 1'b0;
					   	branch <= 1'b0;
					   	memRead <= 1'b0; 
					   	memToReg <= 1'b0; 
					   	ALUop <= 3'bxxx;
					   	regWrite <= 1'b0;
					   	ALUSrc <= 1'b0;
					   	memWrite <= 1'b0;
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
				memRead <= 1'b0; 
				memToReg <= 1'b0; 
				ALUop <= 3'b010;
				regWrite <= 1'b1;
				ALUSrc <= 1'b1;
				memWrite <= 1'b0;
				sys <= 1'b0;
				jr <= 1'b0;
				jal <= 1'b0;
			end 		
		   
			`LUI: begin
				regDst <= 1'b0;
				jump <= 1'b0;
				branch <= 1'b0;
				memRead <= 1'b0; 
				memToReg <= 1'b0; 
				ALUop <= 3'b011;
				regWrite <= 1'b1;
				ALUSrc <= 1'b1;
				memWrite <= 1'b0;
				sys <= 1'b0;
				jr <= 1'b0;
				jal <= 1'b0;
			end

		    `ADDIU: begin
				regDst <= 1'b0;
				jump <= 1'b0;
				branch <= 1'b0;
				memRead <= 1'b0; 
				memToReg <= 1'b0; 
				ALUop <= 3'b010;
				regWrite <= 1'b1;
				ALUSrc <= 1'b1;
				memWrite <= 1'b0;
				sys <= 1'b0;
				jr <= 1'b0;
				jal <= 1'b0;
			end	

			`ORI: begin
				regDst <= 1'b0;
				jump <= 1'b0;
				branch <= 1'b0;
				memRead <= 1'b0; 
				memToReg <= 1'b0; 
				ALUop <= 3'b001;
				regWrite <= 1'b1;
				ALUSrc <= 1'b1;
				memWrite <= 1'b0;
				sys <= 1'b0;
				jr <= 1'b0;
				jal <= 1'b0;
			end

			`LW: begin
				regDst <= 1'b0;
				jump <= 1'b0;
				branch <= 1'b0;
				memRead <= 1'b1; 
				memToReg <= 1'b1; 
				ALUop <= 3'b010;
				regWrite <= 1'b1;
				ALUSrc <= 1'b1;
				memWrite <= 1'b0;
				sys <= 1'b0;
				jr <= 1'b0;
				jal <= 1'b0;
			end

			`SW: begin
				regDst <= 1'b0;
				jump <= 1'b0;
				branch <= 1'b0;
				memRead <= 1'b0; 
				memToReg <= 1'b0; 
				ALUop <= 3'b010;
				regWrite <= 1'b0;
				ALUSrc <= 1'b1;
				memWrite <= 1'b1;
				sys <= 1'b0;
				jr <= 1'b0;
				jal <= 1'b0;
			end

			`BEQ: begin
				regDst <= 1'bx;
				jump <= 1'b0;
				branch <= 1'b1;
				memRead <= 1'b0; 
				memToReg <= 1'b0; 
				ALUop <= 3'b110;
				regWrite <= 1'b0;
				ALUSrc <= 1'b0;
				memWrite <= 1'b0;
				sys <= 1'b0;
				jr <= 1'b0;
				jal <= 1'b0;
			end

			`BNE: begin
				regDst <= 1'bx;
				jump <= 1'b0;
				branch <= 1'b1;
				memRead <= 1'b0; 
				memToReg <= 1'b0; 
				ALUop <= 3'b110;
				regWrite <= 1'b0;
				ALUSrc <= 1'b0;
				memWrite <= 1'b0;
				sys <= 1'b0;
				jr <= 1'b0;
				jal <= 1'b0;
			end

			`J: begin
				regDst <= 1'bx;
				jump <= 1'b1;
				branch <= 1'b0;
				memRead <= 1'b0; 
				memToReg <= 1'b0; 
				ALUop <= 3'bxxx;
				regWrite <= 1'b0;
				ALUSrc <= 1'bx;
				memWrite <= 1'b0;
				sys <= 1'b0;
				jr <= 1'b0;
				jal <= 1'b0;
			end
			
       		`JAL: begin
				regDst <= 1'b1;
				jump <= 1'b1;
				branch <= 1'b0;
				memRead <= 1'b0; 
				memToReg <= 1'b0; 
				ALUop <= 3'bxxx;
				regWrite <= 1'b1;
				ALUSrc <= 1'bx;
				memWrite <= 1'b0;
				sys <= 1'b0;
				jr <= 1'b0;
				jal <= 1'b1;
			end

			default: begin
				regDst <= 1'b0;
				jump <= 1'b0;
				branch <= 1'b0;
				memRead <= 1'b0; 
				memToReg <= 1'b0; 
				ALUop <= 3'b000;
				regWrite <= 1'b0;
				ALUSrc <= 1'b0;
				memWrite <= 1'b0;
				sys <= 1'b0;
				jr <= 1'b0;
				jal <= 1'b0;
			end
		endcase 
	end
endmodule
