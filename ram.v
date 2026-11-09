module ram(
    input clk,
    input we,
    input [3:0] addr,
    input [7:0] din,
    output [7:0] dout
);

reg [7:0] mem [0:15];

assign dout = mem[addr];

always @(posedge clk) begin
    if (we)
        mem[addr] <= din;
end

endmodule