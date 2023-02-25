// file: mux2to1.v
// author: @juan

`timescale 1ns/1ns
module mux2to1
    #(parameter N=32)
    (input [N-1:0] din0,
    input [N-1:0] din1,
    input sel,
    output [N-1:0] dout);
    
assign dout = sel ? din1 : din0;

endmodule

