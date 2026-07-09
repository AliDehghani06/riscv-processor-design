module RegisterWithEnable
(
    input clk, enable,
    input [31:0] reg_in,
    output reg [31:0] reg_out
);

    always @(posedge clk)
    begin
        if (enable)
            reg_out <= reg_in;
    end
endmodule