module HazadDetectionUnit
(
    input reset, PCSrcE, RegWriteM, RegWriteW,
    input [1:0] ResultSrcE, 
    input [4:0] Rs1D, Rs2D, Rs1E, Rs2E, RdE, RdM, RdW,
    output reg StallF, StallD, FlushD, FlushE,
    output reg [1:0] ForwardAE, ForwardBE
);

    reg lwStall;

    always @(*)
    begin
        StallF = 1'b0; StallD = 1'b0; FlushD = 1'b0; FlushE = 1'b0; lwStall = 1'b0;
        ForwardAE = 2'b00; ForwardBE = 2'b00;

        if(reset)
        begin
            StallF = 1'b0; StallD = 1'b0; FlushD = 1'b0; FlushE = 1'b0; lwStall = 1'b0;
            ForwardAE = 2'b00; ForwardBE = 2'b00;
        end 

        if ((RegWriteM == 1'b1) && (Rs1E == RdM) && (Rs1E != 5'd0))
            ForwardAE = 2'b01;
        else if ((RegWriteW == 1'b1) && (Rs1E == RdW) && (Rs1E != 5'd0))
            ForwardAE = 2'b10;
        
        if ((RegWriteM == 1'b1) && (Rs2E == RdM) && (Rs2E != 5'd0))
            ForwardBE = 2'b01;
        else if ((RegWriteW == 1'b1) && (Rs2E == RdW) && (Rs2E != 5'd0))
            ForwardBE = 2'b10;
        
        if(ResultSrcE == 2'b01)
            lwStall = (Rs1D == RdE) || (Rs2D == RdE);
        
        if(lwStall == 1'b1)
        begin
           StallF = 1'b1;
           StallD = 1'b1; 
        end

        if(PCSrcE == 1'b1)
            FlushD = 1'b1;
        
        if(PCSrcE == 1'b1 || lwStall == 1'b1)
            FlushE = 1'b1;

    end

endmodule
