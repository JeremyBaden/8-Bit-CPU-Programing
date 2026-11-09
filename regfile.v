module regfile(
    input clk,
    input we,
    input [1:0] waddr,
    input [1:0] raddr_a,
    input [1:0] raddr_b,
    input [7:0] wdata,
    output [7:0] rdata_a,
    output [7:0] rdata_b
);

reg [7:0] regs [0:3];

assign rdata_a = regs[raddr_a];
assign rdata_b = regs[raddr_b];

always @(posedge clk) begin
    if (we)
        regs[waddr] <= wdata;
end

endmodule