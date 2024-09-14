`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:24:23 08/07/2024 
// Design Name:    Simple RISC CPU
// Module Name:    register_file 
// Project Name:   Simple RISC CPU Design
// Target Devices: 
// Tool versions: 
// Description:    This module defines a register file with 16 general-purpose
//                 registers. It supports simultaneous reading from two registers 
//                 and writing to one register.
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module register_file #(
    parameter read_addr_width = 4,    // Width of the read address (log2 of reg_depth)
    parameter write_addr_width = 4,   // Width of the write address
    parameter reg_width = 32,         // Width of each register
    parameter reg_depth = 16          // Number of registers
)(
    input wire clk_150_mhz,                     // Clock signal at 150 MHz
    input wire reg_rst_n,                       // Active low reset signal
    input wire write_en,                        // Write enable signal
    input wire [read_addr_width-1:0] reg_read_addr_1, // Read address for first register
    input wire [read_addr_width-1:0] reg_read_addr_2, // Read address for second register
    input wire [write_addr_width-1:0] reg_write_addr, // Write address
    input wire [reg_width-1:0] reg_write_data,        // Data to be written to the register
    output wire [reg_width-1:0] reg_data_out_1,       // Output data from the first read register
    output wire [reg_width-1:0] reg_data_out_2        // Output data from the second read register
);

    // Register array to store the register values
    reg [reg_width-1:0] register_file [0:reg_depth-1];

    integer i;

    // Sequential block for handling register write and reset operations
    always @(posedge clk_150_mhz or negedge reg_rst_n)
	begin
        if (!reg_rst_n)
		begin
            // Reset all registers to 0 on active low reset
            for (i = 0; i <= reg_depth-1; i = i + 1) 
                register_file[i] <= 32'd0;
                end 
        else 
		begin
            if (write_en) 
                register_file[reg_write_addr] <= reg_write_data; // Write operation
        	end
	end
	 // Continuous assignments for register read operations
    assign reg_data_out_1 = register_file[reg_read_addr_1];
    assign reg_data_out_2 = register_file[reg_read_addr_2];

endmodule
