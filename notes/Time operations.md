---
tags: [Notebooks/Programming Languages/Java]
title: Time operations
created: '2020-02-27T04:57:45.732Z'
modified: '2020-02-27T05:08:45.907Z'
---

# Time operations

Java provides two methods to time operations. `System.nanoTime()` and `System.currentTimeMillis()`.

```java
public static long currentTimeMillis()
/* Returns the current time  milliseconds.
* Pros:
  - thread safe
  - alway return absolute time elapsed size the *epoch*(1 Jan 1970 00:00)
  - lower overhead(5-6 cpu clocks)
*/


public static long nanoTime()
/* Returns the current value of the running JVM's high-resolution time source in nanoseconds.
* Pros:
  - Highly precise
* Cons:
  - The value returned represents nanoseconds since some fixed but arbitrary time (perhaps in the future, so values may be negative).
  - Less accurate. This method provides nanosecond precision, but not necessarily nanosecond accuracy
  - Not thread safe
*/
```

## Resources

- https://www.geeksforgeeks.org/java-system-nanotime-vs-system-currenttimemillis/
