---
tags: [Notebooks/Cheatsheet]
title: awk
created: '2020-02-21T13:45:57.318Z'
modified: '2020-02-22T03:59:43.392Z'
---

# awk


```bash
> awk '{ sub(/aaa/,"\n&bbb\n"); print }'  ./a.txt  > b.txt
> cat a.txt
aaa
> cat b.txt
aaa
bbb
```
