---
tags: [Notebooks/Compiler]
title: Lex && Yacc
created: '2020-02-29T03:54:05.327Z'
modified: '2020-04-15T11:10:38.857Z'
---

# Lex && Yacc

### Resource
  - [ANSI C grammar, Lex specification](http://www.lysator.liu.se/c/ANSI-C-grammar-l.html)
  - [ANSI C Yacc grammar](http://www.lysator.liu.se/c/ANSI-C-grammar-y.html)
  - https://www.ibm.com/developerworks/cn/linux/sdk/lex/

## Lex

priority: longest matching; same length, prefers the one listed first

<img src="./Lex && Yacc.assets/image-20200229155628075.png" alt="image-20200229155628075" style="zoom:50%;" />

| Lex 变量 |                                                              |
| :------- | :----------------------------------------------------------- |
| yyin     | FILE* 类型。 它指向 lexer 正在解析的当前文件。               |
| yyout    | FILE* 类型。 它指向记录 lexer 输出的位置。 缺省情况下，yyin 和 yyout 都指向标准输入和输出。 |
| yytext   | 匹配模式的文本存储在这一变量中（char*）。                    |
| yyleng   | 给出匹配模式的长度。                                         |
| yylineno | 提供当前的行数信息。 （lexer不一定支持。）                   |

| Lex 函数      |                                                              |
| :------------ | :----------------------------------------------------------- |
| yylex()       | 这一函数开始分析。 它由 Lex 自动生成。                       |
| yywrap()      | 这一函数在文件（或输入）的末尾调用。 如果函数的返回值是1，就停止解析。 因此它可以用来解析多个文件。 代码可以写在第三段，这就能够解析多个文件。 方法是使用 yyin 文件指针（见上表）指向不同的文件，直到所有的文件都被解析。 最后，yywrap() 可以返回 1 来表示解析的结束。 |
| yyless(int n) | 这一函数可以用来送回除了前�n? 个字符外的所有读出标记。       |
| yymore()      | 这一函数告诉 Lexer 将下一个标记附加到当前标记后。            |

```bash
lex lex.l
cc lex.yy.c -L/usr/local/opt/flex/lib -ll
```

## Yacc

<img src="./Lex && Yacc.assets/image-20200414225352109.png" alt="image-20200414225352109" style="zoom:80%;" />

- `$$`: left-hand side
- `$<n>`: the n-th token on right-hand side(including terminals)

Unless otherwise instructed, `yacc` will resolve all parsing action conflicts using the following two rules:

- A reduce/reduce conflict is resolved by choosing the conflicting production listed first
- A shift/reduce conflict is resolved in favor of shift.(this default rule resolves the dangling-else ambiguity correctly)

To further resolve shift/reduce conflicts, we can assign precedences and associativities to terminals.

- `%left '+' '-'` : make  `+` and `-` of the same precedence and be left associative.
- `%right '^'`: make `'^' ` right-associative
- `%nonassoc ‘<’`: make `'<'` non-associative
- `%prec UMINUS`: have the same associativities with `UMINUS`(unary-minus)

```bash
lex lex.l
yacc -dy yacc.y
# -d: generate header file lex.yy.h
# -v: generate parsing table
cc lex.yy.c y.tab.c -o parser
```

| yacc 变量 |      |
| -------- | ---- |
| `yylineno` |      |
| `yylval`|See more info in https://www.gnu.org/software/bison/manual/html_node/Token-Values.html |

| yacc 函数                |      |
| ------------------------ | ---- |
| `yyparse()`              |      |
| `int yyerror(char* msg)` |      |

