`timescale 1ns/1ns
module mips
    (input [0:0] rst,
    input [0:0] clk,
    output [0:0] overflow,
    output [31:0] mipsOut
    );
    
wire [1:0] PCSource;
wire [1:0] ALUSrcB;
wire [0:0] ALUSrcA;
wire [0:0] RegWrite;
wire [0:0] RegDst;
wire [0:0] PCWriteCond;
wire [0:0] PCWrite;
wire [0:0] IorD;
wire [0:0] MemRead;
wire [0:0] MemWrite;
wire [0:0] MemToReg;
wire [0:0] IRWrite;
wire [2:0] ALUControl;
wire [31:0] instruction;

wire [1:0] ALUOp;

control_mips control_mips(   .op(instruction[31:26]), 
                            .rst(rst), 
                            .clk(clk), 
                            .PCWriteCond(PCWriteCond), 
                            .PCWrite(PCWrite), 
                            .IorD(IorD), 
                            .MemRead(MemRead), 
                            .MemWrite(MemWrite), 
                            .MemtoReg(MemToReg), 
                            .IRWrite(IRWrite), 
                            .ALUSrcA(ALUSrcA), 
                            .RegWrite(RegWrite), 
                            .RegDst(RegDst), 
                            .PCSource(PCSource), 
                            .ALUSrcB(ALUSrcB), 
                            .ALUOp(ALUOp));
                            
aluControl aluControl(  .aluOp(ALUOp), 
                        .inst(instruction[5:0]), 
                        .aluControl(ALUControl));

datapath datapath(  .PCSource(PCSource), 
                    .ALUSrcB(ALUSrcB), 
                    .ALUSrcA(ALUSrcA), 
                    .RegWrite(RegWrite), 
                    .RegDst(RegDst), 
                    .PCWriteCond(PCWriteCond), 
                    .PCWrite(PCWrite), 
                    .IorD(IorD), 
                    .MemRead(MemRead), 
                    .MemWrite(MemWrite), 
                    .MemToReg(MemToReg), 
                    .IRWrite(IRWrite), 
                    .clk(clk), 
                    .rst(rst), 
                    .ALUControl(ALUControl), 
                    .instruction(instruction), 
                    .ALUOut(mipsOut), 
                    .overflow(overflow));
                    

endmodule

