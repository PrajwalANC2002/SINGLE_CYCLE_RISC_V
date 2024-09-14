`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:20:00 08/10/2024
// Design Name:   riscv_cpu
// Module Name:   /home/ise/major_project/alu/riscv_cpu_tb.v
// Project Name:  alu
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: riscv_cpu
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module riscv_cpu_tb;

	// Inputs
	reg clk_150_mhz;
	reg clk_70_mhz;
	reg rst_n;

	// Outputs
	wire [31:0] dummy_out;

	// Instantiate the Unit Under Test (UUT)
	riscv_cpu uut (
		.clk_150_mhz(clk_150_mhz), 
		.clk_70_mhz(clk_70_mhz),
		.rst_n(rst_n), 
		.dummy_out(dummy_out)
	);
	
	always #3.33 clk_150_mhz=~clk_150_mhz;
	
	always #7.141 clk_70_mhz=~clk_70_mhz;

	initial begin
		// Initialize Inputs
		clk_150_mhz = 0;
		clk_70_mhz = 0;
		rst_n = 1;

		// Wait 100 ns for global reset to finish
		#1 rst_n=1'b0;
		#15 rst_n=1'b1;
		
   
		// Add stimulus here

	end
      
endmodule

