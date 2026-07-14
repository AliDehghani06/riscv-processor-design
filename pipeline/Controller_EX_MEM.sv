module Controller_EX_MEM
(
    input clk,
    input RegWriteE, MemWriteE,
    input [1:0] ResultSrcE,
    output RegWriteM, MemWriteM,
    output [1:0] ResultSrcM
);
    Register1bit stage0 (clk, 1'b0, 1'b1, RegWriteE, RegWriteM);
    Register1bit stage1 (clk, 1'b0, 1'b1, MemWriteE, MemWriteM);
    Register2bit stage2 (clk, 1'b0, 1'b1, ResultSrcE, ResultSrcM);
endmodule