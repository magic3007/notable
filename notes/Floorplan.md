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

 <img src="./Floorplan.assets/image-20200621104454905.png" alt="image-20200621104454905" /> 

 <img src="./Floorplan.assets/image-20200621134402443.png" alt="image-20200621134402443" /> 

## Normalized Polish Expression: Representation of Slicing Floorplan

- <u>Skewed Slicing Tree</u>
  - no node and its right son are the same.

- <u>Normalized Polish Expression</u>
  - no consecutive H’s or V’s in polish expression
  - what is a valid NPE?
    - operand: +1; operator -1; any prefix sum is greater or equal to zero.
  - Normalized polished expression can be formulated as a state space search problem.
- There is a 1-1 correspondence between Slicing Floorplan, Skewed Slicing Tree, and Normalized Polish Expression.

 <img src="./Floorplan.assets/image-20200621104805562.png" alt="image-20200621104805562" /> 

#### Neighborhood Structure

 <img src="./Floorplan.assets/image-20200621105602433.png" alt="image-20200621105602433" /> 

 <img src="./Floorplan.assets/image-20200621105619674.png" alt="image-20200621105619674" /> 

### Combining Shape Curves

 <img src="./Floorplan.assets/image-20200621110609005.png" alt="image-20200621110609005" /> 

 <img src="./Floorplan.assets/image-20200621110622210.png" alt="image-20200621110622210" /> 

### One Algorithm: Annealing Schedule

 <img src="./Floorplan.assets/image-20200621110959081.png" alt="image-20200621110959081" /> 

## How to handle L-shaped blocks?

 <img src="./Floorplan.assets/image-20200621112846634.png" alt="image-20200621112846634" /> 

Differences

- Another 5 operators and 4 moves defined to handle the more complex shapes

  - ~, V1, V2, H1, H2

- Idea of shape curves no longer applicable

- Depend on Simulated Annealing to pick different shapes for blocks probabilistically

 <img src="./Floorplan.assets/image-20200621114947623.png" alt="image-20200621114947623" /> 

 <img src="./Floorplan.assets/image-20200621115227532.png" alt="image-20200621115227532" /> 

 <img src="./Floorplan.assets/image-20200621115631308.png" alt="./image-20200621115631308" /> 

 <img src="./Floorplan.assets/image-20200621115906813.png" alt="image-20200621115906813" /> 

### Dynamic Programming

 <img src="./Floorplan.assets/image-20200621122952010.png" alt="image-20200621122952010" /> 

## Mixed Integer Linear Program

### Formulation with Hard Blocks

 <img src="./Floorplan.assets/image-20200621132732658.png" alt="image-20200621132732658" /> 

### Formulation with Soft Blocks

 <img src="./Floorplan.assets/image-20200621133005013.png" alt="image-20200621133005013" /> 

 <img src="./Floorplan.assets/image-20200621134134886.png" alt="image-20200621134134886" /> 

## Successive Augmentation

 <img src="./Floorplan.assets/image-20200621134323914.png" alt="image-20200621134323914" /> 

## Sequence-Pair Representation: General(non-slicing) floorplans representations

- Positive Locus
  - center of each block -> move right -> move up -> …
  - center of each block -> move left -> move down -> …
- Negative Locus
  - center of each block -> move down -> move right -> …
  - center of each block -> move up -> move left -> …

 <img src="./Floorplan.assets/image-20200621135004214.png" alt="image-20200621135004214" /> 

 <img src="./Floorplan.assets/image-20200621135234767.png" alt="image-20200621135234767" /> 

 <img src="./Floorplan.assets/image-20200621135302883.png" alt="image-20200621135302883" /> 

 <img src="./Floorplan.assets/image-20200621135525953.png" alt="image-20200621135525953" /> 

- Given a sequence-pair, the placement with smallest area can be found in $O(n^2)$ time.
- Algorithms of time $O(n\log \log n)$ or $O(n \log n)$ exist. But faster than $O(n^2)$ algorithm only when $n$ is quite large.

### Floorplan Realization

> How to construct a floorplan from a sequence pair?

We can make use of the horizontal and vertical constraint graphs ($G_h$ and $G_v$).

 <img src="./Floorplan.assets/image-20200621140903092.png" alt="image-20200621140903092" /> 

 <img src="./Floorplan.assets/image-20200621141430407.png" alt="image-20200621141430407" /> 

 <img src="./Floorplan.assets/image-20200621141448352.png" alt="image-20200621141448352" /> 

 <img src="./Floorplan.assets/image-20200621141828379.png" alt="image-20200621141828379" /> 

 <img src="./Floorplan.assets/image-20200621141859440.png" alt="image-20200621141859440" /> 