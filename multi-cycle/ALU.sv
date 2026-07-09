module ALU(
    input [31:0] A, B,
    input [2:0] control,
    output reg [31:0] Y,
    output reg zero
);

    always @(*)
    begin
        case(control)
            3'b000: Y = A + B;
            3'b001: Y = A - B;
            3'b010: Y = A & B;
            3'b011: Y = A | B;
            3'b100:
            begin
                if($signed(A) < $signed(B))
                    Y = 32'd1;
                else
                    Y = 32'd0;
            end
            3'b101: Y = A ^ B;
            default: Y = 0;
        endcase
        zero = (Y == 32'd0);
    end
endmodule