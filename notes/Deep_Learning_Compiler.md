---
title: Deep Learning Compiler
created: '2020-02-06T12:24:31.075Z'
modified: '2020-02-28T03:17:07.699Z'
---

# Algorithm-Hardware Co-Design for Machine Learning Acceleration

[TOC]

## Deep Learning Compiler

### toolkits

- Halide IR: used by TVM
- Marlin C backend: use OpenMP-like pragma; could generate both HLS C kernels and OpenCL kernels
- Stencil Back End: `SODA` framework takes in a lightweight DSL that describes the stencil compute patterns and design parameters
- Systolic Array Back End: generates annotated HLS C++ code as an input to the `PolySA` framework  

### Paper Script

| Paper Title                                                  | Tag                                 | Abstract & Contribution                                      | First Author               |
| ------------------------------------------------------------ | ----------------------------------- | ------------------------------------------------------------ | -------------------------- |
| [HeteroCL: A Multi-Paradigm Programming Infrastructure for Sofware-Defined Reconfigurable Computing](https://zhang.ece.cornell.edu/proj.html) | `FPGA2019 ` `complier` `best paper` | leverage stencil(`SODA` framework) and systolic array(`PolySA`  framework) as backend | Yi-Hsiang Lai, Zhiru Zhang |
|                                                              |                                     |                                                              |                            |
|                                                              |                                     |                                                              ||

