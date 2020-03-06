---
tags: [Notebooks/Programming Languages/Lisp]
title: lisp syntax
created: '2020-02-20T12:03:28.455Z'
modified: '2020-02-27T12:33:16.471Z'
---

# lisp syntax

[](@attachment/gw_sicp_01_1.ppt)
- http://www.cs.rpi.edu/academics/courses/fall00/ai/scheme/reference/Scheme.html
- https://web-artanis.com/scheme.html



##### display
->stdout
```scheme
(display "hello world!")
(displayln "hello world!")
(newline)
``` 

##### define function & variables

```scheme

; variables
(define <name> <expression>)
; function
(define (⟨name⟩ ⟨formal parameters⟩)
 ⟨e1⟩ <e2> ... <en>) 


; leverage lambda to define function
; # |lambda| is special form, and the parameters won't be evaluated.
  (lambda (arg1 ... argn)
    exp1 ... expn))
```
实际上在编译时, 函数都是被解析成lambda.
```
(define foo (lambda (x) (+ x 1)))
; 等价于
```
[辨析]


> define parameterless function `(define (<name>) <body>)` 
> vs. 
> define variables `(define <name> <expression>)` 
```scheme
; define variables
> (define p 5)
> p
5

; define parameterless function
> (define (p2) 5); paremeterless function
>  p2
#<procedure:p2>; function is a value
> (p2); evaluate function, in curves
5
```
 
```scheme
(define (func x)
  (+ x 1)(display "tmp")(newline)(* x 2)
)
(func 6)
; stdout:
; tmp
; 12
```


##### conditional expression

```scheme
(cond (⟨p1⟩ ⟨e1⟩) (⟨p2⟩ ⟨e2⟩) . . . (⟨pn⟩ ⟨en⟩))

(cond (⟨p1⟩ ⟨e1⟩) (⟨p2⟩ ⟨e2⟩) . . . (⟨pn⟩ ⟨en⟩) (else <en_1>))

(if ⟨predicate⟩ ⟨consequent⟩ ⟨alternative⟩)
```
##### prediates

```scheme
`(and/or <e1> ... <en>)`
`(not <e>)`
```


##### void
do nothing.
```scheme
(if (> x 3)
  (display 3)
  (void))
```

##### begin
`(begin <e1> <e2> ... <en>)`
evaluate in order, return the value of `<en>`

##### let

定义局部变量
```scheme
(let ((<var1> <exp1>)
      ))
```
`<body>`的最后

## Misc

1. <u>list</u>(inconsistent in memory) vs. <u>vector</u>(consistent in memory)

