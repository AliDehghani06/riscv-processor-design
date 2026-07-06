module Controller
(
    input [31:0] inst,
    input zero,
    output PCSrc, RegWrite, AdderSrc, ALUSrc, MemWrite, ResultSrc, RFWriteSrc,
    output [1:0] ImmSrc,
    output [2:0] ALU_function
);

    wire branch, jump;
    wire [1:0] ALU_operation;

    MainController stage0 (inst[6:0], RegWrite, AdderSrc, ALUSrc, MemWrite, ResultSrc, RFWriteSrc, branch, jump, ImmSrc, ALU_operation);
    ALUController stage1 (inst[14:12], inst[31:25], ALU_operation, ALU_function);
    PCController stage2(inst[14:12], branch, jump, zero, PCSrc);

endmodule