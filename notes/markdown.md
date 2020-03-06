---
tags: [Notebooks/Cheatsheet]
title: markdown
created: '2020-02-23T14:34:25.893Z'
modified: '2020-03-06T09:54:47.163Z'
---

# markdown

### 图文混排
使用 <img> 标签来贴图，然后指定 align 属性.
<img align="right" src="https://raw.githubusercontent.com/mzlogin/mzlogin.github.io/master/images/posts/markdown/demo.png"/>

这是一个示例图片。

图片显示在 N 段文字的右边。

N 与图片高度有关。

刷屏行。

刷屏行。

到这里应该不会受影响了，本行应该延伸到了图片的正下方，所以我要足够长才能确保不同的屏幕下都看到效果.

### `<markdown>` Tag
A custom <markdown> HTML tag is supported. Anything written inside it will be rendered as Markdown. This is particularly useful when you have to write some wrapper HTML but you still want to write Markdown inside it.

```
<details open>
  <summary>Summary...</summary>
  <markdown>
- Embedded
  - _Markdown_
  </markdown>
</details>
```

<details open>
  <summary>Summary...</summary>
  <markdown>
- Embedded
  - _Markdown_
  </markdown>
</details>

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

