---
tags: [Notebooks/Cheatsheet]
title: Debugging and Profiling
created: '2020-02-09T14:54:37.819Z'
modified: '2020-03-09T06:42:52.801Z'
---

# Debugging and Profiling

[TOC]



## Debugging

### Print debugging and Logging

Logging is better than regular print statements for several reasons:

- You can log to files, sockets or even remote servers instead of standard output.
- Logging supports severity levels (such as INFO, DEBUG, WARN, ERROR, &c), that allow you to filter the output accordingly.
- For new issues, there’s a fair chance that your logs will contain enough information to detect what is going wrong.

### Third party logs

Luckily, most programs write their own logs somewhere in your system. In UNIX systems, it is commonplace for programs to write their logs under `/var/log`. For instance, the [NGINX](https://www.nginx.com/) webserver places its logs under `/var/log/nginx`.

More recently, systems have started using a **system log**, which is increasingly where all of your log messages go. Most (but not all) Linux systems use `systemd`, a system daemon that controls many things in your system such as which services are enabled and running. `systemd` places the logs under `/var/log/journal` in a specialized format and you can use the [`journalctl`](http://man7.org/linux/man-pages/man1/journalctl.1.html) command to display the messages. 

Similarly, on macOS there is still `/var/log/system.log` but an increasing number of tools use the system log, that can be displayed with [`log show`](https://www.manpagez.com/man/1/log/). On most UNIX systems you can also use the [`dmesg`](http://man7.org/linux/man-pages/man1/dmesg.1.html) command to access the **kernel log**.

For logging under the system logs you can use the [`logger`](http://man7.org/linux/man-pages/man1/logger.1.html) shell program. Here’s an example of using `logger` and how to check that the entry made it to the system logs. Moreover, most programming languages have bindings logging to the system log.

```bash
logger "Hello Logs"
# On macOS
log show --last 1m | grep Hello
# On Linux
journalctl --since "1m ago" | grep Hello
```

There are also some tools like [`lnav`](http://lnav.org/), that provide an improved presentation and navigation for log files.

### Debuggers

Many programming languages come with some form of debugger. In Python this is the Python Debugger [`pdb`](https://docs.python.org/3/library/pdb.html). [`ipdb`](https://pypi.org/project/ipdb/) is an improved `pdb` that uses the [`IPython`](https://ipython.org/) REPL enabling tab completion, syntax highlighting, better tracebacks, and better introspection while retaining the same interface as the `pdb` module.

For more low level programming you will probably want to look into [`gdb`](https://www.gnu.org/software/gdb/) (and its quality of life modification [`pwndbg`](https://github.com/pwndbg/pwndbg)) and [`lldb`](https://lldb.llvm.org/). They are optimized for C-like language debugging but will let you probe pretty much any process and get its current machine state: registers, stack, program counter, &c.

### Specialized Tools

There are commands that let you trace the **syscalls** your program makes. In Linux there’s [`strace`](http://man7.org/linux/man-pages/man1/strace.1.html) and macOS and BSD have [`dtrace`](http://dtrace.org/blogs/about/). `dtrace` can be tricky to use because it uses its own `D` language, but there is a wrapper called [`dtruss`](https://www.manpagez.com/man/1/dtruss/) that provides an interface more similar to `strace` (more details [here](https://8thlight.com/blog/colin-jones/2015/11/06/dtrace-even-better-than-strace-for-osx.html)).

Below are some examples of using `strace` or `dtruss` to show [`stat`](http://man7.org/linux/man-pages/man2/stat.2.html) syscall traces for an execution of `ls`. For a deeper dive into `strace`, [this](https://blogs.oracle.com/linux/strace-the-sysadmins-microscope-v2) is a good read.

```bash
# On Linux
sudo strace -e lstat ls -l > /dev/null
4
# On macOS
sudo dtruss -t lstat64_extended ls -l > /dev/null
```

Under some circumstances, you may need to look at the **network packets** to figure out the issue in your program. Tools like [`tcpdump`](http://man7.org/linux/man-pages/man1/tcpdump.1.html) and [Wireshark](https://www.wireshark.org/) are network packet analyzers that let you read the contents of network packets and filter them based on different criteria.

For **web development**, the Chrome/Firefox developer tools are quite handy. They feature a large number of tools, including:

- Source code - Inspect the HTML/CSS/JS source code of any website.
- Live HTML, CSS, JS modification - Change the website content, styles and behavior to test (you can see for yourself that website screenshots are not valid proofs).
- Javascript shell - Execute commands in the JS REPL.
- Network - Analyze the requests timeline.
- Storage - Look into the Cookies and local application storage.

### Static Analysis

Static analysis programs take source code as input and analyze it using coding rules to reason about its correctness.

Static analysis for <u>python</u>:

- we run [`pyflakes`](https://pypi.org/project/pyflakes) on the code we get the errors related to both bugs
-  [`mypy`](http://mypy-lang.org/) is another tool that can detect type checking issues

Static analysis for <u>shell scripts</u>:

-  [`shellcheck`](https://www.shellcheck.net/)

  #### code linting

Most editors and IDEs support displaying the output of these tools within the editor itself, highlighting the locations of warnings and errors. This is often called **code linting** and it can also be used to display other types of issues such as stylistic violations or insecure constructs.

In <u>vim</u>, the plugins [`ale`](https://vimawesome.com/plugin/ale) or [`syntastic`](https://vimawesome.com/plugin/syntastic) will let you do that. 

For <u>Python</u>, [`pylint`](https://www.pylint.org/) and [`pep8`](https://pypi.org/project/pep8/) are examples of stylistic linters and [`bandit`](https://pypi.org/project/bandit/) is a tool designed to find common security issues. 

For other languages people have compiled comprehensive lists of useful static analysis tools, such as [Awesome Static Analysis](https://github.com/mre/awesome-static-analysis) (you may want to take a look at the *Writing* section) and for linters there is [Awesome Linters](https://github.com/caramelomartins/awesome-linters).

A complementary tool to stylistic linting are code formatters such as [`black`](https://github.com/psf/black) for Python, `gofmt` for Go or `rustfmt` for Rust. These tools autoformat your code so that it’s consistent with common stylistic patterns for the given programming language. Although you might be unwilling to give stylistic control about your code, standardizing code format will help other people read your code and will make you better at reading other people’s (stylistically standardized) code.



## Profiling

### Timing

<u>wall clock time</u> can be misleading since your computer might be running other processes at the same time or waiting for events to happen. It is common for tools to make a distinction between *Real*, *User* and *Sys* time. In general, *User* + *Sys* tells you how much time your process actually spent in the CPU (more detailed explanation [here](https://stackoverflow.com/questions/556405/what-do-real-user-and-sys-mean-in-the-output-of-time1)).

###  Profilers

#### CPU

There are two main types of CPU profilers: *tracing* and *sampling* profilers. 

- Tracing profilers keep a record of every function call your program makes

- sampling profilers probe your program periodically (commonly every millisecond) and record the program’s stack. They use these records to present aggregate statistics of what your program spent the most time doing.

[Here](https://jvns.ca/blog/2017/12/17/how-do-ruby---python-profilers-work-) is a good intro article if you want more detail on this topic.

Most programming languages have some sort of command line profiler that you can use to analyze your code. They often integrate with full fledged IDEs but for this lecture we are going to focus on the command line tools themselves.

In Python we can use the `cProfile` module to profile time per function call.

If we used Python’s `cProfile` profiler and got lots of lines of output, and even with sorting it’d be hard to understand where the time is being spent. A quick run with [`line_profiler`](https://github.com/rkern/line_profiler) shows the time taken per line.

#### Memory

In languages like C or C++ memory leaks can cause your program to never release memory that it doesn’t need anymore. To help in the process of memory debugging you can use tools like [Valgrind](https://valgrind.org/) that will help you identify memory leaks.

In garbage collected languages like Python it is still useful to use a memory profiler because as long as you have pointers to objects in memory they won’t be garbage collected. Here’s an example program and its associated output when running it with [memory-profiler](https://pypi.org/project/memory-profiler/) (note the decorator like in `line-profiler`).

```python
@profile
def my_func():
    a = [1] * (10 ** 6)
    b = [2] * (2 * 10 ** 7)
    del b
    return a

if __name__ == '__main__':
    my_func()
```

```
$ python -m memory_profiler example.py
Line #    Mem usage  Increment   Line Contents
==============================================
     3                           @profile
     4      5.97 MB    0.00 MB   def my_func():
     5     13.61 MB    7.64 MB       a = [1] * (10 ** 6)
     6    166.20 MB  152.59 MB       b = [2] * (2 * 10 ** 7)
     7     13.61 MB -152.59 MB       del b
     8     13.61 MB    0.00 MB       return a
```

#### Event Profiling

The [`perf`](http://man7.org/linux/man-pages/man1/perf.1.html) command abstracts CPU differences away and does not report time or memory, but instead it reports system events related to your programs. For example, `perf` can easily report poor cache locality, high amounts of page faults or livelocks. Here is an overview of the command:

- `perf list` - List the events that can be traced with perf
- `perf stat COMMAND ARG1 ARG2` - Gets counts of different events related a process or command
- `perf record COMMAND ARG1 ARG2` - Records the run of a command and saves the statistical data into a file called `perf.data`
- `perf report` - Formats and prints the data collected in `perf.data`

`gprof` is another type of tool called a profiler. Profiling allows you to learn where your program spent its time and which functions called which other functions while it was executing.

#### Visualization

One common way to display CPU profiling information for sampling profilers is to use a [Flame Graph](http://www.brendangregg.com/flamegraphs.html), which will display a hierarchy of function calls across the Y axis and time taken proportional to the X axis. They are also interactive, letting you zoom into specific parts of the program and get their stack traces.

In Python you can use the [`pycallgraph`](http://pycallgraph.slowchop.com/en/master/) library to generate them.
#### Disk Reading/Writing Spead

- [hdparm](http://man7.org/linux/man-pages/man8/hdparm.8.html) is a command line program for Linux to set and view ATA hard disk drive hardware parameters and test performance.

- [dd](http://man7.org/linux/man-pages/man1/dd.1.html): a command-line utility for Unix and Unix-like operating systems whose primary purpose is to convert and copy files

```bash
fdisk -l # acquire the name of disk device

# read
hdparm -tT <path to disk device>

# write
time dd if=/dev/zero bs=1024 count=1000000 of=/1Gb.file


```

#### Resource Monitoring

- **I/O operations** - [`iotop`](http://man7.org/linux/man-pages/man8/iotop.8.html) displays live I/O usage information and is handy to check if a process is doing heavy I/O disk operations
- **Disk Usage** - [`df`](http://man7.org/linux/man-pages/man1/df.1.html) displays metrics per partitions and [`du`](http://man7.org/linux/man-pages/man1/du.1.html) displays **d**isk **u**sage per file for the current directory. In these tools the `-h` flag tells the program to print with **h**uman readable format. A more interactive version of `du` is [`ncdu`](https://dev.yorhel.nl/ncdu) which lets you navigate folders and delete files and folders as you navigate.
- **Memory Usage** - [`free`](http://man7.org/linux/man-pages/man1/free.1.html) displays the total amount of free and used memory in the system. Memory is also displayed in tools like `htop`.
- **Open Files** - [`lsof`](http://man7.org/linux/man-pages/man8/lsof.8.html) lists file information about files opened by processes. It can be quite useful for checking which process has opened a specific file.
- **Network Connections and Config** - [`ss`](http://man7.org/linux/man-pages/man8/ss.8.html) lets you monitor incoming and outgoing network packets statistics as well as interface statistics. A common use case of `ss` is figuring out what process is using a given port in a machine. For displaying routing, network devices and interfaces you can use [`ip`](http://man7.org/linux/man-pages/man8/ip.8.html). Note that `netstat` and `ifconfig` have been deprecated in favor of the former tools respectively.
- **Network Usage** - [`nethogs`](https://github.com/raboof/nethogs) and [`iftop`](http://www.ex-parrot.com/pdw/iftop/) are good interactive CLI tools for monitoring network usage.

- **Hardware Summary**: `dmidecode` gives a description of the system's hardware components

If you want to test these tools you can also artificially impose loads on the machine using the [`stress`](https://linux.die.net/man/1/stress) command.

#### Specialized tools

Sometimes, black box benchmarking is all you need to determine what software to use. Tools like [`hyperfine`](https://github.com/sharkdp/hyperfine) let you quickly benchmark command line programs. For instance, in the shell tools and scripting lecture we recommended `fd` over `find`. We can use `hyperfine` to compare them in tasks we run often. 

```bash
$ hyperfine --warmup 3 'fd -e jpg' 'find . -iname "*.jpg"'
Benchmark #1: fd -e jpg
  Time (mean ± σ):      51.4 ms ±   2.9 ms    [User: 121.0 ms, System: 160.5 ms]
  Range (min … max):    44.2 ms …  60.1 ms    56 runs

Benchmark #2: find . -iname "*.jpg"
  Time (mean ± σ):      1.126 s ±  0.101 s    [User: 141.1 ms, System: 956.1 ms]
  Range (min … max):    0.975 s …  1.287 s    10 runs

Summary
  'fd -e jpg' ran
   21.89 ± 2.33 times faster than 'find . -iname "*.jpg"'
```

As it was the case for debugging, browsers also come with a fantastic set of tools for profiling webpage loading, letting you figure out where time is being spent (loading, rendering, scripting, &c). More info for [Firefox](https://developer.mozilla.org/en-US/docs/Mozilla/Performance/Profiling_with_the_Built-in_Profiler) and [Chrome](https://developers.google.com/web/tools/chrome-devtools/rendering-toolss).
