---
tags: [Notebooks/Cheatsheet]
title: CMake
created: '2020-02-23T09:26:21.376Z'
modified: '2020-03-06T15:21:24.911Z'
---

# CMake

#### set

- Normal Variables(the scope is current file). `set(<variable> <value>... [PARENT_SCOPE])`
  - `add_subdirectory`, `function()`: value copy
  - `include()` `macro()`: code expansion
- Cache Variable(global scope). `set(<variable> <value>... CACHE <type> <docstring> [FORCE])`
```
set(MY_CACHE_VAL "666" CACHE STRING INTERNAL)
```
  - `CMAKE_INSTALL_PREFIX` is `/usr/local` by default.
  - Use normal variables if there are two normal varibles and cache variables sharing the same name.
  - appear in `CMakeCache.txt`
  - two ways to modify cache variables:
    `set(<variable> <value> CACHE INSTERNAL FORCE)` or `cmake -Dvar=value ..` in shell

#### Package

http://www.yeolar.com/note/2014/12/16/cmake-how-to-find-libraries/

Definition file: `Find<package name>.cmake`

`find_package(Gperftools REQUIRED)` equivalent to
``` 
list(APPEND CMAKE_MODULE_PATH <path>)
include(Find<package name>)
```
Once we find the package, the following variables are added covertly.
```
<NAME>_FOUND
<NAME>_INCLUDE_DIRS or <NAME>_INCLUDES
<NAME>_LIBRARIES or <NAME>_LIBRARIES or <NAME>_LIBS
<NAME>_DEFINITIONS
```

