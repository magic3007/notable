---
tags: [Notebooks/Compiler]
title: Regex & context-free grammar
created: '2020-02-19T03:32:37.059Z'
modified: '2020-03-08T15:47:04.435Z'
---

# Regex & context-free grammar


> Comments, consisting of a string surrounded by /* and */, without an intervening */, unless it is inside double-quotes (")

`\/ \* ( [^*"]* | ".*" | \*+[^/]  )*\* \/`

> only consist of `a` and `b` , without `abb`

`b*(a+b?)*`

> without `abc`

`\b((?!abc)\w)+\b`
where `(?!)` is negative assertion.

> number of a != b

solution #1:
$$
\begin{align}
S & \rightarrow A | B \\
A & \rightarrow 0E | 0A | 1AA \\
B & \rightarrow 1E | 1B | 0BB \\
E & \rightarrow 0E1 | 1E0 | EE | \epsilon
\end{align}
$$
solution #2:
		S → A | B
		A → 1 | 0A1 | 1A0 | AA | EAE B → 0 | 0B1 | 1B0 | BB | EBE
		E → 0E1 | 1E0 | EE | ε

solution #3:
		S → TS | C | D
		T → 1B | 0A
		A → 1 | 0AA
		B → 0 | 1BB
		C → 0E
		E → 0AE | 0E | ε（或: E → 0E | 0E1E | ε）
		D → 1F
		F → 1BF | 1F | ε （或: F → 1F | 1F0F | ε）


> 不能表示形如xx的0和1组成的串

$$
\begin{align*}
S &\rightarrow S_0S_1 | S_1S_0 \\
S_0 &\rightarrow 0S_00| 0S_01 | 1S_00 | 1S_01 | 0 \\ 
S_1 &\rightarrow 0S_10| 0S_11 | 1S_10 | 1S_11 | 1 \\ 
\end{align*}
$$
S_0和S_1分别表示中心为0和1的长度为奇数的字符串. 将S_0, S_1拼接, 然后等分成两部分x和y. 虽然S_0和S_1长度可能不相同, 但是容易得到S_0中心在x中的位置, 与S_1的中心在y中的位置是相同的.将S_1, S_0拼接类似.



