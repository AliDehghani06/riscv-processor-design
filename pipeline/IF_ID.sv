module IF_ID
(
    input clk, reset, enable,
    input [31:0] in0, in1, in2,
    output [31:0] out0, out1, out2
);

    Register stage0 (clk, reset, enable, in0, out0);
    Register stage1 (clk, reset, enable, in1, out1);
    Register stage2 (clk, reset, enable, in2, out2);

endmodule