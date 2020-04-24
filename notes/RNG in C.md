---
tags: [Notebooks/Programming Languages/C++]
title: RNG in C
created: '2020-03-06T16:33:36.152Z'
modified: '2020-04-14T07:15:12.195Z'
---

# RNG in C

- [std::mt19937](): RNG with circle &2^19937-1&!(since <kbd>C++11</kbd>)

```c++
#include <random>

int main() {
    std::random_device rd;  // get random seed
    std::mt19937 gen(rd()); // standard
    std::uniform_real_distribution<float> dis(-10, 10);
    std::cout << "Random distribution ready\n";
    return 0;
}
```
