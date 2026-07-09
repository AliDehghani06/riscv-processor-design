module DataPath
(
    input clk, reset, PCWrite, AdrSrc, RegWrite, OldPCWrite, IRWrite,
    input [1:0] ImmSrc, ALUSrcA, ALUSrcB, ResultSrc,
    input [2:0] ALUFunc,
    input [31:0] MemData,
    output zero,
    output [31:0] MemAddress, MemWriteData, inst
);
    
    wire [31:0] Result, PC_out, RegData1, RegData2, ALU_A, ALU_B, ALU_out, Imm_out, OldPC_out, ALUOut_out, A_out, B_out, MDR_out;
    
    assign MemWriteData = B_out; 

    PC stage0 (clk, reset, PCWrite, Result, PC_out);
    RF stage1 (clk, inst[19:15], inst[24:20], inst[11:7], Result, RegWrite, RegData1, RegData2);

    ALU stage2 (ALU_A, ALU_B, ALUFunc, ALU_out, zero);
    Imm_Ext stage3 (inst[31:7], ImmSrc, Imm_out);
    
    RegisterWithEnable IR (clk, IRWrite, MemData, inst);
    RegisterWithEnable OldPC (clk, OldPCWrite, PC_out, OldPC_out);


    Register A (clk, RegData1, A_out);
    Register B (clk, RegData2, B_out);
    Register MDR (clk, MemData, MDR_out);
    Register ALUOut (clk, ALU_out, ALUOut_out);


    Multiplexer2to1 stage4 (PC_out, Result, AdrSrc, MemAddress);

    Multiplexer3to1 stage5 (PC_out, OldPC_out, A_out, ALUSrcA, ALU_A);
    Multiplexer3to1 stage6 (B_out, Imm_out, 32'd4, ALUSrcB, ALU_B);
    Multiplexer3to1 stage7 (ALUOut_out, ALU_out, MDR_out, ResultSrc, Result);

endmodule