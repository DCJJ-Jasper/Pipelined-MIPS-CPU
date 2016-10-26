module HazardUnit(BranchD, WriteRegE, MemtoRegE, RegWriteE, WriteRegM, MemtoRegM, RegWriteM, WriteRegW, RegWriteW, RsD, RtD, RsE, RtE, StallF, StallD, FlushE, ForwardAD, ForwardBD, ForwardAE, ForwardBE); 

    input BranchD;

    input [4:0] WriteRegE;
    input MemtoRegE;
    input RegWriteE;

    input [4:0] WriteRegM;
    input MemtoRegM;
    input RegWriteM;

    input [4:0] WriteRegW;
    input RegWriteW;

    input [4:0] RsD;
    input [4:0] RtD;
    input [4:0] RsE;
    input [4:0] RtE;

    output reg StallF;
    output reg StallD;
    output reg FlushE;
    output reg ForwardAD; 
    output reg ForwardBD;
    output reg [1:0] ForwardAE;
    output reg [1:0] ForwardBE;
    
    initial begin 
        StallF = 0;
        StallD = 0;
        FlushE = 0;
        ForwardAD = 0; 
        ForwardBD = 0;
        ForwardAE = 0;
        ForwardBE = 0;
    end 

    // Control StallF, StallD & FlushE
    always@(MemtoRegE, RtE, RtD, RsD)
    begin      
        if ((MemtoRegE & ((RtE == RtD)|(RtE == RsD)))||((BranchD && RegWriteE && (WriteRegE == RsD || WriteRegE == RtD)) || (BranchD && MemtoRegM && (WriteRegM == RsD || WriteRegM == RtD))))   
        begin
            StallF = 1;
            StallD = 1;
            FlushE = 1;
        end
        else
        begin
            StallF = 0;
            StallD = 0;
            FlushE = 0;
        end

    end

    // Control ForwardAD
    always@(RegWriteM, WriteRegM, RsD)
    begin      
        if (RegWriteM & (RsD == WriteRegM) & (RsD != 0))
            ForwardAD = 1;  
        else
            ForwardAD = 0; 
    end

    // Control ForwardBD
    always@(RegWriteM, WriteRegM, RtD)
    begin      
        if (RegWriteM & (RtD == WriteRegM) & (RtD != 0))
            ForwardBD = 1;
        else
            ForwardBD = 0;
    end

    // Control ForwardAE
    always@(RegWriteM, WriteRegM, RegWriteW, WriteRegW, RsE)
    begin      
        if (RegWriteM & (RsE == WriteRegM) & (WriteRegM != 0))
            ForwardAE = 10;
        else if (RegWriteW & (WriteRegW != 0) & (RsE != WriteRegM) & (RsE == WriteRegW))
            ForwardAE = 01;
        else
            ForwardAE = 00;
    end

    // Control ForwardBE
    always@(RegWriteM, WriteRegM, RegWriteW, WriteRegW, RtE)
    begin      
        if (RegWriteM && (RtE == WriteRegM) && (WriteRegM != 0))
            ForwardBE = 10;
        else if (RegWriteW && (WriteRegW != 0) && (RtE != WriteRegM) && (RtE == WriteRegW))
            ForwardBE = 01;
        else
            ForwardBE = 00;
    end

endmodule