---
tags: [Notebooks/Cheatsheet]
title: shell script
created: '2020-02-18T14:38:52.792Z'
modified: '2020-03-18T15:43:32.800Z'
---

# shell script

[TOC]

#### substitution

- `'` are literal strings and will not substitute variable values.

- `"` delimited strings will will substitute variable values.

See the Bash [quoting](https://www.gnu.org/software/bash/manual/html_node/Quoting.html) manual page for more information.

```bash
foo=bar
echo "$foo"
# prints bar
echo '$foo'
# prints $foo
```

#### IO redirect

``` bash
echo "lalala" | tee -a log.txt # send to stdout & append to a file corrently
```
#### special variables

Below is a list of some of them. A more comprehensive list can be found [here](https://www.tldp.org/LDP/abs/html/special-chars.html).

- `$0` - Name of the script
- `$1` to `$9` - Arguments to the script. `$1` is the first argument and so on.
- `$@` - All the arguments
- `$#` - Number of arguments
- `$?` - Return code of the previous command
- `$$` - Process Identification number for the current script
- `!!` - Entire last command, including arguments. A common pattern is to execute a command only for it to fail due to missing permissions, then you can quickly execute it with sudo by doing `sudo !!`
- `$_` - Last argument from the last command. If you are in an interactive shell, you can also quickly get this value by typing `Esc` followed by `.`

```bash
#!/bin/bash
echo $0    # 当前脚本的文件名（间接运行时还包括绝对路径）。
echo $n    # 传递给脚本或函数的参数。n 是一个数字，表示第几个参数。例如，第一个参数是 $1 。
echo $#    # 传递给脚本或函数的参数个数。
echo $*    # 传递给脚本或函数的所有参数。被双引号 (" ") 包含时, expend 为 "$1 $2 $n"
echo $@    # 传递给脚本或函数的所有参数。被双引号 (" ") 包含时, expend 为 "$1" "$2" "$n"
echo $?    # 上个命令的退出状态，或函数的返回值。
echo $$    # 当前 Shell 进程 ID。对于 Shell 脚本，就是这些脚本所在的进程 ID。
echo $_    # 上一个命令的最后一个参数
echo $!    # 后台运行的最后一个进程的 ID 号
```

#### functions

```bash
mcd () {
    mkdir -p "$1"
    cd "$1"
}
```

#### loop
```bash
n=100
for ((i=1; i<=$n; i ++)) do
          echo $i
done
  
```
#### array

```bash

# - [definition]
# array = (v1 v2 vn)
#   seperated by space
array=(A B "C" D)

# - [indexing]
# ${array[index]}
echo "the first element: ${array[0]}"

# - [get all elements]
# ${array[*]} or ${array[@]} 
echo "all elements: ${array[*]}"

# - [scanning]
for var in ${array[@]};
do
    echo $var
done

# - [length]
# ${#array[*]}
echo "array length: ${#array[*]}"
```
#### number operations

```bash
#!/usr/bin/env bash

a=0
a=$a+1 # 0+1

b=0
b=[$b+1] # 2
```

#### conditional executing

```bash
false || echo "Oops, fail"
# Oops, fail

true || echo "Will not be printed"
#

true && echo "Things went well"
# Things went well

false && echo "Will not be printed"
#

false ; echo "This will always run"
# This will always run
```





#### how to get the output  of a command as a variable?

- *command substitution* `$(CMD)`: get the output of the command and substitute it in place.
-  *process substitution* `<(CMD)`:  place the output in a temporary file and substitute the `<()` with that file’s name.

```bash
for file in $(ls) # the shell will first call ls and then iterate over those values

diff <(ls foo) <(ls bar) # show differences between files in dirs foo and bar
```



#### comparisons

Since that was a huge information dump let’s see an example that showcases some of these features.

```bash
#!/bin/bash

echo "Starting program at $(date)" # Date will be substituted

echo "Running program $0 with $# arguments with pid $$"

for file in $@; do
    grep foobar $file > /dev/null 2> /dev/null
    # When pattern is not found, grep has exit status 1
    # We redirect STDOUT and STDERR to a null register since we do not care about them
    if [[ $? -ne 0 ]]; then
        echo "File $file does not have any foobar, adding one"
        echo "# foobar" >> "$file"
    fi
done
```

When performing comparisons in bash try to use double brackets `[[ ]]` in favor of simple brackets `[ ]`. Chances of making mistakes are lower although it won’t be portable to `sh`. A more detailed explanation can be found [here](http://mywiki.wooledge.org/BashFAQ/031).
[comparating operators]
```bash
-eq # equal(number)
-ne # not equal
-lt # \leq
-gt # \geq

==  # equal(string)
!=  # not equal(string)

-d      # directory exists 
-e      # file exists
-r/w/x  # file exists and has read/write/execute permission 
```

#### shell globbing

- `?` & `*`
- curly braces `{}`

```bash
convert image.{png,jpg}
# Will expand to
convert image.png image.jpg

cp /path/to/project/{foo,bar,baz}.sh /newpath
# Will expand to
cp /path/to/project/foo.sh /path/to/project/bar.sh /path/to/project/baz.sh /newpath

# Globbing techniques can also be combined
mv *{.py,.sh} folder
# Will move all *.py and *.sh files


mkdir foo bar
# This creates files foo/a, foo/b, ... foo/h, bar/a, bar/b, ... bar/h
touch {foo,bar}/{a..j}
touch foo/x bar/y
# Show differences between files in foo and bar
diff <(ls foo) <(ls bar)
# Outputs
# < x
# ---
# > y
```



#### shebang

```python
#!/usr/local/bin/python
import sys
for arg in reversed(sys.argv[1:]):
    print(arg)
```

Note that scripts need not necessarily be written in bash to be called from the terminal.

The shell knows to execute this script with a python interpreter instead of a shell command because we included a [shebang](https://en.wikipedia.org/wiki/Shebang_(Unix)) line at the top of the script.

It is good practice to write shebang lines using the [`env`](http://man7.org/linux/man-pages/man1/env.1.html) command that will resolve to wherever the command lives in the system, increasing the portability of your scripts. 

```python
#!/usr/bin/env python
import sys
for arg in reversed(sys.argv[1:]):
    print(arg)
```

> what is the different between shell functions & shell scripts?

| shell functions                                              | shell scripts                                                |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| have to be in the same language as the shell                 | can be written in any language(This is why including a shebang for scripts is important) |
| loaded once when their definition is read(whenever you change them you will have to reload their definition) | loaded every time they are executed                          |
| executed in the current shell environment<br />can modify environment variables, e.g. change your current directory | execute in their own process<br />will be passed by value environment variables that have been exported using [`export`](http://man7.org/linux/man-pages/man1/export.1p.html) |

## Misc

- `set -e` = `set -o errexit`: used at the beginning; if any statement returns error, stop this scipt immediately. `set +e` vice versa.
## Resource
- [cesho](cecho – a function to print using different colors in bash): cecho – a function to print using different colors in bash

