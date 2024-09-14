`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:55:46 08/07/2024 
// Design Name: 
// Module Name:    pc_address 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description:    Computes the next instruction address based on jump, 
//                 conditional jump, and ALU output signals.
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module pc_address#(
    parameter pc_width = 32  // Width of the program counter
)(
    input wire jmp,                // Jump signal
    input wire jmp_if,             // Conditional jump signal
    input wire alu_out_lsb,        // Least significant bit of the ALU output (for conditional jumps)
    input wire [pc_width-1:0] read_addr,      // Current instruction address (PC value)
    input wire [pc_width-1:0] imm_padded_out, // Immediate value for jump/branch
    output wire [pc_width-1:0] next_instr_addr // Calculated next instruction address
);

wire [pc_width-1:0] jmp_mux_out, jmp_if_mux_out, adder_out_wire;
wire and_gate_out;
reg [pc_width-1:0] adder_out;

// AND gate for conditional jump logic
assign and_gate_out = jmp_if & alu_out_lsb;

// Increment the current instruction address by 1
always @(read_addr) 
	begin
	  adder_out = read_addr +1'b1;
	end
assign adder_out_wire = adder_out;


// Multiplexer to choose between the incremented address and the immediate value based on the jump signal
assign jmp_mux_out = jmp ? imm_padded_out : adder_out_wire;

// Multiplexer to choose between the jump address and the immediate value based on the conditional jump signal
assign jmp_if_mux_out = and_gate_out ? imm_padded_out : jmp_mux_out;

// Output the final next instruction address
assign next_instr_addr = jmp_if_mux_out;

endmodule
