module rom16(
    input [7:0] addr,
    output reg [7:0] data
);

always @(*) begin
    case(addr)
        8'd0: data = 8'b0001_0000; // LOADI R0
        8'd1: data = 8'd42;

        8'd2: data = 8'b0001_0100; // LOADI R1
        8'd3: data = 8'd13;

        8'd4: data = 8'b0010_0001; // ADD R0,R1
        8'd5: data = 8'b0100_0000; // OUT R0
        8'd6: data = 8'b1111_0000; // HALT

        default: data = 8'd0;
    endcase
end

endmodule