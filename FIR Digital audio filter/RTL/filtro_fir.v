// file: filtro_fir.v
// author: @juan

`timescale 1ns/1ns
module filtro_fir(
    input [0:0] nuevo_clk,
    input [0:0] resets,
    input [19:0] muestras_audio,
    output [19:0]salida_filtro
	);

wire clk_lento;
wire [2:0] contador_up;
wire [2:0] contador_down;
wire [20:0] coef;
wire [19:0] conexion12;
wire [19:0] salida_A1;
wire [19:0] salida_A2;
wire [20:0] resultado_suma;
wire [24:0] outmac;
wire [0:0] pass;


                    
clkmuestreo clklento(   .reset(resets),
                        .clk_medio(nuevo_clk), 
                        .clk_lento(clk_lento));
up_counter up(  .clk(nuevo_clk),
                .reset(resets),
                .contador_up(contador_up) );
down_counter down(  .clk(nuevo_clk),
                    .reset(resets),
                    .contador_down(contador_down) );
                    
ROM coeficientes(   .contador_arriba(contador_up), 
                    .coeficiente(coef) );

ASR1    muestreo_arriba(.clk_muestreo(clk_lento),
                        .reset(resets),
                        .DIN(muestras_audio),
                        .Add(contador_up),
                        .OUT(conexion12),
                        .D(salida_A1) );
ASR2    muestreo_abajo( .clk_muestreo(clk_lento),
                        .reset(resets),
                        .DIN(conexion12),
                        .Add(contador_down),
                        .D(salida_A2) );
ADDER   sumador(    .entrada_1(salida_A1),
                    .entrada_2(salida_A2),
                    .resultado(resultado_suma) );
                    
MAC     multiplicador(  .clk(nuevo_clk),
                        .reset(resets),
                        .entrada_1(resultado_suma),
                        .entrada_2(coef),
                        .acumulador(outmac) );

final   ultimasalida(   .clk(nuevo_clk),
                        .reset(resets),
                        .q(outmac),
                        .salida(salida_filtro) );

endmodule



