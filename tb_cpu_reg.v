`timescale 1ns/1ps

module tb;

reg clk;
reg reset;

wire [7:0] out;
wire halted;

cpu_reg dut(
    .clk(clk),
    .reset(reset),
    .out(out),
    .halted(halted)
);

initial begin
    $dumpfile("cpu_reg.vcd");
    $dumpvars(0, tb);
end

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    $monitor("time=%0t OUT=%d HALT=%b", $time, out, halted);

    reset = 1;
    #10;
    reset = 0;

    #100;
    $finish;
end

endmodule