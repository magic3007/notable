---
tags: [Notebooks/Programming Languages/C++]
title: Macro in C
created: '2020-04-14T07:29:00.532Z'
modified: '2020-04-25T16:12:29.747Z'
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

**Order of expansion**
function-like macro expansion occurs in the following stages:
1. Stringification operations `#x` (without performing expansion).
2. Parameters are replaced with their replacement list (without performing expansion).
3. Concatenation operations `x##y`  (without expanding the resulting token).
4. Tokens <u>originating from parameters</u> are expanded.
5. The resulting tokens are expanded as normal.
```c++

#define <identifier>(<parameter list>) <replacement token list>  // function-like macro, note parameters

#define HE HI
#define LLO _THERE
#define HELLO "HI THERE"
#define CAT(a,b) a##b
#define XCAT(a,b) CAT(a,b)
#define CALL(fn) fn(HE,LLO)
CAT(HE,LLO) // "HI THERE", because concatenation occurs before normal expansion
XCAT(HE,LLO) // HI_THERE, because the tokens originating from parameters ("HE" and "LLO") are expanded first
CALL(CAT) // "HI THERE", because parameters are expanded first
```

## X-Macros
- https://en.wikipedia.org/wiki/X_Macro

```c++

// First the list definition. The list entries could contain multiple arguments.
#define LIST_OF_VARIABLES \
    X(value1) \
    X(value2) \
    X(value3)

// Then we execute this list to generate the variable declarations
#define X(name) int name;
LIST_OF_VARIABLES
#undef X

// In a similar way, we can generate a function that prints the variables and their names:
void print_variables()
{
#define X(name) printf(#name " = %d\n", name);
LIST_OF_VARIABLES
#undef X
}

// When run through the C preprocessor, the following code is generated. 
int value1;
int value2;
int value3;

void print_variables()
{
    printf("value1" " = %d\n", value1);
    printf("value2" " = %d\n", value2);
    printf("value3" " = %d\n", value3);
}

```
## Gist

```c
#define OFFSETOF( type, field ) ( (size_t) &(( type *) 0)-> field )
#define FSIZ( type, field ) sizeof( ((type *) 0)->field )


```


