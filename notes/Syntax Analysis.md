---
tags: [Notebooks/Compiler]
title: Syntax Analysis
created: '2020-02-18T16:10:46.730Z'
modified: '2020-02-18T16:14:50.119Z'
---

# Syntax Analysis

[TOC]

#### general types parsers for syntax

- universal(Cocke-Younger-Kasami, Earley's algorithm): inefficient
- top-down (implemented by hand, usually LL) 
- bottom-up 



#### syntax error

1. lexical: misspelling
2. syntactic: misplace; { }
3. semantic: type mismatch
4. logical: == or =



#### recovery strategies

| strategies        | memo                                                         |
| ----------------- | ------------------------------------------------------------ |
| Panic-mode        | discard input until synchronizing token (usually ; { } ( ) ) is found. |
| Phrase-level      | perform local correction                                     |
| Error productions | Augment the grammar. Use production to detects               |
| Global correction | Make as few changes as possible. Often too costly to implement |



#### derivation

grammar $G$ -> sentential form -> sentence(no non-terminals)

language $L(G)$: the set consisting of all the sentences by a grammar



#### regular grammar

left regular grammar: only in form

```
A -> a
A -> Ba
```

right regular grammar: only in form

```
A -> a
A -> aB
```

leftmost derivation vs. rightmost derivation

ambiguous: multiple leftmost/rightmost derivation



#### context-free grammar(CFG)

definition: The left hand side of every generation expression must be a single non-terminal symbol.

tips:
- For any context-free grammar there is a parser that takes at most $O(n^3)$ time to parse a string of $n$ terminals. 
- the expressing ability of *CFG* is strong than *regex=DFA=NFA*. 
  - eg. CFG $S \rightarrow aSb | ab$ , its $L(G)=\{a^nb^n|n>0\}$ could not be expressed by regex expression.
- There is no a algorithm that can justify whether a CFG is ambiguous. However, we could give *<u>sufficient conditions</u>* to justify whether a CFG is ambiguous.



#### non-CFG

<img src="Syntax Analysis.assets/image-20200308205251020.png" alt="image-20200308205251020" style="zoom:50%;" />



<img src="Syntax Analysis.assets/image-20200308205327043.png" alt="image-20200308205327043" style="zoom:50%;" />

CFG不能检查标识符的声明是否先于引用, 也不能检查形参和实参个数是否一致(参数个数检查一般放在语义分析阶段)