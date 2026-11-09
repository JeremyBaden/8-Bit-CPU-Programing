module chip(
    input clk,
    input reset,
    output [7:0] out,
    output halted
);

wire [7:0] acc;

cpu processor(
    .clk(clk),
    .reset(reset),
    .out(out),
    .halted(halted),
    .acc(acc)
);

endmodule