// file: mux2to1.v
// author: @juan

`timescale 1ns/1ns
module nextPCLogic
    (input zero,
    input branch,
    input pcwrite,
    output pcen);
    
wire t;

assign t = branch & zero;
assign pcen = t | pcwrite;

endmodule

