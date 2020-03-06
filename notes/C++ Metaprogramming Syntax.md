---
tags: [Notebooks/Programming Languages/C++]
title: C++ Metaprogramming Syntax
created: '2020-02-21T06:24:59.122Z'
modified: '2020-02-21T07:57:09.770Z'
---

# C++ Metaprogramming Syntax



### meta function definition

> What is the meta element in meta programming?
> *value, type and template could be the inputs and outputs of meta function.*


```c++

template <typename T>
struct Fun_{
  using type = T; // alias
};

// C++14
template <int a>
constexpr int fun = a + 1;
// fun<3>
```
*tips:`constexpr` means evaluating when compiled, function-like expression without state.*
#### type_traits

<kbd>C++11</kbd> `std::remove_reference<T>::type`
<kbd>C++14</kbd> `std::remove_reference_t<T>`





### container

leverage  <u>variadic template</u>.
```c++
// variadic template
template <int...... vals> struct IntContainer;
```

### sequential execution

*template nesting*.

### conditional experssions

`if` expression:
<kbd>C++11</kbd> `std::enable_if<B, T>::type`
<kbd>C++14</kbd> `std::enable_if_t<B, T>`

> *tips: `void` is a type.*

`if-else` expression:
<kbd>C++11</kbd> `std::conditional<B, T, F>::type`
<kbd>C++14</kbd> `std::conditional_t<B, T, F>`

`case` expression:
*branch specialization*.
在非完全特化的类模板中不能有完全特化的模板, 解决方式是通过引入一个dummy的伪参数. 



