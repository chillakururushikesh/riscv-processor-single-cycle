module branchtarget(
    input  [31:0] pc,
    input  [31:0] immediate,
    output [31:0] branchtarget
);

assign branchtarget = pc + immediate;
endmodule
