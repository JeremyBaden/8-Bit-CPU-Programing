`timescale 1ns/1ps

module tb;

reg clk;
reg we;
reg [1:0] waddr;
reg [1:0] raddr_a;
reg [1:0] raddr_b;
reg [7:0] wdata;

wire [7:0] rdata_a;
wire [7:0] rdata_b;

regfile dut(
    .clk(clk),
    .we(we),
    .waddr(waddr),
    .raddr_a(raddr_a),
    .raddr_b(raddr_b),
    .wdata(wdata),
    .rdata_a(rdata_a),
    .rdata_b(rdata_b)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    $monitor("time=%0t we=%b waddr=%d wdata=%d rA=%d rB=%d",
        $time, we, waddr, wdata, rdata_a, rdata_b);

    we = 0;
    waddr = 0;
    raddr_a = 0;
    raddr_b = 1;
    wdata = 0;

    #10;
    waddr = 0;
    wdata = 8'd5;
    we = 1;

    #10;
    waddr = 1;
    wdata = 8'd3;

    #10;
    we = 0;

    #10;
    raddr_a = 0;
    raddr_b = 1;

    #20;
    $finish;
end

endmodule