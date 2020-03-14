---
tags: [Notebooks/Cheatsheet]
title: proxy
created: '2020-02-22T15:51:13.595Z'
modified: '2020-03-07T02:37:42.115Z'
---

# proxy

### ssh reverse proxy

#### 用到的ssh参数
反向代理
`ssh -fCNR`

正向代理
`ssh -fCNL`

```bash
-f 后台执行ssh指令
-C 允许压缩数据
-N 不执行远程指令
-R 将远程主机(服务器)的某个端口转发到本地端指定机器的指定端口
-L 将本地机(客户机)的某个端口转发到远端指定机器的指定端口
-p 指定远程主机的端口
```
查看ssh状态用 `ps aux | grep ssh`.

使用`autossh`保证ssh连接长时间不用不断开.

假设server B在外网, server A在内网.

- 先在srever A上把server B对应端口的流量转发回来
```bash
ssh -fCNR [B机器IP或省略]:[B机器端口]:[A机器的IP]:[A机器端口] [登陆B机器的用户名@服务器IP]
autossh -M 55555 -fCNR 2222:localhost:22 magic@47.94.219.7
```
- 然后在server B上进行本地转发
```bash
ssh -fCNL [A机器IP或省略]:[A机器端口]:[B机器的IP]:[B机器端口] [登陆B机器的用户名@B机器的IP]
ssh -fCNL *:1234:localhost:2222 localhost
```
