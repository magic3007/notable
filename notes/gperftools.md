---
tags: [Notebooks/Cheatsheet]
title: gperftools
created: '2020-02-23T12:24:04.159Z'
modified: '2020-02-23T12:53:02.403Z'
---

# gperftools

```bash
g++ test.cpp -o test  -ltcmalloc -lprofiler
./test
pprof ./test test.prof --text > test.txt
pprof ./test test.prof --pdf > test.pdf

```
## Reference

- https://www.cnblogs.com/gnivor/p/11719958.html
