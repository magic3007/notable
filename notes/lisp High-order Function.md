---
deleted: true
tags: [Notebooks/Programming Languages/Lisp]
title: lisp High-order Function
created: '2020-02-27T12:01:01.359Z'
modified: '2020-02-27T16:04:51.992Z'
---

# lisp High-order Function

> 过程是可以是变量, 可以作为参数, 返回值.

EXAMPLE 序列求和

```scheme

(define (sum term a next b)
  (if (> a b)
    (+ (term a)
      (sum term (next a) next b))))
```
EXAMPLE: 数值积分


