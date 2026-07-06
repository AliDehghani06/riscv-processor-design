module PC
(
    input clk,
    input [31:0] PC_in,
    output reg [31:0] PC_out
);

    always @(posedge clk) 
    begin
        PC_out <= PC_in;
    end

    initial
    begin
        PC_out = 32'b0;
    end
endmodule
