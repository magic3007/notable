---
tags: [Notebooks/Compiler]
title: Liveness Analysis Algorithm
created: '2020-06-09T07:37:55.867Z'
modified: '2020-06-09T07:38:04.225Z'
---

# Liveness Analysis Algorithm

[TOC]

## Resource

- *Modern Compiler Implementation in Java (2nd edition)* [[pdf]](https://eden.dei.uc.pt/~amilcar/pdf/CompilerInJava.pdf)

## Liveness Dataflow Equations

Determining the live range of each variable is an example of a dataflow problem. 

**Uses & Defs**:

- def: lhs of ‘=’

- use: rhs of ‘=’

Flow-graph nodes that have only one predecessor and one successor are not very interesting. We can merge some statements into a *basic block*.

A variable is *live on an edge* if there is a directed path from that edge to a *use* of the variable that does not go through any *def*.

A variable is *live-in* at a node if it is *live* on an node if it is live on any of the in-edges; it is *live-out* at a node if it is live on any of the out-edges of the node.

Liveness information (*live-in* and *live-out*) can be calculated from *use* and *def* as follows: 

 <img src="./Liveness Analysis Algorithm.assets/image-20200609155315257.png" alt="image-20200609155315257" /> 

 <img src="./Liveness Analysis Algorithm.assets/image-20200609155329758.png" alt="image-20200609155329758" /> 



> Whether can the compiler fully understand how all the control flow in every flow in every program will work?

Actually, this is a fundamental mathematical theorem, derivable from the halting problem.

 <img src="./Liveness Analysis Algorithm.assets/image-20200609161845315.png" alt="image-20200609161845315" /> 

 <img src="./Liveness Analysis Algorithm.assets/image-20200609162447135.png" alt="image-20200609162447135" /> 

<u>Dynamic liveness</u>: A variable a is dynamically live at node n if some execution
of the program goes from n to a use of a without going through any definition
of a.

<u>Static liveness</u>: A variable a is statically live at node n if there is some path
of control-flow edges from n to some use of a that does not go through a
definition of a. 

## Interference Graph

the way to add interference edges for each new definition is

 <img src="./Liveness Analysis Algorithm.assets/image-20200609163443129.png" alt="image-20200609163443129" /> 