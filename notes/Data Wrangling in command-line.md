---
tags: [Notebooks/Cheatsheet]
title: Data Wrangling in command-line
created: '2020-02-08T12:12:25.349Z'
modified: '2020-02-27T07:20:27.657Z'
---

# Data Wrangling in command-line

[TOC]

## Reference

- https://missing.csail.mit.edu/2020/data-wrangling/


## Summary

- Regular expressions
- `sed`: Edit text in a scriptable manner
- `grep`: Matches patterns in input text
- `sort`: Sort lines of text files
- `uniq`: Output the unique lines from the given input or file. Since it does not detect repeated lines unless they are adjacent, we need to sort them firs
  t.
- `paste`: Merge lines of files
- `sh -c`: A string is executed as a complete command
- `awk`: A versatile programming language for working on files, which can do all for `sed` and `grep`
- `xargs`: Execute a command with piped arguments coming from another command, a file, etc. The input is treated as a single block of text and split into separate pieces on spaces, tabs, newlines and end-of-file.
- `bc`: Calculator
- [st](https://github.com/nferraz/st): simple statistics from the command line
- `gnuplot`: A graph plotter that outputs in several formats
- [pup](https://github.com/EricChiang/pup): Parsing HTML at the command line
- [jq](https://stedolan.github.io/jq/): a lightweight and flexible command-line JSON processor



## data filter

```bash
ssh myserver journalctl
 | grep sshd
 | grep "Disconnected from"
 | sed -E 's/.*Disconnected from (invalid |authenticating )?user (.*) [^ ]+ port [0-9]+( \[preauth\])?$/\2/'
 | sort | uniq -c
 | sort -nk1,1 | tail -n10
 | awk '{print $2}' | paste -sd,
```

- `{print $2}`: `awk` programs take the form of an optional pattern plus a block saying what to do if the pattern matches a given line. The default pattern (which we used above) matches all lines. Inside the block,`$0` is set to the entire line’s contents, and `$1` through `$n` are set to the `n`th *field* of that line, when separated by the `awk` field separator (whitespace by default, change with `-F`).



Let’s see if we can do something fancier. Let’s compute the number of single-use usernames that start with `c` and end with `e`:

```bash
 | awk '$1 == 1 && $2 ~ /^c[^ ]*e$/ { print $2 }' | wc -l
```

However, `awk` is a programming language, remember?

```bash
BEGIN { rows = 0 }
$1 == 1 && $2 ~ /^c[^ ]*e$/ { rows += $1 }
END { print rows }
```

`BEGIN` is a pattern that matches the start of the input (and `END` matches the end). Now, the per-line block just adds the count from the first field (although it’ll always be 1 in this case), and then we print it out at the end. 

In fact, we *could* get rid of `grep` and `sed` entirely, because `awk` [can do it all](https://backreference.org/2010/02/10/idiomatic-awk/), but we’ll leave that as an exercise to the reader.

### Analyzing data

You can also do math! For example, add the numbers on each line together:

```bash
 | paste -sd+ | bc -l
```

R is another (weird) programming language that’s great at data analysis and [plotting](https://ggplot2.tidyverse.org/). 

```bash
ssh myserver journalctl
 | grep sshd
 | grep "Disconnected from"
 | sed -E 's/.*Disconnected from (invalid |authenticating )?user (.*) [^ ]+ port [0-9]+( \[preauth\])?$/\2/'
 | sort | uniq -c
 | awk '{print $1}' | R --slave -e 'x <- scan(file="stdin", quiet=TRUE); summary(x)'
```

### Data wrangling to make arguments

Sometimes you want to do data wrangling to find things to install or remove based on some longer list. The data wrangling we’ve talked about so far + `xargs` can be a powerful combo:

```bash
rustup toolchain list | grep nightly | grep -vE "nightly-x86" | sed 's/-x86.*//' | xargs rustup toolchain uninstall
```

### Wrangling binary data

So far, we have mostly talked about wrangling textual data, but pipes are just as useful for binary data. For example, we can use `ffmpeg` to capture an image from our camera, convert it to grayscale, compress it, send it to a remote machine over SSH, decompress it there, make a copy, and then display it.

```bash
ffmpeg -loglevel panic -i /dev/video0 -frames 1 -f image2 -
 | convert - -colorspace gray -
 | gzip
 | ssh mymachine 'gzip -d | tee copy.jpg | env DISPLAY=:0 feh -'
```

### Misc

```bash
tr -cd "[0-9]" filter out all the numbers
```

