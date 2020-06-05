---
tags: [Notebooks/Cheatsheet]
title: Finding & Navigation in command-line
created: '2020-02-05T09:57:04.296Z'
modified: '2020-05-22T14:00:42.194Z'
---

# Finding & Navigation in command-line


[TOC]


## Reference

- https://missing.csail.mit.edu/2020/shell-tools/



### Finding how to use commands

- `-h` or `–-help` flag
-  `man` command. 
-  [TLDR pages](https://tldr.sh/): Simplified and community-driven man pages

### Finding files

`find` will recursively search for files matching some criteria. Use `tldr find` for more examples.

```bash


# Find all directories named src
find . -name src -type d
# Find all python files that have a folder named test in their path
find . -path '**/test/**/*.py' -type f
# Find all files modified in the last day
find . -mtime -1
# Find all zip files with size in range 500k to 10M
find . -size +500k -size -10M -name '*.tar.gz'
```

find can also perform actions over files that match your query. 

```bash
# Delete all files with .tmp extension
find . -name '*.tmp' -exec rm {} \;
# Find all PNG files and convert them to JPG
find . -name '*.png' -exec convert {} {.}.jpg \;
```

 [`fd`](https://github.com/sharkdp/fd) is a simple, fast and user-friendly alternative to `find`. It offers some nice defaults like colorized output, default regex matching, Unicode support and it has in what my opinion is a more intuitive syntax. The syntax to find a pattern `PATTERN` is `fd PATTERN`.

### Finding code

- `grep`. Use `tldr find` for more examples.

- `grep -R`(recursively go into directories and look for text files for the matching string) could by improved in many ways. So there has been no shortage of alternatives developed, including [ack](https://beyondgrep.com/), [ag](https://github.com/ggreer/the_silver_searcher) and [rg](https://github.com/BurntSushi/ripgrep). All of them are fantastic but pretty much cover the same need.  

- For now I am sticking with ripgrep (`rg`) given how fast and intuitive is. Some examples:

  ```bash
  # 将当前目录(包括子目录)中所有txt文件中的yyyy字符串替换为xxxx字符串
  sed -i s/yyyy/xxxx/g `grep yyyy -rl --include="*.txt" ./`

  # Find all python files where I used the requests library
  rg -t py 'import requests'
  # Find all files (including hidden files) without a shebang line
  rg -u --files-without-match "^#!"
  # Find all matches of foo and print the following 5 lines
  rg foo -A 5
  # Print statistics of matches (# of matched lines and files )
  rg --stats PATTERN
  ```

### Finding shell commands

- command `history`
- `Ctrl+R`: backwards search through your history
- `fzf`:  A command-line fuzzy finder
- [fishshell](https://fishshell.com/): history-based autosuggestions

Lastly, a thing to have in mind is that if you start a command with a leading space <u>it won’t be added to you shell history</u>. If you make the mistake of not adding the leading space you can always manually remove the entry by editing your `.bash_history` or `.zhistory`.

### Directory Navigation

- [fasd](https://github.com/clvv/fasd): offers quick access to files and directories, inspired by autojump, z and v.

More complex tools exist to quickly get an overview of a directory structure [`tree`](https://linux.die.net/man/1/tree), [`broot`](https://github.com/Canop/broot) or even full fledged file managers like [`nnn`](https://github.com/jarun/nnn) or [`ranger`](https://github.com/ranger/ranger)


### Execuating instructions

[xargs](http://man7.org/linux/man-pages/man1/xargs.1.html) command which will execute a command using STDIN as arguments. For example `ls | xargs rm` will delete the files in the current directory.

This example finds all HTML files in the folder and makes a zip with them. Note that your command should work even if the files have spaces. Bash uses space as delimiter by default. If any argument has space, we can use `\n`.
```bash
find . -name '*.html' -exec echo {} \; | xargs -d '\n' zip -r lalala.zip
```


​	
