module DataPath
(
    input clk, PCSrc, RegWrite, AdderSrc, ALUSrc, ResultSrc, RFWriteSrc,
    input [1:0] ImmSrc,
    input [2:0] ALUFunc,
    input [31:0] inst, MemData,
    output zero,    
    output [31:0] PC_out, ALU_out, RegData2
);
    
    wire [31:0] PC_in, RegWriteData, RegData1, ALU_input2, Imm_out, Sum1_out, Sum2_out, Sum2_in, Result_out;

    PC stage0 (clk, PC_in, PC_out);
    RF stage1 (clk, inst[19:15], inst[24:20], inst[11:7], RegWriteData, RegWrite, RegData1, RegData2);
    ALU stage2 (RegData1, ALU_input2, ALUFunc, ALU_out, zero);
    Imm_Ext stage3 (inst[31:7], ImmSrc, Imm_out);
    
    Multiplexer2to1 stage4 (Sum1_out, Sum2_out, PCSrc, PC_in);
    Multiplexer2to1 stage5 (RegData2, Imm_out, ALUSrc, ALU_input2);
    Multiplexer2to1 stage6 (PC_out, RegData1, AdderSrc, Sum2_in);
    Multiplexer2to1 stage7 (ALU_out, MemData, ResultSrc, Result_out);
    Multiplexer2to1 stage8 (Result_out, Sum1_out, RFWriteSrc, RegWriteData);

    Sum stage9 (PC_out, 32'd4, Sum1_out);
    Sum stage10 (Imm_out, Sum2_in, Sum2_out);


endmodule