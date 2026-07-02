# 5-Stage Pipelined RISC-V Processor in Verilog

A 32-bit **5-stage pipelined RISC-V processor** designed in Verilog HDL based on the architecture presented in *Digital Design and Computer Architecture: RISC-V Edition* by Sarah Harris and David Harris.

The processor implements the classic **IF-ID-EX-MEM-WB** pipeline and includes **data forwarding**, **hazard detection**, and **branch flushing** to ensure correct execution of dependent and control-flow instructions.

---

## Features

- 32-bit RV32I-based architecture
- Five-stage instruction pipeline
  - Instruction Fetch (IF)
  - Instruction Decode (ID)
  - Execute (EX)
  - Memory Access (MEM)
  - Write Back (WB)
- Separate Instruction and Data Memory
- 32 × 32-bit Register File
- Immediate Generation Unit
- ALU supporting:
  - ADD
  - SUB
  - AND
  - OR
  - SLT
- Branch Target Address Generation
- PC Update Logic
- Pipeline Registers
  - IF/ID
  - ID/EX
  - EX/MEM
  - MEM/WB
- Forwarding Unit for ALU data hazards
- Hazard Detection Unit
- Branch Flush Mechanism
- Load-use hazard stalling
- Simulation verified using Xilinx Vivado

---

## Supported Instructions

### R-Type
- ADD
- SUB
- AND
- OR
- SLT

### I-Type
- ADDI
- LW

### S-Type
- SW

### B-Type
- BEQ

### J-Type
- JAL

---

## Pipeline Organization

```
               +------------------+
               | Instruction Fetch|
               +------------------+
                        │
                     IF/ID
                        │
               +------------------+
               | Instruction Decode|
               +------------------+
                        │
                     ID/EX
                        │
               +------------------+
               | Execute Stage    |
               +------------------+
                        │
                    EX/MEM
                        │
               +------------------+
               | Memory Stage     |
               +------------------+
                        │
                    MEM/WB
                        │
               +------------------+
               | Write Back       |
               +------------------+
```

---

## Hazard Handling

### Data Hazards
A forwarding unit resolves most RAW dependencies by forwarding operands from:

- EX/MEM stage
- MEM/WB stage

### Load-Use Hazards
A dedicated Hazard Detection Unit inserts a single pipeline bubble whenever forwarding alone cannot resolve a dependency.

The unit generates:

- StallF
- StallD
- FlushE

to correctly stall the pipeline.

### Control Hazards
Branches and jumps are resolved in the Execute stage.

When a branch is taken:

- Decode stage is flushed
- Execute stage is flushed
- Program Counter is redirected to the branch target

---

## Verification

The processor was validated using multiple assembly test programs covering:

- Independent arithmetic instructions
- ALU forwarding
- Store forwarding
- Load-use hazard detection
- Branch flushing
- Jump (JAL) execution
- Memory read/write operations

Waveforms were analyzed in Xilinx Vivado to verify:

- Pipeline progression
- Forwarding paths
- Hazard detection
- Branch handling
- Register write-back
- Memory operations

---

## Project Structure

```
├── ALU
├── Register File
├── Instruction Memory
├── Data Memory
├── Program Counter
├── Immediate Generator
├── Control Unit
├── Main Decoder
├── ALU Decoder
├── Hazard Detection Unit
├── Forwarding Unit
├── IF_ID Register
├── ID_EX Register
├── EX_MEM Register
├── MEM_WB Register
├── Datapath
├── Top Processor
└── Testbench
```

---

## Tools Used

- Verilog HDL
- Xilinx Vivado
- VS Code
- GTKWave (during initial development)

---

## Future Improvements

- Complete RV32I Instruction Set Support
- Branch Prediction
- Memory-Mapped Peripheral Support
- UART Interface
- Timer and Interrupt Support
- AES Encryption Coprocessor
- Secure RISC-V System-on-Chip (SoC)

---

## References

- David Harris & Sarah Harris, *Digital Design and Computer Architecture: RISC-V Edition*
- RISC-V Unprivileged ISA Specification

---

## Author

**Y. Shiva Rao**

B.Tech Electronics and Communication Engineering  
National Institute of Technology Silchar
