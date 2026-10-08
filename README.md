# riscv-processor-single-cycle

A 32-bit single-cycle RISC-V processor implemented in Verilog with complete datapath and control logic.

## Overview
This project implements a simple but complete single-cycle RISC-V processor where each instruction is executed in a single clock cycle. The design includes:
- Instruction fetch from memory
- Instruction decode with immediate generation
- Register file with read/write operations
- Arithmetic-Logic Unit (ALU) with comprehensive instruction support
- Data memory for load/store operations
- Control unit for instruction routing
- Branch and jump target calculation

## Architecture
The single-cycle processor follows a classic 5-stage datapath (all within one cycle):
1. **Instruction Fetch (IF)** — PC → Instruction Memory → Instruction
2. **Instruction Decode (ID)** — Decode opcode, extract fields, generate immediate
3. **Execute (EX)** — ALU operations with forwarding
4. **Memory (MEM)** — Data memory read/write for load/store instructions
5. **Write Back (WB)** — Write results back to register file

Since all stages complete in one clock cycle, there are no pipeline hazards or forwarding units needed.

## Features
- 32-bit integer datapath
- Comprehensive RISC-V instruction support:
  - **R-type:** ADD, SUB, AND, OR, XOR, SLL, SRL, SRA, SLT, SLTU
  - **I-type:** ADDI, ANDI, ORI, XORI, SLTI, SLTIU, SLLI, SRLI, SRAI
  - **Load/Store:** LW, SW
  - **Branch:** BEQ, BNE, BLT, BGE, BLTU, BGEU
  - **Jump:** JAL, JALR (partial)
- Single-cycle execution
- Register file with 32 registers (x0–x31)
- Data memory (256 words)
- Instruction memory loaded from file (program.mem)

## Repository Structure
```
.
├── README.md
├── rtl/
│   ├── ALU.v                    # Arithmetic-Logic Unit
│   ├── ALU_CONTROL.v            # ALU control decoder
│   ├── ALU_SRC_MUX.v            # Operand B selector (immediate vs reg)
│   ├── BRANCH_TARGET.v          # Branch target calculation
│   ├── CONTROL_UNIT.v           # Main control unit
│   ├── DATA_MEMORY.v            # Data memory (load/store)
│   ├── IMM_GENERATOR.v          # Immediate value extractor
│   ├── INSTRUCTION_MEMORY.v     # Instruction memory
│   ├── JUMP_TARGET.v            # Jump target calculation
│   ├── PC.v                     # Program counter
│   ├── PCPLUS4.v                # PC+4 adder
│   ├── REG_FILE.v               # 32-register file
│   └── WRITEBACK_MUX.v          # Write-back data selector
├── testbench/
│   └── (testbench files can be added here)
└── docs/
    └── (architecture notes can be added here)
```

## Module Description

### PC (Program Counter)
Manages the program counter with reset and next PC input.

### Instruction Memory
Reads instructions from `program.mem` file using `$readmemh` directive.

### Register File
- 32 registers (x0–x31)
- Dual-read, single-write ports
- x0 is hardwired to 0

### Immediate Generator
Extracts and sign-extends immediate values based on instruction format (I-type, S-type, B-type, U-type, J-type).

### ALU
Performs arithmetic, logical, and comparison operations:
- ADD, SUB
- AND, OR, XOR
- SLL, SRL, SRA
- SLT, SLTU

### Control Unit
Decodes the opcode and sets control signals for:
- RegWrite, MemRead, MemWrite
- ALUSrc, MemToReg
- Branch, Jump signals

### Data Memory
Reads/writes 32-bit data words for load/store instructions.

## Simulation

To simulate this design using **Icarus Verilog**:

```bash
# Compile all RTL files
iverilog -g2012 -o riscv_single_cycle rtl/*.v testbench/*.v

# Run simulation
vvp riscv_single_cycle

# View waveform (if testbench generates VCD)
gtk wave dump.vcd
```

## Prerequisites
- **Icarus Verilog** (iverilog)
- **GTKWave** (for viewing waveforms)
- **program.mem** file with RISC-V instructions in hexadecimal format

## Example program.mem
```hex
00A00093  // addi x1, x0, 10
00A00113  // addi x2, x0, 10
00208663  // beq x1, x2, target
06400193  // addi x3, x0, 100 (skipped if branch taken)
03200293  // addi x5, x0, 50 (target)
```

## Status
This repository represents the foundational single-cycle RISC-V processor implementation and is intended as a learning project for understanding basic CPU architecture and digital hardware design.

## Author
RUSHIKESH CHILLAKUR
