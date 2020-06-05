---
tags: [Notebooks/Compiler]
title: Code Generation
created: '2020-05-21T06:37:22.764Z'
modified: '2020-05-21T06:37:38.593Z'
---

# Code Generation

[TOC]

<u>target code form</u>

- absolute machine-language program
- relocatable machine-language program
- assembly-language program



<u>instruction cost</u>

| LD R0, R1       | 1    |
| --------------- | ---- |
| LD R0, M        | 2    |
| LD R1, *100(R2) |      |



## flow graph

<u>basic block</u>

- can only be entered at the first instruction

- and left at the last one

  > how to divide basic block?

  <img src="./Code Generation.assets/1590043864093.png" alt="1590043864093" style="zoom:67%;" />

 <img src="./Code Generation.assets/1590043887043.png" alt="1590043887043" /> 

 <img src="./Code Generation.assets/1590043917000.png" alt="1590043917000" /> 

 <img src="./Code Generation.assets/1590044026856.png" alt="1590044026856" /> 

<u>control flow graph</u> = basic block + edge

<u>entry</u>: first instruction

<u>exit</u>: from any basic block that may exit



<u>loop</u>: a set of nodes L in a flow graph is a _loop_ if L contains a node _e_ called loop _entry_, such that

 <img src="./Code Generation.assets/1590044370133.png" alt="1590044370133" /> 



**Next-Use Information**

 <img src="./Code Generation.assets/1590044695832.png" alt="1590044695832" /> 

> How to determining the liveness and next-use information for each statement in a basic block?

 <img src="./Code Generation.assets/1590044951706.png" alt="1590044951706" /> 

 <img src="./Code Generation.assets/1590044967785.png" alt="1590044967785" /> 

 <img src="./Code Generation.assets/1590044904694.png" alt="1590044904694" /> 



### DAG Representation of Basic Blocks

input nodes: initial values of the variables 

output nodes: *live on exit* from the block

 <img src="./Code Generation.assets/1590045371496.png" alt="1590045371496" /> 

#### local common subexpressions

 <img src="./Code Generation.assets/1590045487412.png" alt="1590045487412" /> 

#### Dead Code Elimination

 <img src="./Code Generation.assets/1590045650967.png" alt="1590045650967" /> 

#### Algebraic Identity

x + 0 = 0 + x = x

find special patterns on DAG

####  Representation of Array References

- _x=[i]_ : assignment from an array
- _a[j]=y_ : assignment to an array; **kill** all currently constructed nodes whose values depends on $a$. A node that has been killed cannot receive any more labels; that is, it cannot become a common expression.

 <img src="./Code Generation.assets/1590046818599.png" alt="1590046818599" /> 

 <img src="./Code Generation.assets/1590047248067.png" alt="1590047248067" /> 

####  Pointer Assignments and Procedure Calls

- _x=*p_ : assignment from pointer, may use any variable; cannot be eliminated
  - take all currently constructed nodes as arguments
- _*q=y_ : assignment to pointer, may assign to any variable
  - kill all constructed nodes

procedure call: take all currently constructed nodes as arguments + kill all constructed nodes

####  Reassembling Basic Blocks From DAG's

 <img src="./Code Generation.assets/1590047776305.png" alt="1590047776305" /> 

 <img src="./Code Generation.assets/1590047785594.png" alt="1590047785594" /> 

 That is, when reordering code, no statement may cross a procedure call or assignment through a pointer, and uses of the same array may cross each other only if both are array accesses, but not assignments to elements of the array.  

 <img src="./Code Generation.assets/1590047875816.png" alt="1590047875816" /> 

## Register & Address Descriptor

 <img src="./Code Generation.assets/image-20200529191514003.png" alt="image-20200529191514003" /> 

 <img src="./Code Generation.assets/image-20200529220007448.png" alt="image-20200529220007448" /> 

 <img src="./Code Generation.assets/image-20200529220140465.png" alt="image-20200529220140465" /> 

### Peephole Optimization

examining a sliding window 

replacing within the peephole by a shorter or faster sequence

#### Eliminating Redundant Loads and Stores

```
LD R0 a
ST a R0
```

#### Eliminating Unreachable Code

#### Flow-of-Control Optimizations

```
goto L1  

...  

Ll: goto L2  

 
goto L1 

... 

L1: if a < b goto L2 

L3 

=> 

if a < b goto L2 

goto L3 
```

#### Algebraic Simplification and Reduction in Strength

#### Use of Machine Idioms

```
a = a + 1 => inc a
```

### Register Allocation

spilling

 <img src="./Code Generation.assets/image-20200529221712036.png" alt="image-20200529221712036" /> 



**register-interference graph (RIG)**

- def-use chain

  - put def and use of the same variable into a **web** 
  - **web** is the unit of register allocation 

   <img src="./Code Generation.assets/image-20200529222545969.png" alt="image-20200529222545969" /> 

- convex set 
  - any a, b in S, every c on the path from a to b, c is in S 

- live range
  - the smallest convex set containing def and use 

- interfere
  - the live ranges of two webs intersect 



whether a graph is k-colorable is NPC 



 <img src="./Code Generation.assets/image-20200529223256375.png" alt="image-20200529223256375" /> 

 <img src="./Code Generation.assets/image-20200529223734648.png" alt="image-20200529223734648" /> 

precolored nodes 

eax, ecx, edx 

 

coalesce 

merge two variables(nodes) 