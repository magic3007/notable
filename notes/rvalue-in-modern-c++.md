---
tags: [Notebooks/Programming Languages/C++]
title: Rvalue In Modern C++
created: '2020-02-03T12:21:49.492Z'
modified: '2020-02-18T14:17:37.639Z'
---

[TOC]

# Reference

[Effective Modern C++: 42 Specific Ways to Improve Your Use of C++11 and C++14](https://www.amazon.com/Effective-Modern-Specific-Ways-Improve/dp/1491903996)

# Rvalue In Modern C++

这篇文章辨析了C++11/14中右值引用, 万能引用, 完美转发等相关概念, 由于是非介绍性文章, 有相关背景知识后阅读更佳.

## What is the reference?

首先需要回答的一个问题是, 在C/C++中什么是引用? 更具体地, 引用变量有占用空间吗? 在汇编语言层次上引用变量的行为是怎样的, 对一个引用变量做取地址操作得到的是什么? 我们可以通过一段例程来说明.

```c++
#include <memory>
#include <iostream>
#include <boost/type_index.hpp>
#include <cstdio>


#define PRINT_TYPE(x) std::cout << "type of " #x " is "  << \
    boost::typeindex::type_id_with_cvr<decltype(x)>().pretty_name() << std::endl


int main(){
    int x = 1;

    int &ax = x;
    int &&bx = std::move(x);
    int &cx = ax;
    int &dx = bx;
    int &&ex = std::move(ax);
    int &&fx = std::move(bx);

    PRINT_TYPE(x);
    printf("%p\n", &x);
    PRINT_TYPE(ax);
    printf("%p\n", &ax);
    PRINT_TYPE(bx);
    printf("%p\n", &bx);
    PRINT_TYPE(cx);
    printf("%p\n", &cx);
    PRINT_TYPE(dx);
    printf("%p\n", &dx);
    PRINT_TYPE(ex);
    printf("%p\n", &ex);
    PRINT_TYPE(fx);
    printf("%p\n", &fx);


    return 0;
}

/** output:
type of x is int
0x7ffff4ddfd24
type of ax is int&
0x7ffff4ddfd24
type of bx is int&&
0x7ffff4ddfd24
type of cx is int&
0x7ffff4ddfd24
type of dx is int&
0x7ffff4ddfd24
type of ex is int&&
0x7ffff4ddfd24
type of fx is int&&
0x7ffff4ddfd24
*/
```

对这段代码生成的可执行文件反汇编后, 我们可以得到一些关于引用在汇编语言层次的信息. 

在汇编语言的层次,引用其实是一个指针, 也是占用空间的. 但是任意对该引用的操作, 如算术运算甚至取地址操作(如例程中的`&ax`), 实际上是对其"本体"的操作. 如这里上面的例程中的取地址操作永远是得到变量`x`的地址而不是引用变量本身的地址. 所以, 实际上<u>引用是会自动提领的指针</u>罢了.

我们先detour一下, 看看下一个与引用无关的问题.

> 怎么区分左值和右值?

大部分资料都认为区分左值和右值的方式是判断是否可以取地址. 笔者感觉这个说法有不太严谨的地方, 看看下面这个例子.
```c++
#include <memory>
#include <iostream>
#include <boost/type_index.hpp>
#include <cstdio>


#define PRINT_TYPE(x) std::cout << "type of " #x " is "  << \
    boost::typeindex::type_id_with_cvr<decltype(x)>().pretty_name() << std::endl


int main(){
    int x = 1;

    int&& w = std::move(1);
    
    printf("w=%x\n",w);
    PRINT_TYPE(x);
    printf("w=%x\n",w);
   
    return 0;
}

/** output:
w=1
type of x is int
w=7804a90
*/
```

这里实际上`w`是一个
