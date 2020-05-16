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
## -- Attaching packages ------------------------------------------------------------------------ tidyverse 1.2.1 --
```

```
## v ggplot2 3.2.1     v purrr   0.3.3
## v tibble  2.1.3     v dplyr   0.8.3
## v tidyr   1.0.0     v stringr 1.4.0
## v readr   1.3.1     v forcats 0.4.0
```

```
## -- Conflicts --------------------------------------------------------------------------- tidyverse_conflicts() --
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

- All the elements (i.e., variables) must be __vectors__ (or __lists__) with the same __length__
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

<br>
<details><summary>**Identify and coerce vector type**</summary>

Identify and coerce vector type

Identifying vector __type__, Grolemund and Wickham:

- "Sometimes you want to do different things based on the type of vector. One option is to use `typeof()`. Another is to use a test function which returns a `TRUE` or `FALSE`"

[NOTE TO CRYSTAL/PATRICIA/OZAN] - REPLACE ALL `is_*` functions with `is.*` functions because `is_*` have been deprecated. NOTE THAT `is_*` AND `is.*` DIFFER BECAUSE `is_*` WAS MEANT TO CAPTURE OBJECT TYPE WHILE `is.*` IS A SOME COMBINATION OF TYPE AND CLASS (I THINK), SO CONTENT OF BELOW SUB-SECTION WILL HAVE TO BE MODIFIED]

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
is.numeric(c(5,6,7))
```

```
## [1] TRUE
```

Functions for converting/coercing between vector types:

- `as.logical()`: Convert to `logical`
- `as.numeric()`: Convert to `numeric`
- `as.integer()`: Convert to `integer`
- `as.character()`: Convert to `character`
- `as.list()`: Convert to `list`
- `as.data.frame()`: Convert to `data.frame`

**Example**: Using `as.logical()` to convert to `logical`

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


**Example**: Using `as.numeric()` to convert to `numeric`

Logical vector coerced to numeric vector:


```r
# FALSE is mapped to 0 and TRUE is mapped to 1
as.numeric(c(FALSE, TRUE))
```

```
## [1] 0 1
```

</details>

## Subset/extract elements


"Subsetting" refers to isolating particular elements of an object 

\medskip
Subsetting operators can be used to select/exclude elements (e.g., variables, observations)

- there are three subsetting operators: `[]`, `$` , `[[]]` 
- these operators function differently based on vector types (e.g, atomic vectors, lists, data frames)

Wichham refers to number of "dimensions" in R objects

- An atomic vector is a 1-dimensional object that contains n elements

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


####  Way #1. Using positive integers to return elements (subset atomic vectors using [])

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


#### Way #2. Using negative integers to exclude elements at specified positions (subset atomic vectors using [])

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


#### Way #3. Using logicals to return elements where corresponding logical is `TRUE` (subset atomic vectors using [])


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


#### Way #4. Empty `[]` returns original vector (subset atomic vectors using [])



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

#### Way #5.  Zero vector [0] (subset atomic vectors using [])

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


#### Way #6. If vector is named, character vectors to return elements with matching names (subset atomic vectors using [])


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

Examples

```r
names(df_event)
```

```
##  [1] "instnm"               "univ_id"              "instst"              
##  [4] "pid"                  "event_date"           "event_type"          
##  [7] "zip"                  "school_id"            "ipeds_id"            
## [10] "event_state"          "event_inst"           "med_inc"             
## [13] "pop_total"            "pct_white_zip"        "pct_black_zip"       
## [16] "pct_asian_zip"        "pct_hispanic_zip"     "pct_amerindian_zip"  
## [19] "pct_nativehawaii_zip" "pct_tworaces_zip"     "pct_otherrace_zip"   
## [22] "fr_lunch"             "titlei_status_pub"    "total_12"            
## [25] "school_type_pri"      "school_type_pub"      "g12offered"          
## [28] "g12"                  "total_students_pub"   "total_students_pri"  
## [31] "event_name"           "event_location_name"  "event_datetime_start"
```

```r
#extract elements 1 through 4 (elements=columns=variables)
df_event[1:4]
```

```
## # A tibble: 18,680 x 4
##    instnm      univ_id instst   pid
##    <chr>         <int> <chr>  <int>
##  1 UM Amherst   166629 MA     57570
##  2 UM Amherst   166629 MA     56984
##  3 UM Amherst   166629 MA     57105
##  4 UM Amherst   166629 MA     57118
##  5 Stony Brook  196097 NY     16281
##  6 USCC         218663 SC      8608
##  7 UM Amherst   166629 MA     56898
##  8 UM Amherst   166629 MA     56933
##  9 UM Amherst   166629 MA     56940
## 10 UM Amherst   166629 MA     57030
## # ... with 18,670 more rows
```

```r
df_event[c(1,2,3,4)]
```

```
## # A tibble: 18,680 x 4
##    instnm      univ_id instst   pid
##    <chr>         <int> <chr>  <int>
##  1 UM Amherst   166629 MA     57570
##  2 UM Amherst   166629 MA     56984
##  3 UM Amherst   166629 MA     57105
##  4 UM Amherst   166629 MA     57118
##  5 Stony Brook  196097 NY     16281
##  6 USCC         218663 SC      8608
##  7 UM Amherst   166629 MA     56898
##  8 UM Amherst   166629 MA     56933
##  9 UM Amherst   166629 MA     56940
## 10 UM Amherst   166629 MA     57030
## # ... with 18,670 more rows
```

```r
str(df_event[1:4])
```

```
## Classes 'tbl_df', 'tbl' and 'data.frame':	18680 obs. of  4 variables:
##  $ instnm : chr  "UM Amherst" "UM Amherst" "UM Amherst" "UM Amherst" ...
##  $ univ_id: int  166629 166629 166629 166629 196097 218663 166629 166629 166629 166629 ...
##  $ instst : chr  "MA" "MA" "MA" "MA" ...
##  $ pid    : int  57570 56984 57105 57118 16281 8608 56898 56933 56940 57030 ...
```

```r
#extract columns 13 and 7
df_event[c(13,7)]
```

```
## # A tibble: 18,680 x 2
##    pop_total zip  
##        <dbl> <chr>
##  1     29970 01002
##  2     14888 01007
##  3     30629 01020
##  4     30629 01020
##  5     17872 01027
##  6     17872 01027
##  7     17872 01027
##  8      6310 01033
##  9      6310 01033
## 10      2853 01038
## # ... with 18,670 more rows
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

> If list x is a train carrying objects, then x[[5]] is the object in car 5; x[4:6] is a train of cars 4-6.

[![](https://d33wubrfki0l68.cloudfront.net/1f648d451974f0ed313347b78ba653891cf59b21/8185b/diagrams/subsetting/train.png)](https://adv-r.hadley.nz/subsetting.html#subset-single)

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


[![](https://d33wubrfki0l68.cloudfront.net/aea9600956ff6fbbc29d8bd49124cca46c5cb95c/28eaa/diagrams/subsetting/train-single.png)](https://adv-r.hadley.nz/subsetting.html#subset-single)

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


## Attributes and class [SKIP]

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


## Names and values [EMPTY]

## Prereq functions/concepts

Several functions and concepts are used frequently when creating loops and/or functions

### Sequences

(Loose) definition

- a sequence is a list of numbers in ascending or descending order

Creating sequences using colon operator

```r
-5:5
```

```
##  [1] -5 -4 -3 -2 -1  0  1  2  3  4  5
```

```r
5:-5
```

```
##  [1]  5  4  3  2  1  0 -1 -2 -3 -4 -5
```
Creating sequences using `seq()` function

- basic syntax: 

```r
seq(from = 1, to = 1, by = ((to - from)/(length.out - 1)),
    length.out = NULL, along.with = NULL, ...)
```
- examples:

```r
seq(10,15)
```

```
## [1] 10 11 12 13 14 15
```

```r
seq(from=10,to=15,by=1)
```

```
## [1] 10 11 12 13 14 15
```

```r
seq(from=100,to=150,by=10)
```

```
## [1] 100 110 120 130 140 150
```
### Length of vectors

#### Length of atomic vectors

\medskip 
Definition: __length__ of an object is its number of elements

\medskip 
Length of vectors, using `length()` function

```r
x <- c(1,2,3,4,"ha ha"); length(x)
```

```
## [1] 5
```

```r
y <- seq(1,10); length(y)
```

```
## [1] 10
```

```r
z <- c(seq(1,10),"ho ho"); length(z)
```

```
## [1] 11
```
Once vector length known, isolate element contents based on position number using `[]`

```r
x[5]
```

```
## [1] "ha ha"
```

```r
z[1]
```

```
## [1] "1"
```
For atomic vectors, applying `[[]]` to vector gives same result as  `[]`

```r
x[[5]]
```

```
## [1] "ha ha"
```

```r
z[[1]]
```

```
## [1] "1"
```
#### Length of lists

\medskip 
Definition: __length__ of an object is its number of elements

- Create data frame `df_bama`

```r
#load(url("https://github.com/ozanj/rclass/raw/master/data/recruiting/recruit_event_somevars.RData"))

df_bama <- df_event %>% arrange(univ_id,event_date) %>% 
  select(instnm,univ_id,event_date,event_type,event_state,zip,med_inc) %>% 
  filter(row_number()<6)

str(df_bama)
```

```
## Classes 'tbl_df', 'tbl' and 'data.frame':	5 obs. of  7 variables:
##  $ instnm     : chr  "Bama" "Bama" "Bama" "Bama" ...
##  $ univ_id    : int  100751 100751 100751 100751 100751
##  $ event_date : Date, format: "2017-01-10" "2017-01-11" ...
##  $ event_type : chr  "private hs" "2yr college" "other" "private hs" ...
##  $ event_state: chr  "TX" "AL" "AL" "TX" ...
##  $ zip        : chr  "75001" "35010" "35044" "75244" ...
##  $ med_inc    : num  77380 39134 38272 89203 127972
```

```r
typeof(df_bama); length(df_bama)
```

```
## [1] "list"
```

```
## [1] 7
```



Once list length known, isolate element contents based on position number using `[]` or `[[]]`

- subset one element of list with `[]` yields list w/ length==1

```r
typeof(df_bama[7]); length(df_bama[7])
```

```
## [1] "list"
```

```
## [1] 1
```
- subset one element of list with `[[]]` yields vector w length== # rows

```r
df_bama[[7]]; typeof(df_bama[[7]]); length(df_bama[[7]])
```

```
## [1]  77380  39134  38272  89203 127972
```

```
## [1] "double"
```

```
## [1] 5
```

subset one element of list with `$` is same as `[[]]`

```r
df_bama$med_inc; typeof(df_bama$med_inc); length(df_bama$med_inc)
```

```
## [1]  77380  39134  38272  89203 127972
```

```
## [1] "double"
```

```
## [1] 5
```

### Combine sequence and length

\medskip

When writing loops, very common to create a sequence from 1 to the length (i.e., number of elements) of an object

\medskip Here, we do this with a vector object

```r
(x <- c("a","b","c","d","e"))
```

```
## [1] "a" "b" "c" "d" "e"
```

```r
length(x)
```

```
## [1] 5
```

```r
1:length(x)
```

```
## [1] 1 2 3 4 5
```

```r
seq(from=1,to=length(x),by=1)
```

```
## [1] 1 2 3 4 5
```

Can do same thing with list object

```r
length(df_bama)
```

```
## [1] 7
```

```r
1:length(df_bama)
```

```
## [1] 1 2 3 4 5 6 7
```

```r
seq(2,length(df_bama))
```

```
## [1] 2 3 4 5 6 7
```


### Directories/paths [SKIP]

Working directory

- When you run an R code chunk in a .Rmd file, the default working directory is the folder where the .Rmd is saved

```r
getwd()
```

```
## [1] "C:/Users/ozanj/Documents/rclass2/lectures/programming"
```
- When you create a "Project" the default working directory in the R console and in an R script is the directory where the project is saved.

When you will be working with both .Rmd files and with R scripts and/or the R console, it is helpful to create a project in the same directory where the .Rmd files live. This way, the default working directory is the same regardless of whether you are using .Rmd, .R script, or the R console

#### Create and delete directories

`dir.create()` creates new directories

- Syntax (with defaults): 
  - `dir.create(path, showWarnings = TRUE, recursive = FALSE)`
- Arguments  
  - `path`: "a character vector containing a single path name"
  - `showWarnings`: "logical; should the warnings on failure be shown?" default equals `TRUE`
  - `recursive`: "Should elements of the path other than the last be created?"
    - That is, will `dir.create()` create the file path `new_directory/new_sub_directory` if neither `new_directory` nor `new_sub_directory` exist?
    - default equals `FALSE`
- Note:
  - if directory you create already exists, you will get a warning, but this won't cause the code to stop running
  - specify `showWarnings = FALSE` to omit warnings
<br>

Let's create a new sub-directory named "data" within our current working directory



```r
getwd()
```

```
## [1] "C:/Users/ozanj/Documents/rclass2/lectures/programming"
```

```r
list.files()
```

```
##  [1] "data"                     "hd2014.csv"              
##  [3] "hd2017.csv"               "ipeds_file_list.txt"     
##  [5] "loop_example_ipeds.R"     "loop_examples.Rmd"       
##  [7] "programming.Rproj"        "programming_lecture.html"
##  [9] "programming_lecture.md"   "programming_lecture.Rmd"
```

```r
#delete directory if it exists [comment out]
  unlink(x = "data", recursive = TRUE) # recursive = TRUE allows you to delete existing directory


#create directory
dir.create(path = "data", showWarnings = FALSE) # showWarnings = FALSE omits warnings if directory already exists
list.files()
```

```
##  [1] "data"                     "hd2014.csv"              
##  [3] "hd2017.csv"               "ipeds_file_list.txt"     
##  [5] "loop_example_ipeds.R"     "loop_examples.Rmd"       
##  [7] "programming.Rproj"        "programming_lecture.html"
##  [9] "programming_lecture.md"   "programming_lecture.Rmd"
```

`unlink()` deletes the file(s) or directories specified by argument `x`

- Syntax (with defaults):
  - `unlink(x, recursive = FALSE, force = FALSE)`
- Arguments:
  - `x`:	"a character vector with the names of the file(s) or directories to be deleted."
  - `recursive`: "logical. Should directories be deleted recursively?"
    - __NOTE__: "If recursive = `FALSE` directories are not deleted, not even empty ones."
  - `force`: "logical. Should permissions be changed (if possible) to allow the file or directory to be removed?"


#### `file.path()` creates file paths


Use the `file.path()` argument to change file paths and/or to create objects representing file paths you will use

What Ben Skinner says in [his R programming course](https://edquant.github.io/past/2020/spring/edh7916/lessons/organizing.html)

> Rather than hard-coding / rewriting all the paths in the script, we can save the paths in an object. We use the file.path() command because it is smart. Some computer operating systems use forward slashes, `/`, for their file paths; others use backslashes, `\`. Rather than try to guess or assume what operating system future users will use, we can use R’s function, file.path(), to check the current operating system and build the paths correctly for us.

`file.path()` function: 

- Description:
  - "Construct the path to a file from components in a platform-independent way" (from `file.path()` help file)
- Syntax:
  - `file.path(..., fsep = .Platform$file.sep)`
- Arguments
  - `...` (the `dot-dot-dot` argument): character vectors separates by commas that represent each layer of the file path
  - `fsep`: the "path separator to use" 
    - the default value (`fsep = .Platform$file.sep`) will get this right

Let's create an object representing the sub-directory `data` we just created

```r
#create object representing file path
data_dir <- file.path(".", "data")
data_dir
```

```
## [1] "./data"
```

```r
getwd()
```

```
## [1] "C:/Users/ozanj/Documents/rclass2/lectures/programming"
```

```r
#change working directory to "data" sub-directory
setwd(file.path(data_dir))
getwd()
```

```
## [1] "C:/Users/ozanj/Documents/rclass2/lectures/programming/data"
```
Note that working directory for R code chunks resets to folder where .Rmd file is saved

```r
getwd()
```

```
## [1] "C:/Users/ozanj/Documents/rclass2/lectures/programming"
```

# Iteration

DEFINE ITERATION

THEN DEFINE LOOPS AS MOST COMMON WAY TO ITERATE



## Loop basics

### Simple loop example

\medskip
What are loops?: __Loops__ execute some set of commands multiple times

- We build loops using the `for()` function
- Each time the loop executes the set of commands is an __iteration__
- The below loop iterates 4 times

__Example__

- Create loop that prints each value of vector `c(1,2,3,4)`, one at a time

```r
c(1,2,3,4)
```

```
## [1] 1 2 3 4
```

```r
for(i in c(1,2,3,4)) { # Loop sequence
  print(i) # Loop body
}
```

```
## [1] 1
## [1] 2
## [1] 3
## [1] 4
```
I use loops to perform practical tasks more efficienlty (e.g., read in data)

- But we'll introduce loop concepts by doing things that aren't very useful

### Components of a loop


```r
for(i in c(1,2,3,4)) { # Loop sequence
  print(i) # Loop body
}
```

```
## [1] 1
## [1] 2
## [1] 3
## [1] 4
```


Components of a loop

1. __Sequence__. Determines what to "loop over" (e.g., from 1 to 4 by 1)
    - sequence in above loop is `for(i in c(1,2,3,4))`
    - this creates a temporary/local object named `i`; could name it anything
        - `i` will no longer exist after the loop is finished running
    - each iteration of loop will assign a different value to `i`
    - c(1,2,3,4) is the set of values that will be assigned to `i` 
          - in first iteration, value of `i` is `1`
          - in second iteration, value of `i` is `2`, etc.
2. __Body__. What commands to execute for each iteration through the loop
    - Body in above loop is `print(i)`
    - Each time (i.e., iteration) through the loop, body prints the value of object `i`

### Using `cat()` to print value of sequence var for each iteration

\medskip
__When building a loop, I always include a line like `cat("z=",z, fill=TRUE)` to help me understand what loop is doing__

\medskip
Below two loops are essentially the same; I prefer second approach. Why?:

- Writing name of sequence var object (here `z`) and seeing value of sequence var object for each iteration helps me understand loop better

```r
for(z in c(1,2,3)) { # Loop sequence
  print(z) # Loop body
}
```

```
## [1] 1
## [1] 2
## [1] 3
```

```r
for(z in c(1,2,3)) { # Loop sequence
  cat("object z=",z, fill=TRUE) # "fill=TRUE" forces line break after each iteration
}
```

```
## object z= 1
## object z= 2
## object z= 3
```

Without `fill=TRUE` [not recommended]

```r
for(z in c(1,2,3)) { # Loop sequence
  cat("object z=",z) # "Loop body
}
```

```
## object z= 1object z= 2object z= 3
```

### Components of a loop

\medskip

Note that these three loops all do the same thing

- __Loop body__ is the same in each loop
- __Loop sequence__ written slightly differently in each loop


```r
for(z in c(1,2,3)) { # Loop sequence
  cat("object z=",z, fill=TRUE) # Loop body
}
```

```
## object z= 1
## object z= 2
## object z= 3
```

```r
for(z in 1:3) { # Loop sequence
  cat("object z=",z, fill=TRUE) # Loop body
}
```

```
## object z= 1
## object z= 2
## object z= 3
```

```r
num_sequence <- 1:3
for(z in num_sequence) { # Loop sequence
  cat("object z=",z, fill=TRUE) # Loop body
}
```

```
## object z= 1
## object z= 2
## object z= 3
```


### Student exercise

Try on your own or just follow along.

\medskip

__Task__

1. Create a numeric vector that has year of birth of members of your family
    - you decide who to include
    - e.g., `birth_years <- c(1944,1950,1981,2016)`
2. Write a loop that calculates current year minus birth year and prints this number for each member of your family
    - Within this loop, you will create a new variable that calculates current year minus birth year

\medskip

Note: multiple correct ways to complete this task

### Student exercise [SOLUTION]

1. Create a numeric vector that has year of birth of members of your family (you decide who to include)
2. Write a loop that calculates current year minus birth year and prints this number for each member of your family 


```r
birth_years <- c(1944,1950,1981,2016)
birth_years
```

```
## [1] 1944 1950 1981 2016
```

```r
for(y in birth_years) { # Loop sequence
  cat("object y=",y, fill=TRUE) # Loop body
  z <- 2018-y
  cat("value of",y,"minus",2018,"is",z, fill=TRUE)
}
```

```
## object y= 1944
## value of 1944 minus 2018 is 74
## object y= 1950
## value of 1950 minus 2018 is 68
## object y= 1981
## value of 1981 minus 2018 is 37
## object y= 2016
## value of 2016 minus 2018 is 2
```

## When to write a loop; recipe for writing loops

### When to write a loop

__Broadly, rationale for writing loop__:

- Do not duplicate code
- Can make changes to code in one place rather than many

\medskip
__When to write a loop__:

- Grolemund and Wickham say __don't copy and paste more than twice__
- If you find yourself doing this, consider writing a loop or function

\medskip
__Don't worry about knowing all the situations you should write a loop__

- Rather, you'll be creating analysis dataset or analyzing data and you will notice there is some task that you are repeating over and over
- Then you'll think "oh, I should write a loop or function for this"

### Recipe for how to write loop

The general recipe for how to write a loop:

1. Complete the task for one instance outside a loop (this is akin to writing the __body__ of the loop)

2. Write the __sequence__ 

3. Which parts of the body need to change with each iteration

4. _if_ you are creating a new object store output of the loop, create this outside of the loop

5. Construct the loop

<br>
<details><summary>**When to write a loop vs a functions [SKIP]**</summary>

Usually obvious when you are duplicating code, but unclear whether you should write a loop or whether you should write a function.

- Often, a repeated task can be completed with a loop or a function

In my experience, loops are better for repeated tasks when the individual tasks are __very__ similar to one another

- e.g., a loop that reads in data sets from individual years; each dataset you read in differs only by directory and name
- e.g., a loop that converts negative values to `NA` for a set of variables

Because functions can have many arguments, functions are better when the individual tasks differ substantially from one another 

- Example: function that runs regression and creates formatted results table
    - function allows you to specify (as function arguments): dependent variable; independent variables; what model to run, etc.

__Note__

- Can embed loops within functions; can call functions within loops
- But for now, just try to understand basics of functions and loops

</details>

## Three ways to loop over a vector (atomic vector or a list)

\medskip

There are 3 ways to loop over elements of an object

1. __Loop over the elements__ [approach we have used so far]
2. __Loop over names of the elements__
3. __Loop over numeric indices associated with element position__ [approach recommended by Grolemnund and Wickham]

Will demonstrate 3 approaches on a named atomic vector and list/data frame

- Create named vector

```r
vec=c("a"=5,"b"=-10,"c"=30)
vec
```

```
##   a   b   c 
##   5 -10  30
```
- Create data frame with fictitious data, 3 columns (vars) and 4 rows (obs)

```r
set.seed(12345) # so we all get the same variable values
df <- tibble(a = rnorm(4),b = rnorm(4),c = rnorm(4))
str(df)
```

```
## Classes 'tbl_df', 'tbl' and 'data.frame':	4 obs. of  3 variables:
##  $ a: num  0.586 0.709 -0.109 -0.453
##  $ b: num  0.606 -1.818 0.63 -0.276
##  $ c: num  -0.284 -0.919 -0.116 1.817
```

### Approach 1: loop over elements of object [object=atomic vector]

\medskip

- \medskip __sequence__ syntax: `for (i in object_name)`
    - Sequence iterates through each element of the object
    - That is, __sequence iterates through _value_ of each element, rather than _name_ or _position_ of element__
- in __body__.
    - value of `i` is equal to the contents of the `ith` element of the object
    

```r
vec # print atomic vector object
```

```
##   a   b   c 
##   5 -10  30
```

```r
for (i in vec) {
  cat("value of object i=",i, fill=TRUE) 
  cat("object i has: type=",typeof(i),"; length=",length(i),"; class=",class(i),
      "; attributes=",attributes(i),"\n",sep="",fill=TRUE) # "\n" adds line break
}
```

```
## value of object i= 5
## object i has: type=double; length=1; class=numeric; attributes=
## 
## value of object i= -10
## object i has: type=double; length=1; class=numeric; attributes=
## 
## value of object i= 30
## object i has: type=double; length=1; class=numeric; attributes=
```

- \medskip __sequence__ syntax: `for (i in object_name)`
    - Sequence iterates through each element of the object
    - That is, __sequence iterates through _value_ of each element__
- in __body__: value of `i` is equal to __contents__ of `ith` element of object


```r
df # print list/data frame object
```

```
## # A tibble: 4 x 3
##        a      b      c
##    <dbl>  <dbl>  <dbl>
## 1  0.586  0.606 -0.284
## 2  0.709 -1.82  -0.919
## 3 -0.109  0.630 -0.116
## 4 -0.453 -0.276  1.82
```

```r
#class(df) 
#attributes(df)
for (i in df) {
  cat("value of object i=",i, fill=TRUE)
  cat("object type=",typeof(i),"; length=",length(i),"; class=",class(i),
      "; attributes=",attributes(i),"\n",sep="",fill=TRUE)
}
```

```
## value of object i= 0.5855288 0.709466 -0.1093033 -0.4534972
## object type=double; length=4; class=numeric; attributes=
## 
## value of object i= 0.6058875 -1.817956 0.6300986 -0.2761841
## object type=double; length=4; class=numeric; attributes=
## 
## value of object i= -0.2841597 -0.919322 -0.1162478 1.817312
## object type=double; length=4; class=numeric; attributes=
```

__Example task__:

- calculate mean value of each element of list object `df`


```r
df # print list/data frame object
```

```
## # A tibble: 4 x 3
##        a      b      c
##    <dbl>  <dbl>  <dbl>
## 1  0.586  0.606 -0.284
## 2  0.709 -1.82  -0.919
## 3 -0.109  0.630 -0.116
## 4 -0.453 -0.276  1.82
```

```r
for (i in df) {
  # sequence
  cat("value of object i=",i, fill=TRUE)
  cat("mean value of object i=",mean(i, na.rm = TRUE), "\n", fill=TRUE)
  
} 
```

```
## value of object i= 0.5855288 0.709466 -0.1093033 -0.4534972
## mean value of object i= 0.1830486 
## 
## value of object i= 0.6058875 -1.817956 0.6300986 -0.2761841
## mean value of object i= -0.2145385 
## 
## value of object i= -0.2841597 -0.919322 -0.1162478 1.817312
## mean value of object i= 0.1243956
```
### Approach 2: loop over names of object elements

To use this approach, elements in object must have name attributes

__sequence__ syntax: `for (i in names(object_name))`

- Sequence iterates through the _name_ of each element in object

in __body__, value of `i` is equal to _name_ of `ith` element in object

- Access element contents using `object_name[i]`
    - same object type as `object_name`; retains attributes (e.g., _name_)
- Access element contents using `object_name[[i]]`
    - removes level of hierarchy, thereby removing attributes
    - Approach recommended by Wickham because isolates value of element

Example: Object= atomic vector

```r
vec  # print atomic vector object
```

```
##   a   b   c 
##   5 -10  30
```

```r
names(vec)
```

```
## [1] "a" "b" "c"
```


```r
for (i in names(vec)) {
  cat("\n","value of object i=",i,"; type=",typeof(i),sep="",fill=TRUE)
  print(str(vec[i])) # "Access element contents using []"
  print(str(vec[[i]])) # "Access element contents using [[]]"
}
```

loop over names of object elements [object = list]

\medskip

__sequence__ syntax: `for (i in names(object_name))`

- Sequence iterates through the _name_ of each element in object

in __body__, value of `i` is equal to _name_ of `ith` element in object

- Access element contents using `object_name[i]`
    - Same object type as `object_name`; retains attributes (e.g., _name_)
- Access element contents using `object_name[[i]]`
    - Removes level of hierarchy, thereby removing attributes
    - Approach recommended by Wickham because isolates value of element

\medskip

Example, object is a list

```r
names(df)
```

```
## [1] "a" "b" "c"
```


```r
for (i in names(df)) {
  cat("\n","value of object i=",i,"; type=",typeof(i),sep="",fill=TRUE)
  print(str(df[i])) # "Access element contents using []"
  print(str(df[[i]])) # "Access element contents using [[]]"
}
```

__Example task__: calculate mean value of each element of list object `df`, using `[[]]` to access element contents


```r
str(df)
```

```
## Classes 'tbl_df', 'tbl' and 'data.frame':	4 obs. of  3 variables:
##  $ a: num  0.586 0.709 -0.109 -0.453
##  $ b: num  0.606 -1.818 0.63 -0.276
##  $ c: num  -0.284 -0.919 -0.116 1.817
```

```r
for (i in names(df)) {
  cat("mean of element named",i,"is",mean(df[[i]], na.rm = TRUE), fill=TRUE)
}
```

```
## mean of element named a is 0.1830486
## mean of element named b is -0.2145385
## mean of element named c is 0.1243956
```

What if we try to complete task using , `[]` to access element contents?

```r
for (i in names(df)) {
  cat("mean of element named",i,"is",mean(df[i],na.rm = TRUE), fill=TRUE)
  #print(typeof(df[i]))
  #print(class(df[i]))  
}
#?mean # mean function only works for particular *classes* of objects
```
### Approach 3: Loop over numeric indices of element position

\medskip

First explain sequence syntax, using atomic vector `vec` as object

- __sequence__ syntax: `for (i in 1:length(object_name))`


```r
vec # print named atomic vector vec
```

```
##   a   b   c 
##   5 -10  30
```

```r
length(vec)
```

```
## [1] 3
```

```r
1:length(vec)
```

```
## [1] 1 2 3
```

```r
for (i in 1:length(vec)) { # loop sequence
  cat("value of object i=",i,fill=TRUE) # loop body
}
```

```
## value of object i= 1
## value of object i= 2
## value of object i= 3
```
Note: These two approaches yield same result as above

```r
for (i in c(1,2,3)) {
  cat("value of object i=",i,fill=TRUE)
}
for (i in 1:3) {
  cat("value of object i=",i,fill=TRUE)
}
```

\medskip

Loop over element position number: Simple sequence syntax

```r
for (i in 1:length(vec)) {
  cat("value of object i=",i,fill=TRUE)
}
```

```
## value of object i= 1
## value of object i= 2
## value of object i= 3
```

__Wickham's preferred sequence syntax__: `for (i in seq_along(object_name))`

- `seq_along(x)` function returns a sequence from 1 value of `length(x)`

```r
length(vec)
```

```
## [1] 3
```

```r
seq_along(vec)
```

```
## [1] 1 2 3
```

```r
for (i in seq_along(vec)) {
  cat("value of object i=",i,fill=TRUE)
}
```

```
## value of object i= 1
## value of object i= 2
## value of object i= 3
```

__sequence__ syntax: `for (i in 1:length(object_name))` __OR__ `for (i in seq_along(object_name))`

- Sequence iterates through _position number_ of each element in the object

In __body__, value of `i` equals the _position number_ of `ith` element in object

- Access element contents using `object_name[i]`
    - Same object type as `object_name`; retains attributes (e.g., _name_)
- Access element contents using `object_name[[i]]` [RECOMMENDED]
    - Removes level of hierarchy, thereby removing attributes

__Example, object is atomic vector__

```r
vec
```

```
##   a   b   c 
##   5 -10  30
```


```r
for (i in 1:length(vec)) {
  cat("\n","value of object i=",i,"; type=",typeof(i),sep="",fill=TRUE)
  print(str(vec[i])) # "Access element contents using []"
  print(str(vec[[i]])) # "Access element contents using [[]]"
}
```

__Example, object is a list__

```r
df %>% head(n=3)
```

```
## # A tibble: 3 x 3
##        a      b      c
##    <dbl>  <dbl>  <dbl>
## 1  0.586  0.606 -0.284
## 2  0.709 -1.82  -0.919
## 3 -0.109  0.630 -0.116
```


```r
for (i in 1:length(df)) {
  cat("\n","value of object i=",i,"; type=",typeof(i),sep="",fill=TRUE)
  print(str(df[i])) # "Access element contents using []"
  print(str(df[[i]])) # "Access element contents using [[]]"
}
```

__Example task__:

- Calculate mean value of each element of list object `df`, using `for (i in seq_along(df))` to create sequence and using `[[]]` to access element contents


```r
for (i in seq_along(df)) {
  cat("mean of element named",i,"is",mean(df[[i]], na.rm = TRUE), fill=TRUE)
}
```

```
## mean of element named 1 is 0.1830486
## mean of element named 2 is -0.2145385
## mean of element named 3 is 0.1243956
```

What happens if we try to complete task using , using `[]` to access element contents?

```r
for (i in seq_along(df)) {
  cat("mean of element named",i,"is",mean(df[i],na.rm = TRUE), fill=TRUE)
  #print(typeof(df[i]))
  #print(class(df[i]))  
}
#?mean # mean(object) requires object to be numeric or logical
```
__When looping over numeric indices, you can extract element names based on element position__

- First, let's experiment w/ `attributes()` and `names()` functions

`attributes()` function [output omitted]

```r
attributes(df)
attributes(df[1]) # not null
attributes(df[[1]]) # null: removing level of hierarchy removes attributes
```

`names()` functions

```r
names(df)
```

```
## [1] "a" "b" "c"
```

```r
names(df[1]) # not null
```

```
## [1] "a"
```

```r
names(df[[1]]) # null: object df[[1]] has no attributes; just values
```

```
## NULL
```

```r
names(df)[[1]] # not null: we extract names of df, then select first element
```

```
## [1] "a"
```

__When looping over numeric indices, you can extract element names based on element position__

- First, experiment w/ `names()` function

```r
names(df)
```

```
## [1] "a" "b" "c"
```

```r
names(df)[[1]] # not null: we extract names of df, then select first element
```

```
## [1] "a"
```

- Second, apply what we learned to loop

```r
for (i in seq_along(df)) {
  #print(names(df)[[i]])
  cat("i=",i,"; names=",names(df)[[i]],sep="",fill=TRUE)
}
```

```
## i=1; names=a
## i=2; names=b
## i=3; names=c
```


### Summary: Three ways to loop over object

1. Loop over elements
1. Loop over element names
1. Loop over numeric indices of element position

Why Wickham prefers "loop over numeric indices of element" approach [3]:

- given element position number, can extract element name[2] and value[1]



```r
for (i in seq_along(df)) {
  cat("i=",i,sep="",fill=TRUE)
  
  name <- names(df)[[i]] # value of object "name" is what we loop over in approach 2
  cat("name=",name,sep="",fill=TRUE)
  
  value <- df[[i]] # value of object "value" is what we loop over in approach 1
  cat("value=",value,"\n",sep=" ",fill=TRUE)
}
```

```
## i=1
## name=a
## value= 0.5855288 0.709466 -0.1093033 -0.4534972 
## 
## i=2
## name=b
## value= 0.6058875 -1.817956 0.6300986 -0.2761841 
## 
## i=3
## name=c
## value= -0.2841597 -0.919322 -0.1162478 1.817312
```

## Modifying vs. Creating new object

###  START HERE FRIDAY 
### Modify object or create new object

Grolemund and Wickham differentiate between two types of tasks loops accomplish: (1) modify existing object; and (2) create new object

1. __Modify an existing object__
    - example: looping through a set of variables in a data frame to:
        - Modifying these variables OR
        - Creating new variables (within the existing data frame object)
    - When writing loops in Stata/SAS/SPSS, we are usually modifying an existing object because these programs typically only have one object - a dataset - open at a time)    
2. __Create a new object__
    - Example: Create an object that has summary statistics for each variable; this object will be the basis for a table or graph
    - Often the new object will be a vector of results based on looping through elements of a data frame
    - In R (as opposed to Stata/SAS/SPSS) creating a new object is very common because R can hold many objects at the same time

## Loops that create new object

### Creating a new object

So far our loops have two components: 

1. sequence
1. body

When we create a new object to store the results of a loop, our loops have three components

1. sequence
1. body
1. output
    - this is the new object that will store results created from your loop

Grolemund and Wickham recommend creating this new object __prior__ to writing the loop (rather than creating the new object within the loop)

> "Before you start loop...allocate sufficient space for the output. This is very important for efficiency: if you grow the for loop at each iteration using c() (for example), your for loop will be very slow."

### Creating a new object

Create sample data frame named `df`

```r
set.seed(54321)
df <- tibble(a = rnorm(10),b = rnorm(10),c = rnorm(10),d = rnorm(10))
```

__Task__: 

- Using the data frame `df`, which contains data on four numeric variables, create a new object that contains the mean value of each variable


In a previous example, we calculated mean for each variable

```r
for (i in seq_along(df)) {
  cat("mean of element named",i,"is",mean(df[[i]], na.rm = TRUE),fill=TRUE)
}
```

```
## mean of element named 1 is -0.2646042
## mean of element named 2 is 0.6025297
## mean of element named 3 is 0.0349128
## mean of element named 4 is -0.4557522
```
Now we just have to create an object to store these results

### Creating a new object

__Task__: Create a new object that contains mean value of each variable in `df`

\medskip
Wickham recommends creating new object __prior__ to creating loop

- You must specify type and length of new object
- New object will contain mean for each variable; should be numeric vector with number of elements (length) equal to number of variables in `df`

\medskip
Create object to hold output; we'll name this object `output`

```r
output <- vector("double", ncol(df)) # create object
typeof(output)
```

```
## [1] "double"
```

```r
length(output)
```

```
## [1] 4
```

```r
length(df)
```

```
## [1] 4
```
Create loop; use position number to assign variable means to elements of vector `output`

```r
for (i in seq_along(df)) {
  #cat("i=",i,fill=TRUE)
  output[[i]] <- mean(df[[i]], na.rm = TRUE) # mean of df[[1]] assigned to output[[1]], etc.
}
output
```

```
## [1] -0.2646042  0.6025297  0.0349128 -0.4557522
```
## Loops that modify existing object

### Example of modifying an object: z-score loop

__Task__ (from Christenson lecture):

- Write a loop that calculates z-score for a set of variables in a data frame and then  replaces the original variables with the z-score variables 

The z-score for observation _i_ is number of standard deviations from mean:

$z_i = \frac{x_i - \bar{x}}{sd(x)}$

Task: calculate z-score for first 4 observations of `df$a`

```r
(df$a[1] - mean(df$a, na.rm=TRUE))/sd(df$a, na.rm=TRUE)
```

```
## [1] 0.06413227
```

```r
(df$a[2] - mean(df$a, na.rm=TRUE))/sd(df$a, na.rm=TRUE)
```

```
## [1] -0.4964552
```

```r
(df$a[3] - mean(df$a, na.rm=TRUE))/sd(df$a, na.rm=TRUE)
```

```
## [1] -0.3886915
```

```r
(df$a[4] - mean(df$a, na.rm=TRUE))/sd(df$a, na.rm=TRUE)
```

```
## [1] -1.037147
```

### Example of modifying an object: z-score loop

__Task__: write loop that replaces variables with z-scores of those variables

\medskip

When modifying existing object, we only need to write __sequence__ and __body__

- __sequence__. 
    - data frame `df` has 4 variables and all are quantitative
    - so write a sequence that loops across each element of `df`
        - `for (i in seq_along(df))`
- __body__.
    - body of z-score function:
        - `(x - mean(x, na.rm=TRUE))/sd(x, na.rm=TRUE)`
    - Substitute `df[[i]]` for  `x`: 
        - `(df[[i]] - mean(df[[i]], na.rm=TRUE))/sd(df[[i]], na.rm=TRUE)`
    - Assign (replace) each observation the value of its z-score: 
        - `df[[i]] <- (df[[i]] - mean(df[[i]], na.rm=TRUE))/sd(df[[i]], na.rm=TRUE)`


```r
set.seed(54321)
(df <- tibble(a = rnorm(10),b = rnorm(10),c = rnorm(10),d = rnorm(10)))

for (i in seq_along(df)) {
  cat("i=",i,"; mean=",mean(df[[i]], na.rm=TRUE),"; sd=",sd(df[[i]], na.rm=TRUE),sep="",fill=TRUE)
  #print((df[[i]] - mean(df[[i]], na.rm=TRUE))/sd(df[[i]], na.rm=TRUE)) # show z-score for each obs
  df[[i]] <- (df[[i]] - mean(df[[i]], na.rm=TRUE))/sd(df[[i]], na.rm=TRUE) # modify values
}
str(df)
```

### Modify z-score loop to work with non-numeric variables

What happens if we apply our loop to the data frame `df_bama`, which has both string and numeric variables?

\medskip
Create data frame `df_bama`

```r
load(url("https://github.com/ozanj/rclass/raw/master/data/recruiting/recruit_event_somevars.RData"))
df_bama <- df_event %>% arrange(univ_id,event_date) %>% 
  select(instnm,univ_id,event_date,event_type,event_state,zip,med_inc) %>% 
  filter(row_number()<6)
str(df_bama)
```

Attempt to run loop; what went wrong?

```r
for (i in seq_along(df_bama)) {
  cat("i=",i,"; mean=",mean(df_bama[[i]], na.rm=TRUE),"; sd=",sd(df_bama[[i]], na.rm=TRUE),sep="",fill=TRUE)
  #print((df_bama[[i]] - mean(df_bama[[i]], na.rm=TRUE))/sd(df_bama[[i]], na.rm=TRUE))
  df_bama[[i]] <- (df_bama[[i]] - mean(df_bama[[i]], na.rm=TRUE))/sd(df_bama[[i]], na.rm=TRUE)
}
df_bama
```
### Modify z-score loop to work with non-numeric variables

What happens if we apply our loop to the data frame `df_bama`, which has both string and numeric variables?

\medskip

Let's modify our loop so that it only calculates z-score only for non-integer, numeric variables

```r
str(df_bama)
for (i in seq_along(df_bama)) {
  cat("i=",i,"; var name=",names(df_bama)[[i]],"; type=",typeof(df_bama[[i]]),
      "; class=",class(df_bama[[i]]),sep="",fill=TRUE)
  
  if(is.numeric(df_bama[[i]]) & (!is_integer(df_bama[[i]]))) {
    df_bama[[i]] <- (df_bama[[i]] - mean(df_bama[[i]], na.rm=TRUE))/sd(df_bama[[i]], na.rm=TRUE)
  } else {
    # do nothing
  }
}
str(df_bama)
```
### Modify object:  embed z-score loop in function [SKIP]

Recreate `df` and `df_bama` [ouput and code omitted]

\medskip

Can we embed this loop in a function that takes the data frame as an argument so we don't have to modify loop for each data frame?


```r
z_score <- function(x) {

  for (i in seq_along(x)) {
    cat("i=",i,"; var name=",names(x)[[i]],"; type=",typeof(x[[i]]),
        "; class=",class(x[[i]]),sep="",fill=TRUE)
    
    if(is.numeric(x[[i]]) & (!is_integer(x[[i]]))) {
      x[[i]] <- (x[[i]] - mean(x[[i]], na.rm=TRUE))/sd(x[[i]], na.rm=TRUE)
    } else {
       #do nothing
    }
  }
}
#apple df
df_z <- z_score(df)
df; df_z
#apply to data frame df_bama
df_bama_z <- z_score(df_bama)
df_bama; df_bama_z
```

## Practice: download IPEDS 

EXPLAIN OBJECTIVE OF EXAMPLE

PASTE RELEVANT CODE FROM R SCRIPT INTO R CODE CHUNKS OR PROVIDE LINK TO R SCRIPT


# Conditional execution

TEXT

# Function basics

TEXT
