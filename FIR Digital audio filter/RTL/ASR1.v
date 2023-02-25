// file: ASR1.v
// author: @juan

`timescale 1ns/1ns
module ASR1(
    input clk_muestreo,
    input reset,
    input [19:0] DIN,
	input [2:0] Add,
	output reg [19:0] OUT,
    output reg [19:0] D
	);

reg [19:0] n1_2;
reg [19:0] n2_3;
reg [19:0] n3_4;
reg [19:0] n4_5;
reg [19:0] n5_6;
reg [19:0] n6_7;
reg [19:0] n7_8;

always @(posedge clk_muestreo)
    begin
		n1_2 <= DIN;
		n2_3 <= n1_2;
		n3_4 <= n2_3;
		n4_5 <= n3_4;
		n5_6 <= n4_5;
		n6_7 <= n5_6;
		n7_8 <= n6_7;
		OUT  <= n7_8;
    end

always @(*)
    begin
    if (reset)
        begin
            n1_2 = 0;
            n2_3 = 0;
            n3_4 = 0;
            n4_5 = 0;
            n5_6 = 0;
            n6_7 = 0;
            n7_8 = 0;
            OUT = 0;
        end

    case (Add)
    	0: D = n1_2;
    	1: D = n2_3;
    	2: D = n3_4;
    	3: D = n4_5;
    	4: D = n5_6;
    	5: D = n6_7;
    	6: D = n7_8;
    	7: D = OUT;
	endcase
    end
endmodule
/* Segun varia clk_muestreo, las muestras iran pasando
hacia los registros. Como salida tenemos el ultimo registro,
y el registro que se quiera dependiendo del contador Add.*/


