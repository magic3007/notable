---
tags: [Notebooks/Compiler]
title: Code Optimization
created: '2020-06-05T13:29:28.392Z'
modified: '2020-06-05T13:29:34.060Z'
---

# Machine-Independent Optimization

[TOC]

### Global Common Subexpressions

 <img src="./Machine-Independent Optimization.assets/image-20200605214230239.png" alt="image-20200605214230239" /> 

### Copy Propagation

[]

### Dead-Code Elimination

[]

copy-propagation may result in dead code.

### Code Motion

 <img src="./Machine-Independent Optimization.assets/image-20200605220633879.png" alt="image-20200605220633879" /> 

### Induction Variables and Reduction in Strength

[]

## Data-flow Analysis

In a flow graph, if every path from entry to n contains d, **then d dominates n (d DOM n)** 

**D(n) = {d | d dominates n}** 

- a DOM b, b DOM a => a = b 

- a DOM b, b DOM c => a DOM c

Therefore, DOM is a partial order.

> How to get the domination set?
>
> D(n) = {n} + intersect{D{p} | p in P(n)}

<u>back edge</u>: n->d, d DOM n

<u>loop</u>: if t->h is a back edge, the loop contains v iff there exists a path from v to t but not containing h 

[]

<u>reducible graph</u>: after remove all the back edges, the graph doesn't contain loop path 

irreducible example:

 <img src="./Machine-Independent Optimization.assets/image-20200605215836585.png" alt="image-20200605215836585" /> 



<u>data-flow graph</u>:

​	program point

​	path: execution path



<u>reaching</u>:

definition: lhs of =

use: rhs of =

a definition reaches a use if the value written by definition may be read by use

 <img src="./Machine-Independent Optimization.assets/image-20200605221227108.png" alt="image-20200605221227108" /> 

### Constant Propagation

Check all the reaching definitions.

If all assign variable to the same constant 

Then use is in fact a constant 

 <img src="./Machine-Independent Optimization.assets/image-20200605221337934.png" alt="image-20200605221337934" /> 



<u>Splitting approach</u>:

If two definitions assign variable to the same constant, we split the definitions, duplicate the code, then apply constant propagation 

 <img src="./Machine-Independent Optimization.assets/image-20200605221444471.png" alt="image-20200605221444471" /> 



### Reaching Definitions

> Computing Reaching Definitions

- use bit vectors to represent all the definitions

- At each basis block, compute the definitions the reach start of block and end of block.

- Do computation by simulating execution of program until reach <u>fixed point</u>.

   <img src="./Machine-Independent Optimization.assets/image-20200605222223598.png" alt="image-20200605222223598" /> 

<u>data-flow value</u>: at every program point(bit vector)

Domain: the set of possible data-flow values for this application

IN[s] and OUT[S]: the data-flow values before and after each statement s



constraints:

- <u>Transfer Function</u>: relationship between the data-flow values before and after a statement
  - Forward: OUT[s] = f(IN[S])
  - Backward: IN[S] = f(OUT[s])

within a basic block, OUT[S_i] = IN[S_i+1]

 <img src="./Machine-Independent Optimization.assets/image-20200605222730893.png" alt="image-20200605222730893" /> 

 <img src="./Machine-Independent Optimization.assets/image-20200605222832231.png" alt="image-20200605222832231" /> 

 <img src="./Machine-Independent Optimization.assets/image-20200605223110475.png" alt="image-20200605223110475" /> 

 <img src="./Machine-Independent Optimization.assets/image-20200605223227758.png" alt="image-20200605223227758" /> 

 <img src="./Machine-Independent Optimization.assets/image-20200605223420817.png" alt="image-20200605223420817" /> 



### Available Definitions

 <img src="./Machine-Independent Optimization.assets/image-20200605224049669.png" alt="image-20200605224049669" /> 

 <img src="./Machine-Independent Optimization.assets/image-20200605224255800.png" alt="image-20200605224255800" /> 

 <img src="./Machine-Independent Optimization.assets/image-20200605224503780.png" alt="image-20200605224503780" /> 

 <img src="./Machine-Independent Optimization.assets/image-20200605224811724.png" alt="image-20200605224811724" /> 

### Live Variables

 <img src="./Machine-Independent Optimization.assets/image-20200605225409548.png" alt="image-20200605225409548" /> 

 <img src="./Machine-Independent Optimization.assets/image-20200605225512105.png" alt="image-20200605225512105" /> 



 <img src="./Machine-Independent Optimization.assets/image-20200605222851941.png" alt="image-20200605222851941" /> 

 <img src="./Machine-Independent Optimization.assets/image-20200605223831058.png" alt="image-20200605223831058" /> 