module Register5bit
(
    input clk, reset, enable,
    input [4:0] reg_in,
    output reg [4:0] reg_out
);

    always @(posedge clk)
    begin
        if (reset)
            reg_out <= 5'd0;
            
        else if (enable)
            reg_out <= reg_in;
    end
endmodule