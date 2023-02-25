// file: mux2to1.v
// author: @juan

`timescale 1ns/1ns
module shiftLeft2
    #(parameter N=32)
    (input [N-1:0] din,
    output [N-1:0] dout);
    
assign dout = (din << 2);
endmodule

