module Register3bit
(
    input clk, reset, enable,
    input [2:0] reg_in,
    output reg [2:0] reg_out
);

    always @(posedge clk)
    begin
        if (reset)
            reg_out <= 3'd0;
            
        else if (enable)
            reg_out <= reg_in;
    end
endmodule