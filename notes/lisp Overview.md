---
tags: [Notebooks/Programming Languages/Lisp]
title: lisp Overview
created: '2020-02-20T09:37:33.477Z'
modified: '2020-03-05T09:24:31.804Z'
---

# lisp Overview


[key features]
- <u>high-order function</u> && <u>lazy evaluation</u>
- <u>modulation</u>

[design idea]

- **function is first class.** High-order function, function is a value.
 1. assigned to variables
 2. as parameters
 3. as return values
  ```scheme
 ; return values
 (define (f n)
  (lambda (x) (+ x n))
 )
 ```
 4. closure
 5. predefine symbols, like `+` and  `-`, are also functions.
```scheme
(define (a-plus-abs-b a b) 
  ((if (> b 0) + -) a b))

```
- data and code are in the same form.
`(t 1 2 3)` function vs. `'(t 1 2 3)` list


#### variables & environment

- `define` and `set!` modify key-value pairs in current environment
- there has been some pre-defined key-value pairs, like `+`, `-`, `abs` `quotient`, `even?`, but we can override them.

#### special form

some expressions should not be evaluated, these expressions are called **special forms**. 
*Sepcial forms are not procedures.* Each special form has it own evaluation strategy.
following are special forms:
<u> *cond, if, cond, and/or/not, lambda, quote* </u>
 
```scheme
(define x 1)
; `x` should not be evaluated, for `define` just binds 
; the variable name `x` to a new value.
(define tmp (calc v0 v1 v2 v3 v4))
; Error! define: not allowed in an expression context
; (calc v0 v1 v2 v3 v4) is not a value
; To define a temporary variable binded to a process, we could leverage `let` syntax.

(if (= x 1) a b)
; if the expression (= x 1) return ture, then variable `b` should not be evaluated.

(cond ((= x 1) 1)
       (= x 2) 2)
; evaluate the expressions in order. 
; If a expression returns false, its "then" expressions will not be evaluted
; Once one expression returns ture, the following conditional repressions will not be evaluated.

(lambda (x) (+ x 1))
; lambda is a special form, its "parameters" should not by evaluated.

; In effect, defining precedure, are all interpreted by lambda.
; when lambda is evaluated, it will generate a procudure.
; evaluating a lambda expression is the only way to generate a procedure.

(define (plus4 x) (+ x 4)); is equivalent to
(define plus4 (lambda (x) (+ x 4)))

; Furthermore, Let expression is an syntactic sugar of lambda.
((lambda (<var1> ...<varn>) <body>) <exp1> ... <expn>)


(car ''abracadabra) => 'quote 
(cadr ''abracadabra) => 'abracadabra 
; ''abracadabra 等价于 (quote (quote abracadabra))，第一个quote是特殊 形式，第二个quote是符号
```




#### applicative-order evaluation vs. normal-order evaluation
- applicative-order evaluation: evaluate the arguments and then apply
- normal-order evaluation: fully expand and then reduce

*Tips: scheme use application-order evaluation.*

TEST whether the interpretor uses application-order evaluation or normal-order evaluation.
```scheme
(define (p) (p)) 
(define (test x y) 
  (if (= x 0) 0 y))

(test 0 (p))
```



