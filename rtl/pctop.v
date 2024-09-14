`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:07:18 08/07/2024 
// Design Name: 
// Module Name:    pctop 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description:    Program counter top-level module for managing instruction addresses.
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module pctop#(
    parameter pc_width = 32  // Width of the program counter
)(
    input wire halt,                      // Halt signal
    input wire jmp,                       // Jump signal
    input wire jmp_if,                    // Conditional jump signal
    input wire alu_out_lsb,               // Least significant bit of ALU output
    input wire clk_150_mhz,               // Clock signal at 150 MHz
	//  input wire clk_70_mhz, 
	 
    input wire pc_rst_n,                  // Active-low reset signal
    input wire [pc_width-1:0] imm_padded_out, // Immediate value padded to the PC width
    output wire [pc_width-1:0] next_instr_addr // Address of the next instruction
);

// Internal wires for interconnections
wire [pc_width-1:0] next_instr_wire, current_instr_wire;//current_instr_wire_read_addr;
wire [pc_width-1:0] halt_mux_out;

// Instantiate the PC incrementer module
pc_incr p0 (
    .next_instr(halt_mux_out),           // Input: address from halt_mux
    .clk_150_mhz(clk_150_mhz),           // Input: 150 MHz clock
    .pc_rst_n(pc_rst_n),                 // Input: reset signal
    .current_instr(current_instr_wire)   // Output: current instruction address
);




// Instantiate the PC address module
pc_address p1 (
    .jmp(jmp),                           // Input: jump signal
    .jmp_if(jmp_if),                     // Input: conditional jump signal
    .alu_out_lsb(alu_out_lsb),           // Input: ALU output LSB
    .read_addr(current_instr_wire),      // Input: current instruction address      
    .imm_padded_out(imm_padded_out),     // Input: padded immediate value 
    .next_instr_addr(next_instr_wire)    // Output: next instruction address
);


// MUX to decide the next instruction based on halt signal
assign halt_mux_out = halt ? current_instr_wire : next_instr_wire; ///_read_addr

// Assign the current instruction address as the next instruction address output
assign next_instr_addr = current_instr_wire;

endmodule
