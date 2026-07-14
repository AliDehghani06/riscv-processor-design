module Controller_ID_EX
(
    input clk, reset,
    input RegWriteD, AdderSrcD, ALUSrcD, MemWriteD, PCWriteCondD, PCWriteD,
    input [1:0] ResultSrcD,
    input [2:0] ALU_functionD, func3D,
    output RegWriteE, AdderSrcE, ALUSrcE, MemWriteE, PCWriteCondE, PCWriteE,
    output [1:0] ResultSrcE,
    output [2:0] ALU_functionE, func3E
);

    Register1bit stage0 (clk, reset, 1'b1, RegWriteD, RegWriteE);
    Register1bit stage1 (clk, reset, 1'b1, AdderSrcD, AdderSrcE);
    Register1bit stage2 (clk, reset, 1'b1, ALUSrcD, ALUSrcE);
    Register1bit stage3 (clk, reset, 1'b1, MemWriteD, MemWriteE);
    Register1bit stage4 (clk, reset, 1'b1, PCWriteCondD, PCWriteCondE);
    Register1bit stage5 (clk, reset, 1'b1, PCWriteD, PCWriteE);
    Register2bit stage6 (clk, reset, 1'b1, ResultSrcD, ResultSrcE);
    Register3bit stage7 (clk, reset, 1'b1, ALU_functionD, ALU_functionE);
    Register3bit stage8 (clk, reset, 1'b1, func3D, func3E);

endmodule