# RISC CPU Lite - Major Project

## Problem Statement

The aim of this project is to design a simplified RISC (Reduced Instruction Set Computer) CPU with a basic instruction set. The CPU should be capable of executing a given set of instructions in binary and work efficiently using separate Program Memory and Data Memory.

## Project Overview

The RISC CPU Lite consists of multiple components including:
- **Program Memory**: Stores the instructions to be executed by the CPU.
- **Data Memory**: Stores data required by load/store operations.
- **Register File**: Contains 16 general-purpose 32-bit registers.
- **ALU (Arithmetic Logic Unit)**: Performs arithmetic, logic, and relational operations.
- **Control Unit**: Generates control signals to guide data flow and instruction execution.
- **Program Counter (PC)**: Tracks the address of the next instruction to be executed.

### Clock Frequencies
- Both the CPU and memory components work at **150 MHz**, simplifying the design to avoid clock domain crossing issues. Previously, the CPU operated at 150 MHz while memory was at 70 MHz.

## Specification

### Register Set
- 16 general-purpose 32-bit registers (R0 to R15).
- The **Program Counter (PC)** holds the address of the next instruction to be executed.

### Memory Configuration
- **Program Memory**: 4K x 32-bit (stores instructions).
- **Data Memory**: 4K x 32-bit (used for data during execution).

### Instruction Format
| Field     | Opcode  | OUT (Dest) | OP1 (Src1) | OP2 (Src2) | Address/Immediate |
|-----------|---------|------------|------------|------------|-------------------|
| **Bits**  | 8       | 4          | 4          | 4          | 12                |

### Supported Instructions
- **Load**: Load data from memory into a register.
- **Store**: Store data from a register into memory.
- **Arithmetic Operations**: Addition, subtraction, and multiplication.
- **Logical Operations**: AND, OR.
- **Control Flow**: Jump, Jump-if, Halt.

### CPU Components
- **Control Unit**: Decodes the instruction and generates control signals for other components.
- **ALU**: Performs operations like addition, subtraction, bitwise AND, OR.
- **Program Memory**: Stores instructions.
- **Data Memory**: Stores data required for the load/store operations.
- **Register File**: Stores intermediate results and operands.

## Design Modifications
- **Single Clock Domain**: The entire CPU (both Program Memory and Data Memory) now operates at 150 MHz. This modification removes the need for clock domain crossing (CDC) handling, making the design simpler.
  
- **Memory Write Enable**: The memory module has been simplified by using a single `mem_write` enable signal to determine when the data memory should perform write operations. Removing the separate `mem_read` signal improved resource utilization in FPGA synthesis, enabling the inference of block RAM rather than distributed RAM.

## Project Flow

1. **Instruction Fetch**: The instruction is fetched from Program Memory based on the address in the Program Counter (PC).
2. **Instruction Decode**: The instruction is decoded by the Control Unit to generate control signals.
3. **Execution**: The decoded instruction is executed, and the ALU performs any arithmetic, logic, or relational operations.
4. **Memory Access**: If needed, data is read from or written to Data Memory based on control signals.
5. **Program Counter Update**: The PC is updated to point to the next instruction.

## Simulation Results

- **Load Instruction**: Loads data from memory to register successfully.
- **Store Instruction**: Stores data from register to memory.
- **Arithmetic Operations**: Addition, subtraction, multiplication, and bitwise operations work as expected.
- **Control Flow**: Jump, Jump-if, and Halt instructions are verified for correct functionality.

## Lint and CDC Verification

### Lint Goals:
- **lint_rtl**: Ensures basic connectivity and simulation correctness.
- **lint_rtl_enhanced**: Covers additional structural and synthesis checks.

**Errors Encountered:**
- **Large Bus Handling**: The program and data memory have a large bus width (12-bit address). This was resolved by setting `handle_large_bus yes`.
- **mthresh**: The memory size required adjusting the threshold in Spyglass using `set_option mthresh` for lint correctness.

### Clock Domain Crossing (CDC)
- CDC issues are no longer applicable since the system operates on a single 150 MHz clock.

## FPGA Synthesis and Deployment

- **Data Memory Issue**: Initially, using two enable signals caused the memory to be inferred as distributed RAM, leading to high FPGA resource usage. The solution was to simplify the design to use only one enable signal (`mem_write`), resulting in the memory being inferred as Block RAM.

- **JMP_IF Instruction**: A loop-based instruction was implemented for scenarios like repeated addition, enabling conditional branching based on register comparisons.

## How to Run the Project

1. **Clone the repository**:
   ```bash
   git clone <repository-url>
