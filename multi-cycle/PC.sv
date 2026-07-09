module PC
(
    input clk, reset, enable,
    input [31:0] PC_in,
    output reg [31:0] PC_out
);

    always @(posedge clk)
    begin
        if (reset)
            PC_out <= 32'd300;
            
        else if (enable)
            PC_out <= PC_in;
    end
endmodule