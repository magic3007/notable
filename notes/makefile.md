---
tags: [Notebooks/Cheatsheet]
title: makefile
created: '2020-02-21T15:16:22.778Z'
modified: '2020-02-25T09:07:29.731Z'
---

# makefile

[TOC]

*Tips:* 
- use tabs as seperators.
- make will create a child sh process for each command line to run the corresponding command
- line break  `\`

## Automated variables

- [Automatic Variables](https://www.gnu.org/software/make/manual/html_node/Automatic-Variables.html)

| Name     | Example                                                      | Usage                                                        |
| -------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| `$(...)` | `$(MAKE)` `$(DIRS)`                                          | 打开makefile中定义的变量                                     |
| `$$...`  | `$$dir`                                                      | 打开makefile中定义的shell变量                            |
| `@`      | `@echo ---compiling $$dir---`                                | 不回显命令                                          |
|`%`|`$(OBJ_PATH)/%.o: $(SRC_PATH)/%.c*`|匹配符|
| `-`      | `-rm dir`                                                    | 通常删除，创建文件时如果碰到文件不存在或者已经创建，那么希望忽略掉这个错误，继续执行，就可以在命令前面添加 `-` |
| `.PHONY` | `.PHONY clean: rm *.o`                                       | 如果恰好有一个名为`clean`的文件, 那么`make clean`不会起作用, 因为`clean`永远是最最新的. 可以使用`PHONY`, 它可以不管依赖项, 每次都会执行. |
| `$@`     |                                                              | 目标集合                                                     |
| `$^`     | `main: main.o hello.o hi.o`<br />`gcc -o main main.o hello.o hi.o` <br />等于<br /> `main: main.o hello.o hi.o`<br />` gcc -o $@ $^` | 所有依赖目标的集合, 会去除重复的依赖目标                     |
| `$+`     |                                                              | 所有依赖目标的集合, 不会去除重复的依赖目标                   |
| `$<`     |      `$(OBJ_PATH)/%.o: $(SRC_PATH)/%.c*`<bar /> `$(CC) $(CCOBJFLAG) -o $@ $<`                                                     | 第一个依赖目标.          |
| `$%`     |                                                              | 当目标是函数库文件时, 表示其中的目标文件名                   |
| `$?`     |      `$(TARGET): $(OBJ)` <br />` $(CC) $(CCFLAG) -o $@ $?`                                                       | 比目标新的依赖目标的集合                                     |
|  `$*`        |    target is `dir/a.foo.b`, target pattern is `a.%.b` ->  `dir/foo`   |  part of the file name that matched the '%' in the target pattern. The stem is useful for constructing names of related files.       |
|`$$?`||exit code of last command|


## Functions

  - [File-Name-Functions](https://www.gnu.org/software/make/manual/html_node/File-Name-Functions.html)
  - [Foreach Function](https://www.gnu.org/software/make/manual/html_node/Foreach-Function.html)
  - [Wildcard Function](https://www.gnu.org/software/make/manual/html_node/Wildcard-Function.html)
  - [Text Functions](https://www.gnu.org/software/make/manual/html_node/Text-Functions.html)

```makefile
$(addsuffix suffix,names...) 
$(addprefix prefix,names...)
$(foreach var,list,text)
$(wildcard pattern...)
$(basename names...) # Extracts all but the suffix of each file name in names(a.c -> a)
$(notdir names...) # Extracts all but the directory-part of each file name in names(src/a.c -> a.c)
$(patsubst pattern,replacement,text) # $(patsubst %.c,%.o,x.c.c bar.c) -> x.c.o bar.o
```


## template



### Small Project

Assume we have a project with the following folder structure, we call it a **Small Project**:

- Root: holds the main src file
  - bin: holds target files
  - obj: holds object files
  - src: holds all src files(except the main src file)
	- some-subdirs: hold **NO** src files related to the general build process

```makefile
# tool macros
CC := # FILL: the compiler
CCFLAG := # FILL: compile flags
DBGFLAG := -g
CCOBJFLAG := $(CCFLAG) -c
LIBFLAG := -lm

# path macros
BIN_PATH := bin
OBJ_PATH := obj
SRC_PATH := src
DBG_PATH := debug

# compile macros
TARGET_NAME := # FILL: target name
ifeq ($(OS),Windows_NT)
	TARGET_NAME := $(addsuffix .exe,$(TARGET_NAME))
endif
TARGET := $(BIN_PATH)/$(TARGET_NAME)
TARGET_DEBUG := $(DBG_PATH)/$(TARGET_NAME)
MAIN_SRC := # FILL: src file contains `main()`

# src files & obj files
SRC := $(foreach x, $(SRC_PATH), $(wildcard $(addprefix $(x)/*,.c*)))
OBJ := $(addprefix $(OBJ_PATH)/, $(addsuffix .o, $(notdir $(basename $(SRC)))))
OBJ_DEBUG := $(addprefix $(DBG_PATH)/, $(addsuffix .o, $(notdir $(basename $(SRC)))))

# clean files list
DISTCLEAN_LIST := $(OBJ) \
	$(OBJ_DEBUG)
CLEAN_LIST := $(TARGET) \
	$(TARGET_DEBUG) \
	$(DISTCLEAN_LIST)

# default rule
default: all

# non-phony targets
$(TARGET): $(OBJ)
	$(CC) $(CCFLAG) -o $@ $? $(LIBFLAG)

$(OBJ_PATH)/%.o: $(SRC_PATH)/%.c*
	$(CC) $(CCOBJFLAG) -o $@ $<

$(DBG_PATH)/%.o: $(SRC_PATH)/%.c*
	$(CC) $(CCOBJFLAG) $(DBGFLAG) -o $@ $<

$(TARGET_DEBUG): $(OBJ_DEBUG)
	$(CC) $(CCFLAG) $(DBGFLAG) $? -o $@ $(LIBFLAG)

# phony rules
.PHONY: all
all: $(TARGET)

.PHONY: debug
debug: $(TARGET_DEBUG)

.PHONY: clean
clean:
	@echo CLEAN $(CLEAN_LIST)
	@rm -f $(CLEAN_LIST)

.PHONY: distclean
distclean:
	@echo CLEAN $(CLEAN_LIST)
	@rm -f $(DISTCLEAN_LIST)
```

### Medium Project

Definition of medium project:

1. There are nested src folders
2. There are multiple sub src folders under one src folder
3. The objects should be held by their folder, rather than a common folder like obj
4. (Mostly) Only one target to build






## Reference

- https://www.cnblogs.com/wang_yb/p/3990952.html
- http://nuclear.mutantstargoat.com/articles/make/
- GNU make
  - [Implicit-Variables](https://www.gnu.org/software/make/manual/html_node/Implicit-Variables.html)

