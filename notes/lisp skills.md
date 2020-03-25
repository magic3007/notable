---
tags: [Notebooks/Programming Languages/Lisp]
title: lisp skills
created: '2020-02-27T11:01:39.265Z'
modified: '2020-03-05T09:50:06.694Z'
---

# lisp skills

1. internal definitions and block structure
2.  Tail recursion Optimization
尾调用定义: 一个函数里的最后一个动作是一个函数调用(不是一个表达式的一部分)
通过**迭代**的方式进行尾调用优化, 减少空间复杂度. 从汇编语言的角度看, 是否是尾递归只需要看是用`jump`还是`call`进行跳转即可.
3. 高阶函数 & lambda. 函数是一等公民:
- 可以作为变量命名
- 可以作为参数
- 可以作为返回值
- 可以放入数据结构
- 可以在运行中动态构造

4. 可以通过不动点(average-dump)和零点(newton-method)来定义数学函数, 如`sqrt`.
5. 利用闭包可以实现面向对象
```scheme
(define (make-point-2D x y) ;二维点类 
  (define (get-x) x) 
  (define (get-y) y) 
  (define (set-x! new-x) (set! x new-x)) 
  (define (set-y! new-y) (set! y new-y)) 
  (lambda (selector . args) ; . args表示后续有任意多个参数，亦可没有 
  (case selector 
    ((get-x) (apply get-x args)) ;apply是基本过程，以 args调用get-x 
    ('get-y (apply get-y args)) ;写 ((get-y) (apply get-y args))一样 
    ('set-x! (apply set-x! args)) 
    ((set-y!) (apply set-y! args)) 
    (else (error "don't understand " selector)))))

(define p1 (make-point-2D 10 20))
 (p1 'get-x) ;=>10    ;’get-x表示“标识符get-x”,不是字符串”get-x”
 (p1 'get-y) ;=>20 
 (p1 'set-x! 5) 
 (p1 'get-x) ;=> 5
 ```
 
 ```scheme
 
 (define (make-point-3D x y z) ;三维点类，从二维点类派生 
  (let ((parent (make-point-2D x y))) 
  (define (get-z) z) 
  (define (set-z! new-z) (set! z new-z)) 
  (lambda (selector . args) 
    (case selector 
      ((get-z) (apply get-z args)) 
      ((set-z!) (apply set-z! args)) 
      (else (apply parent (cons selector args))))))) ;parent是一个能接收个数不定的参数的过程 

(define p2 (make-point-3D 10 20 30)) 
(p2 'get-x)  ;=>10 
(p2 'get-y)  ;=>20 
(p2 'set-z! 5) 
(p2 'get-z)  ;=>5 
(p2 'set-x! 37)
(p2 'get-x)  ;=>37
 ```
 6. Lisp一大强项是对符号处理，例如函数式求导，多项式运算（非数值计算）等的支持
 ```scheme

 #lang racket

(define (variable? x) (symbol? x))
(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))
(define (sum? x)
  (and (pair? x) (eq? (car x) '+)))
(define (addend s) (cadr s))
(define (augend s) (caddr s))
(define (product? x)
  (and (pair? x) (eq? (car x) '*)))
(define (multiplier p) (cadr p))
(define (multiplicand p) (caddr p))
(define (=number? var num)
  (and (number? var) (= var num)))

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2))
         (+ a1 a2))
        (else (list '+ a1 a2))))

(define (make-product m1 m2)
  (cond ((or (=number? m1 0)(=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else (list '* m1 m2))))

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
               (make-product (multiplier exp)
                             (deriv (multiplicand exp) var))
               (make-product (deriv (multiplier exp) var)
                             (multiplicand exp))))
        (else
         (error "unknown expression type -- DERIV" exp))))
 ```








