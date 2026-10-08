module writeback_mux(

    input  [31:0] aluresult,
    input  [31:0] memorydata,
    input         memtoreg,

    output [31:0] writedata

);

assign writedata = memtoreg ? memorydata : aluresult;

endmodule
