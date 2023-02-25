`timescale 1ns/1ns
module control_mips
    (input [5:0] op,
    input [0:0] rst,
    input [0:0] clk,
    output reg [0:0] PCWriteCond, //Branch
    output reg [0:0] PCWrite, 
    output reg [0:0] IorD, 
    output reg [0:0] MemRead, 
    output reg [0:0] MemWrite, 
    output reg [0:0] MemtoReg, 
    output reg [0:0] IRWrite,
    output reg [0:0] ALUSrcA, 
    output reg [0:0] RegWrite, 
    output reg [0:0] RegDst, 
    output reg [1:0] PCSource, 
    output reg [1:0] ALUSrcB, 
    output reg [1:0] ALUOp // Hacia ALUDecoder
    );

parameter S0 = 4'b0000;
parameter S1 = 4'b0001;
parameter S2 = 4'b0010;
parameter S3 = 4'b0011;
parameter S4 = 4'b0100;
parameter S5 = 4'b0101;
parameter S6 = 4'b0110;
parameter S7 = 4'b0111;
parameter S8 = 4'b1000;
parameter S9 = 4'b1001;
parameter S10 = 4'b1010;
parameter S11 = 4'b1011;
parameter S12 = 4'b1100;

reg [3:0] state, nextState;

always @(posedge clk, posedge rst)
    if(rst) state <= S0;
    else    state <= nextState;

always @(*)
    begin
    case (state)
    S0: begin
        PCWriteCond=1'b0;
        PCWrite = 1'b1;
    	IorD    = 1'b0;
    	MemRead = 1'b1;
    	MemWrite= 1'b0;
    	MemtoReg= 1'b0;
    	IRWrite = 1'b1;
    	ALUSrcA = 1'b0;
    	RegWrite= 1'b0;
    	RegDst  = 1'b0;
    	PCSource= 2'b00;
    	ALUSrcB = 2'b01;
    	ALUOp   = 2'b00;
    	nextState = S1;
        end
        
    S1: begin           // Decode
        PCWriteCond=1'b0;
        PCWrite = 1'b0;
    	IorD    = 1'b0;
    	MemRead = 1'b1;
    	MemWrite= 1'b0;
    	MemtoReg= 1'b0;
    	IRWrite = 1'b0;
    	ALUSrcA = 1'b0;
    	RegWrite= 1'b0;
    	RegDst  = 1'b0;
    	PCSource= 2'b00;
    	ALUSrcB = 2'b11;
    	ALUOp   = 2'b00;
    	if ( (op == 6'b100011) || (op == 6'b101011) ) nextState = S2;   // OP de lw y sw.
    	else if (op==6'b000000) nextState = S6;                              // OP de R
    	else if (op==6'b000100) nextState = S8;                              // OP de beq
    	else if (op==6'b001000) nextState = S9;                              // OP de addi
    	else if (op==6'b000010) nextState = S11;                             // OP de jump
    	else if (op==6'b000101) nextState = S12;                             // OP de bneq
    	else nextState = S0;
        end
        
    S2: begin           // Estoy ejecutando lw o sw
        PCWriteCond=1'b0;
        PCWrite = 1'b0;
    	IorD    = 1'b0;
    	MemRead = 1'b1;
    	MemWrite= 1'b0;
    	MemtoReg= 1'b0;
    	IRWrite = 1'b0;
    	ALUSrcA = 1'b1;
    	RegWrite= 1'b0;
    	RegDst  = 1'b0;
    	PCSource= 2'b00;
    	ALUSrcB = 2'b10;
    	ALUOp   = 2'b00;
    	if (op==6'b100011) nextState = S3;      // OP de lw
        else if (op==6'b101011) nextState = S5; // OP de sw
    	else nextState = S0;
    	end
    	
    S3: begin       // Estoy ejecutando lw (1/2)
        PCWriteCond=1'b0;
        PCWrite = 1'b0;
    	IorD    = 1'b1;
    	MemRead = 1'b1;
    	MemWrite= 1'b0;
    	MemtoReg= 1'b0;
    	IRWrite = 1'b0;
    	ALUSrcA = 1'b0;
    	RegWrite= 1'b0;
    	RegDst  = 1'b0;
    	PCSource= 2'b00;
    	ALUSrcB = 2'b00;
    	ALUOp   = 2'b00;
    	nextState = S4;
    	end
    
    S4: begin       // sigo ejecutando lw (2/2)
        PCWriteCond=1'b0;
        PCWrite = 1'b0;
    	IorD    = 1'b0;
    	MemRead = 1'b1;
    	MemWrite= 1'b0;
    	MemtoReg= 1'b1;
    	IRWrite = 1'b0;
    	ALUSrcA = 1'b0;
    	RegWrite= 1'b1;
    	RegDst  = 1'b0;
    	PCSource= 2'b00;
    	ALUSrcB = 2'b00;
    	ALUOp   = 2'b00;
    	nextState = S0;
    	end
    	
    S5: begin       // Estoy ejecutando sw (1/1)
        PCWriteCond=1'b0;
        PCWrite = 1'b0;
    	IorD    = 1'b1;
    	MemRead = 1'b1;
    	MemWrite= 1'b1;
    	MemtoReg= 1'b0;
    	IRWrite = 1'b0;
    	ALUSrcA = 1'b0;
    	RegWrite= 1'b0;
    	RegDst  = 1'b0;
    	PCSource= 2'b00;
    	ALUSrcB = 2'b00;
    	ALUOp   = 2'b00;
    	nextState = S0;
    	end
    
    S6: begin       // Estoy ejecutando R (1/2)
        PCWriteCond=1'b0;
        PCWrite = 1'b0;
    	IorD    = 1'b0;
    	MemRead = 1'b1;
    	MemWrite= 1'b0;
    	MemtoReg= 1'b0;
    	IRWrite = 1'b0;
    	ALUSrcA = 1'b1;
    	RegWrite= 1'b0;
    	RegDst  = 1'b0;
    	PCSource= 2'b00;
    	ALUSrcB = 2'b00;
    	ALUOp   = 2'b10;
    	nextState = S7;
    	end
    	
    S7: begin       // Estoy ejecutando R (2/2)
        PCWriteCond=1'b0;
        PCWrite = 1'b0;
    	IorD    = 1'b0;
    	MemRead = 1'b1;
    	MemWrite= 1'b0;
    	MemtoReg= 1'b0;
    	IRWrite = 1'b0;
    	ALUSrcA = 1'b0;
    	RegWrite= 1'b1;
    	RegDst  = 1'b1;
    	PCSource= 2'b00;
    	ALUSrcB = 2'b00;
    	ALUOp   = 2'b00;
    	nextState = S0;
    	end
    
    S8: begin       // Estoy ejecutando beq (1/1)
        PCWriteCond=1'b1;
        PCWrite = 1'b0;
    	IorD    = 1'b0;
    	MemRead = 1'b1;
    	MemWrite= 1'b0;
    	MemtoReg= 1'b0;
    	IRWrite = 1'b0;
    	ALUSrcA = 1'b1;
    	RegWrite= 1'b0;
    	RegDst  = 1'b0;
    	PCSource= 2'b01;
    	ALUSrcB = 2'b00;
    	ALUOp   = 2'b01;
    	nextState = S0;
    	end
    
    S9: begin       // Estoy ejecutando ADDI (1/2)
        PCWriteCond=1'b0;
        PCWrite = 1'b0;
    	IorD    = 1'b0;
    	MemRead = 1'b1;
    	MemWrite= 1'b0;
    	MemtoReg= 1'b0;
    	IRWrite = 1'b0;
    	ALUSrcA = 1'b1;
    	RegWrite= 1'b0;
    	RegDst  = 1'b0;
    	PCSource= 2'b00;
    	ALUSrcB = 2'b10;
    	ALUOp   = 2'b00;
    	nextState = S10;
    	end
    	
    S10: begin       // Estoy ejecutando ADDI (2/2)
        PCWriteCond=1'b0;
        PCWrite = 1'b0;
    	IorD    = 1'b0;
    	MemRead = 1'b1;
    	MemWrite= 1'b0;
    	MemtoReg= 1'b0;
    	IRWrite = 1'b0;
    	ALUSrcA = 1'b0;
    	RegWrite= 1'b1;
    	RegDst  = 1'b0;
    	PCSource= 2'b00;
    	ALUSrcB = 2'b00;
    	ALUOp   = 2'b00;
    	nextState = S0;
    	end
    
    S11: begin       // Estoy ejecutando jump (1/1)
        PCWriteCond=1'b0;
        PCWrite = 1'b1;
    	IorD    = 1'b0;
    	MemRead = 1'b1;
    	MemWrite= 1'b0;
    	MemtoReg= 1'b0;
    	IRWrite = 1'b0;
    	ALUSrcA = 1'b0;
    	RegWrite= 1'b0;
    	RegDst  = 1'b0;
    	PCSource= 2'b10;
    	ALUSrcB = 2'b00;
    	ALUOp   = 2'b00;
    	nextState = S0;
    	end
    
    S12: begin       // Estoy ejecutando bneq (1/1)
        PCWriteCond=1'b1;
        PCWrite = 1'b0;
    	IorD    = 1'b0;
    	MemRead = 1'b1;
    	MemWrite= 1'b0;
    	MemtoReg= 1'b0;
    	IRWrite = 1'b0;
    	ALUSrcA = 1'b1;
    	RegWrite= 1'b0;
    	RegDst  = 1'b0;
    	PCSource= 2'b01;
    	ALUSrcB = 2'b00;
    	ALUOp   = 2'b11;        // Creo un nuevo ALUOp para bnq
    	nextState = S0;
    	end
    
    default: begin       
        PCWriteCond=1'b0;
        PCWrite = 1'b0;
    	IorD    = 1'b0;
    	MemRead = 1'b0;
    	MemWrite= 1'b0;
    	MemtoReg= 1'b0;
    	IRWrite = 1'b0;
    	ALUSrcA = 1'b0;
    	RegWrite= 1'b0;
    	RegDst  = 1'b0;
    	PCSource= 2'b00;
    	ALUSrcB = 2'b00;
    	ALUOp   = 2'b00;        
    	nextState = S0;
    	end
    endcase
    end
endmodule

