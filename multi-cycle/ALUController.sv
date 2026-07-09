module ALUController(
    input [2:0] func3,
    input [6:0] func7,
    input [1:0] ALU_operation,
    output reg [2:0] ALU_function
);

always @(*)
    begin
        ALU_function = 3'b000;

        case(ALU_operation)
            2'b10:
            begin
                if(func3 == 3'b000)
                begin
                    if(func7 == 7'b0000000)
                        ALU_function = 3'b000;
                    else if (func7 == 7'b0100000)
                        ALU_function = 3'b001;
                end

                else if (func3 == 3'b111)
                    ALU_function = 3'b010;

                else if (func3 == 3'b110)
                    ALU_function = 3'b011;

                else if (func3 == 3'b010)
                    ALU_function = 3'b100;


            end

            2'b00:
            begin
                ALU_function = 3'b000; 
            end


            2'b11:
            begin
                if (func3 == 3'b000)
                    ALU_function = 3'b000;

                else if (func3 == 3'b100)
                    ALU_function = 3'b101;

                else if (func3 == 3'b110)
                    ALU_function = 3'b011;

                else if (func3 == 3'b010)
                    ALU_function = 3'b100;
            end
            
            
            2'b01:
            begin
                if (func3 == 3'b000)
                    ALU_function = 3'b001;

                else if (func3 == 3'b001)
                    ALU_function = 3'b001;

                else if (func3 == 3'b100)
                    ALU_function = 3'b100;


                else if (func3 == 3'b101)
                    ALU_function = 3'b100;
            end

        endcase
    end
    
endmodule