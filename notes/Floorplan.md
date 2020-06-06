---
tags: [EDA]
title: Floorplan
created: '2020-06-06T14:02:13.020Z'
modified: '2020-06-06T14:02:21.133Z'
---

# Floorplan

[TOC]

## Problem Statement & Object Function

 <img src="./Floorplan.assets/image-20200606221656021.png" alt="image-20200606221656021" /> 

 <img src="./Floorplan.assets/image-20200606221801704.png" alt="image-20200606221801704" /> 

- Exact wirelength of each net is not known until routing is done.
- In floorplanning, even pin positions are not known yet.
- Some possible wirelength estimations
  - Center-to-center estimation
  - Half-perimeter estimation

 <img src="./Floorplan.assets/image-20200606221932804.png" alt="image-20200606221932804" /> 



<u>Dead Space</u>: the space that is wasted



Slicing Floorplan & Non-Slicing Floorplan

|                           | Remark                                                       | Illustration                                                 |
| ------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| Slicing Floorplan(easier) | One that can be obtained by repetitively subdividing (slicing) rectangles horizontally or vertically. |  <img src="./Floorplan.assets/image-20200606222228363.png" alt="image-20200606222228363" />  |
| Non-Slicing Floorplan     | One that may not be obtained by repetitively subdividing alone. |  <img src="./Floorplan.assets/image-20200606222238655.png" alt="image-20200606222238655" />  |

## Polar Graph Representation

*Note: There are many other graph representations.*

- Each floorplan is modeled by a pair of directed acyclic graphs: Horizontal polar graph && Vertical polar graph

- For horizontal (vertical) polar graph
  - Vertex: Vertical (horizontal) channel
  - Edge: 2 channels are on 2 sides of a block
  - Edge weight: Width (height) of the block