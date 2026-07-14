module Register2bit
(
    input clk, reset, enable,
    input [1:0] reg_in,
    output reg [1:0] reg_out
);

    always @(posedge clk)
    begin
        if (reset)
            reg_out <= 2'd0;
            
        else if (enable)
            reg_out <= reg_in;
    end
endmodule