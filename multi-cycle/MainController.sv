module MainController
(
    input clk, reset,
    input [6:0] operation_code,
    output reg PCWrite, AdrSrc, RegWrite, OldPCWrite, IRWrite, PCWriteCond, MemWrite,
    output reg [1:0] ImmSrc, ALU_operation, ALUSrcA, ALUSrcB, ResultSrc
);

    parameter IF = 5'b00000, ID = 5'b00001, BT = 5'b00010, RT1 = 5'b00011, RT2 = 5'b00100, SW1 = 5'b00101, SW2 = 5'b00110, LW1 = 5'b00111;
    parameter LW2 = 5'b01000, LW3 = 5'b01001, IT1 = 5'b01010, IT2 = 5'b01011, JT1 = 5'b01100, JT2 = 5'b01101, JAL = 5'b01110, JALR = 5'b01111;
    parameter JT3 = 5'b10000;
    
    reg [4:0] stage, next_stage;

    always @(posedge clk) begin
        if (reset)
            stage <= IF;
        else
            stage <= next_stage;
    end

    always @(*)
    begin
        PCWrite = 0; AdrSrc = 0; RegWrite = 0; OldPCWrite = 0; IRWrite = 0; PCWriteCond = 0; MemWrite = 0;
        ALUSrcA = 2'b00; ALUSrcB = 2'b00; ImmSrc = 2'b00; ALU_operation = 2'b00; ResultSrc = 2'b00;
        next_stage = IF;

        case (stage)
            IF:
            begin
                PCWrite = 1; AdrSrc = 0; IRWrite = 1; OldPCWrite = 1;
                ALUSrcA = 2'b00; ALUSrcB = 2'b10; ALU_operation = 2'b00; ResultSrc = 2'b01;
                next_stage = ID;
            end
            ID:
            begin
                ALUSrcA = 2'b01; ALUSrcB = 2'b01; ALU_operation = 2'b00; ImmSrc = 2'b10;
                case(operation_code)
                7'b0110011: next_stage = RT1;
                7'b0000011: next_stage = LW1;
                7'b0010011: next_stage = IT1;
                7'b1100111: next_stage = JT1;
                7'b0100011: next_stage = SW1;
                7'b1101111: next_stage = JT1;
                7'b1100011: next_stage = BT;
                endcase
            end
            BT:
            begin
                PCWriteCond = 1;
                ALUSrcA = 2'b10; ALUSrcB = 2'b00; ALU_operation = 2'b01; ResultSrc = 2'b00;
                next_stage = IF;
            end
            RT1:
            begin
                ALUSrcA = 2'b10; ALUSrcB = 2'b00; ALU_operation = 2'b10;
                next_stage = RT2;
            end
            RT2:
            begin
                RegWrite = 1;
                ResultSrc = 2'b00;
                next_stage = IF;
            end
            SW1:
            begin
                ALUSrcA = 2'b10; ALUSrcB = 2'b01; ALU_operation = 2'b00; ImmSrc = 2'b01;
                next_stage = SW2;
            end
            SW2:
            begin
                AdrSrc = 1; MemWrite = 1;
                ResultSrc = 2'b00;
                next_stage = IF;
            end
            LW1:
            begin
                ALUSrcA = 2'b10; ALUSrcB = 2'b00; ALU_operation = 2'b00; ImmSrc = 2'b00;
                next_stage = LW2;
            end
            LW2:
            begin
                AdrSrc = 1;
                ResultSrc = 2'b00;
                next_stage = LW3;
            end
            LW3:
            begin
                RegWrite = 1;
                ResultSrc = 2'b10;
                next_stage = IF;
            end
            IT1:
            begin
                ALUSrcA = 2'b10; ALUSrcB = 2'b01; ALU_operation = 2'b11; ImmSrc = 2'b00;
                next_stage = IT2;
            end
            IT2:
            begin
                RegWrite = 1;
                ResultSrc = 2'b00;
                next_stage = IF;
            end
            JT1:
            begin
                ALUSrcA = 2'b01; ALUSrcB = 2'b10; ALU_operation = 2'b00;
                next_stage = JT2;
            end
            JT2:
            begin
                RegWrite = 1;
                ResultSrc = 2'b00;
                case(operation_code)
                    7'b1100111: next_stage = JALR;
                    7'b1101111: next_stage = JAL;
                endcase
            end
            JAL:
            begin
                ALUSrcA = 2'b01; ALUSrcB = 2'b01; ALU_operation = 2'b00; ImmSrc = 2'b11;
                next_stage = JT3;
            end
            JALR:
            begin
                ALUSrcA = 2'b10; ALUSrcB = 2'b01; ALU_operation = 2'b00; ImmSrc = 2'b00;
                next_stage = JT3;
            end
            JT3:
            begin
                PCWrite = 1;
                ResultSrc = 2'b00;
                next_stage = IF;
            end
        endcase
    end


endmodule

