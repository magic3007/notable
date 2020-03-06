---
tags: [Notebooks/Compiler]
title: Token Analysis
created: '2020-02-29T04:05:09.957Z'
modified: '2020-02-29T07:49:32.120Z'
---

# Token Analysis

Regex -> NFA

<img src="./Token Analysis.assets/image-20200229154056458.png" alt="image-20200229154056458" style="zoom:50%;" />

`*` means retracting , namely, returning back the last latter to the input string.



$ R \rightarrow R_1 \vert R_2 \ldots \vert R_n $

priority: longest matching ; same length, prefers the one listed first



