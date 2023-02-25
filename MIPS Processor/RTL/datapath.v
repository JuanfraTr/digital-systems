// file: datapath.v
// author: @juan
`timescale 1ns/1ns
module datapath(
    input [1:0] PCSource,
    input [1:0] ALUSrcB,
    input ALUSrcA,
    input RegWrite,
    input RegDst,
    input PCWriteCond,
    input PCWrite,
    input IorD,
    input MemRead,
    input MemWrite,
    input MemToReg,
    input IRWrite,
    input clk, 
    input rst, 
    input [2:0] ALUControl,
    output [31:0] instruction,
    output [31:0] ALUOut,
    output overflow
    );

wire [31:0] PC;
wire [31:0] ALUOut;
wire [31:0] Adr;
wire [31:0] B;
wire [31:0] RD;
wire [31:0] Instr;
wire [31:0] Data;
wire [31:0] WD3;
wire [4:0] A3;
wire [31:0] RD1;
wire [31:0] RD2;
wire [31:0] A;
wire [31:0] SrcA;
wire [31:0] SrcB;
wire [31:0] SignImm;
wire [31:0] x1;
wire [31:0] x2;
wire [31:0] ALUResult;
wire [0:0] Zero;
wire [0:0] PCEn;
wire [31:0] PC2;
wire [0:0] WE3 = RegWrite; 

mux2to1     mux1(   .din0(PC), 
                    .din1(ALUOut),
                    .sel(IorD),
                    .dout(Adr));

memory      InstMem(.clk(clk),
                    .memoryWrite(MemWrite),
                    .memoryRead(MemRead),
                    .memoryWriteData(B),
                    .memoryAddress(Adr),
                    .rst(rst),
                    .memoryOutData(RD));

register    regen1( .clk(clk),
                    .rst(rst),
                    .en(IRWrite),
                    .din(RD),
                    .dout(Instr));

register    reg11(  .clk(clk),
                    .rst(rst),
                    .en(1'b1),
                    .din(RD),
                    .dout(Data));

mux2to1     mux2(   .din0(ALUOut), 
                    .din1(Data),
                    .sel(MemToReg),
                    .dout(WD3));
                    
mux2to1 #(5)  mux3( .din0(Instr[20:16]), 
                    .din1(Instr[15:11]),
                    .sel(RegDst),
                    .dout(A3));

regfile     regist( .dataWrite(WD3),
                    .addrReadReg1(Instr[25:21]),
                    .addrReadReg2(Instr[20:16]),
                    .addrWriteReg(A3),
                    .regWrite(WE3),
                    .clk(clk),
                    .rst(rst),
                    .data1(RD1),
                    .data2(RD2));
                    
register    reg12(  .clk(clk),
                    .rst(rst),
                    .en(1'b1),
                    .din(RD1),
                    .dout(A));
                    
register    reg13(  .clk(clk),
                    .rst(rst),
                    .en(1'b1),
                    .din(RD2),
                    .dout(B));

mux2to1     mux4(   .din0(PC), 
                    .din1(A),
                    .sel(ALUSrcA),
                    .dout(SrcA));

mux4to1     mux5(   .din0(B),
                    .din1(32'b100),
                    .din2(SignImm),
                    .din3(x1),
                    .sel(ALUSrcB),
                    .dout(SrcB));
                    
alu         ALU(    .aluInA(SrcA),
                    .aluInB(SrcB),
                    .aluControl(ALUControl),
                    .aluResult(ALUResult),
                    .aluZero(Zero),
                    .aluOverflow(overflow));

nextPCLogic PCEna(  .zero(Zero),
                    .branch(PCWriteCond),
                    .pcwrite(PCWrite),
                    .pcen(PCEn));
                    
register    regen2( .clk(clk),
                    .rst(rst),
                    .en(PCEn),
                    .din(PC2),
                    .dout(PC));

signExtend  sgnext( .din(Instr[15:0]),
                    .dout(SignImm));

shiftLeft2  por41(  .din(SignImm),
                    .dout(x1));

register    reg14(  .clk(clk),
                    .rst(rst),
                    .en(1'b1),
                    .din(ALUResult),
                    .dout(ALUOut));
                    
mux4to1     mux6(   .din0(ALUResult),
                    .din1(ALUOut),
                    .din2({PC[31:28],x2[27:0]}),
                    .din3(ALUResult),
                    .sel(PCSource),
                    .dout(PC2));

shiftLeft2 por42(   .din({6'b0,Instr[25:0]}),
                    .dout(x2));

assign instruction = Instr;

endmodule

