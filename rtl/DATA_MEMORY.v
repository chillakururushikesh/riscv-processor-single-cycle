module datamemory(input clk,input memread,input memwrite,input[31:0] address,input[31:0] writedata,output [31:0] readdata);
  reg [31:0] mem [0:255];
  assign readdata=memread ? mem[address[31:2]]:32'd0;
  always@(posedge clk)begin
  if(memwrite)begin
    mem[address[31:2]]=writedata;end
  end
endmodule
