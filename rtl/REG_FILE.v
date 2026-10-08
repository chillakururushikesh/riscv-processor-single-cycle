module regfile(clk,regwrite,rs1,rs2,rd,writedata,readdata1,readdata2);
  input clk;
  input regwrite;
  input [4:0]rs1,rs2,rd;
  reg [31:0] registers [0:31];
  output [31:0]readdata1,readdata2;
  input [31:0]writedata;
  assign readdata1=registers[rs1];
  assign readdata2=registers[rs2];
  always@(posedge clk)begin
    if(regwrite && rd!=0)begin
      registers[rd]<=writedata;end
  end
endmodule
