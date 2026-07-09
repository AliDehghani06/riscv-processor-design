module TopModule
(
    input clk, reset
);
    wire [31:0] MemData, MemAddress, MemWriteData;
    wire MemWrite; 
    
    RISCV stage0 (clk, reset, MemData, MemAddress, MemWriteData, MemWrite);
    Memory stage1 (clk, MemAddress, MemWriteData, MemWrite, MemData);

endmodule