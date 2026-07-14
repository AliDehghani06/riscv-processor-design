module Imm_Ext(
    input [24:0] in,
    input [1:0] control,
    output reg [31:0] out
);

    always @(*)
    begin
        case(control)
            2'b00: out = {{20{in[24]}}, in[24:13]};
            2'b01: out = {{20{in[24]}}, in[24:18], in[4:0]};
            2'b10: out = {{19{in[24]}}, in[24], in[0], in[23:18], in[4:1], 1'b0};
            2'b11: out = {{12{in[24]}}, in[12:5], in[13], in[23:14], 1'b0};
            default: out = 0;
        endcase
    end
    
endmodule