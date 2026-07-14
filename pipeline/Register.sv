module Register
(
    input clk, reset, enable,
    input [31:0] reg_in,
    output reg [31:0] reg_out
);

    always @(posedge clk)
    begin
        if (reset)
            reg_out <= 32'd0;
            
        else if (enable)
            reg_out <= reg_in;
    end
endmodule