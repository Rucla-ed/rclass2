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


```r
library(tidyverse)
```

```
## -- Attaching packages --------------------------------------------------------------------------------------------------------------------------- tidyverse 1.2.1 --
```

```
## v ggplot2 3.2.1     v purrr   0.3.3
## v tibble  2.1.3     v dplyr   0.8.3
## v tidyr   1.0.0     v stringr 1.4.0
## v readr   1.3.1     v forcats 0.4.0
```

```
## -- Conflicts ------------------------------------------------------------------------------------------------------------------------------ tidyverse_conflicts() --
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
```


```r
rm(list = ls()) # remove all objects

#load("../../data/prospect_list/western_washington_college_board_list.RData")
load(url("https://github.com/ozanj/rclass/raw/master/data/prospect_list/wwlist_merged.RData"))

# will this get rid of warnings "Unknown or uninitialised column: 'ethn_code_fac'"?
wwlist <- wwlist %>% mutate(eth_code_fac = NULL) # remove variable

#load off-campus recruiting dataset with one obs per recruiting event
load(url("https://github.com/ozanj/rclass/raw/master/data/recruiting/recruit_event_somevars.RData"))

#load off-campus recruiting dataset with one obs per high school
load(url("https://github.com/ozanj/rclass/raw/master/data/recruiting/recruit_school_somevars.RData"))
```

# Foundational concepts

## Data structures

![_Grolemund and Wickham, 2018_](https://d33wubrfki0l68.cloudfront.net/1d1b4e1cf0dc5f6e80f621b0225354b0addb9578/6ee1c/diagrams/data-structures-overview.png){width=60%}


__Vectors__ are the fundamental data structure in `R`. Recall that there are two broad types of vectors, __atomic vectors__ and __lists__

1. __Atomic vectors__. There are six types:
    - logical, integer, double, character, complex, and raw

2. __lists__. "sometimes called recursive vectors lists can contain other lists"

Main difference between atomic vectors and lists:

- atomic vectors are "homogenous," meaning each element in vector must have same type (e.g., integer, logical, character)
- lists are "heterogeneous," meaning that data type can differ across elements within a list


### Atomic vectors


\medskip An __atomic vector__ is a collection of values

- each value in an atomic vector is an __element__
- all elements within vector must have same __data type__


```r
(a <- c(1,2,3)) # parentheses () assign and print object in one step
```

```
## [1] 1 2 3
```

```r
length(a) # length = number of elements
```

```
## [1] 3
```

```r
typeof(a) # numeric atomic vector, type=double
```

```
## [1] "double"
```

```r
str(a) # investigate structure of object
```

```
##  num [1:3] 1 2 3
```

Type of atomic vectors

1. logical. each element can be three potential values: `TRUE`, `FALSE`, `NA`

```r
typeof(c(TRUE,FALSE,NA))
```

```
## [1] "logical"
```

```r
typeof(c(1==1,1==2))
```

```
## [1] "logical"
```
2. Numeric (integer or double)

```r
typeof(c(1.5,2,1))
```

```
## [1] "double"
```

```r
typeof(c(1,2,1))
```

```
## [1] "double"
```
- Numbers are doubles by default. To make integer, place `L` after number:

```r
typeof(c(1L,2L,1L))
```

```
## [1] "integer"
```

3. character

```r
typeof(c("element of character vector","another element"))
```

```
## [1] "character"
```

```r
length(c("element of character vector","another element"))
```

```
## [1] 2
```

Can assign __names__ to vector elements, creating a __named atomic vector__


```r
(b <- c(v1=1,v2=2,v3=3))
```

```
## v1 v2 v3 
##  1  2  3
```

```r
length(b) 
```

```
## [1] 3
```

```r
typeof(b) 
```

```
## [1] "double"
```

```r
str(b) 
```

```
##  Named num [1:3] 1 2 3
##  - attr(*, "names")= chr [1:3] "v1" "v2" "v3"
```

### Lists

\medskip

- Like atomic vectors, __lists__ are objects that contain __elements__
- However, __data type__ can differ across elements within a list
    - an element of a list can be another list



```r
list_a <- list(1,2,"apple")
typeof(list_a)
```

```
## [1] "list"
```

```r
length(list_a)
```

```
## [1] 3
```

```r
str(list_a)
```

```
## List of 3
##  $ : num 1
##  $ : num 2
##  $ : chr "apple"
```

```r
list_b <- list(1, c("apple", "orange"), list(1, 2))
length(list_b)
```

```
## [1] 3
```

```r
str(list_b)
```

```
## List of 3
##  $ : num 1
##  $ : chr [1:2] "apple" "orange"
##  $ :List of 2
##   ..$ : num 1
##   ..$ : num 2
```

Like atomic vectors, elements within a list can be named, thereby creating a __named list__


```r
# not named
str(list_b) 
```

```
## List of 3
##  $ : num 1
##  $ : chr [1:2] "apple" "orange"
##  $ :List of 2
##   ..$ : num 1
##   ..$ : num 2
```

```r
# named
list_c <- list(v1=1, v2=c("apple", "orange"), v3=list(1, 2, 3))
str(list_c) 
```

```
## List of 3
##  $ v1: num 1
##  $ v2: chr [1:2] "apple" "orange"
##  $ v3:List of 3
##   ..$ : num 1
##   ..$ : num 2
##   ..$ : num 3
```

A __data frame__ is a list with the following characteristics:

- All the elements must be __vectors__ with the same __length__
- Data frames are __augmented lists__ because they have additional __attributes__


```r
#a regular list
(list_d <- list(col_a = c(1,2,3), col_b = c(4,5,6), col_c = c(7,8,9)))
```

```
## $col_a
## [1] 1 2 3
## 
## $col_b
## [1] 4 5 6
## 
## $col_c
## [1] 7 8 9
```

```r
typeof(list_d)
```

```
## [1] "list"
```

```r
attributes(list_d)
```

```
## $names
## [1] "col_a" "col_b" "col_c"
```

```r
#a data frame
(df_a <- data.frame(col_a = c(1,2,3), col_b = c(4,5,6), col_c = c(7,8,9)))
```

```
## # A tibble: 3 x 3
##   col_a col_b col_c
##   <dbl> <dbl> <dbl>
## 1     1     4     7
## 2     2     5     8
## 3     3     6     9
```

```r
typeof(df_a)
```

```
## [1] "list"
```

```r
attributes(df_a)
```

```
## $names
## [1] "col_a" "col_b" "col_c"
## 
## $class
## [1] "data.frame"
## 
## $row.names
## [1] 1 2 3
```

### Identify vector type

Identifying vector __type__, Grolemund and Wickham:

- "Sometimes you want to do different things based on the type of vector. One option is to use `typeof()`. Another is to use a test function which returns a `TRUE` or `FALSE`"

[NOTE TO CRYSTAL/PATRICIA/OZAN] - REPLACE ALL `is_*` functions with `is.*` functions because `is_*` have been deprecated. NOTE THAT `is_*` AND `is.*` DIFFER BECAUSE `is_*` WAS MEANT TO CAPTURE OBJECT TYPE WHILE `is.*` IS A SOME COMBINATION OF TYPE AND CLASS (I THINK), SO CONTENT OF BELOW SUB-SECTION WILL HAVE TO BE MODIFIED]

`is_*()` functions are provided by `purrr` package within `Tidyverse`:

Function | logical | int | dbl | chr | list
---------|---------|-----|-----|-----|-----
`is_logical()` | X | | | |
`is_integer()` |  |X | | |
`is_double()` |  | |X | |
`is_numeric()` |  |X |X | |
`is_character()` |  | | |X |
`is_atomic()` |X  |X |X |X |
`is_list()` |  | | | | X
`is_vector()` |X  |X |X |X |X


```r
is_numeric(c(5,6,7))
```

```
## Warning: Deprecated
```

```
## [1] TRUE
```

Recall that elements of a vector must have the same type

- If vector contains elements of different type, type will be most "complex"
- From simplest to most complex: logical, integer, double, character


```r
is_logical(c(TRUE,TRUE,NA))
is_logical(c(TRUE,TRUE,NA,1))

typeof(c(TRUE,1L))
is_integer(c(TRUE,1L))

typeof(c(TRUE,1L,1.5,"b"))
is_character(c(TRUE,1L,1.5,"b"))
```

\medskip
Comparing `is_*()` vs. `is.*()` functions

- `is_*()` functions (e.g., `is_numeric()`) identifies vector __type__
    - They are the `TRUE/FALSE` versions of `typeof()` function
- `is.*()` functions (e.g., `is.numeric()`) refer to both __type__ and __class__
    - Review: __class__ is an object __attribute__ that defines how object can be treated by object oriented programming language (e.g., which functions you can apply)
    - Recall that R functions care about __class__, not __type__

\medskip

```r
df_event %>% select(instnm,univ_id,event_date,med_inc,titlei_status_pub) %>% str()
```

Variable = `univ_id`

```r
typeof(df_event$univ_id)
class(df_event$univ_id)
is_numeric(df_event$univ_id)
is.numeric(df_event$univ_id)
```
Variable = `event_date`

```r
typeof(df_event$event_date)
class(df_event$event_date)
is_numeric(df_event$event_date)
is.numeric(df_event$event_date)
```

Comparing `is_*()` vs. `is.*()` functions

- `is_*()` functions (e.g., `is_numeric()`) identifies vector __type__
- `is.*()` functions (e.g., `is.numeric()`) refer to both __type__ and __class__

\medskip
Variable = `med_inc`

```r
typeof(df_event$med_inc)
class(df_event$med_inc)
is_numeric(df_event$med_inc)
is.numeric(df_event$med_inc)
```

Variable = `titlei_status_pub`

```r
typeof(df_event$titlei_status_pub)
class(df_event$titlei_status_pub)
is_numeric(df_event$titlei_status_pub)
is.numeric(df_event$titlei_status_pub)
```

### Coerce vector type

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
```

```
##  [1]  TRUE FALSE  TRUE FALSE  TRUE FALSE  TRUE FALSE    NA    NA    NA
```

Numeric vector coerced to logical vector:


```r
# 0 is treated as FALSE, while all other numeric values are treated as TRUE
as.logical(c(0, 0.0, 1, -1, 20, 5.5))
```

```
## [1] FALSE FALSE  TRUE  TRUE  TRUE  TRUE
```

</details>

<br>
<details><summary>**Example**: Using `as.numeric()` to convert to `numeric`</summary>

Logical vector coerced to numeric vector:


```r
# FALSE is mapped to 0 and TRUE is mapped to 1
as.numeric(c(FALSE, TRUE))
```

```
## [1] 0 1
```



## Subset/extract elements


"Subsetting" refers to isolating particular elements of an object 

\medskip
Subsetting operators can be used to select/exclude elements (e.g., variables, observations)

- there are three subsetting operators: `[]`, `$` , `[[]]` 
- these operators function differently based on vector types (e.g, atomic vectors, lists, data frames)

#### Wichham refers to number of "dimensions" in R objects

An atomic vector is a 1-dimensional object that contains n elements

```r
x <- c(1.1, 2.2, 3.3, 4.4, 5.5)
str(x)
```

```
##  num [1:5] 1.1 2.2 3.3 4.4 5.5
```
    
Lists are multi-dimensional objects

- Contains n elements; each element may contain a 1-dimensional atomic vector or a multi-dimensional list. Below list contains 3 dimensions

```r
list <- list(c(1,2), list("apple", "orange"))
str(list)
```

```
## List of 2
##  $ : num [1:2] 1 2
##  $ :List of 2
##   ..$ : chr "apple"
##   ..$ : chr "orange"
```
Data frames are 2-dimensional lists

- each element is a variable (dimension=columns)
- within each variable, each element is an observation (dimension=rows)

```r
ncol(df_school)
```

```
## [1] 26
```

```r
nrow(df_school)
```

```
## [1] 21301
```


### Subset atomic vectors using []

"Subsetting" a vector refers to isolating particular elements of a vector

- I sometimes refer to this as "accessing elements of a vector"
- subsestting elements of a vector is similar to "filtering" rows of a data-frame
- `[]` is the subsetting function for vectors

Six ways to subset an atomic vector using `[]`

1. Using positive integers to return elements at specified positions
2. Using negative integers to exclude elements at specified positions
3. Using logicals to return elements where corresponding logical is `TRUE`
4. Empty `[]` returns original vector (useful for dataframes)
5. Zero vector [0], useful for testing data
6. If vector is "named," use character vectors to return elements with matching names


#### 1. Using positive integers to return elements at specified positions (subset atomic vectors using [])

Create atomic vector `x`

```r
(x <- c(1.1, 2.2, 3.3, 4.4, 5.5))
```

```
## [1] 1.1 2.2 3.3 4.4 5.5
```

```r
str(x)
```

```
##  num [1:5] 1.1 2.2 3.3 4.4 5.5
```

`[]` is the subsetting function for vectors

- contents inside `[]` can refer to element number (also called "position"). 
    - e.g., `[3]` refers to contents of 3rd element (or position 3)


```r
x[5] #return 5th element
```

```
## [1] 5.5
```

```r
x[c(3, 1)] #return 3rd and 1st element
```

```
## [1] 3.3 1.1
```

```r
x[c(4,4,4)] #return 4th element, 4th element, and 4th element
```

```
## [1] 4.4 4.4 4.4
```

```r
#Return 3rd through 5th element
str(x)
```

```
##  num [1:5] 1.1 2.2 3.3 4.4 5.5
```

```r
x[3:5]
```

```
## [1] 3.3 4.4 5.5
```


#### 2. Using negative integers to exclude elements at specified positions (subset atomic vectors using [])

Before excluding elements based on position, investigate object

```r
x
```

```
## [1] 1.1 2.2 3.3 4.4 5.5
```

```r
length(x)
```

```
## [1] 5
```

```r
str(x)
```

```
##  num [1:5] 1.1 2.2 3.3 4.4 5.5
```

Use negative integers to exclude elements based on element position

```r
x[-1] # exclude 1st element
```

```
## [1] 2.2 3.3 4.4 5.5
```

```r
x[c(3,1)] # 3rd and 1st element
```

```
## [1] 3.3 1.1
```

```r
x[-c(3,1)] # exclude 3rd and 1st element
```

```
## [1] 2.2 4.4 5.5
```


#### 3. Using logicals to return elements where corresponding logical is `TRUE` (subset atomic vectors using [])


```r
x
```

```
## [1] 1.1 2.2 3.3 4.4 5.5
```

When using `x[y]` to subset `x`, good practice to have `length(x)==length(y)`

```r
length(x) # length of vector x
```

```
## [1] 5
```

```r
length(c(TRUE,FALSE,TRUE,FALSE,TRUE)) # length of y
```

```
## [1] 5
```

```r
length(x) == length(c(TRUE,FALSE,TRUE,FALSE,TRUE)) # condition true
```

```
## [1] TRUE
```

```r
x[c(TRUE,TRUE,FALSE,FALSE,TRUE)]
```

```
## [1] 1.1 2.2 5.5
```

Recycling rules:

- in `x[y]`, if `x` is different length than `y`, R "recycles" length of shorter to match length of longer


```r
length(c(TRUE,FALSE))
```

```
## [1] 2
```

```r
x
```

```
## [1] 1.1 2.2 3.3 4.4 5.5
```

```r
x[c(TRUE,FALSE)]
```

```
## [1] 1.1 3.3 5.5
```


Note that a missing value (`NA`) in the index always yields a missing value in the output


```r
x[c(TRUE, FALSE, NA, TRUE, NA)]
```

```
## [1] 1.1  NA 4.4  NA
```

Return all elements of object `x` where element is greater than 3

```r
x
```

```
## [1] 1.1 2.2 3.3 4.4 5.5
```

```r
x[x>3]
```

```
## [1] 3.3 4.4 5.5
```


#### 4. Empty `[]` returns original vector (subset atomic vectors using [])



```r
x
```

```
## [1] 1.1 2.2 3.3 4.4 5.5
```

```r
x[]
```

```
## [1] 1.1 2.2 3.3 4.4 5.5
```

This is useful for sub-setting data frames, as we will show below

#### 5. Zero vector [0] (subset atomic vectors using [])

Zero vector, `x[0]`

- R interprets this as returning element 0

```r
x[0]
```

```
## numeric(0)
```

Wickham states:

- "This is not something you usually do on purpose, but it can be helpful for generating test data."


#### 6. If vector is named, character vectors to return elements with matching names (subset atomic vectors using [])


Create vector `y` that has values of vector `x` but each element is named

```r
x
```

```
## [1] 1.1 2.2 3.3 4.4 5.5
```

```r
(y <- c(a=1.1, b=2.2, c=3.3, d=4.4, e=5.5))
```

```
##   a   b   c   d   e 
## 1.1 2.2 3.3 4.4 5.5
```
Return elements of vector based on name of element

- enclose element names in single `''` or double `""` quotes

```r
#show element named "a"
y["a"]
```

```
##   a 
## 1.1
```

```r
#show elements "a", "b", and "d"
y[c("a", "b", "d" )]
```

```
##   a   b   d 
## 1.1 2.2 4.4
```

### Subset lists/data frames using []

Using `[]` operator to subset lists works the same as subsetting atomic vector

- Using `[]` with a list always returns a list



```r
list_a <- list(list(1,2),3,"apple")
str(list_a)
```

```
## List of 3
##  $ :List of 2
##   ..$ : num 1
##   ..$ : num 2
##  $ : num 3
##  $ : chr "apple"
```

```r
#create new list that consists of elements 3 and 1 of list_a
list_b <- list_a[c(3, 1)]
str(list_b)
```

```
## List of 2
##  $ : chr "apple"
##  $ :List of 2
##   ..$ : num 1
##   ..$ : num 2
```

```r
#show elements 3 and 1 of object list_a
#str(list_a[c(3, 1)])
```

#### Subsetting data frames using []

Recall that a data frame is just a particular kind of list

- each element = a column = a variable

Using `[]` with a list always returns a list

- Using `[]` with a data frame always returns a data frame

Two ways to use `[]` to extract elements of a data frame

1. use "single index" `df_name[<columns>]` to extract columns (variables) based on element position number (i.e., column number)
1. use "double index" `df_name[<rows>, <columns>]` to extact particular rows and columns of a data frame

##### Subsetting data frames using [] to extract columns (variables) based on element position

Use "single index" `df_name[<columns>]` to extract columns (variables) based on element number (i.e., column number)

\medskip

Examples [output omitted]

```r
names(df_event)

#extract elements 1 through 4 (elements=columns=variables)
df_event[1:4]
df_event[c(1,2,3,4)]

str(df_event[1:4])
#extract columns 13 and 7
df_event[c(13,7)]
```

##### Subsetting Data Frames to extract columns (variables) and rows (observations) based on positionality

use "double index" syntax `df_name[<rows>, <columns>]` to extact particular rows and columns of a data frame

- often combined with sequences (e.g., `1:10`)



```r
#Return rows 1-3 and columns 1-4
df_event[1:3, 1:4]
```

```
## # A tibble: 3 x 4
##   instnm     univ_id instst   pid
##   <chr>        <int> <chr>  <int>
## 1 UM Amherst  166629 MA     57570
## 2 UM Amherst  166629 MA     56984
## 3 UM Amherst  166629 MA     57105
```

```r
#Return rows 50-52 and columns 10 and 20
df_event[50:52, c(10,20)]
```

```
## # A tibble: 3 x 2
##   event_state pct_tworaces_zip
##   <chr>                  <dbl>
## 1 MA                      1.98
## 2 MA                      1.98
## 3 MA                      1.98
```

recall that empty `[]` returns original object (output omitted)

```r
#return original data frame
df_event[]

#return specific rows and all columns (variables)
df_event[1:5, ]

#return all rows and specific columns (variables)
df_event[, c(1,2,3)]
```

#### Use [] to extract data frame columns based on variable names

Selecting columns from a data frame by subsetting with `[]` and list of element names (i.e., variable names) enclose in quotes

\medskip

"single index" approach extracts specific variables, all rows (output omittted)

```r
df_event[c("instnm", "univ_id", "event_state")] 
select(df_event,instnm,univ_id,event_state) # same same
```

"Double index" approach extracts specific variables and specific rows

- syntax `df_name[<rows>, <columns>]`


```r
df_event[1:5, c("instnm", "event_state", "event_type")] 
```

```
## # A tibble: 5 x 3
##   instnm      event_state event_type
##   <chr>       <chr>       <chr>     
## 1 UM Amherst  MA          public hs 
## 2 UM Amherst  MA          public hs 
## 3 UM Amherst  MA          public hs 
## 4 UM Amherst  MA          public hs 
## 5 Stony Brook MA          public hs
```

#### Student exercises

Use subsetting operators from base R in extracting columns (variables), observations:

1. Use both "single index" and "double index" in subsetting to create a new dataframe by extracting the columns `instnm`, `event_date`, `event_type` from df_event. And show what columns (variables) are in the newly created dataframe. 

2. Use subsetting to return rows 1-5 of columns `state_code`, `name`, `address` from df_school.


Solution to Student Exercises

Solution to 1

__base R__ using subsetting operators

```r
# single index
df_event_br <- df_event[c("instnm", "event_date", "event_type")]
#double index
df_event_br <- df_event[, c("instnm", "event_date", "event_type")]
names(df_event_br)
```

```
## [1] "instnm"     "event_date" "event_type"
```

Solution to 2

__base R__ using subsetting operators

```r
df_school[1:5, c("state_code", "name", "address")]
```

```
## # A tibble: 5 x 3
##   state_code name                        address                     
##   <chr>      <chr>                       <chr>                       
## 1 AK         Bethel Regional High School 1006 Ron Edwards Memorial Dr
## 2 AK         Ayagina'ar Elitnaurvik      106 Village Road            
## 3 AK         Kwigillingok School         108 Village Road            
## 4 AK         Nelson Island Area School   118 Village Road            
## 5 AK         Alakanuk School             9 School Road
```

### Subset lists/data frames using [[]] and $

#### Subset single element from object using [[]] operator

So far we have used `[]` to excract elements from an object

- Applying `[]` to an atomic vector returns an atomic vector with specific elements you requested
- Applying `[]` to a list returns a shorter list that contains the specific elements you requested

`[[]]` also extract elements from an object

- Applying `[[]]` gives same result as `[]`; that is, an atomic vector with element you request

```r
(x <- c(1.1, 2.2, 3.3, 4.4, 5.5))
```

```
## [1] 1.1 2.2 3.3 4.4 5.5
```

```r
str(x[3])
```

```
##  num 3.3
```

```r
str(x[[3]])
```

```
##  num 3.3
```

- Applying `[[]]` to list gives the "contents" of the list, rather than list itself

```r
list_a <- list(1:3, "a", 4:6)
str(list_a)
```

```
## List of 3
##  $ : int [1:3] 1 2 3
##  $ : chr "a"
##  $ : int [1:3] 4 5 6
```

```r
str(list_a[1])
```

```
## List of 1
##  $ : int [1:3] 1 2 3
```

```r
str(list_a[[1]])
```

```
##  int [1:3] 1 2 3
```

Wickham "Advanced R" chapter 4.3 [[LINK HERE](https://adv-r.hadley.nz/subsetting.html#subset-single)] uses "Train Metaphor" to differentiate list vs. contents of list

The list is the entire train. Create a list with three elements (three "carriages")

```r
list_a <- list(1:3, "a", 4:6)
str(list_a)
```

```
## List of 3
##  $ : int [1:3] 1 2 3
##  $ : chr "a"
##  $ : int [1:3] 4 5 6
```
When extracting element(s) of a list you have two options:

1. Extracting elements using `[]` always returns a smaller list (smaller train)

```r
str(list_a[1]) # returns a list
```

```
## List of 1
##  $ : int [1:3] 1 2 3
```
2. Extracting element using `[[]]` returns contents of particular carriage
    - I say applying `[[]]` to a list or data frame returns a simpler object that moves up one level of hierarchy

```r
str(list_a[[1]]) # returns an atomic vector
```

```
##  int [1:3] 1 2 3
```
    

In contrast to `[]`, we use `[[]]` to extract individual elements rather than multiple elements

- we could write `x[4]` or `x[4:6]`
- we could write `x[[4]]` but not `x[[4:6]]`

Just like `[]` can use `[[]]` to return contents of __named__ elements, specified using quotes

- syntax: `obj_name[["element_name"]]`

```r
list_b <- list(var1=1:3, var2="a", var3=4:6)
str(list_b)
```

```
## List of 3
##  $ var1: int [1:3] 1 2 3
##  $ var2: chr "a"
##  $ var3: int [1:3] 4 5 6
```

```r
str(list_b["var1"])
```

```
## List of 1
##  $ var1: int [1:3] 1 2 3
```

```r
str(list_b[["var1"]])
```

```
##  int [1:3] 1 2 3
```
Works the same with data frames

```r
str(df_event["zip"])
```

```
## Classes 'tbl_df', 'tbl' and 'data.frame':	18680 obs. of  1 variable:
##  $ zip: chr  "01002" "01007" "01020" "01020" ...
```

```r
str(df_event[["zip"]])
```

```
##  chr [1:18680] "01002" "01007" "01020" "01020" "01027" "01027" "01027" ...
```


#### Subset lists/data frames using $

`obj_name$element_name` shorthand operator for `obj_name[["element_name"]]`


```r
str(list_b)
```

```
## List of 3
##  $ var1: int [1:3] 1 2 3
##  $ var2: chr "a"
##  $ var3: int [1:3] 4 5 6
```

```r
list_b[["var1"]]
```

```
## [1] 1 2 3
```

```r
list_b$var1
```

```
## [1] 1 2 3
```

```r
str(list_b[["var1"]])
```

```
##  int [1:3] 1 2 3
```

```r
str(list_b$var1)
```

```
##  int [1:3] 1 2 3
```
`df_name$var_name`: easiest way in base R to refer to variable in a data frame

```r
str(df_event[["zip"]])
```

```
##  chr [1:18680] "01002" "01007" "01020" "01020" "01027" "01027" "01027" ...
```

```r
str(df_event$zip)
```

```
##  chr [1:18680] "01002" "01007" "01020" "01020" "01027" "01027" "01027" ...
```


#### Subsetting Data Frames with [] combined with $ 

Combine `[]` with `$` to subset data frame same as `filter()` or `subset()`

Syntax: `df_name[df_name$var_name <condition>, ]`

- Note: Uses "double index" `df_name[<rows>, <columns>]` syntax
- __Cannot__ use "single index" `df_name[<columns>]`

Examples (output omitted)

- All observations where the hich school received at least 1 visit from UC Berkeley (var=`visits_by_110635`) and all columns

```r
df_school[df_school$visits_by_110635 >= 1, ]
```

- All obs where the high school received at least 1 visit from UC Berkeley and the first three columns

```r
df_school[df_school$visits_by_110635 == 1, 1:3]
```
- All obs where the high school received at least 1 visit from UC Berkeley and variables "state_code" "school_type" "name"

```r
df_school[df_school$visits_by_110635 == 1, c("state_code","school_type","name")]
```

Combine `[]` with `$` to subset data frame same as `filter()` or `subset()`

- Syntax: `df_name[df_name$var_name <condition>, ]`

- Can be combined with `count()` or `nrow()` to avoid printing many rows

\medskip
Count obs where high schools received at least 1 visit by Bama (100751) and at least one visit by Berkeley (110635)

- compare with `filter()` and `subset()` approaches

```r
#[] combined with $ approach
count(df_school[df_school$visits_by_110635 >= 1
  & df_school$visits_by_100751 >= 1, ])
```

```
## # A tibble: 1 x 1
##       n
##   <int>
## 1   247
```

```r
count(df_school[df_school[["visits_by_110635"]] >= 1
  & df_school[["visits_by_100751"]] >= 1, ])
```

```
## # A tibble: 1 x 1
##       n
##   <int>
## 1   247
```

```r
df_school[]
```

```
## # A tibble: 21,301 x 26
##    state_code school_type ncessch name  address city  zip_code pct_white
##    <chr>      <chr>       <chr>   <chr> <chr>   <chr> <chr>        <dbl>
##  1 AK         public      020000~ Beth~ 1006 R~ Beth~ 99559       11.8  
##  2 AK         public      020000~ Ayag~ 106 Vi~ Kong~ 99559        0    
##  3 AK         public      020000~ Kwig~ 108 Vi~ Kwig~ 99622        0    
##  4 AK         public      020000~ Nels~ 118 Vi~ Toks~ 99637        0    
##  5 AK         public      020000~ Alak~ 9 Scho~ Alak~ 99554        2.52 
##  6 AK         public      020000~ Emmo~ Genera~ Emmo~ 99581        0    
##  7 AK         public      020000~ Hoop~ Genera~ Hoop~ 99604        0    
##  8 AK         public      020000~ Igna~ 100 Hi~ Moun~ 99632        0    
##  9 AK         public      020000~ Pilo~ 5090 S~ Pilo~ 99650        0.559
## 10 AK         public      020000~ Kotl~ 20129 ~ Kotl~ 99620        0.538
## # ... with 21,291 more rows, and 18 more variables: pct_black <dbl>,
## #   pct_hispanic <dbl>, pct_asian <dbl>, pct_amerindian <dbl>, pct_other <dbl>,
## #   num_fr_lunch <dbl>, total_students <dbl>, num_took_math <dbl>,
## #   num_prof_math <dbl>, num_took_rla <dbl>, num_prof_rla <dbl>,
## #   avgmedian_inc_2564 <dbl>, visits_by_110635 <int>, visits_by_126614 <int>,
## #   visits_by_100751 <int>, inst_110635 <chr>, inst_126614 <chr>,
## #   inst_100751 <chr>
```

```r
#filter() approach
nrow(filter(df_school, visits_by_110635 >= 1, visits_by_100751 >= 1))
```

```
## [1] 247
```

```r
#subset() approach
nrow(subset(df_school, visits_by_110635 >= 1 & visits_by_100751 >= 1))
```

```
## [1] 247
```

## Attributes and class

### Atomic vs. augmented vectors

__Atomic vectors__ [our focus so far]

- I think of atomic vectors as "just the data"
- Atomic vectors are the building blocks for augmented vectors

\medskip 

__Augmented vectors__

- __Augmented vectors__ are atomic vectors with additional __attributes__ attached

__Attributes__

- __Attributes__ are additional "metadata" that can be attached to any object (e.g., vector or list)

Example: variables of a dataset

- a data frame is a list
- each element in the list is a variable, which consists of:
    - atomic vector ("just the data"); 
    - variable __name__, which is an attribute we attach to the element/variable
    - any other attributes we want to attach to element/variable
    
Other examples of attributes in R

- __value labels__: character labels (e.g., "Charter School") attached to numeric values
- __Object class__: Specifies how object treated by object oriented programming language

__Main takaway__:

- Augmented vectors are atomic vectors (just the data) with additional attributes attached


Description of attributes from Wickham and Grolemund 20.6

- "Any vector can contain arbitrary additional __metadata__ through its __attributes__"
- "You can think of __attributes__ as named list of vectors that can be attached to any object"

Functions to identify and modify attributes

- `attributes()` function to describe all attributes of an object
- `attr()` to see individual attribute of an object or set/change an individual attribute of an object

### `attributes()` function describes all attributes of an object


```r
?attributes
```

An atomic vector

```r
#vector with name attributes
(vector1 <- c(a = 1, b= 2, c= 3, d = 4))
```

```
## a b c d 
## 1 2 3 4
```

```r
attributes(vector1)
```

```
## $names
## [1] "a" "b" "c" "d"
```

```r
#remove all attributes from object
attributes(vector1) <- NULL
vector1
```

```
## [1] 1 2 3 4
```

```r
attributes(vector1)
```

```
## NULL
```

#### Attributes and subset operators `[[]]` and `[]`

\medskip

Accessing variable using `[[]]` subset operator

- recall `object_name[["element_name"]]` accesses contents of the element
- If object is a data frame, `df_name[["var_name"]]` accesses contents of variable
    - for simple vars like `firstgen` syntax yields an atomic vector ("just the data")
- shorthand syntax for `df_name[["var_name"]]` is `df_name$var_name`


```r
str(wwlist[["firstgen"]])
```

```
##  chr [1:268396] NA "N" "N" "N" NA "N" "N" "Y" "Y" "N" "N" "N" "N" "N" "N" ...
```

```r
attributes(wwlist[["firstgen"]])
```

```
## NULL
```

```r
str(wwlist$firstgen) # same same
```

```
##  chr [1:268396] NA "N" "N" "N" NA "N" "N" "Y" "Y" "N" "N" "N" "N" "N" "N" ...
```

```r
attributes(wwlist$firstgen)
```

```
## NULL
```

Accessing variable using `[]` subset operator

- `object_name["element_name"]` creates object of same type as `object_name`
- contains attributes of `object_name`, atomic vector associated with `element_name`, and any attributes associated with `element_name`

```r
str(wwlist["firstgen"])
attributes(wwlist["firstgen"])
```

#### Attributes of lists and data frames

\medskip


```r
#attributes of a named list
list2 <- list(col_a = c(1,2,3), col_b = c(4,5,6))
str(list2)
```

```
## List of 2
##  $ col_a: num [1:3] 1 2 3
##  $ col_b: num [1:3] 4 5 6
```

```r
attributes(list2)
```

```
## $names
## [1] "col_a" "col_b"
```

```r
#attributes of a data frame
list3 <- data.frame(col_a = c(1,2,3), col_b = c(4,5,6))
str(list3)
```

```
## 'data.frame':	3 obs. of  2 variables:
##  $ col_a: num  1 2 3
##  $ col_b: num  4 5 6
```

```r
attributes(list3)
```

```
## $names
## [1] "col_a" "col_b"
## 
## $class
## [1] "data.frame"
## 
## $row.names
## [1] 1 2 3
```

### `attr()` function: get or set specific attributes of an object



Syntax

- Get: `attr(x, which, exact = FALSE)`
- Set: `attr(x, which) <- value`

Arguments

- `x`	an object whose attributes are to be accessed.
- `which`	a non-empty character string specifying which attribute is to be accessed
- `exact`	logical: should `which` be matched exactly? default is `exact = FALSE`
- `value`	an object, new value of attribute, or NULL to remove attribute.

\medskip

Using `attr()` to __get__ specific attribute of an object

```r
(vector1 <- c(a = 1, b= 2, c= 3, d = 4))
```

```
## a b c d 
## 1 2 3 4
```

```r
attributes(vector1)
```

```
## $names
## [1] "a" "b" "c" "d"
```

```r
attr(x=vector1, which = "names", exact = FALSE)
```

```
## [1] "a" "b" "c" "d"
```

```r
attr(vector1, "names")
```

```
## [1] "a" "b" "c" "d"
```

```r
attr(vector1, "name") # we don't provide exact name of attribute
```

```
## [1] "a" "b" "c" "d"
```

```r
attr(vector1, "name", exact = TRUE) # don't provide exact name of attribute
```

```
## NULL
```

### attr() function: get or set specific attributes of an object



Syntax

- Get: `attr(x, which, exact = FALSE)`
- Set: `attr(x, which) <- value`

Arguments

- `x`	an object whose attributes are to be accessed.
- `which`	a non-empty character string specifying which attribute is to be accessed
- `exact`	logical: should `which` be matched exactly? default is `exact = FALSE`
- `value`	an object, new value of attribute, or NULL to remove attribute.

\medskip

Using `attr()` to __set__ specific attribute of an object (output omitted)

```r
(vector1 <- c(a = 1, b= 2, c= 3, d = 4))
attributes(vector1) # see all attributes

attr(x=vector1, which = "greeting") <- "Hi!" # create new attribute
attr(x=vector1, which = "greeting") # see attribute

attr(vector1, "farewell") <- "Bye!" # create attribute

attr(x=vector1, which = "names") # see names attribute
attr(x=vector1, which = "names") <- NULL # delete names attribute

attributes(vector1) # see all attributes
```


#### Applying attr() to data frames

\medskip 

Using `wwlist`, create data frame with three variables

```r
wwlist_small <- wwlist[1:25, ] %>% select(hs_state,firstgen,med_inc_zip)
str(wwlist_small)
attributes(wwlist_small)
```
Get/set attribute of a data frame

```r
#get/examine names attribute
attr(x=wwlist_small, which = "names") 

str(attr(x=wwlist_small, which = "names")) # names attribute is character atomic vector, length=3

#add new attribute to data frame
attr(x=wwlist_small, which = "new_attribute") <- "contents of new attribute"
attributes(wwlist_small)
```
Get/set attribute of a variable in data frame

```r
str(wwlist_small$med_inc_zip)
attributes(wwlist_small$med_inc_zip)

#create attribute for variable med_inc_zip
attr(wwlist_small$med_inc_zip, "inc attribute") <- "inc attribute contents"

#investigate attribute for variable med_inc_zip
attributes(wwlist_small$med_inc_zip)
str(wwlist_small$med_inc_zip)
attr(wwlist_small$med_inc_zip, "inc attribute")
```


#### Student exercises

1. Using "wwlist", creat data frame of 30 observations with three variables: "state", "zip5", "pop_total_zip".

2. Describe all attribute of the new data frame; Get the name attribute of the new data frame.

3. Add a new attribute to the data frame: name: "attribute_data", content: "new attribute of data";
  
   then investigate the attribute and get the new name attribute of the data.

4. Get the attribute of the variable pop_total_zip.

5. Add a new attribute to the variable pop_total_zip: name: "attribute_variable", content: "new attribute of variable"; 

   then investigate the attribute and get the new name attribute of the variable.

Solution to student exercises


```r
wwlist_exercise <- wwlist[1:30, ] %>% select(state,zip5,pop_total_zip)

attributes(wwlist_exercise)
attr(x=wwlist_exercise, which = "names") 

attr(x=wwlist_exercise, which = "attribute_data") <- "new attribute of data"

attributes(wwlist_exercise)
attr(wwlist_exercise, which ="attribute_data")

attributes(wwlist_exercise$pop_total_zip)

attr(wwlist_exercise$pop_total_zip, "attribute_variable") <- "new attribute of variable"

attributes(wwlist_exercise$pop_total_zip)
attr(wwlist_exercise$pop_total_zip, "attribute_variable")
```

### Object class

\medskip 
Every object in R has a __class__

- class is an __attribute__ of an object
- Object class controls how functions work; defines rules for how object can be treated by object oriented programming language
    - e.g., which functions you can apply to object of a particular class
    - e.g., what the function does to one object class, what it does to another object class


Many ways to identify object class

- Simplest is `class()` function

```r
(vector2 <- c(a = 1, b= 2, c= 3, d = 4))
```

```
## a b c d 
## 1 2 3 4
```

```r
typeof(vector2)
```

```
## [1] "double"
```

```r
class(vector2)
```

```
## [1] "numeric"
```

When I encounter a new object I often investigate object by applying `typeof()`, `class()`, and `attributes()` functions

```r
typeof(vector2)
```

```
## [1] "double"
```

```r
class(vector2)
```

```
## [1] "numeric"
```

```r
attributes(vector2)
```

```
## $names
## [1] "a" "b" "c" "d"
```

#### Why is object class important?

Functions care about object __class__, not object __type__

\medskip

Specific functions usually work with only particular __classes__ of objects

- e.g., "date"" functions usually only work on objects with a date class
- "string" functions usually only work with on objects with a character class
- Functions that do mathematical computation usually work on objects with a numeric class


Example: `sum()` applies to __numeric__, __logical__, or __complex__ class objects


- Apply `sum()` to __logical__ and __numeric__ class

```r
(x <- c(TRUE,FALSE,NA,TRUE)) # class = logical
```

```
## [1]  TRUE FALSE    NA  TRUE
```

```r
typeof(x)
```

```
## [1] "logical"
```

```r
class(x)
```

```
## [1] "logical"
```

```r
sum(x, na.rm = TRUE) 
```

```
## [1] 2
```

```r
# class = numeric
typeof(wwlist$med_inc_zip) 
```

```
## [1] "double"
```

```r
class(wwlist$med_inc_zip) 
```

```
## [1] "numeric"
```

```r
wwlist$med_inc_zip[1:5]
```

```
## [1] 92320.5 63653.0 88344.5 88408.5 82895.0
```

```r
sum(wwlist$med_inc_zip[1:5], na.rm = TRUE) 
```

```
## [1] 415621.5
```
- What happens when apply `sum()` to an object with class = __character__?

```r
typeof(wwlist$hs_city)
class(wwlist$hs_city)
wwlist$hs_city[1:5]
sum(wwlist$hs_city[1:5], na.rm = TRUE) 
```

Date functions can be applied to objects with a date-time class

- date-time objects have __type__ = numeric
- date-time objects __class__ = date or date-time

Example: `year()` function from `lubridate` package




- apply `year()` to object with __class__ = date

```r
wwlist$receive_date[1:5]
```

```
## [1] "2016-05-31" "2016-05-31" "2016-05-31" "2016-05-31" "2016-05-31"
```

```r
typeof(wwlist$receive_date)
```

```
## [1] "double"
```

```r
class(wwlist$receive_date) 
```

```
## [1] "Date"
```

```r
year(wwlist$receive_date[1:5])
```

```
## [1] 2016 2016 2016 2016 2016
```

- apply `year()` to object with __class__ = numeric

```r
typeof(wwlist$med_inc_zip) 
class(wwlist$med_inc_zip) 
year(wwlist$med_inc_zip[1:10]) 
```

Most string functions are intended to apply to objects with a __character__ class. 

- __type__ = character
- __class__ = character

Example: `tolower()` function

- syntax: `tolower(x)`
- where argument `x` is "a character vector, or an object that can be coerced to character by `as.character()`"


Apply `tolower()` to character class object

```r
str(wwlist$hs_city)
```

```
##  chr [1:268396] "Seattle" "Covington" "Everett" "Seattle" "Lake Stevens" ...
```

```r
typeof(wwlist$hs_city)
```

```
## [1] "character"
```

```r
class(wwlist$hs_city)
```

```
## [1] "character"
```

```r
wwlist$hs_city[1:6]
```

```
## [1] "Seattle"      "Covington"    "Everett"      "Seattle"      "Lake Stevens"
## [6] "Seattle"
```

```r
tolower(wwlist$hs_city[1:6])
```

```
## [1] "seattle"      "covington"    "everett"      "seattle"      "lake stevens"
## [6] "seattle"
```

#### Class and object-oriented programming

R is an object-oriented programming language

\medskip
Definition of object oriented programming from this [LINK](https://www.webopedia.com/TERM/O/object_oriented_programming_OOP.html)

\medskip

> "Object-oriented programming (OOP) refers to a type of computer programming in which programmers define not only the data type of a data structure, but also the types of operations (functions) that can be applied to the data structure."

\medskip

Object __class__ is fundamental to object oriented programming because:

- object class determines which functions can be applied to the object
- object class also determines what those functions do to the object
    - e.g., a specific function might do one thing to objects of __class__ A and another thing to objects of __class__ B
    - What a function does to objects of different class is determined by whoever wrote the function

\medskip
Many different object classes exist in R

- You can also create our own classes
    - Example: the `labelled` class is an object class created by Hadley Wickham when he created the `haven` package
- In this course we will work with classes that have been created by others


## Names and values

TEXT

# Iteration

## Introduction and prereqs

## Loop basics



# Conditional execution

TEXT

# Function basics

TEXT
