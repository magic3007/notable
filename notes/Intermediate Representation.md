---
tags: [Notebooks/Compiler]
title: Intermediate Representation
created: '2020-04-24T09:59:51.448Z'
modified: '2020-04-24T10:08:02.212Z'
---

# Intermediate Representation

[TOC]

## Format

representation method:

- AST

- DAG

  ![1587723352478](./Intermediate Representation.assets/1587723352478.png)

  ![1587725381570](./Intermediate Representation.assets/1587725381570.png)

  differences DAG between AST: before creating a new code, these functions first check whether an identical node already exists.00

- three-address code

  ```
  x = y op z
  x = op y
  x = y
  goto L
  if/ifFalse x goto L
  if x ROP y goto L
  
  param x1; param x2; ... param xn; y = call p n // return y
  x=y[i]
  x[i]=y
  x=&y
  x=*y
  *x=y
  ```

| implementation of three-address code |                                    |
| ------------------------------------ | ---------------------------------- |
| quadruple                            | `op arg1 arg2 result`              |
| triple                               | `op arg1 arg2`                     |
| indirect triple                      | indirect code table + triple table |

### quadruple

`op arg1 arg2 result`

![1587729452087](./Intermediate Representation.assets/1587729452087.png)

### triple

`op arg1 arg2`

![1587729560871](./Intermediate Representation.assets/1587729560871.png)

### indirect triples

Problem of triples: moving an instruction may require us to change all references to that result

solution: <u>**indirect triples**</u>

![1587729704763](./Intermediate Representation.assets/1587729704763.png)

## SSA(Static Single Assignment)

based on triples

all assignments in SSA are to variables with distinct names

![1587729997895](./Intermediate Representation.assets/1587729997895.png)

the same variable may be defined in two different control-flow paths in a program.

<img src="./Intermediate Representation.assets/1587730080771.png" alt="1587730080771" style="zoom:80%;" />

 ø-function to combine the two definitions of x: 

<img src="./Intermediate Representation.assets/1587730119058.png" alt="1587730119058" style="zoom:100%;" />

## Type Expression

```
type_exp ::= 
basic_type    
type_name    
array(size, type_exp)    
record(fields) 
function s-> t    
s X t  (tuple) 
```

<img src="./Intermediate Representation.assets/1587730839590.png" alt="1587730839590" style="zoom:50%;" />

Type expression may contain variables whose values are type expressions.

#### type equivalence

- structurally equivalent(iff. one of the following conditions is true):
  - they are the same basic type
  - they are formed by applying the same constructor to structurally equivalent types
  - one is a type name that denotes the other
- name equivalence
  -  two types are equal if, and only if, they have the same name

<img src="./Intermediate Representation.assets/1587731055544.png" alt="1587731055544" style="zoom:67%;" />

### type system & type conversion 

- type system = type expression + type conversion rules

- 隐式转换(coercion)
- 显式转换(cast)

widening & narrowing

![1587731719534](./Intermediate Representation.assets/1587731719534.png)

![1587731739245](./Intermediate Representation.assets/1587731739245.png)

### Declarations

![1587732023874](./Intermediate Representation.assets/1587732023874.png)

### Storage Layout of local variables

![1587731450576](./Intermediate Representation.assets/1587731450576.png)

![1587732077846](./Intermediate Representation.assets/1587732077846.png)

Note: t & w are global variables.

### sequence of declarations

![1587732539494](./Intermediate Representation.assets/1587732539494.png)

### Fields in Records and Classes

![1587732651394](./Intermediate Representation.assets/1587732651394.png)

