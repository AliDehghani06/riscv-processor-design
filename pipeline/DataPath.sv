module DataPath
(
    input clk, reset,  PCSrc, AdderSrc, RegWrite, ALUSrc, StallF, StallD, FlushD, FlushE,
    input [1:0] ResultSrc, ImmSrc, ForwardAE, ForwardBE,
    input [2:0] ALUFunc,
    input [31:0] inst_RD, data_RD,
    output zero,
    output [4:0] Rs1D, Rs2D, Rs1E, Rs2E, RdE, RdM, RdW,
    output [31:0] inst_adr, data_adr, data_WD, inst
);

    wire [31:0] PC_in, PC_out_IF, PC_out_ID, PC_out_EX, sum0_out_IF, sum0_out_ID, sum0_out_EX, sum0_out_MEM, sum0_out_WB, A, B, Y,
                sum1_out, RegWriteData, RegData1_ID, RegData2_ID, Imm_out_ID, Imm_out_EX, RegData1_EX, RegData2_EX,
                mult5_out, mult3_out, data_adr_WB, data_RD_WB;

    wire [4:0] RdD;

    // IF
    Register PC (clk, reset, ~StallF, PC_in, PC_out_IF);
    assign inst_adr = PC_out_IF;
    Sum sum0 (PC_out_IF, 32'd4, sum0_out_IF);
    Multiplexer2to1 mult0 (sum0_out_IF, sum1_out, PCSrc, PC_in);

    // IF_ID
    IF_ID stage_IF_ID (clk, FlushD, ~StallD, inst_RD, PC_out_IF, sum0_out_IF,
                                             inst, PC_out_ID, sum0_out_ID);

    // ID
    RF stage_RF (clk, inst[19:15], inst[24:20], RdW, RegWriteData, RegWrite, RegData1_ID, RegData2_ID);
    Imm_Ext stage_Imm (inst[31:7], ImmSrc, Imm_out_ID);
    
    assign RdD = inst[11:7];
    assign Rs1D = inst[19:15];
    assign Rs2D = inst[24:20]; 

    // ID_EX
    ID_EX stage_ID_EX (clk, FlushE, RdD, Rs1D, Rs2D, RegData1_ID, RegData2_ID, PC_out_ID, Imm_out_ID, sum0_out_ID,
                                   RdE, Rs1E, Rs2E, RegData1_EX, RegData2_EX, PC_out_EX, Imm_out_EX, sum0_out_EX);

    // EX
    ALU stage_ALU (A, B, ALUFunc, Y, zero);
    Sum sum1 (mult5_out, Imm_out_EX, sum1_out);

    Multiplexer3to1 mult2 (RegData1_EX, data_adr, RegWriteData, ForwardAE, A);
    Multiplexer3to1 mult3 (RegData2_EX, data_adr, RegWriteData, ForwardBE, mult3_out);
    Multiplexer2to1 mult4 (mult3_out, Imm_out_EX, ALUSrc, B);
    Multiplexer2to1 mult5 (PC_out_EX, RegData1_EX, AdderSrc, mult5_out);

    // EX_MEM
    EX_MEM stage_EX_MEM (clk, RdE, Y, mult3_out, sum0_out_EX,
                              RdM, data_adr, data_WD, sum0_out_MEM);

    // MEM_WB
    MEM_WB stage_MEM_WB (clk, RdM, data_adr, data_RD, sum0_out_MEM,
                              RdW, data_adr_WB, data_RD_WB, sum0_out_WB);
    
    // WB
    Multiplexer3to1 mult6 (data_adr_WB, data_RD_WB, sum0_out_WB, ResultSrc, RegWriteData);

endmodule