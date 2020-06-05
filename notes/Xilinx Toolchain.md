---
tags: [Notebooks/Cheatsheet]
title: Xilinx Toolchain
created: '2020-05-22T03:27:41.160Z'
modified: '2020-05-22T15:37:52.614Z'
---

# Xilinx Toolchain

## Misc

```bash

# Credit to https://www.xilinx.com/support/answers/34806.html
# LSPCI is available on Linux platforms and allows users to view the PCI Express device configuration space. 
# LSPCI is usually found in the /sbin directory. LSPCI displays a list of devices on the PCI buses in the system.
ls /proc/bus/pci
lspci
# -t: view all devices in a tree format
# -s [[[[<domain>]:]<bus>]:][<slot>][.[<func>]]
#   domains are numbered from 0 to ffff), bus (0 to ff), slot (0 to 1f) and function (0 to 7).
#   E.g., 
#   "0:" means all devices on bus 0
#   "0" means all functions of device 0 on any bus
#   "0.3" selects third function of device 0 on all buses
#   ".4" shows only the fourth function of each device.

# 3b:00.0 Processing accelerators: Xilinx Corporation Device 5000 -> bus 3b, device 0, <read> function
# 3b:00.1 Processing accelerators: Xilinx Corporation Device 5001 -> bus 3b, device 0, <write> function
#  Note that for each card, there will be two physical functions found:
# one for management(1) and one for user(0). 
```
## Vivado

### Installing Vivado HLx 2018.3 on Server
- https://gist.github.com/sgherbst/f73c31938d3483e6c72e3baf3443f66a

### Vivado License
- https://forums.xilinx.com/t5/Installation-and-Licensing/vivado-license-problem-in-ubuntu/td-p/556097

```bash
/tools/Xilinx/Vivado/2018.3/bin/vlm
```

### Vivado tcl Script

```bash
vivado -mode tcl
# vivado -mode gui

```


## XRT(Xilinx Runtime)

- https://china.xilinx.com/support/documentation/boards_and_kits/accelerator-cards/1_4/ug1301-getting-started-guide-alveo-accelerator-cards.pdf

```bash
 source /opt/xilinx/xrt/setup.sh
```

###  Card Bring-Up and Validation
```bash
lspci

xbmgmt flash --scan

# The xbutil validate command validates the correct installation by performing the following set of tests: 
# - Validates the device found.
# - Checks PCIe link status.
# - Runs a verify kernel on the card.
# - Performs the following data bandwidth tests:
#   - DMA test - Data transfer between host and FPGA DDR through PCIe.
#   - DDR test - Data transfer between kernels and FPGA DDR.
xbutil validate

```
