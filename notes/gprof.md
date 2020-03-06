---
tags: [Notebooks/Cheatsheet]
title: gprof
created: '2020-02-22T13:06:39.351Z'
modified: '2020-02-22T15:01:41.789Z'
---

# gprof

```bash
g++ -pg -o kruse kruse.cc


gprof program-name [ data-file ] [ > output-file ]  
# If you don't specify the name of a data file, gmon.out is assumed. 

```
*注: 由于gprof的采样周期0.01s过大, 因此有时非常不准确.*

## Reference

- https://web.eecs.umich.edu/~sugih/pointers/gprof_quick.html
