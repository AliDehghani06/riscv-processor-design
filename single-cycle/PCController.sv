module PCController(
    input [2:0] func3,
    input branch, jump, zero,
    output reg PCSrc
);

always @(*)
    begin
        PCSrc = 1'b0;
        if (branch == 1'b1)
        begin
            case(func3)
                3'b000:
                    PCSrc = zero;
                3'b001:
                    PCSrc = ~zero;
                3'b100:
                    PCSrc = ~zero;
                3'b101:
                    PCSrc = zero;
            endcase
        end
        PCSrc = PCSrc | jump;
    end
    
endmodule