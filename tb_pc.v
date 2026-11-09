`timescale 1ns/1ps

module tb;

reg clk;
reg reset;
reg load;
reg [7:0] next;
wire [7:0] count;

pc dut(clk, reset, load, next, count);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    $monitor("time=%0t reset=%b load=%b next=%d count=%d",
             $time, reset, load, next, count);

    reset = 1;
    load = 0;
    next = 8'd0;

    #10 reset = 0;

    #30;
    next = 8'd20;
    load = 1;

    #10 load = 0;

    #30;
    $finish;
end

endmodule
