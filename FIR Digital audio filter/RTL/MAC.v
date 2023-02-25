// file: ADDER.v
// author: @juan

`timescale 1ns/1ns
module MAC(
    input clk,
    input reset,
    input [20:0] entrada_1,
	input [20:0] entrada_2,
    output reg [24:0] acumulador
	);

wire [41:0] n1;
wire [20:0] resultado;
reg [3:0] contador;

/* En cada flanco de subida del CLK, Multiplica ambas entradas
y las va sumando*/

assign n1 = entrada_1 * entrada_2;
assign resultado = n1[41:21];

always @(posedge clk)
    begin
    if (reset)
        begin
            acumulador <= 0;
            contador <= 0;
        end
    else if (contador == 8)
        begin
            contador <= 1;
            acumulador <= resultado;
        end
    else if (contador == 7)
        begin
            contador <= contador + 1;
            acumulador <= acumulador + resultado;
        end
    else
        begin
        contador <= contador + 1;
        acumulador <= acumulador + resultado;
        end
    end
endmodule
/* Al multiplicar dos numeros binarios, quedaran
el doble de bits como parte real, y el doble
de bits como parte decimal.*/
/*10 de unidad y resto de fraccion*/

