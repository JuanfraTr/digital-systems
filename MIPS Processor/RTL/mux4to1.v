// file: mux2to1.v
// author: @juan

`timescale 1ns/1ns
module mux4to1
    #(parameter N=32)
    (input [N-1:0] din0,
    input [N-1:0] din1,
    input [N-1:0] din2,
    input [N-1:0] din3,
    input [1:0] sel,
    output [N-1:0] dout);

assign dout = sel[1] ? (sel[0] ? din3 : din2) 
                     : (sel[0] ? din1 : din0);

endmodule

