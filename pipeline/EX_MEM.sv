module EX_MEM
(
    input clk,
    input [4:0] in0,
    input [31:0] in1, in2, in3,
    output [4:0] out0,
    output [31:0] out1, out2, out3
);

    Register5bit stage0 (clk, 1'b0, 1'b1, in0, out0);
    Register stage1 (clk, 1'b0, 1'b1, in1, out1);
    Register stage2 (clk, 1'b0, 1'b1, in2, out2);
    Register stage3 (clk, 1'b0, 1'b1, in3, out3);

endmodule