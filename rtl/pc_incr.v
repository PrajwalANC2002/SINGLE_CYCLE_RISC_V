`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:53:55 08/07/2024 
// Design Name: 
// Module Name:    pc_incr 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description:    Program counter incrementer that updates the current instruction
//                 address on each clock cycle or resets on reset signal.
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module pc_incr#(
    parameter pc_width = 32  // Width of the program counter
)(
    input wire [pc_width-1:0] next_instr, // Next instruction address
    input wire clk_150_mhz,               // 150 MHz clock signal
    input wire pc_rst_n,                  // Active-low reset signal
    output reg [pc_width-1:0] current_instr // Current instruction address
);

// Update current instruction on the rising edge of the clock or reset on the falling edge of reset
always @(posedge clk_150_mhz or negedge pc_rst_n)
begin
    if (!pc_rst_n) // Reset condition (active-low)
    begin
        current_instr <= 32'd0; // Reset the current instruction to address 0
    end
    else // Normal operation
    begin
        current_instr <= next_instr; // Update current instruction with the next instruction address
    end
end

endmodule
