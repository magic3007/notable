---
tags: [Notebooks/Compiler]
title: Regex
created: '2020-02-19T03:32:37.059Z'
modified: '2020-02-19T04:01:56.831Z'
---

# Regex


- Comments, consisting of a string surrounded by /* and */, without an intervening */, unless it is inside double-quotes (")
`\/ \* ( [^*"]* | ".*" | \*+[^/]  )*\* \/`

- only consist of `a` and `b` , without `abb`

`b*(a+b?)*`

- without `abc`

`\b((?!abc)\w)+\b`
where `(?!)` is negative assertion.

