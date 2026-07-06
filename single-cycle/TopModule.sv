module TopModule
(
    input clk
);
    wire [31:0] inst, MemData, PC_out, ALU_out, RegData2;
    wire MemWrite; 

    RISCV stage0(clk, inst, MemData, PC_out, ALU_out, RegData2, MemWrite);
    inst_mem stage1 (PC_out, inst);
    Data_Mem stage2 (clk, ALU_out, RegData2, MemWrite, MemData);

endmodule