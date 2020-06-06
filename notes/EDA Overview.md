---
tags: [EDA]
title: EDA Overview
created: '2020-06-06T06:50:16.207Z'
modified: '2020-06-06T14:12:57.117Z'
---

# EDA Overview

[TOC]

**physical design cycle**

 <img src="./EDA Overview.assets/image-20200606145657435.png" alt="image-20200606145657435" /> 

- Floorplan: Details like shapes of blocks, I/O pin positions, etc. are not yet fixed (blocks with flexible shape are called soft blocks)
- Placement: Details like module shapes and I/O pin positions are fixed (blocks with no flexibility in shape are called hard blocks).


> <u>Optical Proximity Correction(OPC)</u> 
> && OPC-Aware Routing

OPC is a photolithography enhancement technique commonly used to compensate for image errors due to diffraction or process effects.

 <img src="./EDA Overview.assets/image-20200606150728990.png" alt="image-20200606150728990" /> 

 <img src="./EDA Overview.assets/image-20200606151003675.png" alt="image-20200606151003675" /> 



**Basic Knowledge of Circuit***

Some explanations about PMOS & NMOS could be viewed at[What is the difference between NMOS, PMOS and CMOS transistors?](https://www.quora.com/What-is-the-difference-between-NMOS-PMOS-and-CMOS-transistors)

|      | Illustration                                                 | Remark                  |
| ---- | ------------------------------------------------------------ | ----------------------- |
| NMOS |  <img src="./EDA Overview.assets/image-20200606153126752.png" alt="image-20200606153126752" />  | high voltage -> conduct |
| PMOS |  <img src="./EDA Overview.assets/image-20200606153009228.png" alt="image-20200606153009228" />  | low voltage -> conduct  |

- VDD: Voltage Drain Drain

- VSS: Voltage Source Source



**Comparisons of Design Styles**

- full custom design style
- standard cell design style
- Gate Array Design style
- FPGA Design Style

 <img src="./EDA Overview.assets/image-20200606161956731.png" alt="image-20200606161956731" /> 



