// file: up_counter.v
`timescale 1ns/1ns

`timescale 1ns / 1ps
module down_counter(
    input clk,
    input reset,
    output reg [2:0] contador_down
	);
	
/* Si fck_muestreo = 48kHz,
entonces f_cont = N*fck_muestreo.
T_cont = 2.6us. */

always @(posedge clk)
    begin
		if (contador_down == 0 | reset)
			contador_down <= 7;
		else
			contador_down <= contador_down - 1;
    end

endmodule
/* Segun varia clk_muestreo, las muestras iran pasando
hacia los registros, siempre y cuando enabe = 1. 
Como salida tenemos el ultimo registro, y el registro 
que se quiera dependiendo del contador Add.*/


