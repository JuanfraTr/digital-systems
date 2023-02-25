// file: mux2to1.v
// author: @juan

`timescale 1ns/1ns
module signExtend
    #(parameter Nin=16, parameter Nout=32)
    (input [Nin-1:0] din,
    output [Nout-1:0] dout);
    
assign dout = { {Nout-Nin{din[Nin-1]}}, din};

endmodule