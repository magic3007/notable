---
tags: [Notebooks/Cheatsheet/Metaprogramming]
title: Metaprogramming
created: '2020-02-14T15:50:18.269Z'
modified: '2020-02-23T07:29:44.448Z'
---

# Metaprogramming

## Build Systems

- [make]()
- [cmake]()
- [gradle](https://gradle.org/)


## Dependency management

These days, most dependencies will be available through a repository that hosts a large number of such dependencies in a single place, and provides a convenient mechanism for installing them. Some examples include the Ubuntu package repositories for Ubuntu system packages, which you access through the apt tool, RubyGems for Ruby libraries, PyPi for Python libraries, or the Arch User Repository for Arch Linux user-contributed packages.

 The exact meaning of each one varies between projects, but one relatively common standard is semantic versioning. With semantic versioning, every version number is of the form: `major.minor.patch`. The rules are:
- If a new release does not change the API, increase the patch version.
- If you add to your API in a backwards-compatible way, increase the minor version.
- If you change the API in a non-backwards-compatible way, increase the major version.

## Continuous integration systems

## Testing


## Reference

- https://missing.csail.mit.edu/2020/metaprogramming/
