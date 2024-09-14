`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:12:25 08/07/2024 
// Design Name:    Control Unit
// Module Name:    control_unit 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description:    Control unit for the CPU, generating control signals 
//                 based on the opcode.
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module control_unit(
    input wire [7:0] opcode,                  // 8-bit opcode from the instruction
    output reg mem_write,                     // Memory write enable signal
    output reg reg_write_en,                  // Register write enable signal
    output reg alu_en,                        // ALU enable signal
    output reg jmp,                           // Jump instruction signal
    output reg jmp_if,                        // Conditional jump instruction signal
    output reg load_imm,                      // Load immediate value signal
    output reg load_indirect,                 // Load indirect value signal
    output reg store_indirect,                // Store indirect value signal
    output reg mem_reg,                       // Memory register select signal
    output reg halt                          // Halt signal
);

// Control logic based on the opcode
always @(opcode) begin
    case (opcode)
        8'h01: begin
            mem_write = 1'b0;
            jmp = 1'b0;
            jmp_if = 1'b0;
            load_imm = 1'b0;
            load_indirect = 1'b0;
            store_indirect = 1'b0;
            mem_reg = 1'b1;
            alu_en = 1'b0;
            reg_write_en = 1'b1;
	    halt = 1'b0;
        end
        8'h02: begin
            mem_write = 1'b0;
            jmp = 1'b0;
            jmp_if = 1'b0;
            load_imm = 1'b0;
            load_indirect = 1'b1;
            store_indirect = 1'b0;
            mem_reg = 1'b1;
            alu_en = 1'b0;
            reg_write_en = 1'b1;
	    halt = 1'b0;
        end
        8'h03: begin
            mem_write = 1'b0;
            jmp = 1'b0;
            jmp_if = 1'b0;
            load_imm = 1'b1;
            load_indirect = 1'b0;
            store_indirect = 1'b0;
            mem_reg = 1'b0;
            alu_en = 1'b0;
            reg_write_en = 1'b1;
	    halt = 1'b0;
        end
        8'h04: begin
            mem_write = 1'b1;
            jmp = 1'b0;
            jmp_if = 1'b0;
            load_imm = 1'b0;
            load_indirect = 1'b0;
            store_indirect = 1'b0;
            mem_reg = 1'b0;
            alu_en = 1'b0;
            reg_write_en = 1'b0;
	    halt = 1'b0;
        end
        8'h05: begin
            mem_write = 1'b1;
            jmp = 1'b0;
            jmp_if = 1'b0;
            load_imm = 1'b0;
            load_indirect = 1'b0;
            store_indirect = 1'b1;
            mem_reg = 1'b0;
            alu_en = 1'b0;
            reg_write_en = 1'b0;
	    halt = 1'b0;
        end
        8'h06: begin
            mem_write = 1'b0;
            jmp = 1'b0;
            jmp_if = 1'b0;
            load_imm = 1'b0;
            load_indirect = 1'b0;
            store_indirect = 1'b0;
            mem_reg = 1'b0;
            alu_en = 1'b1;
            reg_write_en = 1'b1;
				halt = 1'b0;
        end
        8'h07: begin
            mem_write = 1'b0;
            jmp = 1'b0;
            jmp_if = 1'b0;
            load_imm = 1'b0;
            load_indirect = 1'b0;
            store_indirect = 1'b0;
            mem_reg = 1'b0;
            alu_en = 1'b1;
            reg_write_en = 1'b1;
	    halt = 1'b0;
        end
        8'h08: begin
            mem_write = 1'b0;
            jmp = 1'b0;
            jmp_if = 1'b0;
            load_imm = 1'b0;
            load_indirect = 1'b0;
            store_indirect = 1'b0;
            mem_reg = 1'b0;
            alu_en = 1'b1;
            reg_write_en = 1'b1;
	    halt = 1'b0;
        end
        8'h09: begin
            mem_write = 1'b0;
            jmp = 1'b0;
            jmp_if = 1'b0;
            load_imm = 1'b0;
            load_indirect = 1'b0;
            store_indirect = 1'b0;
            mem_reg = 1'b0;
            alu_en = 1'b1;
            reg_write_en = 1'b1;
	    halt = 1'b0;
        end
        8'h0a: begin
            mem_write = 1'b0;
            jmp = 1'b0;
            jmp_if = 1'b0;
            load_imm = 1'b0;
            load_indirect = 1'b0;
            store_indirect = 1'b0;
            mem_reg = 1'b0;
            alu_en = 1'b1;
            reg_write_en = 1'b1;
	    halt = 1'b0;
        end
        8'h0b: begin
            mem_write = 1'b0;
            jmp = 1'b0;
            jmp_if = 1'b0;
            load_imm = 1'b0;
            load_indirect = 1'b0;
            store_indirect = 1'b0;
            mem_reg = 1'b0;
            alu_en = 1'b1;
            reg_write_en = 1'b1;
	    halt = 1'b0;
        end
        8'h0c: begin
            mem_write = 1'b0;
            jmp = 1'b0;
            jmp_if = 1'b0;
            load_imm = 1'b0;
            load_indirect = 1'b0;
            store_indirect = 1'b0;
            mem_reg = 1'b0;
            alu_en = 1'b1;
            reg_write_en = 1'b1;
	    halt = 1'b0;
        end
        8'h0d: begin
            mem_write = 1'b0;
            jmp = 1'b0;
            jmp_if = 1'b0;
            load_imm = 1'b0;
            load_indirect = 1'b0;
            store_indirect = 1'b0;
            mem_reg = 1'b0;
            alu_en = 1'b1;
            reg_write_en = 1'b1;
	    halt = 1'b0;
        end
        8'h0e: begin
            mem_write = 1'b0;
            jmp = 1'b1;
            jmp_if = 1'b0;
            load_imm = 1'b0;
            load_indirect = 1'b0;
            store_indirect = 1'b0;
            mem_reg = 1'b0;
            alu_en = 1'b0;
            reg_write_en = 1'b0;
	    halt = 1'b0;
        end
        8'h0f: begin
            mem_write = 1'b0;
            jmp = 1'b0;
            jmp_if = 1'b1;
            load_imm = 1'b0;
            load_indirect = 1'b0;
            store_indirect = 1'b0;
            mem_reg = 1'b0;
            alu_en = 1'b1;
            reg_write_en = 1'b0;
	    halt = 1'b0;
        end
        8'hff: begin
            mem_write = 1'b0;
            jmp = 1'b0;
            jmp_if = 1'b0;
            load_imm = 1'b0;
            load_indirect = 1'b0;
            store_indirect = 1'b0;
            mem_reg = 1'b0;
            alu_en = 1'b0;
            reg_write_en = 1'b0;
	    halt = 1'b1;
        end 
        default: begin
            mem_write = 1'b0;
            jmp = 1'b0;
            jmp_if = 1'b0;
            load_imm = 1'b0;
            load_indirect = 1'b0;
            store_indirect = 1'b0;
            mem_reg = 1'b0;
            alu_en = 1'b0;
            reg_write_en = 1'b0;
	    halt = 1'b0;
        end
    endcase
end



endmodule
