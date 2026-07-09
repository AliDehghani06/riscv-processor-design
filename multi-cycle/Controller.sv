module Controller
(
    input clk, reset, zero,
    input [31:0] inst,
    output PCWrite, AdrSrc, RegWrite, OldPCWrite, IRWrite, MemWrite,
    output [1:0] ImmSrc, ALUSrcA, ALUSrcB, ResultSrc,
    output [2:0] ALU_function
);

    wire PCWriteCond, PC_write;
    wire [1:0] ALU_operation;

    MainController stage0 (clk, reset, inst[6:0], PC_write, AdrSrc, RegWrite, OldPCWrite, IRWrite, PCWriteCond, MemWrite, ImmSrc, ALU_operation, ALUSrcA, ALUSrcB, ResultSrc);
    ALUController stage1 (inst[14:12], inst[31:25], ALU_operation, ALU_function);
    PCController stage2(inst[14:12], PCWriteCond, PC_write, zero, PCWrite);
    
endmodule