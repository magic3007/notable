---
tags: [Notebooks/Compiler]
title: Lex && Yacc
created: '2020-02-29T03:54:05.327Z'
modified: '2020-02-29T07:50:32.304Z'
---

# Lex && Yacc



## Lex

priority: longest matching ; same length, prefers the one listed first

<img src="Lex &amp;&amp; Yacc.assets/image-20200229155628075.png" alt="image-20200229155628075" style="zoom:50%;" />



lex.l – LEX –> lex.yy.c — gcc -> yylex

```bash
flex lex.l; gcc lex.yy.c -L/usr/local/opt/flex/lib -fl
```

https://www.ibm.com/support/knowledgecenter/en/ssw_aix_72/com.ibm.aix.genprogc/ie_prog_4lex_yacc.htm

