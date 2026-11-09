`timescale 1ns/1ps

module tb;

reg clk;
reg load;
reg [7:0] d;

wire [7:0] q;

reg8 dut(
    .clk(clk),
    .load(load),
    .d(d),
    .q(q)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    $monitor("time=%0t load=%b d=%d q=%d", $time, load, d, q);

    load = 0;
    d = 8'd0;

    #10;
    d = 8'd42;
    load = 1;

    #10;
    load = 0;

    #10;
    d = 8'd100;

    #10;
    load = 1;

    #10;
    load = 0;

    #20;
    $finish;
end

endmodule