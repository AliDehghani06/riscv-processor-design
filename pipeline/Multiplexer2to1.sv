module Multiplexer2to1
(
    input [31:0] A,
    input [31:0] B,
    input control,
    output reg [31:0] out
);
    always @(*) 
    begin
        if(!control)
            out = A;
        else
            out = B;
    end
endmodule