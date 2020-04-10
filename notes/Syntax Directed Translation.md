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

      <img src="./Syntax Directed Translation.assets/image-20200408224911826.png" alt="image-20200408224911826" style="zoom:33%;" />



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