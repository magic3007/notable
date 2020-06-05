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

   <img src="./Intermediate Representation.assets/1587723352478.png" alt="1587723352478" /> 

   <img src="./Intermediate Representation.assets/1587725381570.png" alt="1587725381570" /> 

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

 <img src="./Intermediate Representation.assets/1587729452087.png" alt="1587729452087" /> 

### triple

`op arg1 arg2`

 <img src="./Intermediate Representation.assets/1587729560871.png" alt="1587729560871" /> 

### indirect triples

Problem of triples: moving an instruction may require us to change all references to that result

solution: <u>**indirect triples**</u>

 <img src="./Intermediate Representation.assets/1587729704763.png" alt="1587729704763" /> 

## SSA(Static Single Assignment)

based on triples

all assignments in SSA are to variables with distinct names

 <img src="./Intermediate Representation.assets/1587729997895.png" alt="1587729997895" /> 

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

 <img src="./Intermediate Representation.assets/1587731719534.png" alt="1587731719534" /> 

 <img src="./Intermediate Representation.assets/1587731739245.png" alt="1587731739245" /> 

### Declarations

 <img src="./Intermediate Representation.assets/1587732023874.png" alt="1587732023874" /> 

### Storage Layout of local variables

 <img src="./Intermediate Representation.assets/1587731450576.png" alt="1587731450576" /> 

 <img src="./Intermediate Representation.assets/1587732077846.png" alt="1587732077846" /> 

Note: t & w are global variables.

### sequence of declarations

 <img src="./Intermediate Representation.assets/1587732539494.png" alt="1587732539494" /> 

### Fields in Records and Classes

 <img src="./Intermediate Representation.assets/1587732651394.png" alt="1587732651394" /> 

## Translation

### three-address code

 <img src="./Intermediate Representation.assets/1588075030287.png" alt="1588075030287" /> 

on-the-fly(function `gen` will emit code)

 <img src="./Intermediate Representation.assets/1588075101042.png" alt="1588075101042" /> 

### array

row major(Java/C) column major(Fortran) 

 <img src="./Intermediate Representation.assets/1588075568674.png" alt="1588075568674" /> 

 <img src="./Intermediate Representation.assets/1588075588056.png" alt="1588075588056" /> 



 <img src="./Intermediate Representation.assets/1588075766346.png" alt="1588075766346" /> 

 <img src="./Intermediate Representation.assets/1588075952713.png" alt="1588075952713" /> 

 <img src="./Intermediate Representation.assets/1588076088881.png" alt="1588076088881" /> 

### control flow

 <img src="./Intermediate Representation.assets/1588076510948.png" alt="1588076510948" /> 

boolean expression(`x = a < b`)

 <img src="./Intermediate Representation.assets/1588076594678.png" alt="1588076594678" /> 

### backpatch

problem: `if (B) S`, how to evaluate `B.false` in one pass?

solution:

<img src="./Intermediate Representation.assets/1588076783911.png" alt="1588076783911" style="zoom:50%;" />

truelist, falselist 和 nextlist 都是 综合属性.

<img src="./Intermediate Representation.assets/1588077110463.png" alt="1588077110463" style="zoom:50%;" />

<img src="./Intermediate Representation.assets/1588077459710.png" alt="1588077459710" style="zoom:50%;" />

<img src="./Intermediate Representation.assets/1588077708446.png" alt="1588077708446" style="zoom:50%;" />

<img src="./Intermediate Representation.assets/1588077827421.png" alt="1588077827421" style="zoom:50%;" />

<img src="./Intermediate Representation.assets/1588077927347.png" alt="1588077927347" style="zoom:50%;" />

<img src="./Intermediate Representation.assets/1588078789269.png" alt="1588078789269" style="zoom:50%;" />

<img src="./Intermediate Representation.assets/1588079164445.png" alt="1588079164445" style="zoom:50%;" />

<img src="./Intermediate Representation.assets/1588079374244.png" alt="1588079374244" style="zoom:50%;" />

### break & continue

<img src="./Intermediate Representation.assets/1588079589489.png" alt="1588079589489" style="zoom:50%;" />

#### zip-backpatch

<img src="./Intermediate Representation.assets/1588079750923.png" alt="1588079750923" style="zoom:50%;" />

### switch

 <img src="./Intermediate Representation.assets/1588079989188.png" alt="1588079989188" /> 

 <img src="./Intermediate Representation.assets/1588080060840.png" alt="1588080060840" /> 

