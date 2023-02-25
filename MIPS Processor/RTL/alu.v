`timescale 1ns/1ns
module alu
    (input [31:0] aluInA,
    input [31:0] aluInB,
    input [2:0] aluControl,
    output reg [31:0] aluResult,
    output reg [0:0] aluZero,
    output reg [0:0] aluOverflow
    );

reg [32:0] aux;

always @(*) 
    begin
        if (aluControl == 3'b000)
        // AND
            begin
                aluResult = aluInA & aluInB;
                aluOverflow = 1'b0;
                if (aluInA & aluInB == 32'b0)
                    aluZero = 1'b1;    
            end
        if (aluControl == 3'b001)
        // OR 
            begin
                aluResult = aluInA | aluInB;
                aluOverflow = 1'b0;
                if (aluInA | aluInB == 32'b0)
                    aluZero = 1'b1;    
            end
        if (aluControl == 3'b010) 
        // A+B
            begin
            aluResult = aluInA + aluInB;
            if (aluInA + aluInB == 32'b0)
                aluZero = 1'b1;
                
            if ( (aluInA[31] && aluInB[31]) == 1'b1 ) 
                begin
                aux = aluInA + aluInB;
                if ( aux[31]==1'b0 ) 
                    begin
                    aluOverflow = 1'b1;
                    end
                end
            else if ( (aluInA[31] || aluInB[31]) == 1'b0 ) 
                begin
                aux = aluInA + aluInB;
                if (aux[31]==1'b1) 
                    begin
                    aluOverflow = 1'b1;
                    end
                end
            end
        if (aluControl == 3'b110)
        //A-B
            begin 
            aluResult = aluInA - aluInB;
            if (aluInA - aluInB == 32'b0)
                aluZero = 1'b1; 
            if ( (aluInB[31]==1 && aluInA[31]) == 1'b0 ) 
                begin
                aux = aluInA - aluInB;
                if ( aux[31] == 1'b0 ) 
                    begin
                    aluOverflow = 1'b1;
                    end
                end
            else if ( (aluInA[31]==0 && aluInB[31]) == 1'b0 ) 
                begin
                aux = aluInA + aluInB;
                if (aux[31]==1'b1)
                    begin
                    aluOverflow = 1'b1;
                    end
                end
            end
        if (aluControl == 3'b100)
        //A-B Especifico para bnq. Si son iguales, manda un Zero=0
            begin 
            aluResult = aluInA - aluInB;
            if (aluInA - aluInB == 32'b0)
                aluZero = 1'b0;
            else 
                aluZero = 1'b1;
            if ( (aluInB[31]==1 && aluInA[31]) == 1'b0 ) 
                begin
                aux = aluInA - aluInB;
                if ( aux[31] == 1'b0 ) 
                    begin
                    aluOverflow = 1'b1;
                    end
                end
            else if ( (aluInA[31]==0 && aluInB[31]) == 1'b0 ) 
                begin
                aux = aluInA + aluInB;
                if (aux[31]==1'b1)
                    begin
                    aluOverflow = 1'b1;
                    end
                end
            end
            
        if (aluControl == 3'b011)
        //NOR
            begin 
                aluResult = aluInA ~| aluInB;
                aluOverflow = 1'b0;
                if (aluInA ~| aluInB == 32'b0)
                    aluZero = 1'b1;    
            end
        if (aluControl == 3'b111)
        //XOR
            begin 
                aluResult = aluInA ^ aluInB;
                aluOverflow = 1'b0;
                if (aluInA ^ aluInB == 32'b0)
                    aluZero = 1'b1;    
            end
    end

endmodule

