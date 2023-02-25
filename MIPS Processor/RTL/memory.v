// file: memory.v
// author: @juan
`timescale 1ns/1ns
module memory(
    input clk,
    input [0:0] memoryWrite,
    input [0:0] memoryRead,
    input [31:0] memoryWriteData,
    input [31:0] memoryAddress,
    input [0:0] rst,
    output reg [31:0] memoryOutData
    );
    
reg [31:0] RAM[31:0];

always @(posedge clk)
    begin
    if (rst)
        begin
        //RAM[0] = 32'b000000_10000_10001_10010_00000_100000; // add s18 = s16  + s17
        //RAM[0] = 32'b000000_10001_10000_10010_00000_100010; // sub s18 = s17  - s16
        //RAM[0] = 32'b000000_10001_10000_10010_00000_100100; // and s18 = s17 && s16
        //RAM[0] = 32'b000100_10001_10000_0000000000000011; // beq if(s17 == s16) imm=3
        //RAM[0] = 32'b000101_10001_10000_0000000000000011; // bnq if(s17 != s16) imm=3
        //RAM[0] = 32'b000010_00000_00000_0000000000001000; // jump addr
        //RAM[0] = 32'b101011_00000_10000_0000000000001000; // store word. sw s16 con address = 8.
        RAM[0] = 32'b100011_10001_10000_0000000000010000; // load word. lw s16 16(s17)
        RAM[9] = 32'd100;
        end
    else
        begin
        if (memoryWrite)
            begin
            RAM[memoryAddress[31:2]] <= memoryWriteData;
            end
        end
    end

always @(*)
    begin
    if (memoryRead)
        begin
        memoryOutData = RAM[memoryAddress[31:2]];
        end
    end
    
endmodule


