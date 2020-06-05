---
tags: [Notebooks/Cheatsheet]
title: CMake
created: '2020-02-23T09:26:21.376Z'
modified: '2020-05-11T12:13:15.695Z'
---

# CMake

## Config

```cmake
# Without this variable set, CMake will build tests when running install
set(CMAKE_SKIP_INSTALL_ALL_DEPENDENCY ON)
```

## Special Variables

```cmake
# - CMAKE_MODULE_PATH
# Include custom Find<Module>.cmake scripts.
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_SOURCE_DIR}/cmake)
```

#### set

- Normal Variables(the scope is current file). `set(<variable> <value>... [PARENT_SCOPE])`
  - `add_subdirectory`, `function()`: value copy
  - `include()` `macro()`: code expansion
- Cache Variable(global scope). `set(<variable> <value>... CACHE <type> <docstring> [FORCE])`
```
set(MY_CACHE_VAL "666" CACHE STRING INTERNAL)
```
  - `CMAKE_INSTALL_PREFIX` is `/usr/local` by default.
  - Use normal variables if there are two normal varibles and cache variables sharing the same name.
  - appear in `CMakeCache.txt`
  - two ways to modify cache variables:
    `set(<variable> <value> CACHE INSTERNAL FORCE)` or `cmake -Dvar=value ..` in shell

## Target

> PUBLIC, PRIVATE and INTERFACE
> https://stackoverflow.com/questions/26037954/cmake-target-link-libraries-interface-dependencies
> - `PUBLIC`: source files and your headers include the headers of another library
> - `PRIVATE`:  your source cpp files include the headers of another library, but your header files don't.
> - `INTERFACE`: header files but not your source files include the headers of another library

## Package

http://www.yeolar.com/note/2014/12/16/cmake-how-to-find-libraries/

Definition file: `Find<package name>.cmake`

`find_package(Gperftools REQUIRED)` equivalent to
```cmake
list(APPEND CMAKE_MODULE_PATH <path>)
include(Find<package name>)
```
Once we find the package, the following variables are added covertly.
```cmake
<NAME>_FOUND
<NAME>_INCLUDE_DIRS or <NAME>_INCLUDES
<NAME>_LIBRARIES or <NAME>_LIBRARIES or <NAME>_LIBS
<NAME>_DEFINITIONS
```

## Snippets
```cmake
# Generate Doxygen if available
find_package(Doxygen)
if(Doxygen_FOUND)
  configure_file(${CMAKE_SOURCE_DIR}/Doxyfile.in Doxyfile)
  add_custom_target(doxygen ALL
      COMMAND ${DOXYGEN_EXECUTABLE} Doxyfile 
      WORKING_DIRECTORY ${CMAKE_BINARY_DIR})
endif()


# [Option] CMAKE_BUILD_TYPE
# Build in Release mode by default; otherwise use selected option
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "Release" CACHE STRING "Build type" FORCE)
    set_property(CACHE CMAKE_BUILD_TYPE PROPERTY
        STRINGS "Release" "Debug" "MinSizeRel" "RelWithDebInfo")
endif()
message(STATUS "Build type (CMAKE_BUILD_TYPE): ${CMAKE_BUILD_TYPE}")

# [Option] CXX compiler flags
# For easier adding of CXX compiler flags
include(CheckCXXCompilerFlag)
function(enable_cxx_compiler_flag_if_supported flag)
    string(FIND "${CMAKE_CXX_FLAGS}" "${flag}" flag_already_set)
    if(flag_already_set EQUAL -1)
        message(STATUS "Adding CXX compiler flag: ${flag} ...")
        check_cxx_compiler_flag("${flag}" flag_supported)
        if(flag_supported)
            set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${flag}" PARENT_SCOPE)
        endif()
        unset(flag_supported CACHE)
    endif()
endfunction()

# Always build position-independent-code
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

# Don't make the install target depend on the all target.
set(CMAKE_SKIP_INSTALL_ALL_DEPENDENCY ON)

# In Debug mode, enable extra compiler flags.
if(NOT MSVC AND SEAL_DEBUG)
  enable_cxx_compiler_flag_if_supported("-Wall")
  enable_cxx_compiler_flag_if_supported("-Wextra")
  enable_cxx_compiler_flag_if_supported("-Wconversion")
  enable_cxx_compiler_flag_if_supported("-Wshadow")
  enable_cxx_compiler_flag_if_supported("-pedantic")
endif()

# Path for outupt
if(ANDROID_ABI)
    # Android compiles several targets at the same time. Need to specify
    # separate directories for separate ABIs.
    set(OUTLIB_PATH "lib/${ANDROID_ABI}")
else()
    set(OUTLIB_PATH "lib")
endif()

# For extra modules we might have
list(APPEND CMAKE_MODULE_PATH ${SEAL_SOURCE_DIR}/cmake)

```
