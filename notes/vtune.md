---
tags: [Notebooks/Cheatsheet]
title: vtune
created: '2020-02-22T15:24:18.522Z'
modified: '2020-02-23T04:54:54.556Z'
---

# vtune

```bash
amplxe-cl -collect hotspots ./debug/whetdc 300000
amplxe-cl -report hotspots -format=csv  > whetstone_300000.csv
```

## Reference

 - https://software.intel.com/en-us/vtune-help-collect

