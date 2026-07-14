module RF 
(
    input clk,
    input [4:0] Adr1, Adr2, write_address,
    input [31:0] write_data,
    input we,
    output [31:0] read_data1,
    output [31:0] read_data2
);

    reg [31:0] mem [0:31];

    always @(negedge clk)
    begin
        if (we && write_address != 5'd0)
            mem[write_address] <= write_data;
    end


    assign read_data1 = (Adr1 == 5'd0) ? 32'd0 : mem[Adr1];
    assign read_data2 = (Adr2 == 5'd0) ? 32'd0 : mem[Adr2];

endmodule