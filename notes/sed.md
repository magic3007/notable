---
tags: [Notebooks/Cheatsheet]
title: sed
created: '2020-02-22T03:56:50.762Z'
modified: '2020-02-22T04:07:19.676Z'
---

# sed

Edit text in a scriptable manner.

```bash
sed 's/^/HEAD&/g' test.file # add "HEAD" at the beginning of each line

sed 's/$/&TAIL/g' test.file # add "TAIL" at the end of each line

# "^" means the beginning of a line
# "$" means the end of a line
# "g" means replace any occurance in a line, otherwise only replace once
# "-i" modify the source file vs. "> new.file" create new file
```
