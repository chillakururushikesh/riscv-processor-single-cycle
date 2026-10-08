module instructionmemory(pc,instruction);
  input [31:0] pc;
  output [31:0] instruction;
  reg [31:0]mem[0:256];
  initial begin
        $readmemh("program.mem", mem);
    end
  assign instruction=mem[pc[31:2]];
endmodule
