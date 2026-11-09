module cpu(
    input clk,
    input reset,
    output reg halted,
    output reg [7:0] acc,
    output reg [7:0] out
);

reg [7:0] pc;

wire [7:0] ram_out;

wire ram_we;
assign ram_we = (!halted && opcode == 4'b0111);

ram memory(
    .clk(clk),
    .we(ram_we),
    .addr(imm),
    .din(acc),
    .dout(ram_out)
);

wire [7:0] instruction;

rom program(
    .addr(pc),
    .data(instruction)
);

wire [3:0] opcode;
wire [3:0] imm;

assign opcode = instruction[7:4];
assign imm    = instruction[3:0];

always @(posedge clk) begin

    if(reset) begin
        pc <= 0;
        acc <= 0;
        out <= 0;
        halted <= 0;
    end

    else if(!halted) begin

        case(opcode)
        
            4'b0001: begin // LOAD
                acc <= imm;
                pc <= pc + 1;
            end

            4'b0010: begin // ADD
                
                acc <= acc + imm;
                pc <= pc + 1;
            end

            4'b1111: begin // HALT
                
                halted <= 1;
            end
            
            4'b0011: begin // SUB
                
                acc <= acc - imm;
                pc <= pc + 1;
            end

            4'b0100: begin // OUT
                
                out <= acc;
                pc <= pc + 1;
            end

            4'b0101: begin // JMP
                
                pc <= imm;
            end

            4'b0110: begin // JZ
                
                if(acc == 0)
                    pc <= imm;
                else
                    pc <= pc + 1;
            end

            4'b0111: begin // STORE
                // ram_we is set, so the write will happen in the RAM module
                pc <= pc + 1;
            end

            4'b1000: begin // LOADM
                acc <= ram_out;
                pc <= pc + 1;
            end

            default: begin // NOP
                
                pc <= pc + 1;
            end

        endcase

    end

end

endmodule