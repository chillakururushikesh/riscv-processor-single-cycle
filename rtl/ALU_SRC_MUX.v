module alu_src_mux(

    input  [31:0] read_data2,
    input  [31:0] immediate,
    input         alusrc,

    output [31:0] alu_operand_b

);

assign alu_operand_b = alusrc ? immediate : read_data2;

endmodule
