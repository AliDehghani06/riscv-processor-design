module Data_Mem 
(
    input clk,
    input [31:0] Adr,
    input [31:0] write_data,
    input we,
    output [31:0] read_data
);

    reg [7:0] mem [0:1023];

    always @(posedge clk)
    begin
        if(we)
            {mem[Adr + 3], mem[Adr + 2], mem[Adr + 1], mem[Adr]} <= write_data;
    end

    assign read_data = {mem[Adr + 3], mem[Adr + 2], mem[Adr + 1], mem[Adr]};

    initial
    begin
        $readmemb("memory.mem", mem);
    end

    integer file;
    integer i;

    final begin
        file = $fopen("memory.mem", "w");

        for(i = 0; i < 1024; i = i + 1)
        begin
            $fwrite(file, "%08b\n", mem[i]);
        end

        $fclose(file);
    end
    
endmodule