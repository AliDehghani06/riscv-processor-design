`timescale 1ns / 1ns

module tb_TopModule();

    reg clk;
    reg reset;

    TopModule uut
    (
        .clk(clk),
        .reset(reset)
    );

    initial begin
        clk = 0;
        reset = 0;
        #4 reset = 1;
        #1 clk = 1;
        
        #4 reset = 0;
        #1 clk = 0;


        repeat (1600)
        begin
            #5 clk = ~clk;
        end
    end

endmodule