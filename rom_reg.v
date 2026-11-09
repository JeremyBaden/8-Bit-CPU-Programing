module rom_reg(
    input [7:0] addr,
    output reg [7:0] data
);

always @(*) begin
    case(addr)
        8'd0: data = 8'b0001_0001; // LOADI R0, 1
        8'd1: data = 8'b0001_0110; // LOADI R1, 2
        8'd2: data = 8'b0010_0001; // ADD R0, R1
        8'd3: data = 8'b0100_0000; // OUT R0
        8'd4: data = 8'b1111_0000; // HALT
        default: data = 8'b0000_0000;
    endcase
end

endmodule