---
attachments: [Clipboard_2020-04-08-22-24-21.png]
tags: [Notebooks/Compiler]
title: Syntax Directed Translation
created: '2020-04-08T14:24:20.684Z'
modified: '2020-04-08T14:24:41.828Z'
---

# Syntax Directed Translation

[TOC]

[Syntax-Directed]

Attach program fragments to the productions of a grammar.

- syntax-directed definition(SDD)
- syntax-directed translation(SDT)



## Syntax-directed Definition(SDD)

| attribute              |                                                              |
| ---------------------- | ------------------------------------------------------------ |
| synthesized  attribute | *defined only in terms of attribute values at the  children and itself* |
| inherited  attribute   | *defined only in terms of attribute values at N's  parent, N itself, and N's siblings* |
| S-attributed           | *An SDD is S-attributed if every attribute is synthesized*   |
| L-Attributed           | dependency-graph edges can go from left to right, but not from right to left |

<u>attribute grammar</u>: SDD without side effect

​	side effect: action except for evaluating, like painting



[use inherited attribute in non-left-recursive version]

 <img src="./Syntax Directed Translation.assets/image-20200408223958130.png" alt="image-20200408223958130" /> 



### dependency graph

 <img src="./Syntax Directed Translation.assets/image-20200408224139373.png" alt="image-20200408224139373" /> 

- necessity: no circle

- *Note: SDD with S-attribute or L-attribute doesn’t have circle.*

  - how to implement?

    - (LDD)input: inherited attribute; output: synthesized attribute. Recursive Subroutine Algorithm

      <img src="./Syntax Directed Translation.assets/image-20200408224911826.png" alt="image-20200408224911826" style="zoom:70%;" />



[variable declaration]

 <img src="./Syntax Directed Translation.assets/image-20200408225337759.png" alt="image-20200408225337759" /> 

A dependency graph for the input string `float id1, id2, id3` 

 <img src="./Syntax Directed Translation.assets/image-20200408225510006.png" alt="image-20200408225510006" /> 

Node 6,8,10 are the dummy attributes that represent the application of the function `addType`.



[array type]

 <img src="./Syntax Directed Translation.assets/image-20200408225827680.png" alt="image-20200408225827680" /> 



### Abstract Syntax Tree

syntax tree:

| Concrete | A parse tree  (nodes represent non-terminals) |
| -------- | --------------------------------------------- |
| Abstract | nodes represent  operator                     |

 <img src="./Syntax Directed Translation.assets/image-20200408230025833.png" alt="image-20200408230025833" /> 

 <img src="./Syntax Directed Translation.assets/image-20200408230429074.png" alt="image-20200408230429074" /> 



## Syntax-directed Translation(SDT)

context-free grammar with program fragments embedded within production bodies

| underlying grammar | LL          | LR          |
| ------------------ | ----------- | ----------- |
| attribute of SDT   | L-attribute | S-attribute |

 <img src="./Syntax Directed Translation.assets/1587717701749.png" alt="1587717701749" /> 

 <img src="./Syntax Directed Translation.assets/1587719355554.png" alt="1587719355554" /> 

 <img src="./Syntax Directed Translation.assets/1587719505305.png" alt="1587719505305" /> 

implementation for L-Attributed SDT

1. recursive-descent parser

2. on-the-fly generation(optimization of first method)
3. combined with LL parser
4. combined with LR parser

### postfix SDT

<u>postfix SDT</u>: all actions are at the end of the body of the production

 <img src="./Syntax Directed Translation.assets/1587717967754.png" alt="1587717967754" /> 

postfix SDT could be implemented during LR parsing

 <img src="./Syntax Directed Translation.assets/1587718203851.png" alt="1587718203851" /> 

 Not all SDT's can be implemented during one pass for both LL and LR(eg. infix -> prefix expression), except for *postfix SDT* and *L-attribute SDT*. 

A general solution is to build AST and insert virtual action nodes and then scan AST in another pass.

### eliminating left recursion for SDT’s

 <img src="./Syntax Directed Translation.assets/1587719013557.png" alt="1587719013557" /> 

 <img src="./Syntax Directed Translation.assets/1587719026371.png" alt="1587719026371" /> 

 <img src="./Syntax Directed Translation.assets/1587719040757.png" alt="1587719040757" /> 

### recursive-descent parser of L-attribute SDD's

 <img src="./Syntax Directed Translation.assets/1587719898534.png" alt="1587719898534" /> 

 <img src="./Syntax Directed Translation.assets/1587719834737.png" alt="1587719834737" /> 

### on-the-fly of L-attribute SDD's

 generate the code **on-the-fly**, rather than computing it as an attribute  

<u>**main attributes**</u>:

 <img src="./Syntax Directed Translation.assets/1587720083058.png" alt="1587720083058" /> 

We could **emit** the non-main-attribute elements of the concatenations during pass!

 <img src="./Syntax Directed Translation.assets/1587720312313.png" alt="1587720312313" /> 

### LR Parsing of L-Attributed SDD's

 <img src="./Syntax Directed Translation.assets/1587720773024.png" alt="1587720773024" /> 

 <img src="./Syntax Directed Translation.assets/1587720978041.png" alt="1587720978041" /> 

 <img src="./Syntax Directed Translation.assets/1587721121386.png" alt="1587721121386" /> 