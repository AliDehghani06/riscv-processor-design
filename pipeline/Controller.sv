module Controller
(
    input clk, reset, FlushE, zero,
    input [31:0] inst,
    output PCSrcE, RegWriteM, RegWriteW, AdderSrcE, ALUSrcE, MemWriteM,
    output [1:0] ImmSrcD, ResultSrcE, ResultSrcW,
    output [2:0] ALU_functionE
);

    wire RegWriteD, AdderSrcD, ALUSrcD, MemWriteD, PCWriteCondD, PCWriteD, RegWriteE, MemWriteE, PCWriteCondE, PCWriteE;
    wire [1:0] ALU_operation, ResultSrcD, ResultSrcM;
    wire [2:0] ALU_functionD, func3E;


    // ID
    CU stage_CU (inst[6:0], RegWriteD, AdderSrcD, ALUSrcD, MemWriteD, PCWriteCondD, PCWriteD, ResultSrcD, ImmSrcD, ALU_operation);
    ALUController stage_ALU_Controller (inst[14:12], inst[31:25], ALU_operation, ALU_functionD);

    // ID_EX
    Controller_ID_EX stage_ID_EX (clk, FlushE, RegWriteD, AdderSrcD, ALUSrcD, MemWriteD, PCWriteCondD, PCWriteD, ResultSrcD, ALU_functionD, inst[14:12],
                                               RegWriteE, AdderSrcE, ALUSrcE, MemWriteE, PCWriteCondE, PCWriteE, ResultSrcE, ALU_functionE, func3E);
    // EX
    PCController stage_PCSrc (reset, func3E, PCWriteCondE, PCWriteE, zero, PCSrcE);

    // EX_MEM
    Controller_EX_MEM stage_EX_MEM (clk, RegWriteE, MemWriteE, ResultSrcE,
                                         RegWriteM, MemWriteM, ResultSrcM);
    
    // MEM_WB
    Controller_MEM_WB stage_MEM_WB (clk, RegWriteM, ResultSrcM,
                                         RegWriteW, ResultSrcW);

endmodule