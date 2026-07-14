module Register1bit
(
    input clk, reset, enable, reg_in,
    output reg reg_out
);

    always @(posedge clk)
    begin
        if (reset)
            reg_out <= 1'b0;

        else if (enable)
            reg_out <= reg_in;
    end
endmodule