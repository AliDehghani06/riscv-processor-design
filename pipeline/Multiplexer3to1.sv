module Multiplexer3to1
(
    input [31:0] A,
    input [31:0] B,
    input [31:0] C,
    input [1:0] control,
    output reg [31:0] out
);
    always @(*) 
    begin
        if(control == 2'b00)
            out = A;
        else if(control == 2'b01)
            out = B;
        else if(control == 2'b10)
            out = C;
        else
            out = 32'd0;
    end
endmodule