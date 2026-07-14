module ID_EX
(
    input clk, reset,
    input [4:0] in0, in1, in2,
    input [31:0] in3, in4, in5, in6, in7,
    output [4:0] out0, out1, out2,
    output [31:0] out3, out4, out5, out6, out7
);

    Register5bit stage0 (clk, reset, 1'b1, in0, out0);
    Register5bit stage1 (clk, reset, 1'b1, in1, out1);
    Register5bit stage2 (clk, reset, 1'b1, in2, out2);
    Register stage3 (clk, reset, 1'b1, in3, out3);
    Register stage4 (clk, reset, 1'b1, in4, out4);
    Register stage5 (clk, reset, 1'b1, in5, out5);
    Register stage6 (clk, reset, 1'b1, in6, out6);
    Register stage7 (clk, reset, 1'b1, in7, out7);

endmodule