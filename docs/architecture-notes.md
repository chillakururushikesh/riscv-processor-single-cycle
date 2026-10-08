# RISC-V Single-Cycle Processor Architecture Notes

## Datapath Flow

For a **RISC-V Single-Cycle Processor**, instructions flow through all stages in one clock cycle:

### Instruction Fetch (IF)
- PC drives instruction memory
- Instruction retrieved from memory
- PC+4 calculated in parallel

### Instruction Decode (ID)
- Opcode extracted from instruction
- Control signals generated (RegWrite, MemRead, MemWrite, etc.)
- Immediate value sign-extended and generated
- Register file reads both operands (rs1, rs2)

### Execute (EX)
- ALU performs computation
- Branch/jump target calculated
- For branches: ALU computes (rs1 - rs2), zero flag indicates equality

### Memory (MEM)
- For load: data memory returns data word
- For store: data memory writes data word
- For ALU operations: ALU result passes through

### Write Back (WB)
- Write-back multiplexer selects between:
  - ALU result (for R-type, I-type)
  - Memory data (for load instructions)
  - PC+4 (for JAL instruction)
- Selected data written to register file (rd)

## Control Signals

| Instruction | RegWrite | MemRead | MemWrite | ALUSrc | MemToReg | Branch | Jump |
|--------------|----------|---------|----------|--------|----------|--------|------|
| R-type       | 1        | 0       | 0        | 0      | 0        | 0      | 0    |
| I-type ALU   | 1        | 0       | 0        | 1      | 0        | 0      | 0    |
| Load         | 1        | 1       | 0        | 1      | 1        | 0      | 0    |
| Store        | 0        | 0       | 1        | 1      | x        | 0      | 0    |
| Branch       | 0        | 0       | 0        | 0      | x        | 1      | 0    |
| JAL          | 1        | 0       | 0        | x      | 0        | 0      | 1    |

## Timing Considerations

**Single-cycle design constraint:** The clock period must be long enough for:
1. Instruction memory access (longest latency)
2. Register file read
3. ALU operation
4. Data memory access
5. Register file setup time

This limits the maximum clock frequency compared to pipelined designs.

## Supported Instructions

### Arithmetic (R-type)
- ADD, SUB, SLL, SRL, SRA, AND, OR, XOR
- SLT (signed), SLTU (unsigned)

### Immediate (I-type)
- ADDI, ANDI, ORI, XORI
- SLLI, SRLI, SRAI
- SLTI, SLTIU
- LW (load word)

### Store (S-type)
- SW (store word)

### Branch (B-type)
- BEQ, BNE, BLT, BGE, BLTU, BGEU

### Jump (J-type)
- JAL (jump and link)

## Potential Enhancements

1. **Pipeline** → 5-stage pipeline for improved throughput
2. **Forwarding** → Handle data hazards in pipelined design
3. **Hazard Detection** → Stall on load-use hazards
4. **Cache** → Instruction/data caches for faster memory access
5. **Branch Prediction** → Reduce branch penalties

