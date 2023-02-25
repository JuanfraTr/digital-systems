// file: nclk.v
// author: @juan

`timescale 1ns/1ns
module clkmuestreo(
    input reset,
    input [0:0] clk_medio,
    output reg [0:0] clk_lento
	);
	
/* Reloj de muestreo, es de 48kHz.
Llega uno de T_cont = 2.604us.*/

reg [1:0] contador;

initial
begin
clk_lento = 0;
contador = 0;
end

parameter tope = 3'b11;

always @(posedge clk_medio)
    begin
        if (reset)
            begin
            contador = 0;
            clk_lento = 1;
            end
		else if(contador >= tope)
			begin
			contador <= 0;
			clk_lento <= ~clk_lento;
			end
		else
			contador <= contador + 1;
    end
endmodule


