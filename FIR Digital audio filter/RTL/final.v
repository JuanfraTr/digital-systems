// file: ADDER.v
// author: @juan

`timescale 1ns/1ns
module final(
    input clk,
    input reset,
    input [24:0] q,
    output reg [19:0] salida
	);

reg [3:0] contador;

always @(posedge clk)
    begin
    if (reset)
        begin
            contador <= 0;
        end
    else if (contador == 8)
        begin
            contador <= 1;
            salida <= q[24:5];
        end
    else if (contador == 7)
        begin
            contador <= contador + 1;
        end
    else
        begin
        contador <= contador + 1;
        end
    end
endmodule



