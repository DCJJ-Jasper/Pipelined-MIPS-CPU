// ALU (An arithmetic logic unit ) module

// This modules does arithmetic logic depending on the given alu control signal.
// According to the given control signal, it will do the corresponding arithmetic based on the given 2 inputs: rs and rt, and then pass to the output.

module alu(opcode, rs, rt, out);

    input [2:0] opcode;
    input [31:0] rs;
    input [31:0] rt;
    output [31:0] out;

    reg [31:0] temp;

    always@(*) begin
      
        case(opcode)    
            3'b000:     //and
            begin
                temp = rs & rt;
            end

            3'b001:     //or
            begin
                temp = rs | rt;
            end

            3'b010:     //add
            begin
                temp = rs + rt;
            end

            3'b011:     //lui
            begin
                temp = rt<<16;
            end

            3'b110:     //sub
            begin
                temp = rs-rt;
            end

            3'b111:     //slt
            begin
                if(rs<rt)
                begin
                    temp = 1;
                end
                else
                begin
                    temp = 0;
                end
            end
     
            default: temp = 0;
     
        endcase         

    end 

    assign out = temp;
   
endmodule




/*
// Here is the simple test for this module individually.
module test();
   
    reg [2:0] opcode = 3'b010;
    reg [31:0] rs = 32'b1011;
    reg [31:0] rt = 32'b111;

    wire [31:0] out;

    initial begin
        #10 opcode = 6;
        #10 opcode = 0;
        #10 opcode = 1;
        #10 opcode = 7;
    end

    initial
        $monitor("op:%b rs:%b rt:%b out:%b",opcode,rs,rt,out );

    alu one(opcode,rs,rt,out);
     
endmodule
*/
