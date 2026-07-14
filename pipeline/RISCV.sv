module RISCV
(
    input clk, reset, 
    input [31:0] inst_RD, data_RD,
    output MemWriteM,
    output [31:0] inst_adr, data_adr, data_WD
);

    wire PCSrcE, AdderSrcE, RegWriteM, RegWriteW, ALUSrcE, StallF, StallD, FlushD, FlushE, zero;
    wire [1:0] ResultSrcE, ResultSrcW, ImmSrcD, ForwardAE, ForwardBE;
    wire [2:0] ALUFuncE;
    wire [4:0] Rs1D, Rs2D, Rs1E, Rs2E, RdE, RdM, RdW;
    wire [31:0] inst;


    DataPath stage_DataPath (clk, reset,  PCSrcE, AdderSrcE, RegWriteW, ALUSrcE, StallF, StallD, FlushD, FlushE, ResultSrcW, ImmSrcD, ForwardAE, ForwardBE, ALUFuncE, inst_RD, data_RD,
                            zero, Rs1D, Rs2D, Rs1E, Rs2E, RdE, RdM, RdW, inst_adr, data_adr, data_WD, inst);

    Controller stage_Controller (clk, reset, FlushE, zero, inst, PCSrcE, RegWriteM, RegWriteW, AdderSrcE, ALUSrcE, MemWriteM, ImmSrcD, ResultSrcE, ResultSrcW, ALUFuncE);

    HazadDetectionUnit stage_HazadDetection (reset, PCSrcE, RegWriteM, RegWriteW, ResultSrcE, Rs1D, Rs2D, Rs1E, Rs2E, RdE, RdM, RdW, StallF, StallD, FlushD, FlushE, ForwardAE, ForwardBE);

endmodule