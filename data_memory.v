`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////

// Company: 

// Engineer: 

// 

// Create Date:    16:24:46 08/07/2024 

// Design Name: 

// Module Name:    data_memory 

// Project Name:   Simple RISC CPU

// Target Devices: 

// Tool versions: 

// Description:    This module defines the data memory for the RISC CPU, 

//                 allowing read and write operations based on the provided 

//                 control signals and addresses.

//

// Dependencies: 

//

// Revision: 

// Revision 0.01 - File Created

// Additional Comments: 

//

//////////////////////////////////////////////////////////////////////////////////



module data_memory #(

    parameter datamem_depth = 4096,         // Number of memory locations

    parameter datamem_width = 32,           // Width of each memory location

    parameter data_mem_addr_depth = 12      // Address width for data memory

)(

    input wire clk_70_mhz,                            // Clock signal at 70 MHz

    input wire [data_mem_addr_depth-1:0] datamem_addr, // Address for memory access

    input wire [datamem_width-1:0] datamem_write_data, // Data to be written to memory

    input wire datamem_write_en,                      // Write enable signal

    output reg [datamem_width-1:0] datamem_data_out   // Output data from memory

);



    // Memory array to store data

    reg [datamem_width-1:0] datamemory [datamem_depth-1:0];



    // Memory read/write operations

    always @(posedge clk_70_mhz) begin

        if (datamem_write_en) 

	  begin

            datamemory[datamem_addr] <= datamem_write_data;  // Write operation

	  end
	  else
	  begin

            datamem_data_out <= datamemory[datamem_addr];         // Read operation
	  end

    end



endmodule

