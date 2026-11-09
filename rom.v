module rom(
    input [7:0] addr,
    output reg [7:0] data
);

always @(*) begin
    case(addr)

       8'd0: data = 8'b0001_0111; // LOAD 7

       8'd1: data = 8'b0111_0010; // STORE 2

       8'd2: data = 8'b0001_0000; // LOAD 0

       8'd3: data = 8'b1000_0010; // LOADM 2

       8'd4: data = 8'b0100_0000; // OUT

       8'd5: data = 8'b1111_0000; // HALT
    endcase
end

endmodule