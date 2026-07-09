module PCController(
    input [2:0] func3,
    input PCWriteCond, PC_write, zero,
    output reg PCWrite
);

always @(*)
    begin
        PCWrite = 1'b0;
        if (PCWriteCond == 1'b1)
        begin
            case(func3)
                3'b000:
                    PCWrite = zero;
                3'b001:
                    PCWrite = ~zero;
                3'b100:
                    PCWrite = ~zero;
                3'b101:
                    PCWrite = zero;
            endcase
        end
        PCWrite = PCWrite | PC_write;
    end
    
endmodule