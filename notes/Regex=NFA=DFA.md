---
tags: [Notebooks/Compiler]
title: Regex=NFA=DFA
created: '2020-02-29T07:47:01.627Z'
modified: '2020-03-08T13:42:29.998Z'
---

# Regex=NFA=DFA

[TOC]

DFA vs. NFA
- DFA has no $\epsilon$ edge
- NFA: one latter -> multi states


### construct DFA from NFA

$\epsilon-closure$ : move along any $\epsilon$ edge, until converging to a closure, such subset is a state in DFA.

<img src="./Regex=NFA=DFA.assets/image-20200308195707448.png" alt="image-20200308195707448" style="zoom:50%;" />

### construct DFA directly from regex expression

*Proof*:

Use mathematical induction to the number of operators in a regex expression.

regex expression $r$ with zero operator: $r=\epsilon$, $r=\empty$, $r=a \in \Sigma$

regex expression r with more than one operators could be separated into interior sub-expressions: or-expression $r= r_1 | r_2$ , concatenating-expression $r=r_1r_2$ and repeating-expression $r=r_1^*$.

QOE.

*features*:

1. the number of state in DFA $\leq$ 2 * the number of operators in regex expression

2. only have one starting state and one ending state

3. except for the ending state, each state either has an non-$\epsilon$ out edge, or has at most two $\epsilon$ out edges.

### minimizing the numbers of states in DFA

![image-20200308200612474](./Regex=NFA=DFA.assets/image-20200308200612474.png)

Time complexity: $O(n\log n)$, where $n$ is the number of states in DFA.

<img src="./Regex=NFA=DFA.assets/image-20200308200729538.png" alt="image-20200308200729538" style="zoom:50%;" />

