module MainController
(
    input [6:0] operation_code,
    output reg RegWrite, AdderSrc, ALUSrc, MemWrite, ResultSrc, RFWriteSrc, branch, jump,
    output reg [1:0] ImmSrc, ALU_operation
);

    always @(*)
    begin
        RegWrite = 0; AdderSrc = 0; ALUSrc = 0; MemWrite = 0; ResultSrc = 0; RFWriteSrc = 0; branch = 0; jump = 0;
        ImmSrc = 2'b00; ALU_operation = 2'b00;

        case(operation_code)
            7'b0110011:
            begin
                RegWrite = 1;
                ALU_operation = 2'b10;
            end

            7'b0000011:
            begin
                ResultSrc = 1; ALUSrc = 1; RegWrite = 1; 
            end

            7'b0010011:
            begin
                ALUSrc = 1; RegWrite = 1;
                ALU_operation = 2'b11; 
            end

            7'b1100111:
            begin
                RFWriteSrc = 1; AdderSrc = 1; RegWrite = 1; jump = 1;
            end

            7'b0100011:
            begin
                MemWrite = 1; ALUSrc = 1;
                ImmSrc = 2'b01;
            end


            7'b1101111:
            begin
                RFWriteSrc = 1; RegWrite = 1; jump = 1;  
                ImmSrc = 2'b11; 
            end

            7'b1100011:
            begin
                branch = 1;
                ImmSrc = 2'b10; ALU_operation = 2'b01;
            end
            
        endcase
    end
endmodule
