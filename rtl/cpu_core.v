`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////

// Company: 

// Engineer: 

// 

// Create Date:    08:24:41 08/08/2024 

// Design Name: 

// Module Name:    cpu_core 

// Project Name: 

// Target Devices: 

// Tool versions: 

// Description:    A basic CPU core with control unit, ALU, register file, and program counter.

//                 This core takes instructions and memory data as inputs and provides

//                 necessary outputs to drive memory and register operations.

//

// Dependencies: 

//

// Revision: 

// Revision 0.01 - File Created

// Additional Comments: 

//

//////////////////////////////////////////////////////////////////////////////////

module cpu_core(

    input wire clk_150_mhz,          // Clock input

    input wire rst_n,                // Active low reset

    input wire [31:0] instruction,   // 32-bit instruction input

    input wire [31:0] mem_reg_in,   // 32-bit data from memory/register

    output wire [31:0] data_mem_addr,     // Address for data memory

    output wire [31:0] data_mem_write_data,// Data to write to data memory

    output wire [31:0] next_instruction_address, // Address of the next instruction

    output wire [31:0] alu_out,      // ALU output

    output wire [31:0] imm_padded_out_wire_out,

    output wire mem_write,           // Memory write enable

    output wire mem_reg_select,     // Memory/register select signal

    output wire load_imm_mux_cntrl   //load immediate mux control signal

);







// Internal wire declarations

wire [31:0] instruction_wire;

wire [31:0] reg_data_out1_wire, reg_data_out2_wire;

wire [31:0] alu_out_wire;



wire alu_en_wire, jmp_wire, jmp_if_wire, load_imm_wire, load_indirect_wire, store_indirect_wire, halt_wire;

wire mem_read_wire, mem_write_wire, mem_reg_select_wire;

wire reg_write_en_wire;

wire [31:0] next_instruction_address_wire;



wire [31:0] imm_padded_out_wire;

wire [3:0] alu_operation_wire;



wire [31:0] load_indirect_mux_out, store_indirect_mux_out, load_imm_mux_out;



wire load_imm_wire_150_mhz;



assign load_imm_mux_cntrl = load_imm_wire; 



// Assignments of ouputs of cpu core with the correpsonding internal wires

assign instruction_wire = instruction; 

assign alu_out = alu_out_wire;



assign mem_write = mem_write_wire;

assign mem_reg_select = mem_reg_select_wire;



assign next_instruction_address = next_instruction_address_wire;



// Immediate field padding for the instruction

assign imm_padded_out_wire = {{20{1'b0}}, instruction_wire[11:0]};



assign imm_padded_out_wire_out = imm_padded_out_wire;



// ALU instantiation

alu a0(

    .operand1(reg_data_out1_wire), // alu operand1 connect to register set data out1

    .operand2(reg_data_out2_wire), // alu operand2 connect to register set data out2

    .alu_op(alu_operation_wire),  //specifies the alu operations to be performed 

    .alu_out(alu_out_wire)        // alu output 

);



// Register file instantiation

register_file r0(

    .clk_150_mhz(clk_150_mhz),

    .reg_rst_n(rst_n),

    .write_en(reg_write_en_wire),   // register set write enable

    .reg_read_addr_1(instruction_wire[19:16]), // slicing the [19:16] bits from instruction to specify the address of register from which to read the data

    .reg_read_addr_2(instruction_wire[15:12]), // slicing the [15:12] bits from instruction to specify the address of register from which to read the data

    .reg_write_addr(instruction_wire[23:20]), // slicing the [23:20] bits from instruction to specify the address of register to write the data

    .reg_write_data(mem_reg_in),   //register set write data pin

    .reg_data_out_1(reg_data_out1_wire), // register data output from the address specified by reg_read_addr_1

    .reg_data_out_2(reg_data_out2_wire) //// register data output from the address specified by reg_read_addr_2

);







// Program counter control

pctop p3(
	 .clk_150_mhz(clk_150_mhz),  //clock input

    .halt(halt_wire),       //control signal for halt mux

    .jmp(jmp_wire),         //control signal for jmp mux

    .jmp_if(jmp_if_wire),   //control signal for jmp_if mux

    .alu_out_lsb(alu_out_wire[0]), //lsb of alu_out to perform jmp_if instruction

    .pc_rst_n(rst_n),              //resets the program counter to first location of program memory

    .imm_padded_out(imm_padded_out_wire),

    .next_instr_addr(next_instruction_address_wire) //address of next instruction to be executed to be provided as input to program memory

);



// Control unit instantiation

control_unit c0(

    .opcode(instruction_wire[31:24]),       //extracting opcode from instruction 

    .mem_write(mem_write_wire),             //data memory write enable 

    .reg_write_en(reg_write_en_wire),       // register set write enable

    .alu_en(alu_en_wire),                   // alu enable 

    .jmp(jmp_wire),                         //jmp mux control signal

    .jmp_if(jmp_if_wire),                   //jmp_if mux xontrol signal

    .load_imm(load_imm_wire),               //load immediate mux control signal

    .load_indirect(load_indirect_wire),     //load indirect mux control signal

    .store_indirect(store_indirect_wire),   //store indirect mux control signal

    .mem_reg(mem_reg_select_wire),          //memory to reg mux control signal

    .halt(halt_wire)                        //halt mux contol signal

);



// ALU control instantiation

alu_control a1(

    .alu_instruction(instruction_wire[31:24]), //extracting opcode from instruction

    .alu_en(alu_en_wire),                      //alu enable helps enable the alu whenever required

    .alu_operation(alu_operation_wire)         //specifies what operation needs to be performed

);



// Mux for load indirect operation

assign load_indirect_mux_out = load_indirect_wire ? reg_data_out1_wire : imm_padded_out_wire;



// Mux for store indirect operation

assign store_indirect_mux_out = store_indirect_wire ? reg_data_out2_wire : load_indirect_mux_out;







// Data memory interface assignments

assign data_mem_write_data = reg_data_out1_wire;

assign data_mem_addr = store_indirect_mux_out;



endmodule



