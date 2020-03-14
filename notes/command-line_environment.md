---
tags: [Notebooks/Cheatsheet]
title: command-line environment
created: '2020-02-09T12:27:53.581Z'
modified: '2020-03-09T09:29:41.869Z'
---

# command-line environment

## Reference

- https://missing.csail.mit.edu/2020/command-line/

[TOC]

## Job Control

### killing  a process

- `SIGINT`: <kbd>Ctrl-C</kbd>
- `SINQUIT`: <kbd>Ctrl-\\</kbd>
- `SIGTERM`: To send this signal we can use the [kill](http://man7.org/linux/man-pages/man1/kill.1.html) command, with the syntax `kill -TERM <pid>`.

A special signal is `SIGKILL` since it cannot be captured by the process and it will always terminate it immediately. However, it can have bad side effects such as leaving orphaned children processes.

You can learn more about these and other signals [here](https://en.wikipedia.org/wiki/Signal_(IPC)) or typing [`man signal`](http://man7.org/linux/man-pages/man7/signal.7.html) or `kill -t`.

### Pausing and backgrounding processes

- `SIGSTOP`: `Ctrl-Z`
-  [`fg`](http://man7.org/linux/man-pages/man1/fg.1p.html) or [`bg`](http://man7.org/linux/man-pages/man1/bg.1p.html): continue the paused job in the foreground or in the background
- `jobs`: lists the unfinished jobs <u>associated with the current terminal session</u>.
- [`pgrep`](http://man7.org/linux/man-pages/man1/pgrep.1.html): Find or signal process by name

More intuitively, you can also refer to a process using the percent symbol `%` followed by its job number (displayed by `jobs`). To refer to the last backgrounded job you can use the `$!` environment variable.

One more thing to know is that the `&` suffix in a command will run the command in the background, giving you the prompt back, although it will still use the shell’s STDOUT which can be annoying (use shell redirections in that case).

To background an already running program you can do `Ctrl-Z` followed by `bg`. Note that backgrounded processes are still children processes of your terminal and will die if you close the terminal (this will send yet another signal, `SIGHUP`). To prevent that from happening you can run the program with [`nohup`](http://man7.org/linux/man-pages/man1/nohup.1.html) (a wrapper to ignore `SIGHUP`), or use `disown` if the process has already been started. Alternatively, you can use a terminal multiplexer  like `tmux`.

## Terminal Multiplexers

The most popular terminal multiplexer these days is [`tmux`](http://man7.org/linux/man-pages/man1/tmux.1.html). 

For further reading, [here](https://www.hamvocke.com/blog/a-quick-and-easy-guide-to-tmux/) is a quick tutorial on `tmux` and [this](http://linuxcommand.org/lc3_adv_termmux.php) has a more detailed explanation that covers the original `screen` command. You might also want to familiarize yourself with [`screen`](http://man7.org/linux/man-pages/man1/screen.1.html), since it comes installed in most UNIX systems.

## Mount

```bash
# Show all mounted filesystems
mount

# Mount a device to a directory
# filesystem_type: ext4
mount -t {{filesystem_type}} {{path/to/device_file}} {{path/to/target_directory}} 
```
##  Privilege

```bash
adduser <username>
passwd <username>

# sudo privilege is configured in /etc/sudoers

# Ubuntu
sudo usermod -aG sudo <username>
# CentOS
sudo usermod -aG wheel <username>
```

## File Compression and Depression

```bash

# .iso file
# mount an ISO image in read-only mode using the loop device 
# and then copy files to another directory.
# -o loop: mount the iso file like a disk
sudo mkdir /mnt/isoimage
sudo mount -o loop <.iso file> /mnt/isomage
ls /mnt/isoimage
cp -r /mnt/isoimage /tmp
```

## Aliases

```bash
# Make shorthands for common flags
alias ll="ls -lh"

# Save a lot of typing for common commands
alias gs="git status"
alias gc="git commit"
alias v="vim"

# Save you from mistyping
alias sl=ls

# Overwrite existing commands for better defaults
alias mv="mv -i"           # -i prompts before overwrite
alias mkdir="mkdir -p"     # -p make parent dirs as needed
alias df="df -p"           # -h prints human readable format

# Alias can be composed
alias la="ls -A"
alias lla="la -l"

# To ignore an alias run it prepended with \
\ls
# Or disable an alias altogether with unalias
unalias la

# To get an alias definition just call it with alias
alias ll
# Will print ll='ls -lh'
```

because [`alias`](http://man7.org/linux/man-pages/man1/alias.1p.html) is a shell command that takes a <u>single</u> argument.

## Dotfiles

Many programs are configured using plain-text files known as *dotfiles*. [Here](https://blog.flowblok.id.au/2013-02/shell-startup-scripts.html) is an excellent resource on the topic.

> What is the shell startup process?

All shells will first run `env`, then login shells will run `login`, then interactive shells will run `interactive`. Once finished, login shells will run `logout`.

- If is setting  or modifying environment variables, it should go in `login`.
- If it’s alias or a terminal-specific environment variable (e.g., GREP_COLOR), it should go in `interactive`. 



> How should you organize your dotfiles? 

They should be in their own folder, under version control, and **symlinked** into place using a script. This has the benefits of:

- **Easy installation**: if you log in to a new machine, applying your customizations will only take a minute.
- **Portability**: your tools will work the same way everywhere.
- **Synchronization**: you can update your dotfiles anywhere and keep them all in sync.
- **Change tracking**: you’re probably going to be maintaining your dotfiles for your entire programming career, and version history is nice to have for long-lived projects.

What should you put in your dotfiles? You can learn about your tool’s settings by reading online documentation or [man pages](https://en.wikipedia.org/wiki/Man_page). Another great way is to search the internet for blog posts about specific programs, where authors will tell you about their preferred customizations. Yet another way to learn about customizations is to look through other people’s dotfiles: you can find tons of [dotfiles repositories](https://github.com/search?o=desc&q=dotfiles&s=stars&type=Repositories) on — see the most popular one [here](https://github.com/mathiasbynens/dotfiles) (we advise you not to blindly copy configurations though). [Here](https://dotfiles.github.io/) is another good resource on the topic.

All of the class instructors have their dotfiles publicly accessible on GitHub: [Anish](https://github.com/anishathalye/dotfiles), [Jon](https://github.com/jonhoo/configs), [Jose](https://github.com/jjgo/dotfiles).



## Remote Machines

As with most tools covered, Secure Shell (SSH) is highly configurable so it is worth learning about it.

### Executing commands

An often overlooked feature of `ssh` is the ability to run commands directly. `ssh foobar@server ls` will execute `ls` in the home folder of foobar.

It also works with pipes,  

- `ssh foobar@server ls | grep PATTERN` will grep locally the remote output of `ls` 
-  `ls | ssh foobar@server grep PATTERN` will grep remotely the local output of `ls`

### SSH Keys

Nevertheless, the private key (often `~/.ssh/id_rsa` and more recently `~/.ssh/id_ed25519`) is effectively your password, so treat it like so.

#### Key generation

To generate a pair you can run [`ssh-keygen`](http://man7.org/linux/man-pages/man1/ssh-keygen.1.html).

```bash
ssh-keygen -o -a 100 -t ed25519 -f ~/.ssh/id_ed25519
```

You should choose a passphrase, to avoid someone who gets ahold of your private key to access authorized servers. Use [`ssh-agent`](http://man7.org/linux/man-pages/man1/ssh-agent.1.html) or [`gpg-agent`](https://linux.die.net/man/1/gpg-agent) so you do not have to type your passphrase every time.

If you have ever configured pushing to GitHub using SSH keys, then you have probably done the steps outlined [here](https://help.github.com/articles/connecting-to-github-with-ssh/) and have a valid key pair already. To check if you have a passphrase and validate it you can run `ssh-keygen -y -f /path/to/key`.

#### Key based authentication

`ssh` will look into `.ssh/authorized_keys` to determine which clients it should let in. To copy a public key over you can use:

```bash
cat .ssh/id_ed25519.pub | ssh foobar@remote 'cat >> ~/.ssh/authorized_keys'
```

A simpler solution can be achieved with `ssh-copy-id` where available:

```bash
ssh-copy-id -i .ssh/id_ed25519.pub foobar@remote
```

#### Copying files over SSH

There are many ways to copy files over ssh:

- `ssh+tee`, the simplest is to use `ssh` command execution and STDIN input by doing `cat localfile | ssh remote_server tee serverfile`
  - Recall that [`tee`](http://man7.org/linux/man-pages/man1/tee.1.html) writes the output from STDIN into a file.
- [`scp`](http://man7.org/linux/man-pages/man1/scp.1.html) when copying large amounts of files/directories, the secure copy `scp` command is more convenient since it can easily recurse over paths. The syntax is `scp path/to/local_file remote_host:path/to/remote_file`
- [`rsync`](http://man7.org/linux/man-pages/man1/rsync.1.html) improves upon `scp` by detecting identical files in local and remote, and preventing copying them again. It also provides more fine grained control over symlinks, permissions and has extra features like the `--partial` flag that can resume from a previously interrupted copy. `rsync` has a similar syntax to `scp`

#### Port Forwarding

 *port forwarding*  comes in two flavors: Local Port Forwarding and Remote Port Forwarding (see the pictures for more details, credit of the pictures from [this StackOverflow post](https://unix.stackexchange.com/questions/115897/whats-ssh-port-forwarding-and-whats-the-difference-between-ssh-local-and-remot)).

##### Local Port Forwarding

![Local Port Forwarding](https://i.stack.imgur.com/a28N8.png%C2%A0)

##### Remote Port Forwarding

![Remote Port Forwarding](https://i.stack.imgur.com/4iK3b.png%C2%A0)

The most common scenario is local port forwarding.  For example, if we execute `jupyter notebook` in the remote server that listens to the port `8888`. Thus, to forward that to the local port `9999`, we would do `ssh -L 9999:localhost:8888 foobar@remote_server` and then navigate to `locahost:9999` in our local machine.

#### SSH Configuration

there is a better alternative using `~/.ssh/config` for setting local port forwarding.

```bash
Host vm
    User foobar
    HostName 172.16.174.141
    Port 2222
    IdentityFile ~/.ssh/id_ed25519
    RemoteForward 9999 localhost:8888

# Configs can also take wildcards
Host *.mit.edu
    User foobaz
```

An additional advantage of using the `~/.ssh/config` file over aliases is that other programs like `scp`, `rsync`, `mosh`, &c are able to read it as well and convert the settings into the corresponding flags.

Server side configuration is usually specified in `/etc/ssh/sshd_config`. Here you can make changes like

- disabling password authentication

- changing ssh ports

- enabling X11 forwarding

  You can specify config settings in a per user basis.

#### Miscellaneous

A common pain when connecting to a remote server are disconnections due to shutting down/sleeping your computer or changing a network. Moreover if one has a connection with significant lag using ssh can become quite frustrating. [Mosh](https://mosh.org/), the mobile shell, improves upon ssh, allowing roaming connections, intermittent connectivity and providing intelligent local echo.

Sometimes it is convenient to mount a remote folder. [sshfs](https://github.com/libfuse/sshfs) can mount a folder on a remote server locally, and then you can use a local editor.

## Shells & Frameworks

the `zsh` shell is a superset of `bash` and provides many convenient features.

**Frameworks** can improve your shell as well. Some popular general frameworks are [prezto](https://github.com/sorin-ionescu/prezto) or [oh-my-zsh](https://github.com/robbyrussll/oh-my-zsh), and smaller ones that focus on specific features such as [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) or [zsh-history-substring-search](https://github.com/zsh-users/zsh-history-substring-search). Shells like [fish](https://fishshell.com/) include many of these user-friendly features by default.

## Terminal Emulators

Along with customizing your shell, it is worth spending some time figuring out your choice of **terminal emulator** and its settings, like `xterm`. There are many many terminal emulators out there (here is a [comparison](https://anarc.at/blog/2018-04-12-terminal-emulators-1/)).

Since you might be spending hundreds to thousands of hours in your terminal it pays off to look into its settings. Some of the aspects that you may want to modify in your terminal include:

- Font choice
- Color Scheme
- Keyboard shortcuts
- Tab/Pane support
- Scrollback configuration
- Performance (some newer terminals like [Alacritty](https://github.com/jwilm/alacritty) or [kitty](https://sw.kovidgoyal.net/kitty/) offer GPU acceleration).

