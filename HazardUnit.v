module HazardUnit(BranchD, WriteRegE, MemtoRegE, RegWriteE, WriteRegM, MemtoRegM, RegWriteM, WriteRegW, RegWriteW, RsD, RtD, RsE, RtE, StallF, StallD, FlushE, ForwardAD, ForwardBD, ForwardAE, ForwardBE); 

    // BranchD is not used recently, fix it somehow
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
        // Does this way of initializing the values of forwarding hurts?
        ForwardAD = 0; 
        ForwardBD = 0;
        ForwardAE = 0;
        ForwardBE = 0;
    end 

    // TODO double-check the logic is correct

    // Control StallF, StallD & FlushE
    always(@)
    begin      
        if (MemtoRegE & ((RtE == RtD)|(RtE == RsD)))   
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
    always(@)
    begin      
        if (RegWriteM & (RsD == WriteRegM) & (RsD != 0))
            ForwardAD = 1;  
        else
            ForwardAD = 0; 
    end

    // Control ForwardBD
    always(@)
    begin      
        if (RegWriteM & (RtD == WriteRegM) & (RtD != 0))
            ForwardBD = 1;
        else
            ForwardBD = 0;
    end

    // Control ForwardAE
    always(@)
    begin      
        if (RegWriteM & (RsE == WriteRegM) & (WriteRegM != 0))
            ForwardAE = 10;
        else if (RegWriteW & (WriteRegW != 0) & (RsE != WriteRegM) & (RsE == WriteRegW))
            ForwardAE = 01;
        else
            ForwardAE = 00;
    end

    // Control ForwardBE
    always(@)
    begin      
        if (RegWriteM & (RtE == WriteRegM) & (WriteRegM != 0))
            ForwardBE = 0;
        else if (RegWriteW & (WriteRegW != 0) & (RtE != WriteRegM) & (RtE == WriteRegW))
            ForwardBE = 0;
        else
            ForwardBE = 0;
    end

endmodule