---
tags: [Notebooks/Architecture]
title: RISCV ISA
created: '2020-03-08T16:39:20.709Z'
modified: '2020-03-09T04:53:50.834Z'
---

# RISCV ISA

[TOC]

## References

- [The RISC-V Instruction Set Manual - RISC-V Foundation](https://content.riscv.org/wp-content/uploads/2017/05/riscv-spec-v2.2.pdf)

## Instruction Length Encoding

 <img src="./RISCV ISA.assets/image-20200309125427064.png" alt="image-20200309125427064" /> 

## Register State

- 31 general-purpose registers `x0(zero)`, `x1-x31` plus `pc`
- `XLEN` equals to 32(RV32I) or 64(RV64I)

<img src="./RISCV ISA.assets/image-20200309125618598.png" alt="image-20200309125618598" style="zoom:67%;" />

## Base Instruction Formats

 <img src="./RISCV ISA.assets/image-20200309125810314.png" alt="image-20200309125810314" /> 

*features*:

1. As for RV32I, sign extension always uses $inst[31]$.

### Control Transfer INstructions

#### Unconditional Jumps

- PC-relative address jump: jump and link (`JAL`) instruction uses J-type format
  - the offset is sign-extended and added to <u>current</u> `PC` to obtain target address
- indirection jump: jump and link register(`JALR`) instruction uses I-type format. 
  - the target address is obtained by adding imm and register
  - *Note that `JALR` don’t treat 12-bit imm as multiaples of 2 bytes*

 <img src="./RISCV ISA.assets/image-20200309132628639.png" alt=" image-20200309132628639" /> 

 <img src="./RISCV ISA.assets/image-20200309133308578.png" alt="image-20200309133308578" /> 

- Both `JAL` and `JALR` store the address of the instruction following the jump, namely `PC+4` into register `rd`

  - `rd=x0`: never return

  - `rd=x1/x5`: for standard software calling convention, uses `x1` as the return address register and `x5` as an alternate link register

    > **alternative link register**
    >
    > - The alternate link register `x5` supports calling millicode routines (e.g., those to save and restore registers in compressed code) while preserving the regular return address register `x1`
    > - See more Info in: https://stackoverflow.com/questions/44556354/jal-what-is-the-alternate-link-register-x5-for

> **Return-address Predcition Stack(RAS)**
>
> For RISC-V, hints as to the instructions’ usage are encoded implicitly via <u>the register numbers used</u>.
>
> - `JAL` : push the return address onto RAS only when `rd=x1/x5`
>
> - `JALR`: push/pop a RAS as shown following:
>
>    <img src="./RISCV ISA.assets/image-20200309134453544.png" alt="image-20200309134453544" /> 

## Memory Model

`FENCE` instruction: guarantee ordering between memory operations from diﬀerent RISCV harts

## Control & Status Register (CSR) Instructions

**SYSTEM** instructions, which are defined to allow simpler implementations to always <u>trap</u> to a single software trap handler, consist of

- CSR: CSRs could be devided into two main classes:
  - atomically read-modify-write CSR
  - other potentially privileged instructions, like timer and counter
- Environment Call `ECALL`:  used to make a request to the supporting execution environment, which is usually an operating system, like `int 0x80` in x86.
- Breakpoint `EBREAK`: used by debuggers to cause control to be transferred back to a debugging environment
