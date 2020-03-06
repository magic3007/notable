---
tags: [Notebooks/Cheatsheet]
title: git
created: '2020-02-06T16:36:53.319Z'
modified: '2020-03-06T09:07:33.719Z'
---

# git

## Reference

- https://missing.csail.mit.edu/2020/version-control/
- [a note about git commit messages](https://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html).

[TOC]

## config

```bash


git config --list
git config --global <key-name> <value>
git config --global --unset <key-name>

# [proxy]
# relative key-names: http.proxy https.proxy http.proxy

# [password-free]
# add RSA public key to github in advance
git config --global credential.helper store
```

## push

```bash
git push -u <name> <branch>
#  -u, --set-upstream     add upstream (tracking) reference
# eg. git push -u origin master
```

## checkout
```bash
# a new branch to be created as if git-branch(1) were called and then checked out.
# If -B is given, <new_branch> is created if it doesn’t exist; otherwise, it is reset.
git checkout -b|-B <new_branch> [<start point>]  
```

## remote
```bash
git remote -v

git remote add [<options>] <name> <url>
# -f, --fetch           fetch the remote branches
# eg. git remote add origin  <url>.git

git remote set-url origin <url>.git
```

## archive

```bash
git archive -o latest.zip HEAD
```





```







