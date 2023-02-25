// file: mux2to1.v
// author: @juan

`timescale 1ns/1ns
module register
    #(parameter N=32)
    (input clk,
    input rst,
    input en,
    input [N-1:0] din,
    output reg [N-1:0] dout);
    
always @(posedge clk)
    if (rst)
        dout <= 0;
    else
        begin
        if (en)
            dout <= din;
        end
endmodule

