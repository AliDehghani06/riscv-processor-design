module TopModule
(
    input clk, reset
);

    wire MemWrite;
    wire [31:0] inst_RD, data_RD, inst_adr, data_adr, data_WD;


    RISCV stage_CPU (clk, reset, inst_RD, data_RD, MemWrite, inst_adr, data_adr, data_WD);

    Data_Mem stage_data (clk, data_adr, data_WD, MemWrite, data_RD);

    inst_mem stage_inst (inst_adr, inst_RD);

endmodule