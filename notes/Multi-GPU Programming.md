---
tags: [Notebooks/Programming Languages/cuda]
title: Multi-GPU Programming
created: '2020-03-12T06:50:21.868Z'
modified: '2020-03-12T07:00:40.920Z'
---

# Multi-GPU Programming

## Resources

- https://www.nvidia.com/docs/IO/116711/sc11-multi-gpu.pdf
- [CUDA Toolkit Reference Manual](https://developer.download.nvidia.cn/compute/DevZone/docs/html/C/doc/CUDA_Toolkit_Reference_Manual.pdf)

## Streams & Events

- streams and events are <u>per device(GPU)</u> and determined by the GPU that’s current at the time of their creation(`cudaSetDevice`)

  - each device has it own *default* stream(aka 0- or NULL- stream)
- Steams and:

  - Kernels: can be launched to a stream only if the stream’s GPU is current
  - Memory Copies: can be issued to any stream 
    - even if the stream doesn’t belong to current GPU
    - Driver will ensure that all calls to that stream complete before bytes are transferred
- Events: can be recorded only to a stream if the stream’s GPU is current
- Synchronization/query
  - It is OK to query of synchronize with any event/stream
  - even if stream/event does not belong to the current GPU

## Accessing other GPUs’ memory

- Two interesting aspects
  - Accessing another GPU’s addresses directly(thanks to UVA)
    -  driver/device can determine from an address where data resides
  - Peer-to-peer (P2P) memory copies

- Both require peer-access to be enabled
  - see `cudaDeviceEnablePeerAccess` and `cudaDeviceCanAccessPeer` for detail

## Code pattern

there are three patterns for multi-GPU programming: 1thread<->multi-GPU, multi-thread<->multi-GPU and multi-process<->multi-GPU.

<img src="./Multi-GPU Programming.assets/image-20200312150228153.png" alt="image-20200312150228153" style="zoom:67%;" />

*code pattern for 1thread<->multi-GPU*:

 <img src="./Multi-GPU Programming.assets/image-20200312150708128.png" alt="image-20200312150708128" /> 