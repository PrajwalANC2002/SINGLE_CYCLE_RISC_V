`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////

// Company: 

// Engineer: 

// 

// Create Date:    10:55:46 08/07/2024 

// Design Name:    RISC CPU

// Module Name:    program_memory 

// Project Name:   Simple RISC CPU

// Target Devices: 

// Tool versions: 

// Description:    This module defines the program memory, which stores the 

//                 instructions for the RISC CPU. The instructions are fetched 

//                 based on the address provided by the program counter.

//

// Dependencies: 

//

// Revision: 

// Revision 0.01 - File Created

// Additional Comments: 

//

//////////////////////////////////////////////////////////////////////////////////



module program_memory #(

    parameter program_mem_width = 32,  // Width of each instruction

    parameter program_mem_depth = 4096, // Number of instructions

    parameter program_mem_addr = 12     // Address width for program memory

)(
	 input wire clk_150_mhz, //clock input

    input [program_mem_addr-1:0] program_addr,  // Address from program counter

    output wire [program_mem_width-1:0] instruction // Output instruction

);



    // Memory array to store the program instructions

    reg [program_mem_width-1:0] programmemory [0:program_mem_depth-1];



    // asynchronous read

        assign instruction = programmemory[program_addr];



    // always block to load instructions into the memory

  always@(posedge clk_150_mhz)

		begin

        programmemory[0]    <= 32'h03_0_0_0_003; // load value 3 to 0 register

        programmemory[1]    <= 32'h03_1_0_0_00A; //load value 10 to 1 register

        programmemory[2]    <= 32'h06_2_0_1_000; //add data present in 0 and 1 register and store result in register 2

        programmemory[3]    <= 32'h07_3_1_0_000; //subtract values of 1 and 0 register and store result in register 3

        programmemory[4]    <= 32'h08_4_0_1_000; //multiply values of 0 and 1 register and store result in register 4

        programmemory[5]    <= 32'h09_5_1_0_000; //performs bitwise and of data in 0 and 1 register and store result in register 5

        programmemory[6]    <= 32'h0A_6_1_0_000; //performs bitwise or of data in 0 and 1 register and store result in register 6

        programmemory[7]    <= 32'h0B_7_0_0_000; //performs bitwise not of data in 0 register and store result in register 7

        programmemory[8]    <= 32'h0C_2_0_1_000; //performs greater than comparision of data in 0 and 1 register and store result in register 2

        programmemory[9]    <= 32'h0D_3_0_0_000; //performs equality comparision of data in 0 and 1 register and store result in register 3

        programmemory[10]   <= 32'h0E_0_0_0_FFC; //performs jump to 4092

        programmemory[4092] <= 32'h06_4_0_0_000; //add data present in 0 and 0 register and store result in register 4

        programmemory[4093] <= 32'h07_5_0_0_000; //subtract data present in 0 and 0 register and store result in register 5

        programmemory[4094] <= 32'h08_6_0_0_000; //multiply data present in 0 and 0 register and store result in register 6

        programmemory[4095] <= 32'h0E_0_0_0_00B; //performs jump to 11

        programmemory[11]   <= 32'h04_0_0_0_FFD;  //store the value of 0 register to 4093 address of data memory

        programmemory[12]   <= 32'h04_0_1_0_FFF;  //store the value of 0 register to 4095 address of data memory

        programmemory[13]   <= 32'h03_7_0_0_FFF;  //load value FFF to 7 register

        programmemory[14]   <= 32'h02_4_7_0_000;  //load indirect load data present in address present in register 7 of data memory to register 4

        programmemory[15]   <= 32'h05_0_1_7_000;  //store indirect ,store value of register 1 to address present in register 7

        programmemory[16]   <= 32'h05_0_0_7_000;  //store indirect ,store value of register 0 to address present in register 7  

        programmemory[17]   <= 32'h01_6_0_0_FFF;  //load data present in 4095 of data memory to register 6

        programmemory[18]   <= 32'h01_5_0_0_FFF;  //load data present in 4095 of data memory to register 5

        programmemory[19]   <= 32'h03_0_0_0_000;  // load value 0 to 0 register

        programmemory[20]   <= 32'h03_1_0_0_001;  // load value 1 to 1 register

        programmemory[21]   <= 32'h03_2_0_0_00a;  // load value 10 to 2 register

        programmemory[22]   <= 32'h06_0_0_1_000;  //add data present in 0 and 1 register and store result in register 0

        programmemory[23]   <= 32'h0F_0_0_2_016;  //jump to 21 if values of registers 0 and 2 are not equal

        programmemory[24]   <= 32'hFF_0_0_0_000;  //halt instruction 

        programmemory[254]  <= 32'h03_1_0_0_001;

		end



endmodule

/*For FPGA validation the program memory should only have the following instruction
mem[0] <= 32'h03_0_0_0_003; // Load value 3 into register 0
mem[1] <= 32'h03_1_0_0_00a; // Load value 10 into register 1
mem[2] <= 32'h06_2_0_1_000; // Add values from registers 0 and 1, store result in register 2
mem[3] <= 32'hff_0_0_0_000; // Halt instruction
*/

