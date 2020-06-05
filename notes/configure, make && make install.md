---
tags: [Notebooks/Cheatsheet/Metaprogramming]
title: 'configure, make && make install'
created: '2020-05-06T14:10:15.028Z'
modified: '2020-05-06T14:58:57.705Z'
---

# configure, make && make install

## configure


#### `configure.ac`

```
AC_INIT(MiniJava-Compiler, 1.0)

AC_CHECK_PROGS([SPIM], [spim], [:])
if test "$SPIM" = :; then
AC_MSG_ERROR([This package needs spim.])
fi

AC_OUTPUT
```
