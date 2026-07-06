module RISCV
(
    input clk,
    input [31:0] inst, MemData,
    output [31:0] PC_out, ALU_out, RegData2,
    output MemWrite
);
    wire PCSrc, RegWrite, AdderSrc, ALUSrc, ResultSrc, RFWriteSrc;
    wire [1:0] ImmSrc;
    wire [2:0] ALUFunc;
    wire zero;


    DataPath stage0(clk, PCSrc, RegWrite, AdderSrc, ALUSrc, ResultSrc, RFWriteSrc, ImmSrc, ALUFunc, inst, MemData, zero, PC_out, ALU_out, RegData2);
    Controller stage1(inst, zero, PCSrc, RegWrite, AdderSrc, ALUSrc, MemWrite, ResultSrc, RFWriteSrc, ImmSrc, ALUFunc);

endmodule