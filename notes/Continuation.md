---
tags: [Notebooks/Programming Languages/Lisp]
title: Continuation
created: '2020-03-25T03:24:49.556Z'
modified: '2020-03-26T13:23:37.820Z'
---

# Continuation

## Resources
- https://beautifulracket.com/explainer/continuations.html
- https://www.it.uu.se/edu/course/homepage/avfunpro/ht13/lectures/Racket-2-Continuations.pdf
- https://wizardforcel.gitbooks.io/teach-yourself-scheme/130-jumps.html

## What is a continuation?

Each expression has calculation order. For example, as for expression `(+ (+ 2 3))`, we have to evaluate `(+ 2 3)` before evaluating `(+ 1 ...)`. The missing part of `(+ 1 ...)` is call a **hole</u>. 
Actually, a continuation is an expression with a hole. a continuation is chained. If all the continuations are chained together, it is the whole process of computation called **evaluation context**  

*Tips:*
- **continuation = term + context**
- the delimited continuation are chained until *top level*.

For example,

```scheme
(+ 1 (+ 2 (+ 3 4)))
#|
the nestest continuation of (+ 3 4) is (+ 2 ...)
the chained continuations of (+ 3 4) is <(+ 2 ...), cont1>, where cont1=<(+ 1 ...), halt>
 
|#
```



### Continuation-Passing Stype(CPS)

The idea of CPS is to expose the continuation as a high-order function with one argument. This argument is actually the hole. In addition, examples show that manual CPS is a chain of closure.
```scheme
(define k+ (lambda (x y k) (k (+ x y))))
(define k* (lambda (x y k) (k (* x y))))
(define (return x) x)

(k+ 1 2 (lambda (x) (k* x 3 return)))
```

Note that CPS could be esaily optimized by tail calling, therefore CPS is preferable in some situations.
```scheme
(define (return x) x)

(define k+ (lambda (x y k) (k (+ x y))))
(define k* (lambda (x y k) (k (* x y))))

; CPS factorial
(define (kfact n k)
  (if (= n 1)
    (k 1)
    (kfact (sub1 n ) (lambda (x) (k (* n x))))))

(kfact 10 return) ; 3628800
(kfact 10 (lambda (x) (k+ x 3 return))) ; 3628803

; CPS map
(define (kmap proc lst cc)
  (if (empty? lst) (cc '())
      (proc (first lst) (lambda (v)
                          (kmap proc (rest lst)
                                 (lambda (rest-v) (cc (cons v rest-v))))))))


(kmap (lambda (x cc) (cc (+ x 1))) `(1 2 3) return) ; '(2 3 4)
```
 In the CPS function, the next function is stored in a local variable `break`, so that it can quit immediately.
 ```scheme
 ; CPS product
(define (kproduct lst k)
  (let ([break k])
    (let loop ([lst lst] [k k])
      (cond
        [(null? lst) (k 1)]
        [(zero? (first lst)) (break 0)]
        [else (loop (cdr lst) (lambda (x) (k (* (first lst) x))))]))))

(kproduct '(1 2 3) return) ; 6
 ```
Exception handling is a simple example of such cases.
```scheme
(define (non-number-value-error x)
  (display "Value error: ")
  (display  x)
  (display " is not number.")
  (newline)
  'error)

; CPS product
(define (kproduct lst k k-value-error)
  (let ([break k])
    (let loop ([lst lst] [k k])
      (cond
        [(null? lst) (k 1)]
        [(not (number? (first lst))) (k-value-error (first lst))]
        [(zero? (first lst)) (break 0)]
        [else (loop (cdr lst) (lambda (x) (k (* (first lst) x))))]))))

(kproduct '(1 2 3) return non-number-value-error)

(kproduct '(1 2 a) return non-number-value-error)
```


## Continuation in Racket

`call/cc` is a strategy provided by Racket to get current continuation.
```scheme
(+ 1 (+ 2 3))
(+ 1 (call/cc (lambda (k) (k (+ 2 3)))))
; the continuation we get is (+1 ...), which is passed to k.
```


```scheme
#|
10.4 Continuations
    call/cc : (call/cc proc [prompt-tag])
        proc : (continuation? . -> . any)
        prompt-tag      : continuation-prompt-tag?
                          = (default-continuation-prompt-tag)
        alias for "call-with-current-continuation"
        - *call/cc* is a procedure of one argument *proc*, 
          and the aurgment *proc* must also be a procedure of one argument
        - the continuation is passed to *proc* as the parameter
        - *proc* is called directly in tail position with respect to *call/cc*.
          and its return value is return by *call/cc*
        - prompt-tag(optional): captures the current continuation up to the nearest prompt tagged by *prompt-tag*
    let/cc : (let/cc k body ...+) = (call/cc (lambda (k) body ...))
|#

(call/cc (lambda (_) (3 . + . 4))) ;7
(call/cc (lambda (cc) cc)) ; return the continuation
(+ 2 (call/cc (lambda (cc) (+ 30 (cc 10))))); 12
(call/cc (lambda (cc) (cc cc))) ; return the continuation as well
  ; the outmost continuation is equivalent to (lambda (x) x)

((call/cc (lambda (cc) 
       (let ([x (+ 30 (call/cc cc))])
        (lambda (foo) (+ x foo)))
      )) 5) ; 40

; **Saving a continuation**

(define sc #f)
(define (save! x)
  (call/cc (lambda (cc) (set! sc cc) x)))
; save! save the current continuation into sc, which can be used to replay the computation
; with another value
(+ 1 (save! 3) 4 2) ; 10
(sc 10); 17
(sc 20); 27

```


From the perspective of application, a *continuation* is a special kind of function that's like a bookmark to the location of an expression, and let you jump back to an earlier point in the program, thereby circumventing the control flow of the usual evaluation model.

## What are they good for?

### Usage

With continuations, one can implement...
- Exceptions
- Non-deterministic choise points
- return & break
- (lazy) generators
- coroutines

#### Exceptions

When you need to jump back to an earlier point in your program, a continuation can be the right tool for the job. For instance, [errors and exceptions](https://beautifulracket.com/explainer/errors-and-exceptions.html) are implemented with continuations.

#### `return` & `break`
Though Racket has no `return`  and `break` statement, it can be implemented with a continuation:
```scheme
(define (find-multiple factor)
  (let/cc return
    (for ([num (shuffle (range 2000))])
         (when (zero? (modulo num factor))
           (return num)))))

(find-multiple 43)
```

#### `goto`


> Is a continuation just `goto` in disguise?
Not quite. 
- A goto can move anywhere in the program because the possible desti­na­tions are known at compile time.
- A contin­u­a­tion, by contrast, needs the current eval­u­a­tion context, which is only known at run time. In that sense, a contin­u­a­tion is less flex­ible: it can only repre­sent a loca­tion in the program that’s already been visited. Thus, when you invoke a contin­u­a­tion, you can only travel back­ward, not forward.


#### lazy generators


Func­tions that can be suspended and resumed, like gener­a­tors and certain web appli­ca­tions, can also be built with contin­u­a­tions. 

More broadly,  any algorithm that relies on backtracking - e.g., search, pathfinding, constraint
satisfaction, typesetting, can work with continuation, because they  can be used to set return points.






