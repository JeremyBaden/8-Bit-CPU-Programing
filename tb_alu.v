`timescale 1ns/1ps

module tb;

reg [7:0] a;
reg [7:0] b;
reg [2:0] op;

wire [7:0] out;

alu dut(
    .a(a),
    .b(b),
    .op(op),
    .out(out)
);

initial begin
    $monitor("time=%0t a=%d b=%d op=%b out=%d", $time, a, b, op, out);
    a = 8'd5;
    b = 8'd3;

    op = 3'b000; #10; // add
    op = 3'b001; #10; // subtract
    op = 3'b010; #10; // and
    op = 3'b011; #10; // or

    
   

    $finish;
end

endmodule
