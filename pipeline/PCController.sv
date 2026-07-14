module PCController(
    input reset, 
    input [2:0] func3,
    input PCWriteCond, PC_write, zero,
    output reg PCSrc
);

always @(*)
    begin
        PCSrc = 1'b0;
        if(reset == 1'b1)
            PCSrc = 1'b0;
        if (PCWriteCond == 1'b1)
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
        if(PC_write == 1'b1)
            PCSrc = 1'b1;
    end

endmodule