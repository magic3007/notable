---
tags: [Notebooks/Cheatsheet/Metaprogramming]
title: X11-forwarding
created: '2020-05-20T13:27:10.080Z'
modified: '2020-05-22T03:24:23.734Z'
---

# X11-forwarding

```bash
# server
sudo apt-get install openssh-server

#client
sudo apt-get install openssh-client

# server
vim /etc/ssh/sshd_config
# X11Forwarding yes
# X11UseLocalhost no
service ssh restart

# client
ssh -X <username>@<host_IP>

# test on server
sudo apt install x11-apps
xclock
```

