---
tags: [Notebooks/Cheatsheet]
title: markdown
created: '2020-02-23T14:34:25.893Z'
modified: '2020-04-09T07:44:14.076Z'
---

# markdown

### Mixing Images and Texts
```
<img align="right" src=...>
```
<img align="right" src="@attachment/icon_small.png"/>

This is a demo.

The picture is on the right.


### `<markdown>` Tag
A custom <markdown> HTML tag is supported. Anything written inside it will be rendered as Markdown. This is particularly useful when you have to write some wrapper HTML but you still want to write Markdown inside it.

<details>
  <summary>Click to show more...</summary>
  <markdown>
- Embedded
  - _Markdown_
  </markdown>
</details>

```
<details>
  <summary>Click to show more...</summary>
  <markdown>
- Embedded
  - _Markdown_
  </markdown>
</details>
```

### HTML
HTML can be written inside Markdown. The following are some useful HTML tags that you might want to know for which there's no Markdown-specific syntax.

<!-- Comment -->

#### Abbreviation

<abbr title="Mister">Mr.</abbr>

#### Center

<center>Center</center>
<p align="center">Center</p>

#### Description List

<dl>
 <dt>Mr.</dt>
 <dd>Mister</dd>
</dl>

#### Details

<details open>
  <summary>Summary...</summary>
  Details...
</details>

#### Keyboard

<kbd>Ctrl+F5</kbd>

#### Mark

<mark>Text</mark>

#### highlight text in github
```diff
- red
+ green
! orange
# gray
```

#### colorful marks

- ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) General Purpose
- ![#c5f015](https://placehold.it/15/c5f015/000000?text=+) Neural Network
- ![#1589F0](https://placehold.it/15/1589F0/000000?text=+) Graph Processing
- ![#af62ff](https://placehold.it/15/af62ff/000000?text=+) Bioinformatics
- ![#0abab5](https://placehold.it/15/0abab5/000000?text=+) Data Analytics
- ![#ff66cc](https://placehold.it/15/ff66cc/000000?text=+) Associative Computing
- ![#f4f442](https://placehold.it/15/f4f442/000000?text=+) Automata Computing
- ![#ece5b8](https://placehold.it/15/ece5b8/000000?text=+) Data Manipulation
- ![#161616](https://placehold.it/15/161616/000000?text=+) Security
- ![#003366](https://placehold.it/15/003366/000000?text=+) Others

#### Small

<small>Text</small>

### Reference

#### equation reference

```
In equation $\eqref{eq:1}$, we find the value of an
interesting integral:

$$
\int_0^\infty \frac{x^3}{e^x-1}\,dx = \frac{\pi^4}{15}
  \label{eq:1}
$$

$$
  \| x + y \| \geq | \| x | | - \| y \| |
  \label{eq:2}
$$

Look at the Equation $$\ref{eq:2}$$
```

you can use also include `\tag{}` inside of your LaTeX delimiters to create a custom tag. Note that if `\tag{}` is used in a numbered equation, it will override the document’s numbering.
```
$$
\frac{x\left(x^{2 n}-x^{-2 n}\right)}{x^{2 n}+x^{-2 n}}
\tag{1.1}
$$
```

*Remark:*
- Credit to: https://mathpix.com/docs/mathpix-markdown/syntax-reference.

## Toolkit

- [github-markdown-toc](https://github.com/ekalinin/github-markdown-toc): 生成适用于github的anchor目录

## Recource

- [MathJax Plugin for Github](https://chrome.google.com/webstore/detail/mathjax-plugin-for-github/ioemnmodlmafdkllaclgeombjnmnbima)
- [关于 Markdown 的一些奇技淫巧](https://mazhuang.org/2017/09/01/markdown-odd-skills/)

