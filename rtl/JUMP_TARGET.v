module jump_target(
    input  [31:0] pc,
  input  [31:0] immediate,
    output [31:0] jump_target
);

assign jump_target = pc + immediate;

endmodule
