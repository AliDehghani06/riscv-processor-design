module inst_mem
(
    input [31:0] Adr,
    output [31:0] RD
);

    reg [7:0] mem [0:1023];
    assign RD = {mem[Adr + 3], mem[Adr + 2], mem[Adr + 1], mem[Adr]}; 

    initial
    begin
        $readmemb("PC.mem", mem);
    end
    
endmodule   