//Terence McHugh
module register(input clk,input[4:0] register1,input[4:0] register2,input[4:0] writeregister,input[31:0] data,input regWrite,output reg [31:0]data1,output reg [31:0]data2,output [31:0]regv,output [31:0]rega);
   
    //array of 32 indexes with 32 bit numbers as values
    reg [31:0] mymem [5'b11111 : 5'b00000];
    integer i;

	assign regv = mymem[2];
	assign regv = mymem[4];

    initial begin
        for(i=5'b0; i<5'b11111; i=i+1)begin //set mem values to 0
            mymem[i]=0;
        end
    end

    always @(posedge clk) begin
        data1 = mymem[register1]; //read regester1 to data 1
        data2 = mymem[register2]; //read register 2 to data 2
    end
   
    always @(posedge regWrite) //when the control goes on it knows to write
    begin
        if(regWrite ==1)//if write is on write to writeregister
        begin
            mymem[writeregister]=data;
        end
    end

endmodule // register

