---
tags: [Notebooks/Cheatsheet]
title: vim
created: '2020-02-05T18:35:20.114Z'
modified: '2020-02-18T14:31:28.328Z'
---

# vim

## Tabs
https://www.linux.com/tutorials/vim-tips-using-tabs/

## Windows
 https://thoughtbot.com/blog/vim-splits-move-faster-and-more-naturally
  - Note that `C-w` means closing current windows in Win, therefore we can use different key mappings for easy navigation between splits to save a keystroke.
  ```bash
  nnoremap <C-J> <C-W><C-J>
  nnoremap <C-K> <C-W><C-K>
  nnoremap <C-L> <C-W><C-L>
  nnoremap <C-H> <C-W><C-H>
  ```

## Macro: 
   - https://blog.confirm.ch/mastering-vim-undo-redo-and-repeat/
   - https://learnku.com/articles/21986

## Register
- https://medium.com/vim-drops/vim-registers-the-powerful-native-clipboard-19b1c97891bd
- https://www.brianstorti.com/vim-registers/
- access the system clipboard: https://vim.fandom.com/wiki/Accessing_the_system_clipboard

> Tip:
> - Registers are being stored in ~/.viminfo, and will be loaded again on next restart of vim.
> - Register 0 contains always the value of the last yank command.
