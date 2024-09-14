`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:59:23 08/08/2024 
// Design Name:    ALU Control
// Module Name:    alu_control
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description:    ALU Control module for selecting ALU operations based on the 
//                 instruction opcode and enabling signal.
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module alu_control(
    input wire [7:0] alu_instruction,   // 8-bit ALU instruction opcode
    input wire alu_en,                  // ALU enable signal
    output reg [3:0] alu_operation      // 4-bit ALU operation code
);

// ALU operation selection logic based on instruction opcode and enable signal
always @(alu_instruction or alu_en) begin
    if (alu_en) begin
        case (alu_instruction)
            8'h06: alu_operation = 4'b0000; // Operation code 000 for instruction 0x06
            8'h07: alu_operation = 4'b0001; // Operation code 001 for instruction 0x07
            8'h08: alu_operation = 4'b0010; // Operation code 010 for instruction 0x08
            8'h09: alu_operation = 4'b0011; // Operation code 011 for instruction 0x09
            8'h0a: alu_operation = 4'b0100; // Operation code 100 for instruction 0x0A
            8'h0b: alu_operation = 4'b0101; // Operation code 101 for instruction 0x0B
            8'h0c: alu_operation = 4'b0110; // Operation code 110 for instruction 0x0C
            8'h0d: alu_operation = 4'b0111; // Operation code 111 for instruction 0x0D
            8'h0f: alu_operation = 4'b1000; // Operation code 111 for instruction 0x0F
            default: alu_operation = 4'b0000; // Default operation code //this case will not happen since alu_en is used
        endcase
    end else begin
        alu_operation = 4'b1111; // deafult state for alu when ALU is disabled
    end
end

endmodule
