module RISCV
(
    input clk, reset,
    input [31:0] MemData,
    output [31:0] MemAddress, MemWriteData,
    output MemWrite
);
    wire PCWrite, AdrSrc, RegWrite, OldPCWrite, IRWrite;
    wire [1:0] ImmSrc, ALUSrcA, ALUSrcB, ResultSrc;
    wire [2:0] ALUFunc;
    wire zero;
    wire [31:0] inst;


    DataPath stage0 (clk, reset, PCWrite, AdrSrc, RegWrite, OldPCWrite, IRWrite, ImmSrc, ALUSrcA, ALUSrcB, ResultSrc, ALUFunc, MemData, zero, MemAddress, MemWriteData, inst);
    Controller stage1 (clk, reset, zero, inst, PCWrite, AdrSrc, RegWrite, OldPCWrite, IRWrite, MemWrite, ImmSrc, ALUSrcA, ALUSrcB, ResultSrc, ALUFunc);
endmodule