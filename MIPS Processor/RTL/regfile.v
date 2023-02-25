// file: aluControl.v
// author: @juan
`timescale 1ns/1ns

module regfile(
    input [31:0] dataWrite,
    input [4:0] addrReadReg1,
    input [4:0] addrReadReg2,
    input [4:0] addrWriteReg,
    input [0:0] regWrite,
    input [0:0] clk,
    input [0:0] rst,
    output reg [31:0] data1,
    output reg [31:0] data2
    );
    
reg [31:0] registros[31:0];

always @(posedge clk)
    begin
    if (rst)
        begin
        registros[0]  <= 32'd0;
        registros[1]  <= 32'd11;
        registros[2]  <= 32'd22;
        registros[3]  <= 32'd33;
        registros[4]  <= 32'd44;
        registros[5]  <= 32'd55;
        registros[6]  <= 32'd66;
        registros[7]  <= 32'd77;
        registros[8]  <= 32'd88;
        registros[9]  <= 32'd99;
        registros[10] <= 32'd111;
        registros[11] <= 32'd122;
        registros[12] <= 32'd133;
        registros[13] <= 32'd144;
        registros[14] <= 32'd155;
        registros[15] <= 32'd166;
        registros[16] <= 32'd10;
        registros[17] <= 32'd20;
        registros[18] <= 32'd199;
        registros[19] <= 32'd211;
        registros[20] <= 32'd222;
        registros[21] <= 32'd233;
        registros[22] <= 32'd244;
        registros[24] <= 32'd255;
        registros[25] <= 32'd266;
        registros[26] <= 32'd277;
        registros[27] <= 32'd288;
        registros[28] <= 32'd299;
        registros[29] <= 32'd311;
        registros[30] <= 32'd322;
        registros[31] <= 32'd333;
        end
    if (regWrite) 
        registros[addrWriteReg] <= dataWrite;
    end
    
always @(*)
    begin
    if (rst)
        begin
        data1 = 0;
        data2 = 0;
        end
    else
        begin
        data1 = (addrReadReg1 != 0) ? registros[addrReadReg1] : 0;
        data2 = (addrReadReg2 != 0) ? registros[addrReadReg2] : 0;
        end
    end
// Si el address es cero, mando el registro 0, el cual es constante = 0.
// Si el adrres no es cero, mando el valor que contiene tal address en regfile.

endmodule











