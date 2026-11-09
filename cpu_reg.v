module cpu_reg(
    input clk,
    input reset,
    output reg [7:0] out,
    output reg halted
);

reg [7:0] pc;

wire [7:0] instruction;
wire [7:0] immediate;
rom16 program(
    .addr(pc),
    .data(instruction)
);

rom16 program2(
    .addr(pc + 1),
    .data(immediate)
);

wire [3:0] opcode = instruction[7:4];
wire [1:0] rd     = instruction[3:2];
wire [1:0] rs     = instruction[1:0];

reg rf_we;
reg [1:0] rf_waddr;
reg [1:0] rf_raddr_a;
reg [1:0] rf_raddr_b;
reg [7:0] rf_wdata;

wire [7:0] rA;
wire [7:0] rB;

regfile rf(
    .clk(clk),
    .we(rf_we),
    .waddr(rf_waddr),
    .raddr_a(rf_raddr_a),
    .raddr_b(rf_raddr_b),
    .wdata(rf_wdata),
    .rdata_a(rA),
    .rdata_b(rB)
);

always @(*) begin
    rf_we = 0;
    rf_waddr = rd;
    rf_raddr_a = rd;
    rf_raddr_b = rs;
    rf_wdata = 8'd0;

    case(opcode)
        4'b0001: begin // LOADI rd, imm
            rf_we = 1;
            rf_wdata = immediate; 
        end

        4'b0010: begin // ADD rd, rs
            rf_we = 1;
            rf_wdata = rA + rB;
        end

        4'b0011: begin // SUB rd, rs
            rf_we = 1;
            rf_wdata = rA - rB;
        end
    endcase
end

always @(posedge clk) begin
    if(reset) begin
        pc <= 0;
        out <= 0;
        halted <= 0;
    end else if(!halted) begin
        case(opcode)

            4'b0100: begin // OUT rd
                out <= rA;
                pc <= pc + 1;
            end

            4'b1111: begin // HALT
                halted <= 1;
            end

            4'b0001: begin // LOADI uses 2 bytes
                pc <= pc + 2;
            end

            default: begin
                pc <= pc + 1;
            end

        endcase
    end
end

endmodule