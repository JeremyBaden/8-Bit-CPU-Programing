module pc(
    input clk,
    input reset,
    input load,
    input [7:0] next,
    output reg [7:0] count
);

always @(posedge clk) begin
    if (reset)
        count <= 8'd0;
    else if (load)
        count <= next;
    else
        count <= count + 1;
end

endmodule