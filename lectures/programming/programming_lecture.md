---
title: "Programming"
author: 
date: 
urlcolor: blue
output: 
  html_document:
    toc: true
    toc_depth: 3
    toc_float: true # toc_float option to float the table of contents to the left of the main document content. floating table of contents will always be visible even when the document is scrolled
      #collapsed: false # collapsed (defaults to TRUE) controls whether the TOC appears with only the top-level (e.g., H2) headers. If collapsed initially, the TOC is automatically expanded inline when necessary
      #smooth_scroll: true # smooth_scroll (defaults to TRUE) controls whether page scrolls are animated when TOC items are navigated to via mouse clicks
    number_sections: true
    fig_caption: true # ? this option doesn't seem to be working for figure inserted below outside of r code chunk    
    highlight: tango # Supported styles include "default", "tango", "pygments", "kate", "monochrome", "espresso", "zenburn", and "haddock" (specify null to prevent syntax    
    theme: default # theme specifies the Bootstrap theme to use for the page. Valid themes include default, cerulean, journal, flatly, readable, spacelab, united, cosmo, lumen, paper, sandstone, simplex, and yeti.
    df_print: tibble #options: default, tibble, paged
    keep_md: true # may be helpful for storing on github
    
---



# Introduction

Load packages:


```r
library(tidyverse)
library(ggplot2)
library(lubridate)
```


The "programming" unit will introduce you to tools that tell the computer to do the same or similar things over and over, without writing code over and over. And the code you write to do things over and over, will be able to do things differently depending on conditions of the data or depending on things you specify. 

Paraphrasing Will Doyle

> "Computers love to do the same thing over and over. It's their favorite thing to do. Learn to make your computer happy."

The core foci of this unit are:

- iteration (loops)
- conditionals (if, if else)
- functions

But more than learning these things, this unit is about developing a more formal, rigorous understanding of programming concepts so that you can become a more powerful programmer. Towards that end, we will be reading chapters from Wickhams free text book [_Advanced R_](https://adv-r.hadley.nz/)

  
In fact, please spend 10 minutes reading the [Chapter 1](https://adv-r.hadley.nz/introduction.html) (sections 1.1 through 1.5)

# Foundational concepts

## Data structures and types

What is an **object**?

- Everything in R is an object
- We can classify objects based on their _class_ and _type_
- The _class_ of the object determines what kind of functions we can apply to it
  - E.g., "Date" functions usually only work on objects with a `Date` class
  - E.g., "String" functions usually only work with on objects with a `character` class
  - E.g., Functions that do mathematical computation usually work on objects with a `numeric` class
- Objects may be combined to form data structures

<br>
<details><summary>Class and object-oriented programming</summary>

> "Object-oriented programming (OOP) refers to a type of computer programming in which programmers define not only the data type of a data structure, but also the types of operations (functions) that can be applied to the data structure."

*Source: [Webopedia](https://www.webopedia.com/TERM/O/object_oriented_programming_OOP.html)*

<br>
R is an **object-oriented programming language**:

- The _class_ of an object is fundamental to object-oriented programming because:
  - It determines which functions can be applied to the object
  - It also determines what those functions do to the object
    - E.g., A specific function might do one thing to objects of __class__ A and another thing to objects of __class__ B
    - What a function does to objects of different class is determined by whoever wrote the function
- Many different object classes exist in R
- You can also create our own classes
    - E.g., The `labelled` class is an object class created by Hadley Wickham when he created the `haven` package
- In this course we will work with classes that have been created by others

</details>
<br>

[![](https://d33wubrfki0l68.cloudfront.net/1d1b4e1cf0dc5f6e80f621b0225354b0addb9578/6ee1c/diagrams/data-structures-overview.png){width=400px}](https://r4ds.had.co.nz/vectors.html)

*Credit: [R for Data Science](https://r4ds.had.co.nz/vectors.html)*

<br>
Basic **data structures**:

- [Atomic vectors](#atomtic-vectors)
- [Lists](#lists)
  - [Dataframes](#dataframes)
  
Basic **data types**:

- Logical (`TRUE`, `FALSE`)
- Numeric (e.g., `5`, `2.5`)
- Integer (e.g., `1L`, `4L`, where `L` tells R to store as `integer` type)
- Character (e.g., `"R is fun"`)

Functions for investigating R objects (From [Data Types and Structures](https://swcarpentry.github.io/r-novice-inflammation/13-supp-data-structures/))

- `str()`: Compactly display the internal structure of an R object
- `class()`: What kind of object is it (high-level)?
- `typeof()`: What is the object's data type (low-level)?

### Atomtic vectors

What are **atomic vectors**?

- **Atomic vectors** are objects that contains elements
- Elements must be of the same data type (i.e., _homogeneous_)
- Elements can be named to form a _named atomic vector_
- The `class()` and `typeof()` a vector describes the elements it contains

<br>
<details><summary>**Example**: Investigating logical vectors</summary>


```r
v <- c(TRUE, FALSE, FALSE, TRUE)
str(v)
#>  logi [1:4] TRUE FALSE FALSE TRUE
class(v)
#> [1] "logical"
typeof(v)
#> [1] "logical"
```

</details>

<br>
<details><summary>**Example**: Investigating numeric vectors</summary>


```r
v <- c(1, 3, 5, 7)
str(v)
#>  num [1:4] 1 3 5 7
class(v)
#> [1] "numeric"
typeof(v)
#> [1] "double"
```
</details>

<br>
<details><summary>**Example**: Investigating integer vectors</summary>


```r
v <- c(1L, 3L, 5L, 7L)
str(v)
#>  int [1:4] 1 3 5 7
class(v)
#> [1] "integer"
typeof(v)
#> [1] "integer"
```

</details>

<br>
<details><summary>**Example**: Investigating character vectors</summary>

Each element in a `character` vector is a **string** (covered in next section):


```r
v <- c("a", "b", "c", "d")
str(v)
#>  chr [1:4] "a" "b" "c" "d"
class(v)
#> [1] "character"
typeof(v)
#> [1] "character"
```

</details>

<br>
<details><summary>**Example**: Investigating named vectors</summary>


```r
v <- c(v1 = 1, v2 = 2, v3 = 3)
v
#> v1 v2 v3 
#>  1  2  3
str(v)
#>  Named num [1:3] 1 2 3
#>  - attr(*, "names")= chr [1:3] "v1" "v2" "v3"
class(v)
#> [1] "numeric"
typeof(v)
#> [1] "double"
```

</details>


### Lists

What are **lists**?

- **Lists** are objects that contains elements
- Elements do not need to be of the same type (i.e., _heterogeneous_)
  - Elements can be atomic vectors or even other lists
- Elements can be named to form a _named list_
- The `class()` and `typeof()` a list is `list`

<br>
<details><summary>**Example**: Investigating heterogeneous lists</summary>


```r
l <- list(2.5, "abc", TRUE, c(1L, 2L, 3L))
str(l)
#> List of 4
#>  $ : num 2.5
#>  $ : chr "abc"
#>  $ : logi TRUE
#>  $ : int [1:3] 1 2 3
class(l)
#> [1] "list"
typeof(l)
#> [1] "list"
```

</details>

<br>
<details><summary>**Example**: Investigating nested lists</summary>


```r
l <- list(list(TRUE, c(1, 2, 3), list(c("a", "b", "c"))), FALSE, 10L)
str(l)
#> List of 3
#>  $ :List of 3
#>   ..$ : logi TRUE
#>   ..$ : num [1:3] 1 2 3
#>   ..$ :List of 1
#>   .. ..$ : chr [1:3] "a" "b" "c"
#>  $ : logi FALSE
#>  $ : int 10
class(l)
#> [1] "list"
typeof(l)
#> [1] "list"
```

</details>

<br>
<details><summary>**Example**: Investigating named lists</summary>


```r
l <- list(l1 = 1, l2 = c("apple", "orange"), l3 = list(1, 2, 3))
str(l)
#> List of 3
#>  $ l1: num 1
#>  $ l2: chr [1:2] "apple" "orange"
#>  $ l3:List of 3
#>   ..$ : num 1
#>   ..$ : num 2
#>   ..$ : num 3
class(l)
#> [1] "list"
typeof(l)
#> [1] "list"
```

</details>


#### Dataframes

What are **dataframes**?

- **Dataframes** are a special kind of **list** with the following characteristics:
  - Each element is a **vector** (i.e., _a column in the dataframe_)
  - The element should be named (i.e., _column name in the dataframe_)
  - Each of the vectors must be the same length (i.e., _same number of rows in the dataframe_)
  - The data type of each vector may be different
- Dataframes can be created using the function `data.frame()`
- The `class()` of  a dataframe is `data.frame`
- The `typeof()` a dataframe is `list`


<br>
<details><summary>**Example**: Investigating dataframe</summary>


```r
df <- data.frame(
  colA = c(1, 2, 3),
  colB = c("a", "b", "c"),
  colC = c(TRUE, FALSE, TRUE),
  stringsAsFactors = FALSE
)
df
#> # A tibble: 3 x 3
#>    colA colB  colC 
#>   <dbl> <chr> <lgl>
#> 1     1 a     TRUE 
#> 2     2 b     FALSE
#> 3     3 c     TRUE
str(df)
#> 'data.frame':	3 obs. of  3 variables:
#>  $ colA: num  1 2 3
#>  $ colB: chr  "a" "b" "c"
#>  $ colC: logi  TRUE FALSE TRUE
class(df)
#> [1] "data.frame"
typeof(df)
#> [1] "list"
```

</details>

### Identifying object types

Functions for identifying object types (_returns `TRUE` or `FALSE`_):

- `is.logical()`: Is object of type `logical`?
- `is.integer()`: Is object of type `integer`?
- `is.double()`: Is object of type `double`?
- `is.numeric()`: Is object of type `numeric`?
- `is.character()`: Is object of type `character`?
- `is.atomic()`: Is object of type `atomic`?
- `is.list()`: Is object of type `list`?
- `is.vector()`: Is object of type `vector`?


Function | logical | int | dbl | chr | list
---------|---------|-----|-----|-----|-----
`is.logical()` | X | | | |
`is.integer()` |  |X | | |
`is.double()` |  | |X | |
`is.numeric()` |  |X |X | |
`is.character()` |  | | |X |
`is.atomic()` |X  |X |X |X |
`is.list()` |  | | | | X
`is.vector()` |X  |X |X |X |X

<br>
<details><summary>**Example**: Identifying object types</summary>


```r
v <- c(5, 6, 7)
is.logical(v)
#> [1] FALSE
is.integer(v)
#> [1] FALSE
is.double(v)
#> [1] TRUE
is.numeric(v)
#> [1] TRUE
is.character(v)
#> [1] FALSE
is.atomic(v)
#> [1] TRUE
is.list(v)
#> [1] FALSE
is.vector(v)
#> [1] TRUE
```

</details>


### Converting between classes

Functions for converting between classes:

- `as.logical()`: Convert to `logical`
- `as.numeric()`: Convert to `numeric`
- `as.integer()`: Convert to `integer`
- `as.character()`: Convert to `character`
- `as.list()`: Convert to `list`
- `as.data.frame()`: Convert to `data.frame`


<br>
<details><summary>**Example**: Using `as.logical()` to convert to `logical`</summary>

Character vector coerced to logical vector:


```r
# Only "TRUE"/"FALSE", "True"/"False", "T"/"F", "true"/"false" are able to be coerced to logical type
as.logical(c("TRUE", "FALSE", "True", "False", "true", "false", "T", "F", "t", "f", ""))
#>  [1]  TRUE FALSE  TRUE FALSE  TRUE FALSE  TRUE FALSE    NA    NA    NA
```

Numeric vector coerced to logical vector:


```r
# 0 is treated as FALSE, while all other numeric values are treated as TRUE
as.logical(c(0, 0.0, 1, -1, 20, 5.5))
#> [1] FALSE FALSE  TRUE  TRUE  TRUE  TRUE
```

</details>

<br>
<details><summary>**Example**: Using `as.numeric()` to convert to `numeric`</summary>

Logical vector coerced to numeric vector:


```r
# FALSE is mapped to 0 and TRUE is mapped to 1
as.numeric(c(FALSE, TRUE))
#> [1] 0 1
```

Character vector coerced to numeric vector:


```r
# Strings containing numeric values can be coerced to numeric (leading 0's are dropped) 
# All other characters become NA
as.numeric(c("0", "007", "2.5", "abc", "."))
#> [1] 0.0 7.0 2.5  NA  NA
```

</details>

<br>
<details><summary>**Example**: Using `as.integer()` to convert to `integer`</summary>

Logical vector coerced to integer vector:


```r
# FALSE is mapped to 0 and TRUE is mapped to 1
as.integer(c(FALSE, TRUE))
#> [1] 0 1
```

Character vector coerced to integer vector:


```r
# Strings containing numeric values can be coerced to integer (leading 0's are dropped, decimals are truncated) 
# All other characters become NA
as.integer(c("0", "007", "2.5", "abc", "."))
#> [1]  0  7  2 NA NA
```

Numeric vector coerced to integer vector:


```r
# All decimal places are truncated
as.integer(c(0, 2.1, 10.5, 8.8, -1.8))
#> [1]  0  2 10  8 -1
```

</details>

<br>
<details><summary>**Example**: Using `as.character()` to convert to `character`</summary>

Logical vector coerced to character vector:


```r
as.character(c(FALSE, TRUE))
#> [1] "FALSE" "TRUE"
```

Numeric vector coerced to character vector:


```r
as.character(c(-5, 0, 2.5))
#> [1] "-5"  "0"   "2.5"
```

Integer vector coerced to character vector:


```r
as.character(c(-2L, 0L, 10L))
#> [1] "-2" "0"  "10"
```

</details>

<br>
<details><summary>**Example**: Using `as.list()` to convert to `list`</summary>

Atomic vectors coerced to list:


```r
# Logical vector
as.list(c(TRUE, FALSE))
#> [[1]]
#> [1] TRUE
#> 
#> [[2]]
#> [1] FALSE

# Character vector
as.list(c("a", "b", "c"))
#> [[1]]
#> [1] "a"
#> 
#> [[2]]
#> [1] "b"
#> 
#> [[3]]
#> [1] "c"

# Numeric vector
as.list(1:3)
#> [[1]]
#> [1] 1
#> 
#> [[2]]
#> [1] 2
#> 
#> [[3]]
#> [1] 3
```

</details>

<br>
<details><summary>**Example**: Using `as.data.frame()` to convert to `data.frame`</summary>

Lists coerced to dataframe:


```r
# Create a list
l <- list(A = c("x", "y", "z"), B = c(1, 2, 3))
str(l)
#> List of 2
#>  $ A: chr [1:3] "x" "y" "z"
#>  $ B: num [1:3] 1 2 3

# Convert to class `data.frame`
df <- as.data.frame(l, stringsAsFactors = F)
str(df)
#> 'data.frame':	3 obs. of  2 variables:
#>  $ A: chr  "x" "y" "z"
#>  $ B: num  1 2 3
```

</details>


## Subsetting elements

What is **subsetting**?

- Subsetting refers to isolating particular elements of an object 
- Subsetting operators can be used to select/exclude elements (e.g., variables, observations)
- There are three subsetting operators: `[]`, `[[]]`, `$` 
- These operators function differently based on vector types (e.g., atomic vectors, lists, dataframes)

<br>
For the examples in the next few subsections, we will be working with the following named atomic vector, named list, and dataframe:

- Create named atomic vector called `v` with 4 elements

    
    ```r
    v <- c(a = 10, b = 20, c = 30, d = 40)
    v
    #>  a  b  c  d 
    #> 10 20 30 40
    ```

- Create named list called `l` with 4 elements

    
    ```r
    l <- list(a = TRUE, b = c("a", "b", "c"), c = list(1, 2), d = 10L)
    l
    #> $a
    #> [1] TRUE
    #> 
    #> $b
    #> [1] "a" "b" "c"
    #> 
    #> $c
    #> $c[[1]]
    #> [1] 1
    #> 
    #> $c[[2]]
    #> [1] 2
    #> 
    #> 
    #> $d
    #> [1] 10
    ```

- Create dataframe called `df` with 4 columns and 3 rows

    
    ```r
    df <- data.frame(
      a = c(11, 21, 31),
      b = c(12, 22, 32),
      c = c(13, 23, 33),
      d = c(14, 24, 34)
    )
    df
    #> # A tibble: 3 x 4
    #>       a     b     c     d
    #>   <dbl> <dbl> <dbl> <dbl>
    #> 1    11    12    13    14
    #> 2    21    22    23    24
    #> 3    31    32    33    34
    ```
    
### Subsetting using `[]`

The `[]` operator:

- Subsetting an object using `[]` returns an object of the same type
  - E.g., Using `[]` on an atomic vector returns an atomic vector, using `[]` on a list returns a list, etc.
- The returned object will contain the element(s) you selected
- Object attributes are retained when using `[]` (e.g., _name_)

Six ways to subset using `[]`:

1. Use positive integers to return elements at specified index positions
2. Use negative integers to exclude elements at specified index positions
3. Use logical vectors to return elements where corresponding logical is `TRUE`
4. Empty vector `[]` returns original object (useful for dataframes)
5. Zero vector `[0]` returns empty object (useful for testing data)
6. If object is named, use character vectors to return elements with matching names

<br>
<details><summary>**Example**: Using positive integers with `[]`</summary>

**Selecting a single element**: Specify the index of the element to subset


```r
# Select 1st element from numeric vector (note that names attribute is retained)
v[1]
#>  a 
#> 10

# Subsetted object will be of type `numeric`
class(v[1])
#> [1] "numeric"

# Select 1st element from list (note that names attribute is retained)
l[1]
#> $a
#> [1] TRUE

# Subsetted object will be a `list` containing the element
class(l[1])
#> [1] "list"
```

<br>
**Selecting multiple elements**: Specify the indices of the elements to subset using `c()`


```r
# Select 3rd and 1st elements from numeric vector
v[c(3,1)]
#>  c  a 
#> 30 10

# Subsetted object will be of type `numeric`
class(v[c(3,1)])
#> [1] "numeric"

# Select 1st element three times from list
l[c(1,1,1)]
#> $a
#> [1] TRUE
#> 
#> $a
#> [1] TRUE
#> 
#> $a
#> [1] TRUE

# Subsetted object will be a `list` containing the elements
class(l[c(1,1,1)])
#> [1] "list"
```

</details>

<br>
<details><summary>**Example**: Using negative integers with `[]`</summary>

**Excluding a single element**: Specify the index of the element to exclude


```r
# Exclude 1st element from numeric vector (note that names are retained)
v[-1]
#>  b  c  d 
#> 20 30 40

# Subsetted object will be of type `numeric`
class(v[-1])
#> [1] "numeric"
```

<br>
**Excluding multiple elements**: Specify the indices of the elements to exclude using `-c()`


```r
# Exclude 1st and 3rd elements from list
l[-c(1,3)]
#> $b
#> [1] "a" "b" "c"
#> 
#> $d
#> [1] 10

# Subsetted object will be a `list` containing the remaining elements
class(l[-c(1,3)])
#> [1] "list"
```

</details>

<br>
<details><summary>**Example**: Using logical vectors with `[]`</summary>

If the logical vector is the same length as the object, then each element in the object whose corresponding position in the logical vector is `TRUE` will be selected:


```r
# Select 2nd and 3rd elements from numeric vector
v[c(FALSE, TRUE, TRUE, FALSE)]
#>  b  c 
#> 20 30

# Subsetted object will be of type `numeric`
class(v[c(FALSE, TRUE, TRUE, FALSE)])
#> [1] "numeric"
```

<br>
If the logical vector is shorter than the object, then the elements in the logical vector will be recycled:


```r
# This is equivalent to `l[c(FALSE, TRUE, FALSE, TRUE)]`, thus retaining 2nd and 4th elements
l[c(FALSE, TRUE)]
#> $b
#> [1] "a" "b" "c"
#> 
#> $d
#> [1] 10

# Subsetted object will be a `list` containing the elements
class(l[c(FALSE, TRUE)])
#> [1] "list"
```

<br>
We can also write expressions that evaluates to either `TRUE` or `FALSE`:

```r
# This expression is recycled and evaluates to be equivalent to `l[c(FALSE, FALSE, TRUE, TRUE)]`
v[v > 20]
#>  c  d 
#> 30 40
```

</details>

<br>
<details><summary>**Example**: Using empty vector `[]`</summary>

An empty vector `[]` just returns the original object:


```r
# Original atomic vector
v[]
#>  a  b  c  d 
#> 10 20 30 40

# Original list
l[]
#> $a
#> [1] TRUE
#> 
#> $b
#> [1] "a" "b" "c"
#> 
#> $c
#> $c[[1]]
#> [1] 1
#> 
#> $c[[2]]
#> [1] 2
#> 
#> 
#> $d
#> [1] 10

# Original dataframe
df[]
#> # A tibble: 3 x 4
#>       a     b     c     d
#>   <dbl> <dbl> <dbl> <dbl>
#> 1    11    12    13    14
#> 2    21    22    23    24
#> 3    31    32    33    34
```

</details>

<br>
<details><summary>**Example**: Using zero vector `[0]`</summary>

A zero vector `[0]` just returns an empty object of the same type as the original object:


```r
# Empty named atomic vector
v[0]
#> named numeric(0)

# Empty named list
l[0]
#> named list()

# Empty dataframe
df[0]
#> # A tibble: 3 x 0
```

</details>

<br>
<details><summary>**Example**: Using element names with `[]`</summary>

We can select a single element or multiple elements by their name(s):


```r
# Equivalent to v[2]
v["b"]
#>  b 
#> 20

# Equivalent to l[c(1, 3)]
l[c("a", "c")]
#> $a
#> [1] TRUE
#> 
#> $c
#> $c[[1]]
#> [1] 1
#> 
#> $c[[2]]
#> [1] 2
```

</details>

### Subsetting using `[[]]`

The `[[]]` operator:

- We can only use `[[]]` to extract a single element rather than multiple elements
- Subsetting an object using `[[]]` returns the selected element itself, which might not be of the same type as the original object
  - E.g., Using `[[]]` to select an element from a list that is a numeric vector will return that numeric vector and not a list containing that numeric vector, like what `[]` would return
    - Let `x` be a list with 3 elements (_Think of it as a train with 3 cars_)
    [![](https://d33wubrfki0l68.cloudfront.net/1f648d451974f0ed313347b78ba653891cf59b21/8185b/diagrams/subsetting/train.png)](https://adv-r.hadley.nz/subsetting.html#subset-single)
    - `x[1]` will be a list containing the 1st element, which is a numeric vector (i.e., _train with the 1st car_)
    - `x[[1]]` will be the numeric vector itself (i.e., _the objects within the 1st car_)
    [![](https://d33wubrfki0l68.cloudfront.net/aea9600956ff6fbbc29d8bd49124cca46c5cb95c/28eaa/diagrams/subsetting/train-single.png)](https://adv-r.hadley.nz/subsetting.html#subset-single)
    - *Source: Subsetting from [R for Data Science](https://adv-r.hadley.nz/subsetting.html)*
- Object attributes are removed when using `[[]]`
  - E.g., Using `[[]]` on a named object returns just the selected element itself without the name attribute

<br>
Two ways to subset using `[[]]`:

1. Use a positive integer to return an element at the specified index position
2. If object is named, using a character to return an element with the specified name

<br>
<details><summary>**Example**: Using positive integer with `[[]]`</summary>


```r
# Select 1st element from numeric vector (note that names attribute is gone)
v[[1]]
#> [1] 10

# Subsetted element is `numeric`
class(v[[1]])
#> [1] "numeric"

# Select 1st element from list (note that names attribute is gone)
l[[1]]
#> [1] TRUE

# Subsetted element is `logical`
class(l[[1]])
#> [1] "logical"
```

</details>

<br>
<details><summary>**Example**: Using element name with `[[]]`</summary>


```r
# Equivalent to v[[2]]
v[["b"]]
#> [1] 20

# Subsetted element is `numeric`
class(v[["b"]])
#> [1] "numeric"

# Equivalent to l[[2]]
l[["b"]]
#> [1] "a" "b" "c"

# Subsetted element is `character` vector
class(l[["b"]])
#> [1] "character"
```

</details>


### Subsetting using `$`

The `$` operator:

- `obj_name$element_name` is shorthand for `obj_name[["element_name"]]`
- This operator only works on lists (including dataframes) and not on atomic vectors

<br>
<details><summary>**Example**: Subsetting with `$`</summary>

Subsetting a list with `$`:


```r
# Equivalent to l[["b"]]
l$b
#> [1] "a" "b" "c"

# Subsetted element is `character` vector
class(l$b)
#> [1] "character"
```

<br>
Since dataframes is just a special kind of named list, it would work the same way:


```r
# Equivalent to df[["d"]]
df$d
#> [1] 14 24 34
```

</details>

### Subsetting dataframes

Subsetting dataframes with `[]`, `[[]]`, and `$`:

- Subsetting dataframes works the same way as lists because dataframes are just a special kind of named list, where we can think of each element as a column
  - `df_name[<column(s)>]` returns a dataframe containing the selected column(s), with its attributes retained
  - `df_name[[<column>]]` or `df_name$<column>` returns the column itself, without any attributes
- In addition to the normal way of subsetting, we are also allowed to subset dataframes by cell(s)
  - `df_name[<row(s)>, <column(s)>]` returns the selected cell(s)
    - If a single cell is selected, or cells from the same column, then these would be returned as an object of the same type as that column (similar to how `[[]]` normally works)
    - Otherwise, the subsetted object would be a dataframe, as we'd normally expect when using `[]`
  - `df_name[[<row>, <column>]]` returns the selected cell

<br>
<details><summary>**Example**: Subsetting dataframe column(s) with `[]`</summary>

We can subset dataframe column(s) the same way we have subsetted atomic vector or list element(s):


```r
# Select 1st column from dataframe (note that names attribute is retained)
df[1]
#> # A tibble: 3 x 1
#>       a
#>   <dbl>
#> 1    11
#> 2    21
#> 3    31

# Subsetted object will be a `data.frame` containing the column
class(df[1])
#> [1] "data.frame"

# Exclude 1st and 3rd columns from dataframe (note that names attribute is retained)
df[-c(1,3)]
#> # A tibble: 3 x 2
#>       b     d
#>   <dbl> <dbl>
#> 1    12    14
#> 2    22    24
#> 3    32    34

# Subsetted object will be a `data.frame` containing the remaining columns
class(df[-c(1,3)])
#> [1] "data.frame"
```

</details>

<br>
<details><summary>**Example**: Subsetting dataframe column with `[[]]` and `$`</summary>

We can select a single dataframe column the same way we have subsetted a single atomic vector or list element:


```r
# Select 1st column from dataframe by its index (note that names attribute is gone)
df[[1]]
#> [1] 11 21 31

# Subsetted column is `numeric` vector
class(df[[1]])
#> [1] "numeric"

# Equivalently, we could've selected 1st column by its name
df[["a"]]
#> [1] 11 21 31

# Equivalently, we could've selected 1st column using `$`
df$a
#> [1] 11 21 31
```

</details>

<br>
<details><summary>**Example**: Subsetting dataframe cell(s) with `[]`</summary>

If we select a single cell by specifying its row and column, we will get back the element itself, not in a dataframe:


```r
# Selects cell in 1st row and 2nd col
df[1, 2]
#> [1] 12

# Subsetted cell is of type `numeric`
class(df[1, 2])
#> [1] "numeric"

# Equivalently, we could select using column name instead of index
df[1, "b"]
#> [1] 12
```

<br>
Similarly, if we select cells from the same column, we will get back the elements themselves, not in a dataframe:


```r
# Selects cells from the 2nd col
df[c(1,3), 2]
#> [1] 12 32

# Subsetted cells is of type `numeric`
class(df[c(1,3), 2])
#> [1] "numeric"

# Selects all cells from the 2nd col
df[, 2]
#> [1] 12 22 32

# Subsetted column is of type `numeric`
class(df[, 2])
#> [1] "numeric"
```

<br>
However, if we select cells from the same row, or cells across multiple rows and columns, we will get back a dataframe that contains the selected cells:


```r
# Selects cells from the 2nd row
df[2, c("a", "c")]
#> # A tibble: 1 x 2
#>       a     c
#>   <dbl> <dbl>
#> 1    21    23

# Subsetted cells are returned as a dataframe
class(df[2, c("a", "c")])
#> [1] "data.frame"

# Selects all cells from the 2nd row
df[2, ]
#> # A tibble: 1 x 4
#>       a     b     c     d
#>   <dbl> <dbl> <dbl> <dbl>
#> 1    21    22    23    24

# Subsetted row is returned as a dataframe
class(df[2, ])
#> [1] "data.frame"

# Selects cells from multiple rows and columns
df[1:2, c("a", "c")]
#> # A tibble: 2 x 2
#>       a     c
#>   <dbl> <dbl>
#> 1    11    13
#> 2    21    23

# Subsetted cells are returned as a dataframe
class(df[1:2, c("a", "c")])
#> [1] "data.frame"
```

</details>

<br>
<details><summary>**Example**: Subsetting dataframe cell with `[[]]`</summary>

With `[[]]`, we are only allowed to select a single cell:


```r
# Selects cell in 1st row and 2nd col
df[[1, 2]]
#> [1] 12

# Subsetted cell is of type `numeric`
class(df[[1, 2]])
#> [1] "numeric"

# This is equivalent to using `[]`
df[1, 2]
#> [1] 12
```

</details>

## Attributes [SKIP]

### Augmented vectors

What are **augmented vectors** and **attributes**?

- Atomic vectors can be thought of as "just the data", while **augmented vectors** are atomic vectors with additional attributes attached
- **Attributes** are additional "metadata" that can be attached to any object (e.g., vector or list)
  - E.g., __Value labels__: Character labels (e.g., "Charter School") attached to numeric values
  - E.g., __Object class__: Specifies how object is treated by object oriented programming language
- Recall that when we subset by `[]`, all the attributes are retained. When we subset by `[[]]`, we get back "just the data" without any of the attributes.

**Example**: Variables of a dataset

- A data frame is a list
- Each element in the list is a variable (i.e., column), which consists of:
    - Atomic vector ("just the data")
    - Variable _name_, which is an attribute we attach to the element/variable
    - Any other attributes we want to attach to element/variable

__Main takaway__:

- Augmented vectors are atomic vectors (just the data) with additional attributes attached
- Description of attributes from [Wickham and Grolemund](https://r4ds.had.co.nz/vectors.html#attributes):
  - "Any vector can contain arbitrary additional __metadata__ through its __attributes__"
  - "You can think of __attributes__ as named list of vectors that can be attached to any object"
- Functions to identify and modify attributes
  - `attributes()`: View all attributes of an object or set/change all attributes of an object
  - `attr()`: View individual attribute of an object or set/change an individual attribute of an object

### `attributes()` function

__The `attributes()` function__:


```r
?attributes

# SYNTAX
attributes(x)  # Get attributes
attributes(x) <- value  # Set attributes
```

- Function: Get or set all attributes of an object
- Arguments
  - `x`: The object whose attributes we want to view or modify
  - `value`: In the assignment form, the value we want to set all attributes to be

<br>
<details><summary>**Example**: Using `attributes()` to get attributes of object</summary>

Recall our dataframe `df` from the previous examples, which has multiple attributes:


```r
df
#> # A tibble: 3 x 4
#>       a     b     c     d
#>   <dbl> <dbl> <dbl> <dbl>
#> 1    11    12    13    14
#> 2    21    22    23    24
#> 3    31    32    33    34

# View attributes of dataframe
attributes(df)
#> $names
#> [1] "a" "b" "c" "d"
#> 
#> $class
#> [1] "data.frame"
#> 
#> $row.names
#> [1] 1 2 3
```

<br>
When we subset by `[]`, attributes are retained:


```r
# Subset 1st column using `[]`
df[1]
#> # A tibble: 3 x 1
#>       a
#>   <dbl>
#> 1    11
#> 2    21
#> 3    31

# Attributes are retained when we subset by `[]`
attributes(df[1])
#> $names
#> [1] "a"
#> 
#> $row.names
#> [1] 1 2 3
#> 
#> $class
#> [1] "data.frame"
```

<br>
When we subset by `[[]]`, attributes are removed and we are left with "just the data":


```r
# Subset 1st column using `[[]]`
df[[1]]
#> [1] 11 21 31

# Attributes are gone when we subset by `[[]]`
attributes(df[[1]])
#> NULL
```

</details>

<br>
<details><summary>**Example**: Using `attributes()` to set attributes of object</summary>

Recall our named atomic vector `v` from the previous examples, which has the _name_ attribute:


```r
v
#>  a  b  c  d 
#> 10 20 30 40

# View attributes of atomic vector
attributes(v)
#> $names
#> [1] "a" "b" "c" "d"
```

<br>
Remove all attributes from the vector:


```r
# Set all attributes to NULL
attributes(v) <- NULL

# The atomic vector is no longer named
v
#> [1] 10 20 30 40

# Confirm that the names attribute is no longer there
attributes(v)
#> NULL
```

</details>

### `attr()` function

__The `attr()` function__:


```r
?attr

# SYNTAX AND DEFAULT VALUES
attr(x, which, exact = FALSE)  # Get attribute
attr(x, which) <- value  # Set attribute
```

- Function: Get or set a specific attribute of an object
- Arguments
  - `x`: The object whose attribute we want to view or modify
  - `which`: A non-empty string specifying which attribute is to be accessed
  - `exact`: If set to `TRUE`, the attribute specified by `which` needs to be matched exactly
  - `value`: In the assignment form, the value we want to set the attribute to be

<br>
<details><summary>**Example**: Using `attr()` to get attribute of object</summary>

Recall our dataframe `df` from the previous examples, which has multiple attributes:


```r
df
#> # A tibble: 3 x 4
#>       a     b     c     d
#>   <dbl> <dbl> <dbl> <dbl>
#> 1    11    12    13    14
#> 2    21    22    23    24
#> 3    31    32    33    34

# View attributes of dataframe
attributes(df)
#> $names
#> [1] "a" "b" "c" "d"
#> 
#> $class
#> [1] "data.frame"
#> 
#> $row.names
#> [1] 1 2 3
```

<br>
We can use `attr()` to fetch individual attributes:


```r
# Get the names attribute
attr(df, "names")
#> [1] "a" "b" "c" "d"

# Note that we don't have to provide the full name of attribute for it to be recognized
attr(df, "nam")
#> [1] "a" "b" "c" "d"

# If we specify `exact = TRUE`, then we do have to provide exact attribute name
attr(df, "names", exact = TRUE)
#> [1] "a" "b" "c" "d"

# This no longer works
attr(df, "nam", exact = TRUE)
#> NULL
```

</details>

<br>
<details><summary>**Example**: Using `attr()` to set attribute of object</summary>

Recall the atomic vector `v` that we've removed all attributes from in the previous example:


```r
v
#> [1] 10 20 30 40

# View attributes of atomic vector
attributes(v)
#> NULL
```

<br>
We can add back the `names` attributes using `attr()`:


```r
# Add back names attribute
attr(v, "names") <- c("a", "b", "c", "d")

# View attributes
attributes(v)
#> $names
#> [1] "a" "b" "c" "d"
```

<br>
We can also create any other attributes we want:


```r
# Create new attribute called `greeting`
attr(x = v, which = "greeting") <- "Hi!"

# View `greeting` attribute
attr(x = v, which = "greeting")
#> [1] "Hi!"

# View all attributes
attributes(v)
#> $names
#> [1] "a" "b" "c" "d"
#> 
#> $greeting
#> [1] "Hi!"
```

<br>
We can use `NULL` to remove attributes:


```r
# Remove `greeting` attribute
attr(x = v, which = "greeting") <- NULL

# Try viewing `greeting` attribute
attr(x = v, which = "greeting")
#> NULL

# View all attributes
attributes(v)
#> $names
#> [1] "a" "b" "c" "d"
```

</details>

<br>
<details><summary>**Example**: Using `attr()` to set attribute of dataframe variable</summary>

Unlike atomic vectors, we can also set attributes of individual elements of lists (which include dataframes). Recall our dataframe `df`:


```r
df
#> # A tibble: 3 x 4
#>       a     b     c     d
#>   <dbl> <dbl> <dbl> <dbl>
#> 1    11    12    13    14
#> 2    21    22    23    24
#> 3    31    32    33    34

# View attributes of dataframe
attributes(df)
#> $names
#> [1] "a" "b" "c" "d"
#> 
#> $class
#> [1] "data.frame"
#> 
#> $row.names
#> [1] 1 2 3
```

<br>
We can also add attributes to an individual column (i.e., variable) of the dataframe using `[[]]` or `$`:


```r
# Equivalent to df[["a"]] - Remember this usually starts off as "just the data" with no attributes
attributes(df$a)
#> NULL

# Add an attribute
attr(df$a, "description") <- "A is for Apple"

# View attributes
attributes(df$a)
#> $description
#> [1] "A is for Apple"
```

<br>
We can use `NULL` to remove attribute:


```r
# Remove `description` attribute
attr(df$a, "description") <- NULL

# Try viewing `description` attribute
attr(df$a, "description")
#> NULL

# View attributes
attributes(df$a)
#> NULL
```

</details>

## Names and values [EMPTY]

## Prerequisite concepts

Several functions and concepts are used frequently when creating loops and/or functions.

### Sequences

What are **sequences**?

- (Loose) definition: A **sequence** is a list of numbers in ascending or descending order
- Sequences can be created using the `:` operator or `seq()` function

**Example**: Creating sequences using `:`


```r
# Sequence from -5 to 5
-5:5
#>  [1] -5 -4 -3 -2 -1  0  1  2  3  4  5

# Sequence from 5 to -5
5:-5
#>  [1]  5  4  3  2  1  0 -1 -2 -3 -4 -5
```

<br>
__The `seq()` function__:


```r
?seq

# SYNTAX AND DEFAULT VALUES
seq(from = 1, to = 1, by = ((to - from)/(length.out - 1)),
    length.out = NULL, along.with = NULL, ...)
```

- Function: Generate a sequence
- Arguments
  - `from`: The starting value of sequence
  - `to`: The end (or maximal) value of sequence
  - `by`: Increment of the sequence

**Example**: Creating sequences using `seq()`


```r
# Sequence from 10 to 15, by increment of 1 (default)
seq(10,15)
#> [1] 10 11 12 13 14 15

# Explicitly specify increment of 1 (equivalent to above)
seq(from=10, to=15, by=1)
#> [1] 10 11 12 13 14 15

# Sequence from 100 to 150, by increment of 10
seq(from=100, to=150, by=10)
#> [1] 100 110 120 130 140 150
```

### Length

__The `length()` function__:


```r
?length

# SYNTAX
length(x)
```

- Function: Returns the number of elements in the object
- Arguments:
  - `x`: The object to find the length of

<br>
**Example**: Using `length()` to find number of elements in `v`


```r
# View the atomic vector
v
#>  a  b  c  d 
#> 10 20 30 40

# Use `length()` to find number of elements
length(v)
#> [1] 4
```

<br>
**Example**: Using `length()` to find number of elements in `df`

Remember that dataframes are just lists where each element is a column, so the number of elements in a dataframe is just the number of columns it has:


```r
# View the dataframe
df
#> # A tibble: 3 x 4
#>       a     b     c     d
#>   <dbl> <dbl> <dbl> <dbl>
#> 1    11    12    13    14
#> 2    21    22    23    24
#> 3    31    32    33    34

# Use `length()` to find number of elements (i.e., columns)
length(df)
#> [1] 4
```

<br>
When we subset a dataframe using `[]` (i.e., _select column(s) from the dataframe_), the length of the subsetted object is the number of columns we selected:


```r
# Subset one column
df[1]
#> # A tibble: 3 x 1
#>       a
#>   <dbl>
#> 1    11
#> 2    21
#> 3    31

# Length is one
length(df[1])
#> [1] 1

# Subset three columns
df[1:3]
#> # A tibble: 3 x 3
#>       a     b     c
#>   <dbl> <dbl> <dbl>
#> 1    11    12    13
#> 2    21    22    23
#> 3    31    32    33

# Length is three
length(df[1:3])
#> [1] 3
```

<br>
When we subset a dataframe using `[[]]` (i.e., _isolate a specific column in the dataframe_), the length of the subsetted object is the number of rows in the dataframe:


```r
# Isolate a specific column
df[[2]]
#> [1] 12 22 32

# Length is number of elements in that column (i.e., number of rows in dataframe)
length(df[[2]])
#> [1] 3
```


### Sequences and length

When writing loops, it is very common to create a sequence from 1 to the length (i.e., number of elements) of an object.

<br>
**Example**: Generating a sequence from 1 to length of `v`


```r
# There are 4 elements in the atomic vector
v
#>  a  b  c  d 
#> 10 20 30 40

# Use `:` to generate a sequence from 1 to 4
1:length(v)
#> [1] 1 2 3 4

# Use `seq()` to generate a sequence from 1 to 4
seq(1, length(v))
#> [1] 1 2 3 4
```

<br>
There is also a function `seq_along()` that makes it easier to generate a sequence from 1 to the length of an object.

<br>
__The `seq_along()` function__:


```r
?seq_along

# SYNTAX
seq_along(x)
```

- Function: Generates a sequence from 1 to the length of the input object
- Arguments
  - `x`: The object to generate the sequence for

<br>
**Example**: Generating a sequence from 1 to length of `df`


```r
# There are 4 elements (i.e., columns) in the dataframe
df
#> # A tibble: 3 x 4
#>       a     b     c     d
#>   <dbl> <dbl> <dbl> <dbl>
#> 1    11    12    13    14
#> 2    21    22    23    24
#> 3    31    32    33    34

# Use `seq_along()` to generate a sequence from 1 to 4
seq_along(df)
#> [1] 1 2 3 4
```

### Directories and paths [SKIP]

<br>

#### Current working directory

When you run R code in an `.Rmd` file, the working directory is the directory that your `.Rmd` file is in:


```r
getwd()
#> [1] "/Users/patriciamartin/Desktop/GitHub/rclass2/lectures/programming"
```

<br>
When you run an `.R` script, the working directory is the directory indicated at the top of your console in RStudio:

![](../../assets/images/r_console.png)

- This is typically your home directory if you are not working from an RStudio project
- If you are working from an RStudio project, your working directory would be the project directory

<br>

#### Checking if a file or directory exists

<br>
__The `file.exists()` function__:


```r
?file.exists

# SYNTAX
file.exists(...)
```

- Function: Checks if a file exists
- Argument(s): filename(s)

<br>
__The `dir.exists()` function__:


```r
?dir.exists

# SYNTAX
dir.exists(paths)
```

- Function: Checks if a directory exists
- Argument(s): path(s)

<br>

#### Creating and deleting directories

<br>
__The `dir.create()` function__:


```r
?dir.create

# SYNTAX AND DEFAULT VALUES
dir.create(path, showWarnings = TRUE, recursive = FALSE, mode = "0777")
```

- Function: Creates new directories
- Arguments  
  - `path`: A character vector containing a single path name
  - `showWarnings`: Should the warnings on failure be shown?
    - If directory you want to create already exists, you will get a warning, but this won't cause the code to stop running
  - `recursive`: Should elements of the path other than the last be created?
    - That is, will `dir.create()` create the file path `new_directory/new_sub_directory` if neither `new_directory` nor `new_sub_directory` exist?

<br>
**Example**: Creating a new directory within current working directory


```r
# Check current working directory
getwd()
#> [1] "/Users/patriciamartin/Desktop/GitHub/rclass2/lectures/programming"

# Create new directory called `my_folder`
dir.create(path = "my_folder")

# Check that `my_folder` has been created
list.files()
#>  [1] "data"                     "function_basics.html"    
#>  [3] "function_basics.md"       "function_basics.Rmd"     
#>  [5] "ipeds_file_list_og.txt"   "ipeds_file_list.txt"     
#>  [7] "loop_example_ipeds.R"     "my_folder"               
#>  [9] "programming_lecture.html" "programming_lecture.md"  
#> [11] "programming_lecture.Rmd"  "programming.Rproj"
```

<br>
__The `unlink()` function__:


```r
?unlink

# SYNTAX AND DEFAULT VALUES
unlink(x, recursive = FALSE, force = FALSE)
```

- Function: Deletes files or directories
- Arguments  
  - `x`: A character vector with the names of the files or directories to be deleted
  - `recursive`: Should directories be deleted recursively?
    - If recursive = `FALSE`, directories are not deleted, not even empty ones.
  - `force`: Should permissions be changed (if possible) to allow the file or directory to be removed?

<br>
**Example**: Deleting a directory within current working directory


```r
# Delete `my_folder` we just created
unlink(x = "my_folder", recursive = TRUE) 

# Check that `my_folder` has been deleted
list.files()
#>  [1] "data"                     "function_basics.html"    
#>  [3] "function_basics.md"       "function_basics.Rmd"     
#>  [5] "ipeds_file_list_og.txt"   "ipeds_file_list.txt"     
#>  [7] "loop_example_ipeds.R"     "programming_lecture.html"
#>  [9] "programming_lecture.md"   "programming_lecture.Rmd" 
#> [11] "programming.Rproj"
```

<br>

#### File paths

> We use the `file.path()` command because it is smart. Some computer operating systems use forward slashes, `/`, for their file paths; others use backslashes, `\`. Rather than try to guess or assume what operating system future users will use, we can use R's function, `file.path()`, to check the current operating system and build the paths correctly for us.

*Credit: [Organizing Lecture](https://edquant.github.io/edh7916/lessons/organizing.html) by Ben Skinner*

<br>
__The `file.path()` function__:


```r
?file.path

# SYNTAX AND DEFAULT VALUES
file.path(..., fsep = .Platform$file.sep)
```

- Pass in each section of the file path as a separate argument
  - Example: `file.path('.', 'lectures', 'week_1')` returns `'./lectures/week_1'`
- You can also save this file path object in a variable
  - Example: `lec_dir <- file.path('.', 'lectures', 'week_1')`


# Iteration

What is **iteration**?

- Iteration is the repetition of some process or operation
  - Example: Iteration can help with "repeating the same operation on different columns, or on different datasets" (From [R for Data Science](https://r4ds.had.co.nz/iteration.html))
- Looping is the most common way to iterate

## Loop basics

What are **loops**?

- __Loops__ execute some set of commands multiple times
- Each time the loop executes the set of commands is an __iteration__
- The below loop iterates 4 times

<br>
__Example__: Printing each element of the vector `c(1,2,3,4)` using a loop


```r
c(1,2,3,4)  # There are 4 elements in the vector
#> [1] 1 2 3 4

for(i in c(1,2,3,4)) {  # Iterate over each element of the vector
  print(i)  # Print out each element
}
#> [1] 1
#> [1] 2
#> [1] 3
#> [1] 4
```

<br>
When to write **loops**?

- Broadly, rationale for writing loop:
  - Do not duplicate code
  - Can make changes to code in one place rather than many
- When to write a loop:
  - Grolemund and Wickham say __don't copy and paste more than twice__
  - If you find yourself doing this, consider writing a loop or function
- Don't worry about knowing all the situations you should write a loop
  - Rather, you'll be creating analysis dataset or analyzing data and you will notice there is some task that you are repeating over and over
  - Then you'll think, "Oh, I should write a loop or function for this"


## Components of a loop

How to write a **loop**?

- We can build loops using the `for()` function
- The **loop sequence** goes inside the parentheses of `for()`
- The **loop body** goes inside the pair of curly brackets (`{}`) that follows `for()`


```r
for(i in c(1,2,3,4)) {  # Loop sequence
  print(i)  # Loop body
}
```

<br>
Components of a **loop**:

1. __Sequence__: Determines what to "loop over"
    - In the above example, the sequence is `i in c(1,2,3,4)`
    - This creates a temporary/local object named `i` (could name it anything)
    - Each iteration of the loop will assign a different value to `i`
    - `c(1,2,3,4)` is the set of values that will be assigned to `i` 
        - In the first iteration, the value of `i` is `1`
        - In the second iteration, the value of `i` is `2`, etc.
2. __Body__: What commands to execute for each iteration of the loop
    - In the above example, the body is `print(i)`
    - Each time through the loop (i.e., iteration), body prints the value of object `i`
    

### Ways to write loop sequence

You may see the loop sequence being written in slightly different ways. For example, these three loops all do the same thing:

- Looping over the vector `c(1,2,3)`

    
    ```r
    for(z in c(1,2,3)) {  # Loop sequence
      print(z)  # Loop body
    }
    #> [1] 1
    #> [1] 2
    #> [1] 3
    ```

- Looping over the sequence `1:3` 

    
    ```r
    for(z in 1:3) {  # Loop sequence
      print(z)  # Loop body
    }
    #> [1] 1
    #> [1] 2
    #> [1] 3
    ```

- Looping over the object `num_sequence`
    
    
    ```r
    num_sequence <- 1:3
    for(z in num_sequence) {  # Loop sequence
      print(z)  # Loop body
    }
    #> [1] 1
    #> [1] 2
    #> [1] 3
    ```

### Printing values in loop body

When building a loop, it is useful to print out information to understand what the loop is doing.

For example, the two loops below are essentially the same, but the second approach is preferable because it more clearly prints out what object we are working with inside the loop:

- Using `print()` to print a single object `z`:

    
    ```r
    for(z in c(1,2,3)) {
      print(z)
    }
    #> [1] 1
    #> [1] 2
    #> [1] 3
    ```

- Using `str_c()` and `writeLines()` to concatenate and print multiple items:

    
    ```r
    for(z in c(1,2,3)) {
      writeLines(str_c("object z=", z))
    }
    #> object z=1
    #> object z=2
    #> object z=3
    ```

### Student exercise


1. Create a numeric vector that contains the year of birth of your family members
    - Example: `birth_years <- c(1944,1950,1981,2016)`
2. Write a loop that calculates the current year minus birth year and prints this number for each member of your family
    - Within this loop, you will create a new variable that calculates current year minus birth year

<br>
<details><summary>**Solution**</summary>


```r
birth_years <- c(1944,1950,1981,2016)
birth_years
#> [1] 1944 1950 1981 2016

for(y in birth_years) {  # Loop sequence
  writeLines(str_c("object y=", y))  # Loop body
  z <- 2020 - y
  writeLines(str_c("value of ", y, " minus ", 2018, " is ", z))
}
#> object y=1944
#> value of 1944 minus 2018 is 76
#> object y=1950
#> value of 1950 minus 2018 is 70
#> object y=1981
#> value of 1981 minus 2018 is 39
#> object y=2016
#> value of 2016 minus 2018 is 4
```
</details>


## Ways to loop over a vector

There are 3 ways to loop over elements of an object:

1. [Looping over the elements](#looping-over-elements) (approach we have used so far)
2. [Looping over names of the elements](#looping-over-names)
3. [Looping over numeric indices associated with element position](#looping-over-indices) (approach recommended by Grolemnund and Wickham)

<br>
For the examples in the next few subsections, we will be working with the following named atomic vector and dataframe:

- Create named atomic vector called `vec`

    
    ```r
    vec <- c(a = 5, b = -10, c = 30)
    vec
    #>   a   b   c 
    #>   5 -10  30
    ```

- Create dataframe called `df` with randomly generated data, 3 columns (vars) and 4 rows (obs)

    
    ```r
    set.seed(12345) # so we all get the same variable values
    df <- tibble(a = rnorm(4), b = rnorm(4), c = rnorm(4))
    str(df)
    #> tibble [4 × 3] (S3: tbl_df/tbl/data.frame)
    #>  $ a: num [1:4] 0.586 0.709 -0.109 -0.453
    #>  $ b: num [1:4] 0.606 -1.818 0.63 -0.276
    #>  $ c: num [1:4] -0.284 -0.919 -0.116 1.817
    ```

### Looping over elements

**Syntax**: `for (i in object_name)`

- This approach iterates over each element in the object
- The value of `i` is equal to the element's _content_ (rather than its _name_ or _index position_)

<br>
**Example**: Looping over elements in `vec`
    

```r
vec  # View named atomic vector object
#>   a   b   c 
#>   5 -10  30

for (i in vec) {
  writeLines(str_c("value of object i=",i))
  writeLines(str_c("object i has: type=", typeof(i), "; length=", length(i), "; class=", class(i),
      "\n"))  # "\n" adds line break
}
#> value of object i=5
#> object i has: type=double; length=1; class=numeric
#> 
#> value of object i=-10
#> object i has: type=double; length=1; class=numeric
#> 
#> value of object i=30
#> object i has: type=double; length=1; class=numeric
```

<br>
**Example**: Looping over elements in `df`


```r
df  # View dataframe object
#> # A tibble: 4 x 3
#>        a      b      c
#>    <dbl>  <dbl>  <dbl>
#> 1  0.586  0.606 -0.284
#> 2  0.709 -1.82  -0.919
#> 3 -0.109  0.630 -0.116
#> 4 -0.453 -0.276  1.82

for (i in df) {
  writeLines(str_c("value of object i=",i))
  writeLines(str_c("object i has: type=", typeof(i), "; length=", length(i), "; class=", class(i),
      "\n"))  # "\n" adds line break
}
#> value of object i=0.585528817843856
#> value of object i=0.709466017509524
#> value of object i=-0.109303314681054
#> value of object i=-0.453497173462763
#> object i has: type=double; length=4; class=numeric
#> 
#> value of object i=0.605887455840394
#> value of object i=-1.81795596770373
#> value of object i=0.630098551068391
#> value of object i=-0.276184105225216
#> object i has: type=double; length=4; class=numeric
#> 
#> value of object i=-0.284159743943371
#> value of object i=-0.919322002474128
#> value of object i=-0.116247806352002
#> value of object i=1.81731204370422
#> object i has: type=double; length=4; class=numeric
```

<br>
<details><summary>**Example**: Calculating column averages for `df` by looping over columns</summary>

The dataframe `df` is a list object, where each element is a vector (i.e., column):


```r
df  # View dataframe object
#> # A tibble: 4 x 3
#>        a      b      c
#>    <dbl>  <dbl>  <dbl>
#> 1  0.586  0.606 -0.284
#> 2  0.709 -1.82  -0.919
#> 3 -0.109  0.630 -0.116
#> 4 -0.453 -0.276  1.82

for (i in df) {
  writeLines(str_c("value of object i=", i))
  writeLines(str_c("mean value of object i=", mean(i, na.rm = TRUE), "\n"))
}
#> value of object i=0.585528817843856
#> value of object i=0.709466017509524
#> value of object i=-0.109303314681054
#> value of object i=-0.453497173462763
#> mean value of object i=0.183048586802391
#> 
#> value of object i=0.605887455840394
#> value of object i=-1.81795596770373
#> value of object i=0.630098551068391
#> value of object i=-0.276184105225216
#> mean value of object i=-0.21453851650504
#> 
#> value of object i=-0.284159743943371
#> value of object i=-0.919322002474128
#> value of object i=-0.116247806352002
#> value of object i=1.81731204370422
#> mean value of object i=0.124395622733679
```
</details>

### Looping over names

**Syntax**: `for (i in names(object_name))`

- To use this approach, elements in the object must have name attributes
- This approach iterates over the names of each element in the object
- `names()` returns a vector of the object's element names
- The value of `i` is equal to the element's _name_ (rather than its _content_ or _index position_)
- But note that it is still possible to access the element's content inside the loop:
    - Access element contents using `object_name[i]`
        - Same object type as `object_name`; retains attributes (e.g., _name_)
    - Access element contents using `object_name[[i]]`
        - Removes level of hierarchy, thereby removing attributes
        - Approach recommended by Wickham because it isolates value of element

<br>
**Example**: Looping over elements in `vec`


```r
vec  # View named atomic vector object
#>   a   b   c 
#>   5 -10  30
names(vec)  # View names of atomic vector object
#> [1] "a" "b" "c"

for (i in names(vec)) {
  writeLines(str_c("\nvalue of object i=", i, "; type=", typeof(i)))
  str(vec[i])  # Access element contents using []
  str(vec[[i]])  # Access element contents using [[]]
}
#> 
#> value of object i=a; type=character
#>  Named num 5
#>  - attr(*, "names")= chr "a"
#>  num 5
#> 
#> value of object i=b; type=character
#>  Named num -10
#>  - attr(*, "names")= chr "b"
#>  num -10
#> 
#> value of object i=c; type=character
#>  Named num 30
#>  - attr(*, "names")= chr "c"
#>  num 30
```

<br>
**Example**: Looping over elements in `df`


```r
df  # View dataframe object
#> # A tibble: 4 x 3
#>        a      b      c
#>    <dbl>  <dbl>  <dbl>
#> 1  0.586  0.606 -0.284
#> 2  0.709 -1.82  -0.919
#> 3 -0.109  0.630 -0.116
#> 4 -0.453 -0.276  1.82
names(df)  # View names of dataframe object (i.e., column names)
#> [1] "a" "b" "c"

for (i in names(df)) {
  writeLines(str_c("\nvalue of object i=", i, "; type=", typeof(i)))
  str(df[i])  # Access element contents using []
  str(df[[i]])  # Access element contents using [[]]
}
#> 
#> value of object i=a; type=character
#> tibble [4 × 1] (S3: tbl_df/tbl/data.frame)
#>  $ a: num [1:4] 0.586 0.709 -0.109 -0.453
#>  num [1:4] 0.586 0.709 -0.109 -0.453
#> 
#> value of object i=b; type=character
#> tibble [4 × 1] (S3: tbl_df/tbl/data.frame)
#>  $ b: num [1:4] 0.606 -1.818 0.63 -0.276
#>  num [1:4] 0.606 -1.818 0.63 -0.276
#> 
#> value of object i=c; type=character
#> tibble [4 × 1] (S3: tbl_df/tbl/data.frame)
#>  $ c: num [1:4] -0.284 -0.919 -0.116 1.817
#>  num [1:4] -0.284 -0.919 -0.116 1.817
```


<br>
<details><summary>**Example**: Calculating column averages for `df` by looping over column names</summary>


```r
str(df)  # View structure of dataframe object
#> tibble [4 × 3] (S3: tbl_df/tbl/data.frame)
#>  $ a: num [1:4] 0.586 0.709 -0.109 -0.453
#>  $ b: num [1:4] 0.606 -1.818 0.63 -0.276
#>  $ c: num [1:4] -0.284 -0.919 -0.116 1.817
```

<br>
Remember that we can use `[[]]` to access element contents by their name:


```r
for (i in names(df)) {
  writeLines(str_c("mean of element named", i, "=", mean(df[[i]], na.rm = TRUE)))
}
#> mean of element nameda=0.183048586802391
#> mean of element namedb=-0.21453851650504
#> mean of element namedc=0.124395622733679
```

<br>
If we tried completing the task using `[]` to access the element contents, we would get an error because `mean()` only takes numeric or logical vectors as input, and `df[i]` returns a dataframe object:


```r
for (i in names(df)) {
  writeLines(str_c("mean of element named", i, "=", mean(df[i], na.rm = TRUE)))
  
  # print(class(df[i]))
}
```

</details>

### Looping over indices


**Syntax**: `for (i in 1:length(object_name))` OR `for (i in seq_along(object_name))`

- This approach iterates over the index positions of each element in the object
- There are two ways to create the loop sequence:
    - `length()` returns the number of elements in the input object, which we can use to create a sequence of index positions (i.e., `1:length(object_name)`)
    - `seq_along()` returns a sequence of numbers that represent the index positions for all elements in the input object (i.e., equivalent to `1:length(object_name)`)
- The value of `i` is equal to the element's _index position_ (rather than its _content_ or _name_)
- But note that it is still possible to access the element's content inside the loop:
    - Access element contents using `object_name[i]`
        - Same object type as `object_name`; retains attributes (e.g., _name_)
    - Access element contents using `object_name[[i]]`
        - Removes level of hierarchy, thereby removing attributes
        - Approach recommended by Wickham because it isolates value of element
- Similarly, we can access the element's name by its index using `names(object_name)[i]` or `names(object_name)[[i]]`
    - In this case, using `[[]]` and `[]` are equivalent because `names()` returns an unnamed vector, which does not have any attributes

<br>
**Example**: Looping over elements in `vec`


```r
vec  # View named atomic vector object
#>   a   b   c 
#>   5 -10  30
length(vec)  # View length of atomic vector object
#> [1] 3
1:length(vec)  # Create sequence from `1` to `length(vec)`
#> [1] 1 2 3

for (i in 1:length(vec)) {
  writeLines(str_c("\nvalue of object i=", i, "; type=", typeof(i)))
  str(vec[i])  # Access element contents using []
  str(vec[[i]])  # Access element contents using [[]]
}
#> 
#> value of object i=1; type=integer
#>  Named num 5
#>  - attr(*, "names")= chr "a"
#>  num 5
#> 
#> value of object i=2; type=integer
#>  Named num -10
#>  - attr(*, "names")= chr "b"
#>  num -10
#> 
#> value of object i=3; type=integer
#>  Named num 30
#>  - attr(*, "names")= chr "c"
#>  num 30
```



<br>
**Example**: Looping over elements in `df`


```r
df  # View dataframe object
#> # A tibble: 4 x 3
#>        a      b      c
#>    <dbl>  <dbl>  <dbl>
#> 1  0.586  0.606 -0.284
#> 2  0.709 -1.82  -0.919
#> 3 -0.109  0.630 -0.116
#> 4 -0.453 -0.276  1.82
seq_along(df)  # Equivalent to `1:length(df)`
#> [1] 1 2 3

for (i in seq_along(df)) {
  writeLines(str_c("\nvalue of object i=", i, "; type=", typeof(i)))
  str(df[i])  # Access element contents using []
  str(df[[i]])  # Access element contents using [[]]
}
#> 
#> value of object i=1; type=integer
#> tibble [4 × 1] (S3: tbl_df/tbl/data.frame)
#>  $ a: num [1:4] 0.586 0.709 -0.109 -0.453
#>  num [1:4] 0.586 0.709 -0.109 -0.453
#> 
#> value of object i=2; type=integer
#> tibble [4 × 1] (S3: tbl_df/tbl/data.frame)
#>  $ b: num [1:4] 0.606 -1.818 0.63 -0.276
#>  num [1:4] 0.606 -1.818 0.63 -0.276
#> 
#> value of object i=3; type=integer
#> tibble [4 × 1] (S3: tbl_df/tbl/data.frame)
#>  $ c: num [1:4] -0.284 -0.919 -0.116 1.817
#>  num [1:4] -0.284 -0.919 -0.116 1.817
```

<br>
We could also access the element's name by its index:


```r
names(df)  # View names of dataframe object (i.e., column names)
#> [1] "a" "b" "c"
names(df)[[2]]  # We can access any element in the names vector by its index
#> [1] "b"

# Incorporate the above line into the loop
for (i in 1:length(df)) {
  writeLines(str_c("i=", i, "; name=", names(df)[[i]]))
}
#> i=1; name=a
#> i=2; name=b
#> i=3; name=c
```

<br>
<details><summary>**Example**: Calculating column averages for `df` by looping over column indices</summary>

Use `i in seq_along(df)` to loop over the column indices and `[[]]` to access column contents:


```r
str(df)  # View structure of dataframe object
#> tibble [4 × 3] (S3: tbl_df/tbl/data.frame)
#>  $ a: num [1:4] 0.586 0.709 -0.109 -0.453
#>  $ b: num [1:4] 0.606 -1.818 0.63 -0.276
#>  $ c: num [1:4] -0.284 -0.919 -0.116 1.817

for (i in seq_along(df)) {
  writeLines(str_c("mean of element at index position", i, "=", mean(df[[i]], na.rm = TRUE)))
}
#> mean of element at index position1=0.183048586802391
#> mean of element at index position2=-0.21453851650504
#> mean of element at index position3=0.124395622733679
```

</details>

### Summary

There are 3 ways to loop over elements of an object:

1. [Looping over the elements](#looping-over-elements)
2. [Looping over names of the elements](#looping-over-names)
3. [Looping over numeric indices associated with element position](#looping-over-indices) (approach recommended by Grolemnund and Wickham)
    - Grolemnund and Wickham recommends this approach (**#3**) because given an element's index position, we can also extract the element name (**#2**) and value (**#1**)



```r
for (i in seq_along(df)) {
  writeLines(str_c("i=", i))  # element's index position
  
  name <- names(df)[[i]]  # element's name (what we looped over in approach #2)
  writeLines(str_c("name=", name))
  
  value <- df[[i]]  # element's value (what we looped over in approach #1)
  writeLines(str_c("value=", value, "\n"))
}
#> i=1
#> name=a
#> value=0.585528817843856
#> 
#> value=0.709466017509524
#> 
#> value=-0.109303314681054
#> 
#> value=-0.453497173462763
#> 
#> i=2
#> name=b
#> value=0.605887455840394
#> 
#> value=-1.81795596770373
#> 
#> value=0.630098551068391
#> 
#> value=-0.276184105225216
#> 
#> i=3
#> name=c
#> value=-0.284159743943371
#> 
#> value=-0.919322002474128
#> 
#> value=-0.116247806352002
#> 
#> value=1.81731204370422
```


## Modifying vs. creating object

Grolemund and Wickham differentiate between two types of tasks loops accomplish:

1. __Modifying an existing object__
    - Example: Looping through a set of variables in a dataframe to:
        - Modify these variables OR
        - Create new variables (within the existing dataframe object)
    - When writing loops in Stata/SAS/SPSS, we are usually modifying an existing object because these programs typically only have one object (a dataset) open at a time
2. __Creating a new object__
    - Example: Creating an object that has summary statistics for each variable, which can be the basis for a table or graph, etc.
    - The new object will often be a vector of results based on looping through elements of a dataframe
    - In R (as opposed to Stata/SAS/SPSS), creating a new object is very common because R can hold many objects at the same time


### Modifying an existing object

How to modify an existing object?

- Recall that we can directly access elements in an object (e.g., atomic vector, lists) using `[[]]`. We can use this same notation to _modify_ the object.
- Even though atomic vectors can also be modified with `[]`, Wickhams recommends using `[[]]` in all cases to make it clear we are working with a single element (from [R for Data Science](https://r4ds.had.co.nz/iteration.html#modifying-an-existing-object))

<br>
<details><summary>**Example**: Modifying an existing atomic vector</summary>

Recall our named atomic vector `vec` from the previous examples:


```r
vec
#>   a   b   c 
#>   5 -10  30
```

We can loop over the index positions and use `[[]]` to modify the object:


```r
for (i in seq_along(vec)) {
  vec[[i]] <- vec[[i]] * 2  # Double each element
}

vec
#>   a   b   c 
#>  10 -20  60
```

</details>

<br>
<details><summary>**Example**: Modifying an existing dataframe</summary>

Recall our dataframe `df` from the previous examples:


```r
df
#> # A tibble: 4 x 3
#>        a      b      c
#>    <dbl>  <dbl>  <dbl>
#> 1  0.586  0.606 -0.284
#> 2  0.709 -1.82  -0.919
#> 3 -0.109  0.630 -0.116
#> 4 -0.453 -0.276  1.82
```

We can loop over the index positions and use `[[]]` to modify the object:


```r
for (i in seq_along(df)) {
  df[[i]] <- df[[i]] * 2  # Double each element
}

df
#> # A tibble: 4 x 3
#>        a      b      c
#>    <dbl>  <dbl>  <dbl>
#> 1  1.17   1.21  -0.568
#> 2  1.42  -3.64  -1.84 
#> 3 -0.219  1.26  -0.232
#> 4 -0.907 -0.552  3.63
```

</details>


### Creating a new object

So far our loops have two components: 

1. Sequence
1. Body

When we create a new object to store the results of a loop, our loops have three components:

1. Sequence
1. Body
1. **Output** (_This is the new object that will store the results created from your loop_)

<br>
Grolemund and Wickham recommend using `vector()` to create this new object __prior__ to writing the loop (rather than creating the new object within the loop):

> "Before you start loop...allocate sufficient space for the output. This is very important for efficiency: if you grow the for loop at each iteration using `c()` (for example), your for loop will be very slow."

<br>
__The `vector()` function__:


```r
?vector

# SYNTAX AND DEFAULT VALUES
vector(mode = "logical", length = 0)
```

- Function: Creates a new vector object of the given length and mode
- Arguments:
  - `mode`: Type of vector to create (e.g., `"logical"`, `"numeric"`, `"list"`)
  - `length`: Length of the vector

<br>
<details><summary>**Example**: Creating a new object to store dataframe column averages</summary>

Recall the previous example where we calculated the mean value of each column in dataframe `df`:


```r
str(df)
#> tibble [4 × 3] (S3: tbl_df/tbl/data.frame)
#>  $ a: num [1:4] 1.171 1.419 -0.219 -0.907
#>  $ b: num [1:4] 1.212 -3.636 1.26 -0.552
#>  $ c: num [1:4] -0.568 -1.839 -0.232 3.635

for (i in seq_along(df)) {
  writeLines(str_c("mean of element at index position", i, "=", mean(df[[i]], na.rm = TRUE)))
}
#> mean of element at index position1=0.366097173604781
#> mean of element at index position2=-0.42907703301008
#> mean of element at index position3=0.248791245467358
```

<br>
Let's create a new object to store these column averages. Specifically, we'll create a new numeric vector whose length is equal to the number of columns in `df`:


```r
output <- vector(mode = "numeric", length = length(df))
class(output)  # Specified by `mode` argument in `vector()`
#> [1] "numeric"
length(output)  # Specified by `length` argument in `vector()`
#> [1] 3
```

<br>
We can loop over the index positions of `df` and use `[[]]` to modify `output`:


```r
for (i in seq_along(df)) {
  output[[i]] <- mean(df[[i]], na.rm = TRUE)  # Mean of df[[1]] assigned to output[[1]], etc.
}

output
#> [1]  0.3660972 -0.4290770  0.2487912
```

</details>

## Summary

The general recipe for how to write a loop:

1. Complete the task for one instance outside a loop (this is akin to writing the __body__ of the loop)

2. Write the __sequence__ 

3. Which parts of the body need to change with each iteration

4. _If_ you are creating a new object to store output of the loop, create this outside of the loop

5. Construct the loop

<br>
<details><summary>**When to write a loop vs a function [SKIP]**</summary>

It's usually obvious when you are duplicating code, but unclear whether you should write a loop or whether you should write a function.

- Often, a repeated task can be completed with a loop or a function

In my experience, loops are better for repeated tasks when the individual tasks are __very__ similar to one another

- E.g., a loop that reads in datasets from individual years; each dataset you read in differs only by directory and name
- E.g., a loop that converts negative values to `NA` for a set of variables

Because functions can have many arguments, functions are better when the individual tasks differ substantially from one another 

- E.g., a function that runs regression and creates formatted results table
    - Function allows you to specify (as function arguments): dependent variable; independent variables; what model to run, etc.

__Note__:

- Can embed loops within functions; can call functions within loops
- But for now, just try to understand basics of functions and loops

</details>


## Practice: Download IPEDS 

Link to Ben Skinner's [downloadipeds.R](https://github.com/btskinner/downloadipeds/blob/master/downloadipeds.R)


```r
#load libraries
library(tidyverse)

#data directory path
data_dir <- file.path(".", "data")
data_dir
#> [1] "./data"

#Create a sub-folder for data inside your group repository
dir.create(path = "data", showWarnings = FALSE) # showWarnings = FALSE omits warnings if directory already exists

## -----------------------------------------------------------------------------
## Part I - Create objects for later use
## -----------------------------------------------------------------------------

url <- "https://nces.ed.gov/ipeds/datacenter/data/"
url
#> [1] "https://nces.ed.gov/ipeds/datacenter/data/"

# suffix of file names
data_suffix <- ".zip" # suffix for csv data files [not stata data]
dict_suffix <- "_Dict.zip" # data dictionary
stata_do_suffix <- "_Stata.zip" # Stata do file w/ variable labels and value labels


# Read in string that has names of IPEDS files
ipeds <- readLines('./ipeds_file_list.txt')
#str(ipeds)
writeLines(ipeds[1:30])
#> ##
#> ## This is as list of all IPEDS files as given in the
#> ## complete data files portal. If you want to add files
#> ## that I've missed, be sure they match the name of the
#> ## link in the Data File column of the drop down table.
#> ##
#> ## You can prevent the script from downloading
#> ## specific files by either commenting out the name with
#> ## a hash symbol (#) or erasing it all together.
#> ##
#> ## Keep in mind that if you've already downloaded some
#> ## of the files before, the download script will not
#> ## download them again unless you change the -overwrite-
#> ## option to TRUE.
#> ##
#> 
#> ## -----------------------------
#> ## LAST UPDATED: 2 December 2019
#> ## -----------------------------
#> 
#> ## ---------------------------
#> ## 2018
#> ## ---------------------------
#> 
#> HD2018
#> IC2018
#> IC2018_AY
#> IC2018_PY
#> EFFY2018
#> EFIA2018

# Use regular expressions to remove blank lines and lines that start with #

#Blank lines
str_view_all(string = ipeds[18:30], pattern ="^\\s*$") # blank lines
```

<!--html_preserve--><div id="htmlwidget-a563b28b397ccb0130ae" style="width:960px;height:100%;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-a563b28b397ccb0130ae">{"x":{"html":"<ul>\n  <li>## LAST UPDATED: 2 December 2019<\/li>\n  <li>## -----------------------------<\/li>\n  <li><span class='match'><\/span><\/li>\n  <li>## ---------------------------<\/li>\n  <li>## 2018<\/li>\n  <li>## ---------------------------<\/li>\n  <li><span class='match'><\/span><\/li>\n  <li>HD2018<\/li>\n  <li>IC2018<\/li>\n  <li>IC2018_AY<\/li>\n  <li>IC2018_PY<\/li>\n  <li>EFFY2018<\/li>\n  <li>EFIA2018<\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

```r
str_detect(string = ipeds[18:30], pattern ="^\\s*$") # blank lines
#>  [1] FALSE FALSE  TRUE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE
#> [13] FALSE

str_view_all(string = ipeds[18:30], pattern ="^[^(\\s*$)]") # NOT blank lines
```

<!--html_preserve--><div id="htmlwidget-5e5cdee79e22c86dedc5" style="width:960px;height:100%;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-5e5cdee79e22c86dedc5">{"x":{"html":"<ul>\n  <li><span class='match'>#<\/span># LAST UPDATED: 2 December 2019<\/li>\n  <li><span class='match'>#<\/span># -----------------------------<\/li>\n  <li><\/li>\n  <li><span class='match'>#<\/span># ---------------------------<\/li>\n  <li><span class='match'>#<\/span># 2018<\/li>\n  <li><span class='match'>#<\/span># ---------------------------<\/li>\n  <li><\/li>\n  <li><span class='match'>H<\/span>D2018<\/li>\n  <li><span class='match'>I<\/span>C2018<\/li>\n  <li><span class='match'>I<\/span>C2018_AY<\/li>\n  <li><span class='match'>I<\/span>C2018_PY<\/li>\n  <li><span class='match'>E<\/span>FFY2018<\/li>\n  <li><span class='match'>E<\/span>FIA2018<\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

```r
str_detect(string = ipeds[18:30], pattern ="^[^(\\s*$)]") # NOT blank lines
#>  [1]  TRUE  TRUE FALSE  TRUE  TRUE  TRUE FALSE  TRUE  TRUE  TRUE  TRUE  TRUE
#> [13]  TRUE

length(str_subset(string = ipeds, pattern ="^[^(\\s*$)]"))
#> [1] 168
length(ipeds)
#> [1] 178

#remove blank lines
ipeds <- str_subset(string = ipeds, pattern ="^[^(\\s*$)]") # overwrite object to remove blanks
length(ipeds)
#> [1] 168

# lines that start with # (or do not start with #)

str_view_all(string = ipeds[1:30], pattern ="^#") # starts with "#"
```

<!--html_preserve--><div id="htmlwidget-42520f0b0ea0f6d35036" style="width:960px;height:100%;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-42520f0b0ea0f6d35036">{"x":{"html":"<ul>\n  <li><span class='match'>#<\/span>#<\/li>\n  <li><span class='match'>#<\/span># This is as list of all IPEDS files as given in the<\/li>\n  <li><span class='match'>#<\/span># complete data files portal. If you want to add files<\/li>\n  <li><span class='match'>#<\/span># that I've missed, be sure they match the name of the<\/li>\n  <li><span class='match'>#<\/span># link in the Data File column of the drop down table.<\/li>\n  <li><span class='match'>#<\/span>#<\/li>\n  <li><span class='match'>#<\/span># You can prevent the script from downloading<\/li>\n  <li><span class='match'>#<\/span># specific files by either commenting out the name with<\/li>\n  <li><span class='match'>#<\/span># a hash symbol (#) or erasing it all together.<\/li>\n  <li><span class='match'>#<\/span>#<\/li>\n  <li><span class='match'>#<\/span># Keep in mind that if you've already downloaded some<\/li>\n  <li><span class='match'>#<\/span># of the files before, the download script will not<\/li>\n  <li><span class='match'>#<\/span># download them again unless you change the -overwrite-<\/li>\n  <li><span class='match'>#<\/span># option to TRUE.<\/li>\n  <li><span class='match'>#<\/span>#<\/li>\n  <li><span class='match'>#<\/span># -----------------------------<\/li>\n  <li><span class='match'>#<\/span># LAST UPDATED: 2 December 2019<\/li>\n  <li><span class='match'>#<\/span># -----------------------------<\/li>\n  <li><span class='match'>#<\/span># ---------------------------<\/li>\n  <li><span class='match'>#<\/span># 2018<\/li>\n  <li><span class='match'>#<\/span># ---------------------------<\/li>\n  <li>HD2018<\/li>\n  <li>IC2018<\/li>\n  <li>IC2018_AY<\/li>\n  <li>IC2018_PY<\/li>\n  <li>EFFY2018<\/li>\n  <li>EFIA2018<\/li>\n  <li>ADM2018<\/li>\n  <li>EF2018A<\/li>\n  <li>EF2018CP<\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

```r
str_detect(string = ipeds[1:30], pattern ="^#") # starts with "#"
#>  [1]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
#> [13]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE FALSE FALSE FALSE
#> [25] FALSE FALSE FALSE FALSE FALSE FALSE


str_view_all(string = ipeds[1:30], pattern ="^[^#]") # starts with anything but #
```

<!--html_preserve--><div id="htmlwidget-bb7fba146f3cca42fcc1" style="width:960px;height:100%;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-bb7fba146f3cca42fcc1">{"x":{"html":"<ul>\n  <li>##<\/li>\n  <li>## This is as list of all IPEDS files as given in the<\/li>\n  <li>## complete data files portal. If you want to add files<\/li>\n  <li>## that I've missed, be sure they match the name of the<\/li>\n  <li>## link in the Data File column of the drop down table.<\/li>\n  <li>##<\/li>\n  <li>## You can prevent the script from downloading<\/li>\n  <li>## specific files by either commenting out the name with<\/li>\n  <li>## a hash symbol (#) or erasing it all together.<\/li>\n  <li>##<\/li>\n  <li>## Keep in mind that if you've already downloaded some<\/li>\n  <li>## of the files before, the download script will not<\/li>\n  <li>## download them again unless you change the -overwrite-<\/li>\n  <li>## option to TRUE.<\/li>\n  <li>##<\/li>\n  <li>## -----------------------------<\/li>\n  <li>## LAST UPDATED: 2 December 2019<\/li>\n  <li>## -----------------------------<\/li>\n  <li>## ---------------------------<\/li>\n  <li>## 2018<\/li>\n  <li>## ---------------------------<\/li>\n  <li><span class='match'>H<\/span>D2018<\/li>\n  <li><span class='match'>I<\/span>C2018<\/li>\n  <li><span class='match'>I<\/span>C2018_AY<\/li>\n  <li><span class='match'>I<\/span>C2018_PY<\/li>\n  <li><span class='match'>E<\/span>FFY2018<\/li>\n  <li><span class='match'>E<\/span>FIA2018<\/li>\n  <li><span class='match'>A<\/span>DM2018<\/li>\n  <li><span class='match'>E<\/span>F2018A<\/li>\n  <li><span class='match'>E<\/span>F2018CP<\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

```r
str_detect(string = ipeds[1:30], pattern ="^[^#]") # does not start with "#"
#>  [1] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
#> [13] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE  TRUE  TRUE
#> [25]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE

str_subset(string = ipeds, pattern ="^[^#]") # does not start with "#"
#>   [1] "HD2018"          "IC2018"          "IC2018_AY"       "IC2018_PY"      
#>   [5] "EFFY2018"        "EFIA2018"        "ADM2018"         "EF2018A"        
#>   [9] "EF2018CP"        "EF2018B"         "EF2018C"         "EF2018D"        
#>  [13] "EF2018A_DIST"    "C2018_A"         "C2018_B"         "C2018_C"        
#>  [17] "C2018DEP"        "SAL2018_IS"      "SAL2018_NIS"     "S2018_OC"       
#>  [21] "S2018_SIS"       "S2018_IS"        "S2018_NH"        "EAP2018"        
#>  [25] "F1718_F1A"       "F1718_F2"        "F1718_F3"        "SFA1718"        
#>  [29] "SFAV1718"        "GR2018"          "GR2018_L2"       "GR2018_PELL_SSL"
#>  [33] "GR200_18"        "OM2018"          "AL2018"          "FLAGS2018"      
#>  [37] "HD2017"          "IC2017"          "IC2017_AY"       "IC2017_PY"      
#>  [41] "EFFY2017"        "EFIA2017"        "EF2017A"         "EF2017B"        
#>  [45] "EF2017C"         "EF2017D"         "EF2017A_DIST"    "C2017_A"        
#>  [49] "C2017_B"         "C2017_C"         "C2017DEP"        "SAL2017_IS"     
#>  [53] "SAL2017_NIS"     "S2017_OC"        "S2017_SIS"       "S2017_IS"       
#>  [57] "S2017_NH"        "EAP2017"         "F1617_F1A"       "F1617_F2"       
#>  [61] "F1617_F3"        "GR2017"          "GR2017_L2"       "GR2017_PELL_SSL"
#>  [65] "GR200_17"        "OM2017"          "AL2017"          "FLAGS2017"      
#>  [69] "HD2016"          "IC2016"          "IC2016_AY"       "IC2016_PY"      
#>  [73] "EFFY2016"        "EFIA2016"        "ADM2016"         "EF2016A"        
#>  [77] "EF2016CP"        "EF2016B"         "EF2016C"         "EF2016D"        
#>  [81] "EF2016A_DIST"    "C2016_A"         "C2016_B"         "C2016_C"        
#>  [85] "C2016DEP"        "SAL2016_IS"      "SAL2016_NIS"     "S2016_OC"       
#>  [89] "S2016_SIS"       "S2016_IS"        "S2016_NH"        "EAP2016"        
#>  [93] "F1516_F1A"       "F1516_F2"        "F1516_F3"        "SFA1516"        
#>  [97] "SFAV1516"        "GR2016"          "GR2016_L2"       "GR200_16"       
#> [101] "GR2016_PELL_SSL" "OM2016"          "AL2016"          "FLAGS2016"      
#> [105] "HD2015"          "IC2015"          "IC2015_AY"       "IC2015_PY"      
#> [109] "EFFY2015"        "EFIA2015"        "ADM2015"         "EF2015A"        
#> [113] "EF2015B"         "EF2015C"         "EF2015D"         "EF2015A_DIST"   
#> [117] "C2015_A"         "C2015_B"         "C2015_C"         "C2015DEP"       
#> [121] "SAL2015_IS"      "SAL2015_NIS"     "S2015_OC"        "S2015_SIS"      
#> [125] "S2015_IS"        "S2015_NH"        "EAP2015"         "F1415_F1A"      
#> [129] "F1415_F2"        "F1415_F3"        "SFA1415"         "SFAV1415"       
#> [133] "GR2015"          "GR2015_L2"       "GR200_15"        "OM2015"         
#> [137] "AL2015"          "FLAGS2015"
length(str_subset(string = ipeds, pattern ="^[^#]")) # does not start with "#"
#> [1] 138

#Remove lines that start with a "#"
ipeds <- str_subset(string = ipeds, pattern ="^[^#]") # does not start with "#"

ipeds[1:50]
#>  [1] "HD2018"          "IC2018"          "IC2018_AY"       "IC2018_PY"      
#>  [5] "EFFY2018"        "EFIA2018"        "ADM2018"         "EF2018A"        
#>  [9] "EF2018CP"        "EF2018B"         "EF2018C"         "EF2018D"        
#> [13] "EF2018A_DIST"    "C2018_A"         "C2018_B"         "C2018_C"        
#> [17] "C2018DEP"        "SAL2018_IS"      "SAL2018_NIS"     "S2018_OC"       
#> [21] "S2018_SIS"       "S2018_IS"        "S2018_NH"        "EAP2018"        
#> [25] "F1718_F1A"       "F1718_F2"        "F1718_F3"        "SFA1718"        
#> [29] "SFAV1718"        "GR2018"          "GR2018_L2"       "GR2018_PELL_SSL"
#> [33] "GR200_18"        "OM2018"          "AL2018"          "FLAGS2018"      
#> [37] "HD2017"          "IC2017"          "IC2017_AY"       "IC2017_PY"      
#> [41] "EFFY2017"        "EFIA2017"        "EF2017A"         "EF2017B"        
#> [45] "EF2017C"         "EF2017D"         "EF2017A_DIST"    "C2017_A"        
#> [49] "C2017_B"         "C2017_C"

# Create new character vector "hd" that contains names of all "HD" files
str_subset(string = ipeds, pattern = "^HD")
#> [1] "HD2018" "HD2017" "HD2016" "HD2015"
hd <- str_subset(string = ipeds, pattern = "^HD")

hd
#> [1] "HD2018" "HD2017" "HD2016" "HD2015"
hd[2]
#> [1] "HD2017"
hd[1:5]
#> [1] "HD2018" "HD2017" "HD2016" "HD2015" NA

length(hd)
#> [1] 4
seq(from = 1, to = length(hd))
#> [1] 1 2 3 4

## -----------------------------------------------------------------------------
## Part 2 - Creating loops
## -----------------------------------------------------------------------------

## -----------------------------------------------------------------------------
## LOOP 1: Create loop that prints URL for each dataset
## -----------------------------------------------------------------------------

# First, just work on creating loop without body and showing the value of object i and hd[i]
for (i in 1:length(hd)) {
  
  writeLines(str_c(i))
  #writeLines(str_c("object i=",i, "; hd[i]=",hd[i], sep = ""))
  #writeLines(str_c("i=",i, "; hd[",i,"]=",hd[i], sep = ""))
}
#> 1
#> 2
#> 3
#> 4
```


## Practice: IPEDS data & rvest package


```r
## -----------------------------------------------------------------------------
## MODIFY HD 2018 DATASET
## -----------------------------------------------------------------------------
#Read in HD2018 data
hd2018 <- read_csv(file = file.path(data_dir,"hd2018.csv"))
#glimpse(hd2018)

#change column names to lowercase
names(hd2018) <- hd2018 %>% 
  names() %>%
  str_to_lower()
  
# Keep only subset of variables (including latitude and longitude, univerisity url, unitid, ) 
# and keep relatively small subset of institutions (e.g., a few UCs)

hd2018_uc <- hd2018 %>%
  dplyr::select(unitid, instnm, addr, stabbr, city, zip, latitude, longitud, webaddr) %>%
  filter(stabbr=="CA" & unitid %in% c(110644, 110662, 110671))
  
#typeof(hd2018_uc$webaddr)

# Create a character vector from the webaddr field and use that to create loop 
web <- str_to_lower(hd2018_uc$webaddr)

web <- str_extract(web, "www\\.\\w+\\.\\w+")

library(rvest) #load rvest package

web <- str_c("https://", web) #add https:// to web address

#str_extract(string = web, pattern = "\\.(w\\+)\\.")

#for loop to create xml_document/xml_node object
for(i in seq_along(web)) {
  
  url <- web[i] #grab url for each iteration
  
  name <- str_match(string = web[i], pattern = 'https://.+\\.([\\w]+)\\..+') #grab uni. name
  name <- name[,2] #get uni name on website
  
  html <- read_html(url) #use rvest function read_html to create xml_document/xml_node object
  
  assign(name, html) #assign name of uni. to object
  
  writeLines(str_c("web name: ", name, " url: ", url, sep = ""))
}

ucla_sm <- ucla %>%
  html_nodes('#social-media') #search for social-media ID

ucla_sm <- as.character(ucla_sm) #change to character


# Use `writeLines()` and `head()` to preview the first few rows of the data
writeLines(head(ucla_sm))

ucla_sm <- str_match(string = ucla_sm, pattern = '<a href="(http://twitter.+)"\\sclass.+</a>') #grab twitter url



ucr_sm <- UCR %>%
  html_nodes('.social-link') #search for social-link class

ucr_sm <- as.character(ucr_sm) #change to character

# Use `writeLines()` and `head()` to preview the first few rows of the data
writeLines(head(ucr_sm))

ucr_sm <- str_match(string = ucr_sm, pattern = '<a href="(https://twitter.+)"\\starget.+</a>') #grab twitter url



ucd_sm <- ucdavis %>%
  html_nodes('ul.pack') 

ucd_sm <- as.character(ucd_sm)

# Use `writeLines()` and `head()` to preview the first few rows of the data
writeLines(head(ucd_sm))

ucd_sm <- str_match(string = ucd_sm, pattern = '<a class=".+ href="(https://twitter.+)">.+</a>')



twitter_ucla <- ucla_sm[,2] #grab twitter urls
twitter_ucd <- ucd_sm[,2]
twitter_ucr <- ucr_sm[,2]

vec <- as_vector(c(twitter_ucd, twitter_ucla, twitter_ucr)) #create a vector of urls

hd2018_t <- bind_cols(hd2018_uc, data.frame(twitter = vec)) #add column to df

hd2018_t %>%
  select(instnm, webaddr, twitter)

```

# Conditional execution

## `if` statement conditions

What are **`if` statement conditions**?

- `if` statements allow you to conditionally execute certain blocks of code depending on whether some condition(s) is `TRUE`
- The condition goes inside of the parentheses in `if()` and the block of code to execute goes between the curly brackets (`{}`)
- The condition must evaluate to either `TRUE` or `FALSE` (i.e., be of type `logical`)
- The condition must have length of `1`


```r
if (condition) {
  # code executed when condition is TRUE
}
```

<br>
The block of code is executed if the condition evaluates to `TRUE`:


```r
if (TRUE) {
  writeLines("This block is executed.")
}
#> This block is executed.
```

The block of code is not executed if condition evaluates to `FALSE`:


```r
if (FALSE) {
  writeLines("This block is not executed.")
}
```

<br>
<details><summary>**Example**: Condition that evaluates to `TRUE`</summary>

Remember that any statement that has a length of `1` and can evaluate to either `TRUE` or `FALSE` can be used as the condition:


```r
# This statement evaluates to `TRUE`
2 + 2 == 4
#> [1] TRUE

# It is of type `logical`
typeof(2 + 2 == 4)
#> [1] "logical"

# It has length of `1`
length(2 + 2 == 4)
#> [1] 1

# We can use it as the if statement condition
if (2 + 2 == 4) {
  writeLines("This block is executed because `2 + 2 == 4` evaluates to `TRUE`.")
}
#> This block is executed because `2 + 2 == 4` evaluates to `TRUE`.
```

</details>

<br>
<details><summary>**Example**: Condition that evaluates to `FALSE`</summary>

Recall that some functions return a `logical`, so you might also see a function call being used as the condition:


```r
# This function call returns `FALSE` because there is no digit in the string "Fourth of July"
str_detect(string = "Fourth of July", pattern = "\\d")
#> [1] FALSE

# It is of type `logical`
typeof(str_detect(string = "Fourth of July", pattern = "\\d"))
#> [1] "logical"

# It has length of `1`
length(str_detect(string = "Fourth of July", pattern = "\\d"))
#> [1] 1

# We can use it as the if statement condition
if (str_detect(string = "Fourth of July", pattern = "\\d")) {
  writeLines("This block is not executed because the condition evaluates to `FALSE`.")
}
```

</details>

### `||` and `&&`

How to combine **multiple logical expressions** in a condition?

- Recall that a logical expression is of type `logical` and has a length of `1`
- An `if` statement condition can be made up of multiple logical expressions
- We can use `||` (or) and `&&` (and) to combine multiple logical expressions
- "Never use `|` or `&` in an if statement: these are _vectorised_ operations that apply to multiple values (that's why you use them in `filter()`)" (From [R for Data Science](https://r4ds.had.co.nz/functions.html#conditional-execution))
    - Vectorised operations apply to each respective elements of the vectors and returns a vector:
        
        ```r
        c(TRUE, TRUE, FALSE) | c(TRUE, FALSE, FALSE)
        #> [1]  TRUE  TRUE FALSE
        ```
        - 1st element of each vector: `TRUE` or `TRUE` is `TRUE`
        - 2nd element of each vector: `TRUE` or `FALSE` is `TRUE`
        - 3rd element of each vector: `FALSE` or `FALSE` is `FALSE`
    - Whereas `||` and `&&` will only look at the first element of each vector:
        
        ```r
        c(TRUE, TRUE, FALSE) || c(TRUE, FALSE, FALSE)
        #> [1] TRUE
        ```

<br>
When using `||` (or), the block of code is executed if any of the conditions evaluates to `TRUE`:


```r
if (condition1 || condition2 || condition3) {
  # code executed when any of the conditions is TRUE
}
```

When using `&&` (and), the block of code is executed if all of the conditions evaluate to `TRUE`:


```r
if (condition1 && condition2 && condition3) {
  # code executed when all of the conditions are TRUE
}
```

<br>
<details><summary>**Example**: Using multiple logical expressions in a condition</summary>

When using `||` (or), the block of code is executed if any of the conditions evaluates to `TRUE`:


```r
if (TRUE || FALSE) {
  writeLines("This block is executed.")
}
#> This block is executed.

if (str_detect(string = "ABC", pattern = "\\d") || str_detect(string = "123", pattern = "[A-Z]")) {
  writeLines("This block is not executed.")
}
```

<br>
When using `&&` (and), the block of code is executed if all of the conditions evaluate to `TRUE`:


```r
if (TRUE && FALSE) {
  writeLines("This block is not executed.")
}

if (str_detect(string = "ABC", pattern = "[A-Z]") && str_detect(string = "123", pattern = "\\d")) {
  writeLines("This block is executed.")
}
#> This block is executed.
```

</details>

## `else` statements

What are **`else` statements**?

- After the `if` block, you can include an `else` block that will be executed if the `if` block did not execute
- In other words, the `else` block is executed if the `if` statement's condition is not met


```r
if (condition) {
  # code executed when condition is TRUE
} else {
  # code executed when condition is FALSE
}
```

<br>
<details><summary>**Example**: Using if-else statement</summary>

Recall the function [`dir.exists()`](#checking-if-a-file-or-directory-exists) that checks if a directory exists:


```r
directory <- "my_new_directory"
dir.exists(directory)
#> [1] FALSE
```

<br>
Let's take a look at using if-else statement to create the directory (using [`dir.create()`](#creating-and-deleting-directories)) only if it doesn't currently exist:


```r
if (dir.exists(directory)) {
  writeLines(str_c("The directory '", directory, "' already exists."))
} else {
  dir.create(directory)
  writeLines(str_c("Created directory '", directory, "'."))
}
#> Created directory 'my_new_directory'.

# Check that directory is created
list.files()
#>  [1] "data"                     "function_basics.html"    
#>  [3] "function_basics.md"       "function_basics.Rmd"     
#>  [5] "ipeds_file_list_og.txt"   "ipeds_file_list.txt"     
#>  [7] "loop_example_ipeds.R"     "my_new_directory"        
#>  [9] "programming_lecture.html" "programming_lecture.md"  
#> [11] "programming_lecture.Rmd"  "programming.Rproj"
```

<br>
If we try creating the directory again, the `if` block would be executed because the directory already exists:


```r
dir.exists(directory)
#> [1] TRUE

if (dir.exists(directory)) {
  writeLines(str_c("The directory '", directory, "' already exists."))
} else {
  dir.create(directory)
  writeLines(str_c("Created directory '", directory, "'."))
}
#> The directory 'my_new_directory' already exists.
```



</details>

<br>
<details><summary>**Example**: Using if-else statement with loop</summary>

We can loop over multiple directory names and for each, create the directory only if it does not already exist:


```r
directories <- c("scripts", "dictionaries", "output")

for (i in directories) {
  if (dir.exists(i)) {
    writeLines(str_c("The directory '", i, "' already exists."))
  } else {
    dir.create(i)
    writeLines(str_c("Created directory '", i, "'."))
  }
}
#> Created directory 'scripts'.
#> Created directory 'dictionaries'.
#> Created directory 'output'.

# Check that directories are created
list.files()
#>  [1] "data"                     "dictionaries"            
#>  [3] "function_basics.html"     "function_basics.md"      
#>  [5] "function_basics.Rmd"      "ipeds_file_list_og.txt"  
#>  [7] "ipeds_file_list.txt"      "loop_example_ipeds.R"    
#>  [9] "output"                   "programming_lecture.html"
#> [11] "programming_lecture.md"   "programming_lecture.Rmd" 
#> [13] "programming.Rproj"        "scripts"
```

<br>
If we try creating the directories again, the `if` block would be executed because they already exist:


```r
for (i in directories) {
  if (dir.exists(i)) {
    writeLines(str_c("The directory '", i, "' already exists."))
  } else {
    dir.create(i)
    writeLines(str_c("Created directory '", i, "'."))
  }
}
#> The directory 'scripts' already exists.
#> The directory 'dictionaries' already exists.
#> The directory 'output' already exists.
```



</details>

## `else if` statements

What are **`else if` statements**?

- Between the `if` and `else` blocks, you can include additional block(s) using `else if` that gets executed if its condition is met and none of the previous blocks got executed
- In other words, only 1 block will ever execute in an `if`/`else if`/`else` chain


```r
if (condition) {
  # run this code if condition TRUE
} else if (condition) {
  # run this code if previous condition FALSE and this condition TRUE
} else if (condition) {
  # run this code if both previous conditions FALSE and this condition TRUE
} else {
  # run this code if all previous conditions FALSE
}
```

<br>
<details><summary>**Example**: Using `else if` statement</summary>

Using the `diamonds` dataset from `ggplot2`, let's create a vector of 5 diamond prices:


```r
prices <- unique(diamonds$price)[23:27]
str(prices)
#>  int [1:5] 405 552 553 554 2757
```

<br>
Let's loop through the `prices` vector and print whether each is affordable (under \$500), pricey (between \$500 and \$1000), or too expensive (\$1000 and up):


```r
for (i in prices) {
  if (i < 500) {
    writeLines(str_c("This diamond costs $", i, " and is affordable."))
  } else if (i >= 500 && i < 1000) {
    writeLines(str_c("This diamond costs $", i, " and is pricey..."))
  } else {
    writeLines(str_c("This diamond costs $", i, " and is too expensive!"))
  }
}
#> This diamond costs $405 and is affordable.
#> This diamond costs $552 and is pricey...
#> This diamond costs $553 and is pricey...
#> This diamond costs $554 and is pricey...
#> This diamond costs $2757 and is too expensive!
```

<br>
Remember that each subsequent `else if` statement will only be considered if all previous blocks did not run (i.e., their conditions were not met). This means we can simplify `i >= 500 && i < 1000` to `i < 1000` in the `else if` condition:


```r
for (i in prices) {
  if (i < 500) {
    writeLines(str_c("This diamond costs $", i, " and is affordable."))
  } else if (i < 1000) {
    writeLines(str_c("This diamond costs $", i, " and is pricey..."))
  } else {
    writeLines(str_c("This diamond costs $", i, " and is too expensive!"))
  }
}
#> This diamond costs $405 and is affordable.
#> This diamond costs $552 and is pricey...
#> This diamond costs $553 and is pricey...
#> This diamond costs $554 and is pricey...
#> This diamond costs $2757 and is too expensive!
```
</details>

## Processing time

Especially when working with large datasets, the time it takes for your code to run can really add up, so it is important to look for ways to optimize code such that it runs most efficiently. We can use `system.time()` to measure how long it takes for some code to run.

__The `system.time()` function__:


```r
?system.time

# SYNTAX AND DEFAULT VALUES
system.time(expr, gcFirst = TRUE)
```

- Function: Returns CPU (and other) times that expr used
- Arguments:
    - `expr`: Valid R expression to be timed

<br>
For the below examples, we'll create a numeric atomic vector called `prices` that is equal to the price of each diamond in the `diamonds` dataframe:


```r
prices <- diamonds$price
str(prices)  # 53,940 diamond prices
#>  int [1:53940] 326 326 327 334 335 336 336 337 337 338 ...
```

<br>
<details><summary>**Example**: Allocating sufficient space for output before loop</summary>

Let's take a look at an example of using a loop to calculate the z-score for each diamond price and storing the scores in a vector. First, we'll calculate the mean and standard deviation of the prices:


```r
m <- mean(prices, na.rm=TRUE)
s <- sd(prices, na.rm=TRUE)
```

<br>
**[Method 1]** Growing the vector inside the loop using `c()`

- "Whenever you use `c()`, `append()`, `cbind()`, `rbind()`, or `paste()` to create a bigger object, R must first allocate space for the new object and then copy the old object to its new home. If you’re repeating this many times, like in a for loop, this can be quite expensive." ([Advanced R](http://adv-r.had.co.nz/Profiling.html#avoid-copies))


```r
z_prices <- c()

system.time(
  for (i in 1:length(prices)) {
    z_prices <- c(z_prices, (prices[i] - m)/s)
  }
)
#>    user  system elapsed 
#>   6.602   4.129  10.872
```

<br>
**[Method 2]** Creating the output vector before loop (_Recommended_)

- "Before you start the loop, you must always allocate sufficient space for the output. This is very important for efficiency" ([R for Data Science](https://r4ds.had.co.nz/iteration.html#for-loops))
- As seen, we can do that by first creating the `z_prices` object using `vector()` before the loop


```r
z_prices <- vector("double", length(prices))

system.time(
  for (i in 1:length(prices)) {
    z_prices[i] <- (prices[i] - m)/s
  }
)
#>    user  system elapsed 
#>   0.013   0.000   0.013
```

</details>


<br>
<details><summary>**Example**: Vectorising your code</summary>

What does it mean to "vectorise your code"? ([Advanced R](http://adv-r.had.co.nz/Profiling.html#vectorise))

- "Vectorising is about taking a 'whole object' approach to a problem, thinking about vectors, not scalars."
- Often, this means avoiding loops and using vectorised functions instead (e.g., use `ifelse()` function instead of if-else statement inside a for loop)

To see the difference, let's look at the example of classifying diamond prices as affordable or expensive.

<br>
**[Method 1]** Using if-else statement inside a for loop


```r
output <- vector("character", length(prices))

system.time(
  for (i in 1:length(prices)) {
    if (i < 500) {
      output[i] <- str_c("This diamond costs $", prices[i], " and is affordable.")
    } else {
      output[i] <- str_c("This diamond costs $", prices[i], " and is too expensive!")
    }
  }
)
#>    user  system elapsed 
#>   0.296   0.001   0.300
```

<br>
**[Method 2]** Using the vectorised `ifelse()` function (_Recommended_)


```r
system.time(
  output <- ifelse(prices < 500,
                   str_c("This diamond costs $", prices, " and is affordable."),
                   str_c("This diamond costs $", prices, " and is too expensive!")
                   )
)
#>    user  system elapsed 
#>   0.063   0.002   0.065
```

</details>

<br>
<details><summary>**Example**: Using multiple `if` statements vs. `if`/`else if`/`else` statements</summary>

**[Method 1]** Using multiple `if` statements inside a for loop

- Look out for situations like the below where we can use `if`/`else if`/`else` statements instead of multiple `if` statements
- With multiple `if` statements, each of the `if` conditions need to be checked for every diamond price


```r
output <- vector("integer", length(prices))

system.time(
  for (i in 1:length(prices)) {
    if (i < 200) {
      output[i] <- 1
    } 
    if (i >= 200 && i < 400) {
      output[i] <- 2
    }
    if (i >= 400 && i < 600) {
      output[i] <- 3
    } 
    if (i >= 600 && i < 800) {
      output[i] <- 4
    }
    if (i >= 800 && i < 1000) {
      output[i] <- 5
    } 
    if (i >= 1000 && i < 1500) {
      output[i] <- 6
    }
    if (i >= 1500 && i < 2000) {
      output[i] <- 7
    }
    if (i >= 2000) {
      output[i] <- 8
    }
  }
)
#>    user  system elapsed 
#>   0.050   0.001   0.051
```

<br>
**[Method 2]** Using `if`/`else if`/`else` statements inside a for loop

- With `if`/`else if`/`else` statements, not all conditions below will be checked (only up to when one of the blocks get executed)
- Thus, we see a reduction in the processing time compared to **Method 1** - this will be especially true the more `if` statements there are


```r
output <- vector("integer", length(prices))

system.time(
  for (i in 1:length(prices)) {
    if (i < 200) {
      output[i] <- 1
    } else if (i < 400) {
      output[i] <- 2
    } else if (i < 600) {
      output[i] <- 3
    } else if (i < 800) {
      output[i] <- 4
    } else if (i < 1000) {
      output[i] <- 5
    } else if (i < 1500) {
      output[i] <- 6
    } else if (i < 2000) {
      output[i] <- 7
    } else {
      output[i] <- 8
    }
  }
)
#>    user  system elapsed 
#>   0.031   0.000   0.031
```

<br>
**[Method 3]** Using the vectorised `ifelse()` function

- Note that using a vectorised function when possible would still be the fastest
- But there can be a "trade-off between code speed and code readability", as nested `ifelse()` statements are hard to read ([Efficient R programming](https://csgillespie.github.io/efficientR/performance.html))


```r
system.time(
  output <- ifelse(prices < 200, 1, ifelse(prices < 400, 2, ifelse(prices < 600, 3, 
                   ifelse(prices < 800, 4, ifelse(prices < 1000, 5, ifelse(prices < 1500, 6, 
                   ifelse(prices < 2000, 7, 8)))))))
)
#>    user  system elapsed 
#>   0.026   0.014   0.040
```

</details>


# Functions

## What are functions

What are **functions**?

- **Functions** are pre-written bits of code that accomplish some task
- Functions allow you to "automate" tasks that you perform more than once
- We can call functions whenever we want to use them, again and again

Functions generally follow **three sequential steps**:

1. Take in __input__ object(s)
2. __Process__ the input
3. __Return__ a new object, which may be a vector, data-frame, plot, etc.


### Functions from packages written by others

We've been working with functions all quarter. 

<br>
__Example__: The `sum()` function


```r
?sum
```

1. __Input__: Takes in a vector of elements (_class_ must be `numeric` or `logical`)
2. __Processing__: Calculates the sum of elements
3. __Return__: Returns a numeric vector of length `1` whose value is the sum of the input vector


```r
# Apply sum() to atomic vector
sum(c(1,2,3))
#> [1] 6
sum(c(1,2,3)) %>% str()
#>  num 6
```

### User-written functions

What are "__user-written functions__"? [_my term_]

- __User-written functions__ are functions _you_ write to perform some specific task
- It can often be for a data-manipulation or analysis task specific to your project

Like all functions, user-written functions usually follow **three steps**:


1. Take in one or more __input__ object(s)
2. __Process__ the input
    - This may include utilizing exsting functions from other packages, for example `sum()` or `length()`
3. __Return__ a new object

**Examples** of what we might want to write a function for:

- Write a function to read in annual data, then call function for each year
- Create interactive maps. e.g., see maps from policy report on [off-campus recruiting by public research universities](https://www.thirdway.org/report/follow-the-money-recruiting-and-the-enrollment-priorities-of-public-research-universities)
    - Link to maps [HERE](https://cyouh95.github.io/third-way-report/assets/maps/map_income.html)
    - R code for interactive maps developed by Karina Salazar, modified by Crystal Han
- [Ben Skinner](https://github.com/btskinner) recommends [paraphrasing] writing "short functions that do one thing and do it well"
    
<br>
__When to write a function__?

- Since functions are _reusable_ pieces of code, they allow you to "automate" tasks that you perform more than once
  - E.g., Check to see if IPEDS data file is already downloaded. If not, then download the data.
  - E.g., Write function that runs regression model and creates results table
- The alternative to writing a function to perform some specific task (aside from loops/iteration) is to copy and paste the code each time you want to perform a task
- [Wickham and Grolemund chapter 19.2](https://r4ds.had.co.nz/functions.html#when-should-you-write-a-function):

  > "You should consider writing a function whenever you’ve copied and pasted a block of code more than twice"
  
- Darin Christenson (professor, UCLA public policy) refers to the programming mantra __DRY__ ("Don't Repeat Yourself")

  > "Functions enable you to perform multiple tasks (that are similar to one another) without copying the same code over and over"

<br>
__Why write functions to complete a task__? (_as opposed to the copy-and-paste approach_)

- As task requirements change (and they always do!), you only need to revise code in one place rather than many places
- Reduce errors that are common in copy-and-paste approach (e.g., forgetting to change variable name or variable value)
- Functions give you an opportunity to make continual improvements to completing a task
    - E.g., you realize your function does not work for certain input values, so you modify function to handle those values

<br>
__How to approach writing functions__? (_broad recipe_)

1. Experiment with performing the task outside of a function
    - Experiment with performing task with different sets of inputs
    - Often, you must revise this code, when an approach that worked outside a function does not work within a function
1. Write the function
1. Test the function
    - Try to "break" it
1. __Continual improvement__. As you use the function, make continual improvements going back-and-forth between steps 1-3

## Basics of writing functions

Often, the functions we write will utilize existing functions from Base R and other R packages. For example, create a function named `z_score()` that calculates how many standard deviations an observation is from the mean. Our `z_score()` function will use the existing Base R `mean()` and `sd()` functions.

We will avoid creating user-written functions that utilize `Tidyverse` functions, particularly functions from the `dplyr` package such as `group_by()`. The reason is that including certain `Tidyverse`/`dplyr` functions in a user-written function (or `loo`) requires knowledge of some advanced programming skills that we have not introduced yet. For more explanation, see [here](https://www.r-bloggers.com/data-frame-columns-as-arguments-to-dplyr-functions/) and [here](https://adv-r.hadley.nz/quasiquotation.html#unquoting). 

Therefore, when teaching how to write funtions that perform data manipulation tasks, we will use a "Base R approach" rather than a "Tidyverse approach."

### Components of a function

The `function()` function tells R that you are writing a function:


```r
# To find help file for function():
  ?`function` # But help file is not a helpful introduction


function_name <- function(arg1, arg2, arg3) {
  # function body
}
```

**Three components** of a function:

1. __Function name__
    - Define a function using `function()` and give it a **name** using the assignment operator `<-`
2. __Function arguments__ (sometimes called "inputs")
    - Inputs that the function takes; they go inside the parentheses of `function()`
      - Can be vectors, data frames, logical statements, strings, etc.
    - In the above hypothetical code, the function took three inputs `arg1`, `arg2`, `arg3`, but we could have written:
      - `function(x, y, z)` or `function(Larry, Curly, Moe)`
    - In the "function call," you specify values to assign to these function arguments
3. __Function body__
    - What the function does to the inputs
    - Function body goes inside the pair of curly brackets (`{}`) that follows `function()`
    - Above hypothetical function doesn't do anything

### `print_hello()` function

__Task__: Write function called `print_hello()` that prints `"Hello, world."`


```r
# Expected output
print_hello()
#> [1] "Hello, world"
```

<details><summary>**Step 1**: Perform task outside of function</summary>

We want to print `"Hello, world"`:


```r
"Hello, world"
#> [1] "Hello, world"
```

<br>
Alternative approaches to perform task outside of function:


```r
print("Hello, world")
#> [1] "Hello, world"

str_c("Hello, world")
#> [1] "Hello, world"
str_c("Hello, world", sep = "", collapse = NULL)
#> [1] "Hello, world"
writeLines(str_c("Hello, world", sep = "", collapse = NULL))
#> Hello, world
```

</details>

<br>
<details><summary>**Step 2**: Create the function</summary>


```r
# Define function called `print_hello()`
print_hello <- function() {  # This function takes no arguments
  "Hello, world"             # The body of the function simply prints "Hello!"
}

# Call function
print_hello()
#> [1] "Hello, world"
```

1. __Function name__
    - Function name is `print_hello()`
2. __Function arguments__ (sometimes called "inputs")
    - `print_hello()` function doesn't take any arguments
3. __Function body__ (what the function does to the inputs)
    - Body of `print_hello()` simply prints "Hello, world"

</details>

<br>

__Task__: Modify `print_hello()` to take a name as input and print `"Hello, world. My name is <name>"`


```r
# Expected output
print_hello("Ozan Jaquette")
#> [1] "Hello, world. My name is Ozan Jaquette"
```

<details><summary>**Step 1**: Perform task outside of function</summary>

Say we want to print `"Hello, world. My name is Ozan Jaquette"`:


```r
"Hello, world. My name is Ozan Jaquette"
#> [1] "Hello, world. My name is Ozan Jaquette"
```

Remember that we eventually want the name to be an input to our function, so let's create a separate object, `x`, to store name:


```r
x <- "Ozan Jaquette"
str_c("Hello, world. My name is", x, sep = " ", collapse = NULL)
#> [1] "Hello, world. My name is Ozan Jaquette"
```

</details>

<br>
<details><summary>**Step 2**: Modify the function</summary>


```r
# Modify `print_hello()` function 
print_hello <- function(x) {  # This function takes 1 argument
  # In the body, use `str_c()` to concatenate greeting and name
  str_c("Hello, world. My name is", x, sep = " ", collapse = NULL)  
}

# Call function
print_hello(x = "Ozan Jaquette")
#> [1] "Hello, world. My name is Ozan Jaquette"
print_hello("Ozan Jaquette")
#> [1] "Hello, world. My name is Ozan Jaquette"
```

1. __Function name__
    - Function name is `print_hello()`
2. __Function arguments__ (sometimes called "inputs")
    - `print_hello()` function takes a name as input
3. __Function body__ (what the function does to the inputs)
    - Body of `print_hello()` prints `"Hello, world. My name is <name>"`

</details>

<br>

__Task__: Modify `print_hello()` to take a name and birthdate as inputs and print `"Hello, world. My name is <name> and I am <age> years old"`


```r
# Expected output
print_hello("Ozan Jaquette", "01/16/1979")
#> [1] "Hello, world. My name is Ozan Jaquette and I am 41 years old"
```

<details><summary>**Step 1**: Perform task outside of function</summary>

Use `mdy()` from the `lubridate` package to help handle birthdates:


```r
y <- "01/16/1979"
y
#> [1] "01/16/1979"
mdy(y)
#> [1] "1979-01-16"
str(mdy(y))
#>  Date[1:1], format: "1979-01-16"
```

<br>
Using `today()` to get today's date, we can calculate an age given a birthdate:


```r
today()
#> [1] "2020-05-31"

# Calculate difference
today() - mdy(y)
#> Time difference of 15111 days
str(today() - mdy(y))
#>  'difftime' num 15111
#>  - attr(*, "units")= chr "days"

# Convert to duration
as.duration(today() - mdy(y))
#> [1] "1305590400s (~41.37 years)"

# Create age in years as numeric vector
as.numeric(as.duration(today() - mdy(y)), "years")
#> [1] 41.37166
floor(as.numeric(as.duration(today() - mdy(y)), "years"))
#> [1] 41

str(floor(as.numeric(as.duration(today() - mdy(y)), "years")))
#>  num 41
```

<br>
Putting it all together, let's print the name and age in years:


```r
x <- "Ozan Jaquette"
y <- "01/16/1979"

age <- floor(as.numeric(as.duration(today() - mdy(y)), "years"))

str_c("Hello, world. My name is", x, "and I am", age, "years old", sep = " ", collapse = NULL)
#> [1] "Hello, world. My name is Ozan Jaquette and I am 41 years old"
```

</details>

<br>
<details><summary>**Step 2**: Modify the function</summary>


```r
# Modify `print_hello()` function 
print_hello <- function(x, y) {  # This function takes 2 arguments
  # In the body, calculate age
  age <- floor(as.numeric(as.duration(today() - mdy(y)), "years"))
  
  # Use `str_c()` to concatenate greeting, name, and age
  str_c("Hello, world. My name is", x, "and I am", age, "years old", sep = " ", collapse = NULL)
}

# Call function
print_hello(x = "Ozan Jaquette", "01/16/1979")
#> [1] "Hello, world. My name is Ozan Jaquette and I am 41 years old"
print_hello(x = "Kartal Jaquette", "01/24/1983")
#> [1] "Hello, world. My name is Kartal Jaquette and I am 37 years old"
print_hello(x = "Sumru Erkut", "06/15/1944")
#> [1] "Hello, world. My name is Sumru Erkut and I am 75 years old"
print_hello(x = "Sumru Jaquette-Nasiali", "04/05/2019")
#> [1] "Hello, world. My name is Sumru Jaquette-Nasiali and I am 1 years old"
```

1. __Function name__
    - Function name is `print_hello()`
2. __Function arguments__ (sometimes called "inputs")
    - `print_hello()` function takes a name and birthdate as inputs
3. __Function body__ (what the function does to the inputs)
    - Body of `print_hello()` prints `"Hello, world. My name is <name> and I am <age> years old"`

</details>


<br>

__Task__: Test/break `print_hello()` by passing in birthdate using a different format


```r
print_hello(x = "Sumru Jaquette-Nasiali", "04/05/2019") # this works

print_hello(x = "Sumru Jaquette-Nasiali", "2019/04/05") # this breaks
```

<br>
If we wanted to make additional improvements to `print_hello()`, we could modify the function to allow date of birth to be entered using several alternative formats (e.g., `"04/05/2019"` or `"2019/04/05"`)


### `z_score()` function

The __z-score__ for an observation _i_ is the number of standard deviations away it is from the mean:

- $z_i = \frac{x_i - \bar{x}}{sd(x)}$

__Task__: Write function called `z_score()` that calculates the z-score for each element of a vector


```r
# Expected output
z_score(c(1, 2, 3, 4, 5))
#> [1] -1.2649111 -0.6324555  0.0000000  0.6324555  1.2649111
```

<details><summary>**Step 1**: Perform task outside of function</summary>

Create a vector of numbers we'll use to calculate z-score:


```r
v=seq(5,15)
v
#>  [1]  5  6  7  8  9 10 11 12 13 14 15
typeof(v) # type == integer vector
#> [1] "integer"
class(v) # class == integer
#> [1] "integer"
length(v) # number of elements in object v
#> [1] 11
v[1] # 1st element of v
#> [1] 5
v[10] # 10th element of v
#> [1] 14
```

<br>
We can calculate the z-score using the Base R `mean()` and `sd()` functions:

- $z_i = \frac{x_i - \bar{x}}{sd(x)}$


```r
mean(v)
#> [1] 10
sd(v)
#> [1] 3.316625
```

<br>
Calculate z-score for some value:


```r
(5-mean(v))/sd(v)
#> [1] -1.507557
(10-mean(v))/sd(v)
#> [1] 0
```

<br>
Calculate z-score for particular elements of vector `v`:


```r
v[1]
#> [1] 5
(v[1]-mean(v))/sd(v)
#> [1] -1.507557
v[8]
#> [1] 12
(v[8]-mean(v))/sd(v)
#> [1] 0.6030227
```

<br>
Calculate `z_i` for multiple elements of vector `v`:


```r
c(v[1],v[8],v[11])
#> [1]  5 12 15
c((v[1]-mean(v))/sd(v),(v[8]-mean(v))/sd(v),(v[11]-mean(v))/sd(v))
#> [1] -1.5075567  0.6030227  1.5075567
```

</details>

<br>
<details><summary>**Step 2**: Write the function</summary>

Write function to calculate z-score for each element of the vector:


```r
z_score <- function(x) {
  (x - mean(x))/sd(x)
}
```

1. __Function name__: `z_score`
2. __Function arguments__: Takes one input, which we named `x`
    - Inputs can be vectors, dataframes, logical statements, etc.
3. __Function body__: What function does to the inputs
    - For each element of `x`, calculate difference between value of element and mean value of elements, then divide by standard deviation of elements

<br>
Test/call the function:


```r
z_score(x = c(5,6,7,8,9,10,11,12,13,14,15))
#>  [1] -1.5075567 -1.2060454 -0.9045340 -0.6030227 -0.3015113  0.0000000
#>  [7]  0.3015113  0.6030227  0.9045340  1.2060454  1.5075567

v
#>  [1]  5  6  7  8  9 10 11 12 13 14 15
z_score(x = v)
#>  [1] -1.5075567 -1.2060454 -0.9045340 -0.6030227 -0.3015113  0.0000000
#>  [7]  0.3015113  0.6030227  0.9045340  1.2060454  1.5075567

z_score(x = c(seq(20,25)))
#> [1] -1.3363062 -0.8017837 -0.2672612  0.2672612  0.8017837  1.3363062
```

</details>

<br><br>

__Task__: Improve the `z_score()` function by trying to break it

<details><summary>**Test 1**: Handling `NA` values</summary>

Let's see what happens when we try passing in a vector containing `NA` to our `z_score()` function:


```r
w <- c(NA, seq(1:5), NA)
w
#> [1] NA  1  2  3  4  5 NA
z_score(w)
#> [1] NA NA NA NA NA NA NA
```

<br>
What went wrong? Let's revise our function to handle `NA` values:


```r
z_score <- function(x) {
  (x - mean(x, na.rm=TRUE))/sd(x, na.rm=TRUE)
}

w
#> [1] NA  1  2  3  4  5 NA
z_score(w)
#> [1]         NA -1.2649111 -0.6324555  0.0000000  0.6324555  1.2649111         NA
```

</details>

<br>
<details><summary>**Test 2**: Applying function to variables from a dataframe</summary>

Create dataframe called `df`:


```r
set.seed(12345) # set "seed" so we all get the same "random" numbers
df <- tibble(
  a = c(NA,rnorm(5)),
  b = c(NA,rnorm(5)),
  c = c(NA,rnorm(5))
)
class(df) # class of object df
#> [1] "tbl_df"     "tbl"        "data.frame"
df # print data frame
#> # A tibble: 6 x 3
#>        a      b      c
#>    <dbl>  <dbl>  <dbl>
#> 1 NA     NA     NA    
#> 2  0.586 -1.82  -0.116
#> 3  0.709  0.630  1.82 
#> 4 -0.109 -0.276  0.371
#> 5 -0.453 -0.284  0.520
#> 6  0.606 -0.919 -0.751

# subset a data frame w/ one element, using []
df["a"] 
#> # A tibble: 6 x 1
#>        a
#>    <dbl>
#> 1 NA    
#> 2  0.586
#> 3  0.709
#> 4 -0.109
#> 5 -0.453
#> 6  0.606
str(df["a"])
#> tibble [6 × 1] (S3: tbl_df/tbl/data.frame)
#>  $ a: num [1:6] NA 0.586 0.709 -0.109 -0.453 ...

# subset values of an element using [[]] or $
df[["a"]]
#> [1]         NA  0.5855288  0.7094660 -0.1093033 -0.4534972  0.6058875
str(df[["a"]])
#>  num [1:6] NA 0.586 0.709 -0.109 -0.453 ...

df$a # print element "a" (i.e., variable "a") of object df (dataframe)
#> [1]         NA  0.5855288  0.7094660 -0.1093033 -0.4534972  0.6058875
str(df$a) # structure of element "a" of df: a numeric vector
#>  num [1:6] NA 0.586 0.709 -0.109 -0.453 ...
```

<br>
Experiment with components of z-score, outside of a function:


```r
mean(df[["a"]], na.rm=TRUE) # mean of variable "a"
#> [1] 0.2676164
sd(df[["a"]], na.rm=TRUE) # std dev of variable "a"
#> [1] 0.5178803

mean(df$a, na.rm=TRUE) # mean of variable "a"
#> [1] 0.2676164
sd(df$a, na.rm=TRUE) # std dev of variable "a"
#> [1] 0.5178803

#would these work?
  #mean(df["a"], na.rm=TRUE) # mean of variable "a"
  #sd(df["a"], na.rm=TRUE) # std dev of variable "a"

#manually calculate z score for second observation in variable "a"
df$a[2]
#> [1] 0.5855288
(df$a[2] - mean(df$a, na.rm=TRUE))/sd(df$a, na.rm=TRUE) # check result
#> [1] 0.6138725
```

<br>
Apply `z_score()` function to variables in dataframe:


```r
# z_score() function to calculate z-score for each obs of variable "a"
df$a # print variable "a"
#> [1]         NA  0.5855288  0.7094660 -0.1093033 -0.4534972  0.6058875
z_score(x = df$a)
#> [1]         NA  0.6138725  0.8531888 -0.7278124 -1.3924329  0.6531840
z_score(x = df[["a"]])
#> [1]         NA  0.6138725  0.8531888 -0.7278124 -1.3924329  0.6531840

#this approach doesn't work:
  #z_score(x = df["a"]) 
  # Why?:
    # df["a"] is a dataframe with one variable
    # you can't apply mean() or sd() functions to a list/data frame object, only a numeric atomic vector

# z-score for each obs of variable "b"
z_score(x = df$b) 
#> [1]         NA -1.4182167  1.2847832  0.2841184  0.2753122 -0.4259971
```

</details>

<br><br>

__Task__: Use the `z_score()` function to create a new variable that is the z-score version of a variable

<details><summary>**Example 1**: Creating a new z-score variable for the `df` dataframe</summary>

First, briefly review how to create and delete variables using Base R approach:


```r
df # print data frame df
#> # A tibble: 6 x 3
#>        a      b      c
#>    <dbl>  <dbl>  <dbl>
#> 1 NA     NA     NA    
#> 2  0.586 -1.82  -0.116
#> 3  0.709  0.630  1.82 
#> 4 -0.109 -0.276  0.371
#> 5 -0.453 -0.284  0.520
#> 6  0.606 -0.919 -0.751

df$c_plus2 <- df$c+2 #create variable equal to "c" plus 2
df
#> # A tibble: 6 x 4
#>        a      b      c c_plus2
#>    <dbl>  <dbl>  <dbl>   <dbl>
#> 1 NA     NA     NA       NA   
#> 2  0.586 -1.82  -0.116    1.88
#> 3  0.709  0.630  1.82     3.82
#> 4 -0.109 -0.276  0.371    2.37
#> 5 -0.453 -0.284  0.520    2.52
#> 6  0.606 -0.919 -0.751    1.25
df$c_plus2 <- NULL # remove variable "c_plus2"
df
#> # A tibble: 6 x 3
#>        a      b      c
#>    <dbl>  <dbl>  <dbl>
#> 1 NA     NA     NA    
#> 2  0.586 -1.82  -0.116
#> 3  0.709  0.630  1.82 
#> 4 -0.109 -0.276  0.371
#> 5 -0.453 -0.284  0.520
#> 6  0.606 -0.919 -0.751
```

<br>
Use `z_score()` function to create a new variable that equals the z-score of another variable. 

- Simply calling the `z_score()` function does not create a new variable:


```r
z_score(x = df$c)
#> [1]           NA -0.510074390  1.525451514  0.002476613  0.159953743
#> [6] -1.177807481
df
#> # A tibble: 6 x 3
#>        a      b      c
#>    <dbl>  <dbl>  <dbl>
#> 1 NA     NA     NA    
#> 2  0.586 -1.82  -0.116
#> 3  0.709  0.630  1.82 
#> 4 -0.109 -0.276  0.371
#> 5 -0.453 -0.284  0.520
#> 6  0.606 -0.919 -0.751
```

<br>

- Instead of modifying the `z_score()` function so that the variable is assigned within the function, the preferred approach is to call the `z_score()` function after the assignment operator `<-`:


```r
df$c_z <- z_score(x = df$c)

# examine data frame
df
#> # A tibble: 6 x 4
#>        a      b      c      c_z
#>    <dbl>  <dbl>  <dbl>    <dbl>
#> 1 NA     NA     NA     NA      
#> 2  0.586 -1.82  -0.116 -0.510  
#> 3  0.709  0.630  1.82   1.53   
#> 4 -0.109 -0.276  0.371  0.00248
#> 5 -0.453 -0.284  0.520  0.160  
#> 6  0.606 -0.919 -0.751 -1.18
```

</details>

<br>
<details><summary>**Example 2**: Creating a new z-score variable for the recruiting dataset</summary>

We can apply our function to a "real" dataset too:


```r
#load dataset with one obs per recruiting event
load(url("https://github.com/ozanj/rclass/raw/master/data/recruiting/recruit_event_somevars.RData"))

df_event_small <- df_event[1:10,] %>% # keep first 10 observations
  select(instnm,univ_id,event_type,med_inc) # keep 4 vars

df_event_small
#> # A tibble: 10 x 4
#>    instnm      univ_id event_type med_inc
#>    <chr>         <int> <chr>        <dbl>
#>  1 UM Amherst   166629 public hs   71714.
#>  2 UM Amherst   166629 public hs   89122.
#>  3 UM Amherst   166629 public hs   70136.
#>  4 UM Amherst   166629 public hs   70136.
#>  5 Stony Brook  196097 public hs   71024.
#>  6 USCC         218663 private hs  71024.
#>  7 UM Amherst   166629 private hs  71024.
#>  8 UM Amherst   166629 public hs   97225 
#>  9 UM Amherst   166629 private hs  97225 
#> 10 UM Amherst   166629 public hs   77800.

#show observations for variable med_inc
df_event_small$med_inc
#>  [1] 71713.5 89121.5 70136.5 70136.5 71023.5 71023.5 71023.5 97225.0 97225.0
#> [10] 77799.5

#calculate z-score of variable med_inc (without assignment)
z_score(x = df_event_small$med_inc)
#>  [1] -0.60825958  0.91982879 -0.74668992 -0.74668992 -0.66882834 -0.66882834
#>  [7] -0.66882834  1.63116060  1.63116060 -0.07402556

#assign new variable equal to the z-score of med_inc
df_event_small$med_inc_z <- z_score(x = df_event_small$med_inc)

#inspect
df_event_small %>% head(5)
#> # A tibble: 5 x 5
#>   instnm      univ_id event_type med_inc med_inc_z
#>   <chr>         <int> <chr>        <dbl>     <dbl>
#> 1 UM Amherst   166629 public hs   71714.    -0.608
#> 2 UM Amherst   166629 public hs   89122.     0.920
#> 3 UM Amherst   166629 public hs   70136.    -0.747
#> 4 UM Amherst   166629 public hs   70136.    -0.747
#> 5 Stony Brook  196097 public hs   71024.    -0.669
```

</details>

<br><br>

__Task__: Improve the `z_score()` function by first checking whether input `x` is valid

<details><summary>**Step 1**: Breaking current function with invalid input</summary>

Current function:


```r
z_score <- function(x) {
  (x - mean(x, na.rm=TRUE))/sd(x, na.rm=TRUE)
}
#?mean
#?sd
```

<br>
What kind of input is our current function limited to?

- `z_score()` function does simple arithmatic and utilizes the `mean()` and `sd()` functions
- `mean()` and `sd()` functions require `x` to be a numeric (or logical) atomic vector
  - `z_score()` function will break if the input `x` is not an atomic vector
  - `z_score()` function will break if the input `x` is not a numeric/logical atomic vector


```r
#function works on below numeric atomic vector
str(df_event_small$med_inc)

#function doesn't work if input is a list/dataframe
str(df_event_small["med_inc"])

z_score(x = df_event_small["med_inc"])

#function doesn't work if x is not a numeric vector
str(df_event_small$instnm)

z_score(x = df_event_small$instnm)
```

</details>

<br>
<details><summary>**Step 2**: Modify the function to handle invalid inputs</summary>

We could modify `z_score()` by using conditional statements to calculate the z-score only if input object `x` is the appropriate class of object:


```r
z_score <- function(x) {
  if (class(x) == "numeric" || class(x) == "logical") {
    (x - mean(x, na.rm=TRUE))/sd(x, na.rm=TRUE)
  }
}
```

<br>
We no longer run into errors if we supply an invalid input:


```r
# Test with list/dataframe input
str(df_event_small["med_inc"])
#> tibble [10 × 1] (S3: tbl_df/tbl/data.frame)
#>  $ med_inc: num [1:10] 71714 89122 70136 70136 71024 ...

z_score(x = df_event_small["med_inc"])

# Test with character vector input
str(df_event_small$instnm)
#>  chr [1:10] "UM Amherst" "UM Amherst" "UM Amherst" "UM Amherst" ...

z_score(x = df_event_small$instnm)
```

<br>
Note that our function would return `NULL` if the input was invalid, so the new variable would not be created if we used `<-`:


```r
str(df_event_small$instnm)
#>  chr [1:10] "UM Amherst" "UM Amherst" "UM Amherst" "UM Amherst" ...

# Invalid character vector input returns `NULL`
typeof(z_score(x = df_event_small$instnm))
#> [1] "NULL"

# We would not see new variable/column `instnm_z`
df_event_small$instnm_z <- z_score(x = df_event_small$instnm)
df_event_small %>% head(5)
#> # A tibble: 5 x 5
#>   instnm      univ_id event_type med_inc med_inc_z
#>   <chr>         <int> <chr>        <dbl>     <dbl>
#> 1 UM Amherst   166629 public hs   71714.    -0.608
#> 2 UM Amherst   166629 public hs   89122.     0.920
#> 3 UM Amherst   166629 public hs   70136.    -0.747
#> 4 UM Amherst   166629 public hs   70136.    -0.747
#> 5 Stony Brook  196097 public hs   71024.    -0.669
```

</details>
<br>

### Student exercise [SKIP]

Some common tasks when working with survey data:

- Identify number of observations with `NA` values for a specific variable
- Identify number of observations with negative values for a specific variable
- Replace negative values with `NA` for a specific variable

<br>

#### `num_negative()` function

__Task__: Write function called `num_negative()`

- Write a function that counts the number of observations with negative values for a specific variable
- Apply this function to variables from dataframe `df` (created below)
- Adapted from Ben Skinner's _Programming 1_ R Workshop [HERE](https://www.btskinner.me/rworkshop/modules/programming_one.html)


```r
# Sample dataframe `df` that contains some negative values
df
#> # A tibble: 100 x 4
#>       id   age sibage parage
#>    <int> <dbl>  <dbl>  <dbl>
#>  1     1    17      8     49
#>  2     2    15    -97     46
#>  3     3   -97    -97     53
#>  4     4    13     12     -4
#>  5     5   -97     10     47
#>  6     6    12     10     52
#>  7     7   -99      5     51
#>  8     8   -97     10     55
#>  9     9    16      6     51
#> 10    10    16    -99     -8
#> # … with 90 more rows
```

<br>
__Recommended steps__:

- Perform task outside of function
    - HINT: `sum(data_frame_name$var_name<0)`
- Write function
- Apply/test function on variables

<br>
<details><summary>**Step 1**: Perform task outside of function</summary>


```r
names(df) # identify variable names
#> [1] "id"     "age"    "sibage" "parage"
df$age # print observations for a variable
#>   [1]  17  15 -97  13 -97  12 -99 -97  16  16 -98  20 -99  20  11  20  12  17
#>  [19]  19  17 -97 -99  12  13  11  15  20  14 -99  11  20 -98  11 -98  12  16
#>  [37]  12  18  12  19  12 -97  20  17  11  19  19  12 -98  11  15  18  15 -98
#>  [55]  15  19 -97  13 -98  16  13  12  16  19 -99  19 -98  13 -97  20  15  19
#>  [73]  15  12  18 -99  18 -98 -98 -98 -97  12  14  19 -97  11  20  18  14 -99
#>  [91]  15  20 -97  14  14  19  18  17  20  15

#BaseR
sum(df$age<0) # count number of obs w/ negative values for variable "age"
#> [1] 27
```

</details>

<br>
<details><summary>**Step 2**: Write function</summary>


```r
num_missing <- function(x){
  sum(x<0)
}
```

</details>

<br>
<details><summary>**Step 3**: Apply function</summary>


```r
num_missing(df$age)
#> [1] 27
num_missing(df$sibage)
#> [1] 22
```

</details>
<br>

#### `num_missing()` function

In survey data, negative values often refer to reason for missing values:

- E.g., `-8` refers to "didn't take survey"
- E.g., `-7` refers to "took survey, but didn't answer this question"

__Task__: Write function called `num_negative()`

- Write a function that counts number of missing observations for a variable and allows you to specify which values are associated with missing for that variable. This function will take two arguments:
    - `x`: The variable (e.g., `df$sibage`)
    - `miss_vals`: Vector of values you want to associate with "missing" variable
        - Values to associate with missing for `df$age`: `-97,-98,-99`
        - Values to associate with missing for `df$sibage`: `-97,-98,-99`
        - Values to associate with missing for `df$parage`: `-4,-7,-8`

<br>
__Recommended steps__:

- Perform task outside of function
    - HINT: `sum(data_frame_name$var_name< %in% c(-4,-5))`
- Write function
- Apply/test function on variables

<br>
<details><summary>**Step 1**: Perform task outside of function</summary>


```r
sum(df$age %in% c(-97,-98,-99))
#> [1] 27
```

</details>

<br>
<details><summary>**Step 2**: Write function</summary>


```r
num_missing <- function(x, miss_vals){

  sum(x %in% miss_vals)
}
```

</details>

<br>
<details><summary>**Step 3**: Apply function</summary>


```r
num_missing(df$age,c(-97,-98,-99))
#> [1] 27
num_missing(df$sibage,c(-97,-98,-99))
#> [1] 22
num_missing(df$parage,c(-4,-7,-8))
#> [1] 17
```

</details>
<br>

## Function arguments

### Default values

What are **default values** for arguments?

- The **default value** for an argument is the value that will be used if the argument value was not supplied during the function call
- When writing the function, you can specify the **default value** for an argument using `name=value`
- Most Base R functions and functions from other packages specify default values for one or more arguments

<br>

**Example**: `str_c()` function

The `str_c()` function has default values for `sep` and `collapse`:

- Syntax
  - `str_c(..., sep = "", collapse = NULL)`
- Arguments
  - `...`: One or more character vectors to join, separated by commas
  - `sep`: String to insert between input vectors
      - Default value: `sep = ""`
  - `collapse`: Optional string used to combine input vectors into single string
      - After joining vectors into single string within each element, should resulting elements be combined into a single string? If so, what string to insert between elements?
      - Default value: `collapse = NULL` is to not combine elements into a single string


```r
# We want to join the following two vectors element-wise into a single character vector
c("a","b")
#> [1] "a" "b"
c(1,2)
#> [1] 1 2

# manually specifying default values
str_c(c("a", "b"), c(1, 2), sep = "", collapse = NULL)
#> [1] "a1" "b2"

# If we don't specify `sep` and `collapse`, they take the default values
str_c(c("a", "b"), c(1, 2))
#> [1] "a1" "b2"

# specify value for `sep` that overrides default value
str_c(c("a", "b"), c(1, 2), sep = "~")
#> [1] "a~1" "b~2"
length(str_c(c("a", "b"), c(1, 2), sep = "~")) # resulting vector has length = 2
#> [1] 2

# specify value for `collapse` that overrides default
str_c(c("a", "b"), c(1, 2), collapse = "|")
#> [1] "a1|b2"
length(str_c(c("a", "b"), c(1, 2), collapse = "|"))  # resulting vector has length = 1
#> [1] 1

# specify alternative values for both `sep` and `collapse`
  #str_c(c("a", "b"), c(1, 2), sep = "~", collapse = "|")
```

<br>
<details><summary>**Example**: Adding a default value to our `z_score()` function</summary>

Recall the `z_score()` function we developed previously, where we wrote this function to remove `NA` values prior to calculating z-score:


```r
z_score <- function(x) {
  (x - mean(x, na.rm=TRUE))/sd(x, na.rm=TRUE)
}

w <- c(NA, seq(1:5), NA)
w
#> [1] NA  1  2  3  4  5 NA
z_score(w)
#> [1]         NA -1.2649111 -0.6324555  0.0000000  0.6324555  1.2649111         NA
```


<br>
We could add an argument (named `na`) that specifies whether `NA`s should be removed prior to calculating z-scores:


```r
z_score <- function(x, na) {
  (x - mean(x, na.rm=na))/sd(x, na.rm=na)
}

w
#> [1] NA  1  2  3  4  5 NA
z_score(w, TRUE)
#> [1]         NA -1.2649111 -0.6324555  0.0000000  0.6324555  1.2649111         NA
z_score(w, FALSE)
#> [1] NA NA NA NA NA NA NA
#z_score(w) # error: argument "na" is missing, with no default
```

<br>
We could also add a default value for the `na` argument. Following conservative approach, we'll specify default value as `FALSE` which means that any `NA` values in input vector `x` will result in z-score of `NA` for all observations:


```r
z_score <- function(x, na = FALSE) {
  (x - mean(x, na.rm=na))/sd(x, na.rm=na)
}

w
#> [1] NA  1  2  3  4  5 NA

z_score(w) # uses default value of FALSE
#> [1] NA NA NA NA NA NA NA
z_score(w, FALSE) # manually specify default value
#> [1] NA NA NA NA NA NA NA
z_score(w, TRUE) # override default value
#> [1]         NA -1.2649111 -0.6324555  0.0000000  0.6324555  1.2649111         NA
```

</details>

### Dot-dot-dot (`...`)

<br>

#### What is dot-dot-dot (`...`)?

Many functions take an arbitrary number of arguments/inputs, including:

- `select()`

    
    ```r
    #?select
    select(df_event,instnm,univ_id,event_type,med_inc) %>% names()
    #> [1] "instnm"     "univ_id"    "event_type" "med_inc"
    ```

- `sum()`

    
    ```r
    #?sum
    sum(3,3,2,2,1,1)
    #> [1] 12
    ```

- `str_c`

    
    ```r
    #?str_c
    
    # 1 character vector as input
    str_c(c("a", "b", "c"))
    #> [1] "a" "b" "c"
    
    # 2 character vectors as input
    str_c(c("a", "b", "c"), " is for ")
    #> [1] "a is for " "b is for " "c is for "
    
    # 3 character vectors as input
    str_c(c("a", "b", "c"), " is for ", c("apple", "banana", "coffee"))
    #> [1] "a is for apple"  "b is for banana" "c is for coffee"
    ```
    
<br>
All of these functions rely on a special argument `...` (pronounced "dot-dot-dot")  

- Dot-dot-dot (`...`) allows a function to take an arbitrary number of arguments
- Wickham and Grolemund [chapter 19.5.3](https://r4ds.had.co.nz/functions.html#dot-dot-dot) states:

  > "`...` captures any number of arguments that aren’t otherwise matched."

<br>

#### Writing functions with dot-dot-dot (`...`) arguments

When writing functions, there are two primary uses of including `...` arguments:

1. A means of allowing the function to take an arbitrary number of arguments, as in the `select()` and `sum()` functions
1. When we write our own function with the special argument `...`, we can pass those inputs into another function that takes `...` (e.g., `str_c()`)

<br>

<details><summary>**Example**: Adding dot-dot-dot (`...`) as function argument</summary>


Recall the first iteration of our `print_hello()` function, which basically just printed a name that we specified in function call. Let's modify the function to make it take an arbitrary number of names to greet:

- Function that only took one argument

    
    ```r
    print_hello1 <- function(x) {  
      str_c("Hello ", x, "!") 
    }
    
    print_hello1("Ozan")
    #> [1] "Hello Ozan!"
    ```

- Modify function to take an arbitrary number of names to greet

    
    ```r
    # Define function
    print_hello2 <- function(...) {  # The function accepts an arbitrary number of inputs
      str_c("Hello ", str_c(..., sep = ", "), "!")  # Pass the `...` to `str_c()`
    }
    
    # Call function
    print_hello2("Dasher", "Dancer", "Prancer", "Vixen")
    #> [1] "Hello Dasher, Dancer, Prancer, Vixen!"
    print_hello2("Rudolf")
    #> [1] "Hello Rudolf!"
    ```

</details>

### Checking values

How to handle invalid inputs?

- As seen previously in the [`z_score()` example](#z_score-function), one way to check for invalid inputs is using conditional statements
- "It's good practice to check important preconditions, and throw an error (with `stop()`), if they are not true" ([R for Data Science](https://r4ds.had.co.nz/functions.html#checking-values))
    - Especially in the case where the invalid input does not cause the function to break, but gives an unintended output instead, we want to explicitly raise an error so this does not go unnoticed

<br>
__The `stop()` function__:


```r
?stop

# SYNTAX AND DEFAULT VALUES
stop(..., call. = TRUE, domain = NULL)
```

<br>
<details><summary>**Example**: Using `stop()` inside function</summary>

Recall the `print_hello()` function. It will not print a greeting if `NA` is supplied as the input:


```r
print_hello <- function(x) {
  str_c("Hello ", x, "!")
}

print_hello(NA)
#> [1] NA
```

<br>
We can raise an error with a custom message if the input is `NA`:


```r
print_hello <- function(x) {
  if (is.na(x)) {
    stop("`x` must not be `NA`")
  }
  
  str_c("Hello ", x, "!")
}

print_hello(NA)
```

</details>
<br>

## Return values

Recall that functions generally follow **three sequential steps**:

1. Take in __input__ object(s)
2. __Process__ the input
3. __Return__ a new object, which may be a vector, data-frame, plot, etc.

### Implicit returns

What are **return values**?

- Just like how it can take inputs (i.e., arguments), functions can also return values as output
- The last statement that the function evaluates will be automatically (i.e., implicitly) returned
- We can use the assignment operator `<-` to store returned values in a new object for future use

Recall the `print_hello()` function:


```r
# Define function
print_hello <- function() {
  "Hello!"  # The last statement in the function is returned
}

# Call function
h <- print_hello()  # We can show that `print_hello()` returns a value by storing it in `h`
h                   # `h` stores the value "Hello!"
#> [1] "Hello!"
```

### Explicit returns

How can we **explicitly return values** from the function?

- We can use `return()` to explicitly return a value from our function
- This is commonly used when we want to return from the function early (e.g., inside an `if` block)
- There can be multiple `return()` in a function
- Returning from a function means exiting the function, so no other code below the point of return would be run

Recall the `print_hello()` function:


```r
# Define function
print_hello <- function() {
  return("Hello!")   # Explicitly return "Hello!"
  print("Goodbye!")  # Since this is after `return()`, it never gets run
}

# Call function
h <- print_hello()  # `print_hello()` returns "Hello!"
h
#> [1] "Hello!"
```

<br>
<details><summary>**Example**: Writing a function with multiple returns</summary>

Recall the previous example where we assess the prices of diamonds from the `diamonds` dataset from `ggplot2`. Let's move the `if`/`else if`/`else` blocks inside of a function, then call the function from inside the loop.

As seen below, the last statement that the function evaluates (i.e., whichever `if`/`else if`/`else` block is run) will be implicitly returned:


```r
assess_price <- function(price) {
  if (price < 500) {
    str_c("This diamond costs $", price, " and is affordable.")
  } else if (price < 1000) {
    str_c("This diamond costs $", price, " and is pricey...")
  } else {
    str_c("This diamond costs $", price, " and is too expensive!")
  }
}

prices <- unique(diamonds$price)[23:27]
for (i in prices) {
  writeLines(assess_price(i))
}
#> This diamond costs $405 and is affordable.
#> This diamond costs $552 and is pricey...
#> This diamond costs $553 and is pricey...
#> This diamond costs $554 and is pricey...
#> This diamond costs $2757 and is too expensive!
```

<br>
But if we were to have another line after the conditional part, then that would be implicitly returned instead, since it is now the last statement in the function:


```r
assess_price <- function(price) {
  if (price < 500) {
    str_c("This diamond costs $", price, " and is affordable.")
  } else if (price < 1000) {
    str_c("This diamond costs $", price, " and is pricey...")
  } else {
    str_c("This diamond costs $", price, " and is too expensive!")
  }
  
  "I can't afford that."  # This is now the last statement in the function that will be returned
}

for (i in prices) {
  writeLines(assess_price(i))
}
#> I can't afford that.
#> I can't afford that.
#> I can't afford that.
#> I can't afford that.
#> I can't afford that.
```

<br>
We can use `return()` to explicitly return early from the function:


```r
assess_price <- function(price) {
  if (price < 500) {
    return(str_c("This diamond costs $", price, " and is affordable."))  # Return early
  } else if (price < 1000) {
    return(str_c("This diamond costs $", price, " and is pricey..."))  # Return early
  } else {
    writeLines(str_c("This diamond costs $", price, " and is too expensive!"))
  }
  
  "I can't afford that."
}

for (i in prices) {
  writeLines(assess_price(i))
}
#> This diamond costs $405 and is affordable.
#> This diamond costs $552 and is pricey...
#> This diamond costs $553 and is pricey...
#> This diamond costs $554 and is pricey...
#> This diamond costs $2757 and is too expensive!
#> I can't afford that.
```

</details>
