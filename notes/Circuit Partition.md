---
tags: [EDA]
title: Circuit Partition
created: '2020-06-06T06:44:50.089Z'
modified: '2020-06-06T06:45:25.619Z'
---

# Circuit Partition

[TOC]

## Circuit Representation

> Terminology
>
> - Bi-partitioning: 2-way partitioning
> - Bi-sectioning: Bi-partitioning such that the two partitions have the same size

 <img src="./Circuit Partition.assets/image-20200606162710622.png" alt="image-20200606162710622" /> 

Bi-partitioning formulation:

|                   |                              |
| ----------------- | ---------------------------- |
| minimum cut       | min c(x,x’)                  |
| minimum bisection | min c(x,x’) st. \|x\|=\|x’\| |
| minimum ratio-cut | min c(x,x’)/\|x\|\|x’\|      |

**general multi-way partitioning formulation**

Suppose partitioning a network $N$ into $N_1$, $N_2$, … $N_k$ such that

- Each partition has an area constraint
  $$
  \sum_{v \in N_i}a(v) \leq A_i
  $$

- Each partition has an IO constraint
  $$
  c(N_i, N - N_i) \leq _i
  $$
  Minimize the total interconnection(bottleneck of delay):
  $$
  \sum_{N_i}c(N_i, N-N_i)
  $$
  
## Partitioning Algorithms

 **summary & break points**:

- Iterative partitioning algorithms
  - greedy iterative improvement method
    - [Kernighan-Lin 1970]
    - [Fiduccia-Mattheyses 1982]
    - [krishnamurthy 1984]
  - Simulated Annealing
    - [Kirkpartrick-Gelatt-Vecchi 1983]
    - [Greene-Supowit 1984]
  - Randomness
- Spectral based algorithms
- Net partitioning vs. module partitioning
- Multi-way partitioning
- Multi-level partitioning
- …

### KL(Kernighan-Lin) Algorithm

- Restrictions
  - bi-sectioning
  - works only for 2-terminal nets(each edge has two terminals)
  - all gates are of the same size/area

 <img src="./Circuit Partition.assets/image-20200606164436571.png" alt="image-20200606164436571" /> 

 <img src="./Circuit Partition.assets/image-20200606165715525.png" alt="image-20200606165715525" /> 

Time Complexity

- $O(n^2\log n)$ per pass
- number of passes is usually small

### Fiduccia-Mattheyses(FM) Algorithm

Improvement on KL algorithm

- can handle non-uniform vertex weights(areas)

- allow unbalanced partitions

- extended to handle hypergraphs(each edge can have >3 terminals)

- linear time!

   <img src="./Circuit Partition.assets/image-20200606195124884.png" alt="image-20200606195124884" /> 

Time Complexity

- $O(p)$ per pass
- number of passes is usually small

### Krishnamurthy Algorithm

 <img src="./Circuit Partition.assets/image-20200606200828989.png" alt="image-20200606200828989" /> 

### Simulated Annealing

 <img src="./Circuit Partition.assets/image-20200606210806812.png" alt="image-20200606210806812" /> 

### Multi-level Partition(hMetis)

### Spectral based partition algorithms

- $D$: degree matrix
- $A$: adjacency matrix
- $Q=D-A$: Laplacian matrix(symmetric & sparse)

<u>partition vector</u>:
$$
X=(x_1, \ldots, x_n), s.t. x_{i}=\left\{\begin{array}{ll}
-1 & i \in X \\
1 & i \in X
\end{array}\right.
$$

property:

- minimum cut: $\sum\limits_{(i,j) \in E} (x_i - x_j)^2 = 4C(X,X')$

- $$
  \begin{aligned}
  x^TQx &= \\
  &= x^TDx - x^TAx \\
  &= \sum d_ix_i^2 -\sum A_{ij}x_ix_j \\
  &= \sum d_ix_i^2 -\sum\limits_{(i,j) \in E} 2a_{ij}x_ix_j \\
  &= \sum\limits_{(i,j) \in E} (x_i - x_j)^2
  \end{aligned}
  $$

  According to Courant-Fischer minimax principle, the 2nd smallest eigenvalue, which gives the best linear placement, satisfies
  $$
  \lambda=\min _{x \text { in } s} \frac{x^{T} Q x}{|x|^2}
  $$

  > Block Lanczos Algorithm(computing the second eigenvector)

