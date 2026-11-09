`timescale 1ns/1ps

module tb;

reg clk;
reg reset;

wire halted;
wire [7:0] acc;
wire [7:0] out;

cpu dut(
    .clk(clk),
    .reset(reset),
    .halted(halted),
    .acc(acc),
    .out(out)
);

initial begin
    $dumpfile("cpu.vcd");
    $dumpvars(0, tb);
end

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin

    $monitor(
        "time=%0t ACC=%d OUT=%d HALT=%b",
        $time,
        acc,
        out,
        halted
    );

    reset = 1;

    #10;
    reset = 0;

    #200;

    $finish;

end



endmodule