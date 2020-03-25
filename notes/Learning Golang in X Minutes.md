---
tags: [Notebooks/Programming Languages/Golang]
title: Learning Golang in X Minutes
created: '2020-03-10T01:57:00.285Z'
modified: '2020-03-17T09:20:30.897Z'
---

# Learning Golang in X Minutes

## Resources

- Book: [Introducing Go: Build Reliable, Scalable Programs](http://file.allitebooks.com/20160110/Introducing%20Go.pdf)

- [godoc](https://godoc.org/): Golang has a rubost well-documented common library. You could also run in terminal like `godoc fmt Println`.

- source code: www.golang.org/src/pkg/

- https://www.kancloud.cn/liupengjie/go/570004


## Types

Go is statically typed programming language. This means that variables always have a specific type that are determinted during compiling procedure.

Go comes with several built-in basic data types: integers(`uint8, uint16, uint32, uint64, int8, int16, int32, and int64`), floating-point numbers, string, boolean and memory unit `byte`.

Go's advanced built-in types consist of arrays, slices and maps.
### array
```go
/* array's difinition pattern:
  (var | const) <variable> [length] <type>
  {
    <initial value>
    ...
  }[optional]
*/
var x [5]int
/*
build-in function: 
  - len(x)
  - range x -> index, value
*/
for index, value := range x{
  total += value
}
```
### slice
*slice* is a type built on top of an array, but with variable length.
```go
/** pattern 1:
  (var | const) <variable> [] <type>{
    initial_value ...
  }(optioal)
  */
var x[]float64
```
If you want to create a slice with a underlying array, you should use the built-in *make* function.
```go
/**
  pattern 2: 
  <variable> = make([]<type>, length)
  <variable> = make([]<type>, length, capacity)
*/
```
another way to create slices is to use the *[low:high]* exprssion.
```go
/**
  pattern 3: <variable> = <array variable>[low:high]
*/
arr := [5]float54{1, 2, 3, 4, 5}
x := arr[0:5]
```

*append*
- `append(<slice variable>, e1, e2, ...)` 
- `append(<slice variable>, <slice|string>...)`
adds elements onto the end of a slice. If there is sufficient capacity in the underlying array, the element is placed after the last element; otherwise, a new array is created.
```go
func main(){
  slice1 := []int{1,2,3}
  slice2 := append(slice1, 4, 5)
  fmt.Println(slice1, slice2)
}
```
`copy(dst, src)` All of entries in src are copied into dst overwriting whatever is there. If the length of the two slices are not the same, the smaller of the two will be used.
```go
func main(){
  slice1 := []int{1,2,3}
  slice2 := make([]int, 2)
  copy(slice2, slice1)
}
```

*Transformation between Variadic Functions & slice*
If you already have multiple args in a slice, apply them to a variadic function using `func(slice...)` like this.
```go
// [_Variadic functions_](http://en.wikipedia.org/wiki/Variadic_function)
// can be called with any number of trailing arguments.
// For example, `fmt.Println` is a common variadic
// function.

package main

import "fmt"

// Here's a function that will take an arbitrary number
// of `int`s as arguments.
func sum(nums ...int) {
	fmt.Print(nums, " ")
	total := 0
	for _, num := range nums {
		total += num
	}
	fmt.Println(total)
}

func main() {

	// Variadic functions can be called in the usual way
	// with individual arguments.
	sum(1, 2)
	sum(1, 2, 3)

	// If you already have multiple args in a slice,
	// apply them to a variadic function using
	// `func(slice...)` like this.
	nums := []int{1, 2, 3, 4}
	sum(nums...)
}

```
### maps
Here's an example of map in Go:
```go
/** variable type:
var <variable> map[<key type>] <value type>
*/
var x map[string] int

/** definition pattern: use `make` built-in function
*/
x := make(map[string] int)

/** delete items: build-in `delete` function
  delete(<map variable> <key>)
*/
delete(x, 1)

/** indexing:
  value, <whether exists> = <map variable>[key]
*/
name, ok := elements["Un"]
```

## Variables

```go
package main

// pattern 1: var <variable> <type> [ = <initial value>]
var gx string
var gy int = 2

func main(){

  // pattern 1
  var x string
  x = "hello world"

  // pattern 1
  var y string = "hello world"
  // pattern 2: <variable> := <initial value>
  // Note: this pattern could not be used for global variables
  c := true

  // pattern 3: const <variable> <type> = <inital value>
  // Go also has support constants
  const z string = "hello"

  /**
   pattern 4: defining multiple variables
  (var | const)(
    <variable> [= <initial value>]
    ... 
  )
  */ 
}
```

### pointers
almost the same as pointers in C/C++
- type `*<basic type>`
- the `*` and `&` operators
- the built-in `new` functions

## Control Structures

 Go only suppport `for` statement for looping, as it can be used in a variety of differnt ways to support different types of loops(while, do, until, foreach, etc)
```go
// pattern 1: "for" in C
for i:=1 i<=10; i++{
  fmt.Println(i)
}

// pattern 2: "while" in C
i := 1
for i<=10 {
  fmt.Println(i)
  i += 1
}
```
Go leverages `if` and `switch` statement for conditonal branching.
Notice that the prediction statement could consist of mupltiple statements with `;` as delimiter, and the return value is the last statement.
```
if el, ok := elements["Li"]; ok {
  ....
}
```

## Functions
here is a example of function in Go:

```go
/** pattern 1:
  func <function>(parameters ...) <return type>{
    ...
  }
*/
func average(x []float64) float64{
  var total = float64(0)
  for _, e := range x{
    total += e
  }
  total /= float64(len(x))
  return total
}
```
*return type can have names, and return multiple values is allowed*
```go
/** pattern 2:
  func <function>(<parameters list>) (<return list>{
    ...
}
*/
func foo()(x int){
  x = 1
  return
}
```
### variadic functions

There is a variadic form available for the last parameter.
```
func add(args ...int) (total int){
  total = 0
  for _, v := range args{
    total += v
  }
  return
}
```
### Functional Programming
applications:
- *closure*
- function as return value. the function types
  - `func(parameter ...) return value type`
  - `func(parameter ...) (return value types list)`
- *anonymous function*
```go
func(parameter...)(return values list){

}
```
### deter, panic & recoer
- `deter`: schedules a function call to be run after the exterior function completes.     
- `panic`: build-in function that causes a runtime error
- `recover`: stops the panic and returns the value that was passede to the call to `panic`. We have to pair it with `defer`
```go
func main(){
  defer func(){
    str := recover()
    fmt.Println(str)
  }()
  panic("PANIC")
}
```
## Structs & Interfaces
- definition
  - struct(define a field set): `type <new struct name> struct{...}`
  - interface(define a method set):`type <new struct name> interface{...}` 
- instantiation
  - the built-in `new` function return a pointer. This allocates memory for all the fields, set each of them to their zero value.
  - give each of the fields an initial values in a curly brackets
  ```
  c := new(Point)
  c := Point{x: 0, y: 0, z: 0}
  c := Point{0,0,0} // leave off the field names if ew know the order they were defined
  ```
- field
  We can access variables's  and <u>pointers's</u> fields using `.` operator.
- method
  - `func (<identifier > *<struct type>) <method name>(parameter ...) (raturn value list ...){...}`

  ```go
  func (r *Rectangle) area() float64{
    ...
  }
  ```

- embedded types / anonymous fields

```go
type Person struct{
  Name string
}

func (p *Person) Talk(){
  fmt.Println("Hi, my name is", p.name)
}

type Android struct {
  Person  // anonymous fields
  Model string
}
```
We would rather say an android *is* a person, rather than an andriod *has* a person. As we can used type(Person) and don't give it a name. Anonymous fields *Person* could be accessed using the type name, and could and call any *Person* methods directly on the *Android*:
```go
a := new(Android)
a.Person.Talk()
a.Talk()
```

**philosophy**:
When building new programs, you often won’t know what your types should look like when you start—and that’s OK. In Go, you generally focus more on *the behavior of your program* than on a taxonomy of types. 

Create a few small structs that do what you want, add in methods that you need, and as you build your program, useful interfaces will tend to emerge. There’s no need to have them all figured out ahead of time.

Interfaces are particularly useful as software projects grow and become more complex. They allow us to hide the incidental details of implementation (e.g., the fields of our struct), which makes it easier to reason about software components in isolation. 

*interfaces can also be used as fields*.
```go
type Shape interface {
  area() float64
}

typedef MultiShape struct{
  shapes []shape
}

func (m *Multishape) area (area float64){
  for _, s := range m.shapes{
    area += s.area()
  }
}
```

*from super interface/struct to derived interface/struct*
```go
type User struct {
    	Name string
    	Id  string
    }

var b interface{}
b = User{"K3vin", "kev"}
if bUser, ok := b.(User); ok {
		...
	}
```

**reflect**:
Credit to [The Laws of Reflection](https://blog.golang.org/laws-of-reflection).

*get type info*:

```go
package main

import (
    "fmt"
    "reflect"
)

type Student struct {
    Name string
    Age  int
}

func main() {

    var stu Student
    
    
    typeOfStu := reflect.TypeOf(stu)
    fmt.Println(typeOfStu.Name()) // -> Student
    fmt.Println(typeOfStu.Kind()) // -> struct

    // pointer
    stu = &Student{Name:"kitty", Age: 20}
    typeOfStu := reflect.TypeOf(stu)
    fmt.Println(typeOfStu.Name()) // (null)
    fmt.Println(typeOfStu.Kind()) // -> ptr
    typeOfStu = typeOfStu.Elem()  // equivalent to * operator for pointer
    fmt.Println(typeOfStu.Name()) // -> Student
    fmt.Println(typeOfStu.Kind()) // -> struct
	
}
```

-   [func TypeOf(i interface{}) Type](https://golang.org/pkg/reflect/#TypeOf)

```go
type Type interface {
	// Name returns the type's name within its package for a defined type.
    // For other (non-defined) types it returns the empty string.
    Name() string
	
    // Kind returns the specific kind of this type.
    Kind() Kind
    
    // Elem returns a type's element type.
    // It panics if the type's Kind is not Array, Chan, Map, Ptr, or Slice.
    Elem() Type
    
    // NumField returns a struct type's field count.
    // It panics if the type's Kind is not Struct.
    NumField() int
    
    // Field returns a struct type's i'th field.
    // It panics if the type's Kind is not Struct.
    // It panics if i is not in the range [0, NumField()).
    Field(i int) StructField
    
    // FieldByName returns the struct field with the given name
    // and a boolean indicating if the field was found.
    FieldByName(name string) (StructField, bool)
    
    // FieldByIndex returns the nested field corresponding
    // to the index sequence. It is equivalent to calling Field
    // successively for each index i.
    // It panics if the type's Kind is not Struct.
    FieldByIndex(index []int) StructField
    
    // FieldByNameFunc returns the struct field with a name
    // that satisfies the match function and a boolean indicating if
    // the field was found.
    FieldByNameFunc(match func(string) bool) (StructField, bool)
    
    ...
}
```

*get value info*:

```go
	typeOfElf := reflect.TypeOf(*file)
	valueOfElf := reflect.ValueOf(*file)
	for i := 0; i < typeOfElf.NumField(); i++{
		fmt.Println(typeOfElf.Field(i).Name, valueOfElf.Field(i))
	}
```

*get type info of the fields of a struct*:

```go
// 
package main

import (
    "fmt"
    "reflect"
)

func main() {
  
    type cat struct {
        Name string
        Type int `json:"type" id:"100"`
    }
  
    ins := cat{Name: "mimi", Type: 1}
  
    typeOfCat := reflect.TypeOf(ins)
  
    for i := 0; i < typeOfCat.NumField(); i++ {
        fieldType := typeOfCat.Field(i)
        fmt.Printf("name: %v  tag: '%v'\n", fieldType.Name, fieldType.Tag)
    }
    /**
    -> name: Name  tag: ''
	-> name: Type  tag: 'json:"type" id:"100"'
	*/
    
    if catType, ok := typeOfCat.FieldByName("Type"); ok {
        fmt.Println(catType.Tag.Get("json"), catType.Tag.Get("id")) // -> type 100
    }
}
```

```go
type StructField struct {
    // Name is the field name.
    Name string
    // PkgPath is the package path that qualifies a lower case (unexported)
    // field name. It is empty for upper case (exported) field names.
    // See https://golang.org/ref/spec#Uniqueness_of_identifiers
    PkgPath string

    Type      Type      // field type
    Tag       StructTag // field tag string
    Offset    uintptr   // offset within struct, in bytes
    Index     []int     // index sequence for Type.FieldByIndex
    Anonymous bool      // is an embedded field
}
```

```go
type StructTag string
func (tag StructTag) Get(key string) string
func (tag StructTag) Lookup(key string) (value string, ok bool)
```

## packages

Go also has a mechanism for combining interfaces, types, variables and functions together into a single component known as *package*.

Some of the most commonly used packages included with Golang.
- Strings
- io
- types
- os
- io/ioutil
- path/filepath
- errors: Go has a built-in type for errors
- container/list
- sort
- hash
- crypto
- net
- encoding
  - json
  - gob
- flag: parsing command-line arguments
- testing
- time
- log

### String Operations
Mainly leverage package `Strings`.

*Mutual Conversion between string and byte array*:

```go
// string -> byte array
arr := []byte("test")
// byte array -> string
str := string([]byte{'t','e','s','t'})
```
*Advanced string operations*: 
  join split repeat replace

See more info in: https://godoc.org/strings

## IO
 The io package consists of a few functions, but mostly interfaces used in other packages. 
 The two main interfaces are *Reader*(*Read* method) and *Writer*(*Write* method). Many functions in Go take Readers or Writers as arguments.

| read from ... | strategy |
| ---           | ---      |
| byte array    | `bytes.Buffer` |
| string        | `strings.NewReader` |

| write to ... | strategy |
| ---           | ---      |
| byte array    | `bytes.Buffer.Bytes()` |
| string        | `bytes.Buffer.String()` |

## Files and Folders
*open a file in Go*:
- `os.Open`
- `io.ioutil.ReadFile`(only get the content of a file)

We use `defer file.Close()` right after opening the file to make sure the file is closed as soon as the function completes.

*cerate a file in Go*:
- `os.Create`

*get the contents of a directory*:
- `os.Open`, `Readdir`

*recursively walk a folder*:
- `path.filepath.Walk`
```go
func main() {
  filepath.Walk(".", func(path string, info os.FileInfo, err error) error{
    fmt.Println(path)        
    return nil    
  }) 
} 
```

### Containers

*doubly linked list*:
- `container.list.List`

### Sort

There are several pre-defined sorting functions for slices of ints and floats.

*customized sort*:
The Sort function in sort takes a sort.interface and sorts it. The sort.interface requires three methods: Len, Less and Swap.

```go
type Person struct {    
  Name string    
  Age int
}

type ByName []Person

func (ps ByName) Len() int {   
  return len(ps) 
}

func (ps ByName) Less(i, j int) bool{ 
  return ps[i].Name < ps[j].Name 
}

func (ps ByName) Swap(i, j int) {
  ps[i], ps[j] = ps[j], ps[i] 
}

func main() {
  kids := []Person{
    {"Jill",9},
    {"Jack",10},}    
  sort.Sort(ByName(kids))
  fmt.Println(kids)
} 
```

### Hashes & Cryptography
Hash functions in Go are broken into two categories: cryptographic and non-cryptographic. 
- The non-cryptographic hash functions can be found underneath the hash package and include adler32, crc32, crc64, and fnv. 
- The cryptographic hash functions can be found underneath the crypto package and include sha1

### Timing

### Customized Packages
- Package names match the folders they fall in
- Go first searches for package directory inside `$GOROOT/src` directory and if it doesn’t find the package, then it looks for `$GOPATH/src`. 
- For an executable package, a file with `main` function is the entry file for execution.
- When we import package(`import "net/http"`), we use its full name; but inside the code file, we only use the last part of the name(`http`)
- alias is allowed `import m "customized/math"`
- scope:
  - In Go, if something starts with a capital letter, that means other packages (and programs) are able to see it; otherwise not.


## Network Programming

*create a TCP Server*:

*create a HTTP Server*: package `net/http`

*RPC*: package `net/rpc`, `net/jsonrpc`

## Documentation
run `godoc` in command-line.
```
godoc <package path> <function/struct/interface name>
```
This documentation is also available in web form by running this command:
```bash
godoc -http=":6060"
```

## Testing
*Tips:*
- test files should end with `_test.go` under the same directory.
- if we'll be testing the `Average` function, name the test function `TestAverage`
- run `go test`
```go
package math
import "testing"

type testpair struct {
  values []float64
  average float64 
}

var tests = []testpair{
  { []float64{1,2}, 1.5 },    
  { []float64{1,1,1,1,1,1}, 1 },
  { []float64{-1,1}, 0 },
}

func TestAverage(t *testing.T) {      
  for _, pair := range tests {
    v := Average(pair.values)      
    if v != pair.average {
      t.Error(
        "For", pair.values,
        "expected", pair.average,
        "got", v,)        
    }    
  } 
}

```

## Concurrency
 Go has rich support for concurrency using goroutines and channels.

### Goroutines

*create*:
use the keyword `go` followed by a function invocation

### Channels
Channels provide a way for two goroutines to communicate with each other and synchronize their execution.

*declaration*:
- `var <variable name> chan <type>`
- resctrict the direction
  - `var <variable name> <-chan <type>`(only send)
  - `var <variable name> chan<- <type>`(only receive)
- asynchronous buffered channel
  - `make(chan <type>, <capacity>)`
  - sending or receiving a message will not wait unless the channel is already full

*send & receive*:
- sender and receiver go the same `chan` type variable(for example, `var c chan string`)
- `c <- "hello"`(send)
- `<- c`(receive)

*select*:
- work like a switch but for channels.
- If more than one of the channels are ready, then it randomly picks which one to receive from
- The default case happens immediately if none of the channels are ready
```go
select {
  case msg1 := <- c1:
    fmt.Println(msg1)
  case msg2 := <- c2:
    fmt.Println(msg2)
  case <- time.After(time.Second): // time.After creates a channel, and after the given duration, will send the current time on it
    fmt.Println("timeout")
  default:
    fmt.Println("nothing ready")
}
```




