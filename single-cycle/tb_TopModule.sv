`timescale 1ns / 1ns

module tb_TopModule();

    reg clk;

    TopModule uut
    (
        .clk(clk)
    );

    initial begin
        clk = 0;
        
        repeat (1000)
        begin
            #5 clk = ~clk;
        end
    end

endmodule
