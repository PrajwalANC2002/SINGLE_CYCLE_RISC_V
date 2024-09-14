`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////

// Company: 

// Engineer: 

// 

// Create Date:    16:08:03 08/07/2024 

// Design Name:    RISC-V CPU

// Module Name:    riscv_cpu

// Project Name: 

// Target Devices: 

// Tool versions: 

// Description:    A simple RISC-V CPU module that integrates a program memory, data memory,

//                 and a CPU core. It handles instruction fetching, execution, and memory operations.

//

// Dependencies: 

//

// Revision: 

// Revision 0.01 - File Created

// Additional Comments: 

//

//////////////////////////////////////////////////////////////////////////////////



module riscv_cpu(

    input wire clk_150_mhz,        // Clock input (150 MHz)

    input wire rst_n ,              // Active low reset

    output wire [31:0] dummy_out         // 32-bit dummy out to clear black box error in xilinx ise

);



// Internal wire declarations

wire [31:0] next_instr_wire;           // Address of the next instruction

wire [31:0] instruction_wire;          // Current instruction

wire [31:0] cpucore_datamemory_addr;  // CPU core to data memory address wire

wire [31:0] cpucore_datamemory_wr_data;  // CPU core to data memory write data wire

wire mem_write_wire;                   // Memory write enable signal

wire mem_reg_select_wire;              // Memory/register select signal

wire [31:0] mem_reg_mux_out_wire;      // Output of the memory/register MUX

wire [31:0] data_mem_out_wire;         // Output from data memory

wire [31:0] alu_out_wire;              // ALU output

wire load_imm_mux_cntrl_wire;                // Load immediate mux control signal

wire [31:0] imm_padded_out_wire_out;   // Immediate padded output

wire [31:0] load_imm_mux_out;          // Mux output for load immediate operation



// Program memory instantiation: Fetches the instruction based on the program counter

program_memory p4 (
	 .clk_150_mhz(clk_150_mhz),

    .program_addr(next_instr_wire[11:0]), // Instruction address (12-bit)

    .instruction(instruction_wire)        // 32-bit instruction output

);



// Data memory instantiation: Handles memory read/write operations

data_memory d0 (

    .clk_150_mhz(clk_150_mhz),            // Clock input

    .datamem_addr(cpucore_datamemory_addr[11:0]), // Data memory address (12-bit)

    .datamem_write_data(cpucore_datamemory_wr_data), // Data to be written to memory

    .datamem_write_en(mem_write_wire),   // Memory write enable  

    .datamem_data_out(data_mem_out_wire) // 32-bit data output from memory

);



// CPU core instantiation: Executes instructions and controls data flow

cpu_core c2 (

    .clk_150_mhz(clk_150_mhz),           // Clock input

    .rst_n(rst_n),                       // Active low reset

    .instruction(instruction_wire),      // Instruction input

    .mem_reg_in(load_imm_mux_out),       // Memory/register MUX output

    .data_mem_addr(cpucore_datamemory_addr),   // Data memory address

    .data_mem_write_data(cpucore_datamemory_wr_data), // Data to write to memory

    .next_instruction_address(next_instr_wire), // Next instruction fetch address to be provided as address input to program memory 

    .alu_out(alu_out_wire),              // ALU output

    .mem_write(mem_write_wire),          // Memory write enable

    .mem_reg_select(mem_reg_select_wire), // Memory/register select signal from control unit

    .imm_padded_out_wire_out(imm_padded_out_wire_out), //32 load immediate value

    .load_imm_mux_cntrl(load_imm_mux_cntrl_wire)  //load_imm mux control signal

);



// Memory/register select MUX: Selects between ALU output and data memory output to be provided as input to register file 
//write data after passing through load immediate mux

assign mem_reg_mux_out_wire = mem_reg_select_wire ? data_mem_out_wire : alu_out_wire;



// Mux for load immediate operation provided as input to register file write data

assign load_imm_mux_out = load_imm_mux_cntrl_wire ? imm_padded_out_wire_out : mem_reg_mux_out_wire;



// Dummy Output assignment: Sends data memory output to the module's output

assign dummy_out = cpucore_datamemory_wr_data; //dummy out to clear no design found error in xilinx ise



endmodule

