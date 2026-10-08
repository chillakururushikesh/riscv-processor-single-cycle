module main_control(

    input [6:0] opcode,

    output reg reg_write,
    output reg mem_read,
    output reg mem_write,
    output reg alu_src,
    output reg mem_to_reg,
    output reg branch,
    output reg jump,
    output reg [1:0] alu_op

);

always @(*) begin

    // Default values
    reg_write = 1'b0;
    mem_read  = 1'b0;
    mem_write = 1'b0;
    alu_src   = 1'b0;
    mem_to_reg = 1'b0;
    branch    = 1'b0;
    jump      = 1'b0;
    alu_op    = 2'b00;

    case (opcode)

        // R-Type
        7'b0110011: begin
            reg_write = 1'b1;
            alu_src   = 1'b0;
            mem_to_reg = 1'b0;
            alu_op    = 2'b10;
        end

        // I-Type ALU
        7'b0010011: begin
            reg_write = 1'b1;
            alu_src   = 1'b1;
            mem_to_reg = 1'b0;
            alu_op    = 2'b10;
        end

        // Load
        7'b0000011: begin
            reg_write = 1'b1;
            mem_read  = 1'b1;
            alu_src   = 1'b1;
            mem_to_reg = 1'b1;
            alu_op    = 2'b00;
        end

        // Store
        7'b0100011: begin
            mem_write = 1'b1;
            alu_src   = 1'b1;
            alu_op    = 2'b00;
        end

        // Branch
        7'b1100011: begin
            branch    = 1'b1;
            alu_src   = 1'b0;
            alu_op    = 2'b01;
        end

        // JAL
        7'b1101111: begin
            reg_write = 1'b1;
            jump      = 1'b1;
            alu_op    = 2'b00;
        end

        default: begin
            reg_write = 1'b0;
        end

    endcase

end

endmodule
