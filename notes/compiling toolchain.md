---
tags: [Function Programming, Notebooks/Programming Languages/Java]
title: compiling toolchain
created: '2020-02-18T14:26:17.822Z'
modified: '2020-02-27T06:00:36.304Z'
---

# compiling toolchain

```bash
> java -help
-jar: execuate a jar file with entry *main*
-cp: class search path of directories and zip/jar files
-o: target filename
-l 	输出行和变量的表
-public	只输出public方法和域
-protected	只输出public和protected类和成员
-package 只输出包，public和protected类和成员，这是默认的
-p -private 输出所有类和成员
-s 输出内部类型签名
-c	输出分解后的代码，例如，类中每一个方法内，包含java字节码的指令
-v	输出栈大小，方法参数的个数
-constants 输出静态final常量
```

```bash
-Xss1M # adjust stack size to 1M
-Xmx1G # adjust heap size to 1G
```
###
```bash
# change the default version, use the `alternatives` command
sudo alternatives --config java
```
 


