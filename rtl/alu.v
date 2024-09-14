`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:30:46 07/31/2024 
// Design Name:    Simple RISC CPU
// Module Name:    alu 
// Project Name:   Simple RISC CPU Design
// Target Devices: 
// Tool versions: 
// Description:    This module implements an Arithmetic Logic Unit (ALU) that performs
//                 various arithmetic and logical operations based on the provided opcode.
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module alu #(
    parameter opwidth = 32,        // Width of operands and result
    parameter opcodewidth = 4      // Width of the opcode
)(
    input [opwidth-1:0] operand1,  // First operand
    input [opwidth-1:0] operand2,  // Second operand
    input [opcodewidth-1:0] alu_op,// ALU operation code
    output reg [opwidth-1:0] alu_out // Result of the ALU operation
);

always @(operand1 or operand2 or alu_op) begin
    case (alu_op)
        4'd0: alu_out = operand1 + operand2;                             // Addition
        4'd1: alu_out = operand1 - operand2;                             // Subtraction
        4'd2: alu_out = operand1 * operand2;                             // Multiplication
        4'd3: alu_out = operand1 & operand2;                             // Bitwise AND
        4'd4: alu_out = operand1 | operand2;                             // Bitwise OR
        4'd5: alu_out = ~operand1;                                       // Bitwise NOT
        4'd6: alu_out = (operand1 > operand2) ? {{opwidth-1{1'b0}},1'b1} : {opwidth{1'b0}};                   // Greater than comparison
        4'd7: alu_out = (operand1 == operand2) ? {{opwidth-1{1'b0}},1'b1} : {opwidth{1'b0}};                  // Equality comparison
	4'd8: alu_out = (operand1 != operand2) ? {{opwidth-1{1'b0}},1'b1} : {opwidth{1'b0}};                  //not equal condition for jmp_if
        default: alu_out = {opwidth{1'b0}};                              // Default to zero for undefined opcodes if alu_op=4'b1111 this state will be taken
    endcase
end

endmodule

