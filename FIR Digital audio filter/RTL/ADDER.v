// file: ADDER.v
// author: @juan

`timescale 1ns/1ns
module ADDER(
    input [19:0] entrada_1,
	input [19:0] entrada_2,
    output reg [20:0] resultado
	);
	
always @(*)
    resultado = entrada_1 + entrada_2;
endmodule
/* Recibe el numero del coeficiente a entregar
gracias al bloque up_counter.*/


