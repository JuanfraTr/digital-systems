// file: mips_tb.v
// author: @juan
// Testbench for mips

`timescale 1ns/1ns

module mips_tb;

	//Inputs
	reg [0: 0] rst;
	reg [0: 0] clk;


	//Outputs
	wire [0: 0] overflow;
	wire [31: 0] mipsOut;


	//Instantiation of Unit Under Test
	mips uut (
		.rst(rst),
		.clk(clk),
		.overflow(overflow),
		.mipsOut(mipsOut)
	);

    
    initial begin
	//Inputs initialization
		clk = 0;
		rst = 0;
	end
    
	initial begin
    	repeat(4) #5 clk = ~clk;
    	#5 clk = ~clk; 
    	rst = 1'b1;
    	#5 clk = ~clk;
    	rst = 1'b0;
    	forever #5 clk = ~clk;
	end


endmodule

