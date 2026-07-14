module CU
(
    input [6:0] operation_code,
    output reg RegWrite, AdderSrc, ALUSrc, MemWrite, PCWriteCond, PC_write,
    output reg [1:0] ResultSrc, ImmSrc, ALU_operation
);

    always @(*)
    begin
        RegWrite = 0; AdderSrc = 0; ALUSrc = 0; MemWrite = 0; PCWriteCond = 0; PC_write = 0;
        ResultSrc = 2'b00; ImmSrc = 2'b00; ALU_operation = 2'b00;

        case(operation_code)
            7'b0110011:
            begin
                RegWrite = 1;
                ALU_operation = 2'b10;
            end

            7'b0000011:
            begin
                ALUSrc = 1; RegWrite = 1;
                ResultSrc = 2'b01; 
            end

            7'b0010011:
            begin
                ALUSrc = 1; RegWrite = 1;
                ALU_operation = 2'b11; 
            end

            7'b1100111:
            begin
                AdderSrc = 1; RegWrite = 1; PC_write = 1;
                ResultSrc = 2'b10;
            end

            7'b0100011:
            begin
                MemWrite = 1; ALUSrc = 1;
                ImmSrc = 2'b01;
            end


            7'b1101111:
            begin
                RegWrite = 1; PC_write = 1;  
                ImmSrc = 2'b11;
                ResultSrc = 2'b10; 
            end

            7'b1100011:
            begin
                PCWriteCond = 1;
                ImmSrc = 2'b10; ALU_operation = 2'b01;
            end
            
        endcase
    end
endmodule
