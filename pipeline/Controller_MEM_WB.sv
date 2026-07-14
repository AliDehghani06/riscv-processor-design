module Controller_MEM_WB
(
    input clk,
    input RegWriteM,
    input [1:0] ResultSrcM,
    output RegWriteW,
    output [1:0] ResultSrcW
);

    Register1bit stage0 (clk, 1'b0, 1'b1, RegWriteM, RegWriteW);
    Register2bit stage1 (clk, 1'b0, 1'b1, ResultSrcM, ResultSrcW);
endmodule