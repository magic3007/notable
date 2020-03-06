---
tags: [Notebooks/Cheatsheet]
title: CMake
created: '2020-02-23T09:26:21.376Z'
modified: '2020-02-23T13:05:43.630Z'
---

# CMake


#### Package

http://www.yeolar.com/note/2014/12/16/cmake-how-to-find-libraries/

不管使用哪一种模式，只要找到包，就会定义下面这些变量：
```
<NAME>_FOUND
<NAME>_INCLUDE_DIRS or <NAME>_INCLUDES
<NAME>_LIBRARIES or <NAME>_LIBRARIES or <NAME>_LIBS
<NAME>_DEFINITIONS
```
这些都在 Find<name>.cmake 文件中.


```
find_package(Gperftools REQUIRED)
```
