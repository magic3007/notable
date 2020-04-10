---
tags: [lecture script, Notebooks/Research/Accelerator]
title: BiS-KM (Paper Script)
created: '2020-02-28T03:01:22.469Z'
modified: '2020-02-28T03:26:32.882Z'
---

# BiS-KM  (Paper Script)

*Source: BiS-KM:EnablingAny-PrecisionK-MeansonFPGAs FPGA 2020*


> Q: 如何量化一个浮点数?

<img src="./Quantization Tech.assets/image-20200228110236258.png" alt="image-20200228110236258" style="zoom: 67%;" />


> Q: 1. 如何做到任意低精度乘上高精度?
>
>    2. 进一步, 一个任意低精度向量和一个高精度向量做点积? 怎么设计架构以提供利用率?

Q1: Bit-Serial Multiplier

<img src="./BiS-KM (Paper Script).assets/image-20200228142619293.png" alt="image-20200228142619293" style="zoom:67%;" />

Q2: Bit-Serial DSP架构

<img src="./BiS-KM (Paper Script).assets/image-20200228142651665.png" alt="image-20200228142651665" style="zoom:50%;" />

<img src="./BiS-KM (Paper Script).assets/image-20200228142706968.png" alt="image-20200228142706968" style="zoom:80%;" />

> 用欧式距离是否合算? 资源利用率高吗?

在充分利用带宽W(=512)的要求下, 对于K(=8)个cluster, 需要W*K=4096个$P_h(=32) \times P_h$的个乘法单元.

同时由于bit-serial, $P_l$个周期后才有一个完整的数, 资源时间利用率只有$\frac{1}{P_l}$.

我们只关心最值, 时间上只关心点积.

<img src="./BiS-KM (Paper Script).assets/image-20200228143342615.png" alt="image-20200228143342615" style="zoom:80%;" />

> 现在有两种并行的方式, 样本间并行和特征间并行. 他们的优缺点分别是什么? pipeline的策略又是什么?
>
> <img src="./BiS-KM (Paper Script).assets/image-20200228143455323.png" alt="image-20200228143455323" style="zoom:80%;" />

样本间并行: 资源消耗多 M * K = 4096个Bit-Serial Multiplier

特征间并行: 片上带宽需求大

解决策略是两种的融合

<img src="./BiS-KM (Paper Script).assets/image-20200228143602691.png" alt="image-20200228143602691" style="zoom:80%;" />

pipeline的策略选择cluster之间pipeline. 最终的架构如下.

<img src="./BiS-KM (Paper Script).assets/image-20200228143906230.png" alt="image-20200228143906230" style="zoom:80%;" />

<img src="./BiS-KM (Paper Script).assets/image-20200228143915389.png" alt="image-20200228143915389" style="zoom:80%;" />