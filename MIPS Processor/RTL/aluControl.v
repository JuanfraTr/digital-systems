// file: aluControl.v
// author: @juan
`timescale 1ns/1ns
module aluControl(
    input [5:0]inst, 
    input [1:0]aluOp,
    output reg [2:0] aluControl
    );
always@(*) 
    begin
    case(aluOp)
        2'b00: aluControl = 3'b010; // +
        2'b01: aluControl = 3'b110; // -
        2'b11: aluControl = 3'b100; // - Especifico para bnq
        default: casez(inst)
            6'b100100: aluControl = 3'b000;  // AND
            6'b100101: aluControl = 3'b001;  // OR
            6'bxxxxxx: aluControl = 3'b010;  // +
            6'bxxxxxx: aluControl = 3'b110;  // - 
            6'b100111: aluControl = 3'b011;  // NOR
            6'b100110: aluControl = 3'b111;  // XOR
            6'b100000: aluControl = 3'b010;  // +2
            6'b100010: aluControl = 3'b110;  // -2
        endcase
    endcase
    end
endmodule


