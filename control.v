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
	memWrite
);

	input [5:0] opcode;
	output reg regDst;
	output reg jump;
	output reg branch;
	output reg memRead;
	output reg memToReg;
	output reg [2:0] ALUop;
	output reg regWrite;
	output reg ALUSrc;
	output reg memWrite;

	initial begin
		regDst = 1'bx;
		jump = 1'bx;
		branch = 1'bx;
		memRead = 1'bx; 
		memToReg = 1'bx; 
		ALUop = 3'bxxx;
		regWrite = 1'bx;
		ALUSrc = 1'bx;
		memWrite = 1'bx;
	end

	always @(*) begin
		case (opcode)
		        `SPECIAL:begin
		              case (func)
				`ADD: begin
				#15 regDst <= 1'b1;
				   jump <= 1'b0;
				   branch <= 1'b0;
				   memRead <= 1'b0; 
				   memToReg <= 1'b0; 
				   ALUop <= 3'b010;
				   regWrite <= 1'b1;
				   ALUSrc <= 1'b0;
				   memWrite <= 1'b0;
				end // case: `ADD
				`ADDU: begin 
				#15 regDst <= 1'b1;
				   jump <= 1'b0;
				   branch <= 1'b0;
				   memRead <= 1'b0; 
				   memToReg <= 1'b0; 
				   ALUop <= 3'b010;
				   regWrite <= 1'b1;
				   ALUSrc <= 1'b0;
				   memWrite <= 1'b0;
				end // case: `ADDU
				`AND: begin
				#15 regDst <= 1'b1;
				   jump <= 1'b0;
				   branch <= 1'b0;
				   memRead <= 1'b0; 
				   memToReg <= 1'b0; 
				   ALUop <= 3'b000;
				   regWrite <= 1'b1;
				   ALUSrc <= 1'b0;
				   memWrite <= 1'b0;
				end // case: `AND
				`JR: begin
				   #15 regDst <= 1'bx;
				   jump <= 1'b1;
				   branch <= 1'b0;
				   memRead <= 1'b0; 
				   memToReg <= 1'b0; 
				   ALUop <= 3'bxxx;
				   regWrite <= 1'b0;
				   ALUSrc <= 1'bx;
				   memWrite <= 1'b0;
				end // case: `JR
				`OR: begin
				   #15 regDst <= 1'b1;
				   jump <= 1'b0;
				   branch <= 1'b0;
				   memRead <= 1'b0; 
				   memToReg <= 1'b0; 
				   ALUop <= 3'b001;
				   regWrite <= 1'b1;
				   ALUSrc <= 1'b0;
				   memWrite <= 1'b0;
				end // case: `OR
				
				`SLT: begin
				   #15 regDst <= 1'b1;
				   jump <= 1'b0;
				   branch <= 1'b0;
				   memRead <= 1'b0; 
				   memToReg <= 1'b0; 
				   ALUop <= 3'b111;
				   regWrite <= 1'b1;
				   ALUSrc <= 1'b0;
				   memWrite <= 1'b0;
				end // case: `SLT
				`SUB: begin
				   #15 regDst <= 1'b1;
				   jump <= 1'b0;
				   branch <= 1'b0;
				   memRead <= 1'b0; 
				   memToReg <= 1'b0; 
				   ALUop <= 3'b110;
				   regWrite <= 1'b1;
				   ALUSrc <= 1'b0;
				   memWrite <= 1'b0;
				end     
			      endcase 
		        
			`ADDI: begin
				#15 regDst <= 1'b0;
				jump <= 1'b0;
				branch <= 1'b0;
				memRead <= 1'b0; 
				memToReg <= 1'b0; 
				ALUop <= 3'b010;
				regWrite <= 1'b1;
				ALUSrc <= 1'b1;
				memWrite <= 1'b0;
			end // case: endcase...
		        `ADDIU: begin
				#15 regDst <= 1'b0;
				jump <= 1'b0;
				branch <= 1'b0;
				memRead <= 1'b0; 
				memToReg <= 1'b0; 
				ALUop <= 3'b010;
				regWrite <= 1'b1;
				ALUSrc <= 1'b1;
				memWrite <= 1'b0;
			end	
			`ORI: begin
				#15 regDst <= 1'b0;
				jump <= 1'b0;
				branch <= 1'b0;
				memRead <= 1'b0; 
				memToReg <= 1'b0; 
				ALUop <= 3'b001;
				regWrite <= 1'b1;
				ALUSrc <= 1'b1;
				memWrite <= 1'b0;
			end
			`LW: begin
				#15 regDst <= 1'b0;
				jump <= 1'b0;
				branch <= 1'b0;
				memRead <= 1'b1; 
				memToReg <= 1'b1; 
				ALUop <= 3'b010;
				regWrite <= 1'b1;
				ALUSrc <= 1'b1;
				memWrite <= 1'b0;
			end
			`SW: begin
				#15 regDst <= 1'bx;
				jump <= 1'b0;
				branch <= 1'b0;
				memRead <= 1'b0; 
				memToReg <= 1'b0; 
				ALUop <= 3'b010;
				regWrite <= 1'b0;
				ALUSrc <= 1'b1;
				memWrite <= 1'b1;
			end
			`BEQ: begin
				#15 regDst <= 1'bx;
				jump <= 1'b0;
				branch <= 1'b1;
				memRead <= 1'b0; 
				memToReg <= 1'b0; 
				ALUop <= 3'b110;
				regWrite <= 1'b0;
				ALUSrc <= 1'b0;
				memWrite <= 1'b0;
			end
			`BNE: begin
				#15 regDst <= 1'bx;
				jump <= 1'b0;
				branch <= 1'b1;
				memRead <= 1'b0; 
				memToReg <= 1'b0; 
				ALUop <= 3'b110;
				regWrite <= 1'b0;
				ALUSrc <= 1'b0;
				memWrite <= 1'b0;
			end
			`J: begin
				#15 regDst <= 1'bx;
				jump <= 1'b1;
				branch <= 1'b0;
				memRead <= 1'b0; 
				memToReg <= 1'b0; 
				ALUop <= 3'bxxx;
				regWrite <= 1'b0;
				ALUSrc <= 1'bx;
				memWrite <= 1'b0;
				$display("Here is a jump.");
			end
			
       			`JAL: begin
				#15 regDst <= 1'bx;
				jump <= 1'b1;
				branch <= 1'b0;
				memRead <= 1'b0; 
				memToReg <= 1'b0; 
				ALUop <= 3'bxxx;
				regWrite <= 1'b0;
				ALUSrc <= 1'bx;
				memWrite <= 1'b0;
			end
			default: begin
				#15 regDst <= 1'b0;
				jump <= 1'b0;
				branch <= 1'b0;
				memRead <= 1'b0; 
				memToReg <= 1'b0; 
				ALUop <= 3'b000;
				regWrite <= 1'b0;
				ALUSrc <= 1'b0;
				memWrite <= 1'b0;
			end
		endcase 
	end
endmodule
