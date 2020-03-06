---
tags: [lecture script, Notebooks/Network, Notebooks/Research/Sensor]
title: Sensor relative Lecture Script
created: '2020-01-16T08:57:15.911Z'
modified: '2020-02-18T14:46:15.471Z'
---

# Sensor relative Lecture Script

[TOC]

## Structures as Sensors(<u>SaS</u>): smaller-data learning in the physical world

[lecturer]

​	Prof. Pei Zhang, CMU

[problem]

- large amount of labeled data for robustness needed by ML

- difficult to capture data by sensors.(e.g. short lifespan, hard to deploy, etc.)
- high numbers of variables that can affect data in physical space(e.g. wather, time, persons, etc.)

> what is the meaning of Structures as Sensors(SaS)?
>
> - The structure(e.g. a building) acts as the physical elements of the sensors.
>
> - the structure response is interpreted to obtain info. about the occupants and the environment.

[methods]

Introduce <u>physical-based</u> approaches to reduce the data demand for robust learning

- generate data through the use of physical models
- improve sensed data through actuation of the sensing system
- combine and transfer data from multiple deployments using physical understanding(key points of this lectures)

{example}

<u>Walking Recognition</u>

use physical knowledge and structural effect to transfer data between different places(lab, hospital, etc.)

<u>Cashless Checkout & System AIM3S</u>

Fuse multiple sensing modalities(e.g.  weight difference on a shelf,  visual item recognition in customers' hands, prior knowledge of item layout, etc.)

