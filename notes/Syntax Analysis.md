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



#### context-free grammar

> For any context-free grammar there is a parser that takes at most $O(n^3)$ time to parse a string of $n$ terminals. 



tip:

ambiguous: multiple leftmost/rightmost derivation

*grammar* is strong than *regex* 



