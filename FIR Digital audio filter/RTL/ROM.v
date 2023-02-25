// file: ROM.v
// author: @juan

`timescale 1ns/1ns
module ROM(
    input [2:0] contador_arriba,
    output reg [20:0] coeficiente
	);
	
parameter h_0 = 21'b1011_0000_0000_0000_0000;
parameter h_1 = 21'b1001_1000_0000_0000_0000;
parameter h_2 = 21'b01001_0000_0000_0000_0000;
parameter h_3 = 21'b1101_0010_0000_0000_0000;
parameter h_4 = 21'b1100_0000_0000_0000_0000;
parameter h_5 = 21'b1000_0110_0000_0000_0000;
parameter h_6 = 21'b1010_0100_0000_0000_0000;
parameter h_7 = 21'b1000_1111_0000_0000_0000;

always @(contador_arriba)
    case(contador_arriba)
		0: coeficiente = h_0;
		1: coeficiente = h_1;
		2: coeficiente = h_2;
		3: coeficiente = h_3;
		4: coeficiente = h_4;
		5: coeficiente = h_5;
		6: coeficiente = h_6;
		7: coeficiente = h_7;
	endcase
endmodule
/* Recibe el numero del coeficiente a entregar
gracias al bloque up_counter.*/

