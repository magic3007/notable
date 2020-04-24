---
tags: [Notebooks/Programming Languages/C++]
title: Macro in C
created: '2020-04-14T07:29:00.532Z'
modified: '2020-04-14T07:36:45.443Z'
---

# Macro in C

## Special Symbols

```c
// ## : connect
// #@ : single quotes
// #  : double quotes

#define CONCAT(x, y) x##y
#define TOCHAR(x) #@x
#define TOSTRING(x) #x


/*
__LINE__：line No.
__FILE__：File Name.
__DATE__：Compiling Date.
__TIME__：Compiling Time.
__STDC__：Is standard ANSI C?
__cplusplus：Is C++?
*/
```


## Usage

```c
#define OFFSETOF( type, field ) ( (size_t) &(( type *) 0)-> field )
#define FSIZ( type, field ) sizeof( ((type *) 0)->field )



```


