---
tags: [Notebooks/Cheatsheet]
title: proxychains
created: '2020-06-03T05:51:39.357Z'
modified: '2020-06-03T06:07:17.244Z'
---

# proxychains


## WSL2

- https://blog.xhyh.best/tutorial/windows-wsl2-env/
```bash
# 目前 WSL 2 和 windows 的 ip 不同

cp -f /etc/proxychains.conf ~/.proxychains.conf

# 获取windows的ip
export WIN_IP=`cat /etc/resolv.conf | grep nameserver | awk '{print $2}'`

# 删除 ~/.proxychains.conf 中 [ProxyList] 所在行到文件末尾的全部内容
sed -i '/\[ProxyList\]/,$d' ~/.proxychains.conf

# 往文件末尾添加socks5设置
echo '[ProxyList]\nsocks5 '${WIN_IP}' 10835' >> ~/.proxychains.conf

alias pc='proxychains4 -q -f ~/.proxychains.conf'
```
