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




# Functions




```r
library(tidyverse)
library(lubridate)
```

## What are functions

__Functions__ are pre-written bits of code that accomplish some task. 

- Functions allow you to "automate" tasks that you perform more than once
- We can call functions whenever we want to use them, again and again


Functions generally follow three sequential steps:

1. take in an __input__ object(s)
2. __process__ the input.
3. __return__.  Returns a new object, which may be a vector, data-frame, plot, etc.

We've been working with functions all quarter. 

### Functions from packages written by others

\medskip
__Example__: `length()` function counts number of elements in an object


```r
?length
```
1. __input__. takes in "R object" as the input
2. __processing__. counts the number of elements in the object
3. __return__. Returns a new object, specifically an integer atomic vector of length == 1, that indicates the number of elements in the input R object


```r
# apply length() to atomic vector
x <- c(1,2,3,4)
x
#> [1] 1 2 3 4
length(x)
#> [1] 4

# apply length() to a list that is a data frame
mpg %>% head(5)
#> # A tibble: 5 x 11
#>   manufacturer model displ  year   cyl trans      drv     cty   hwy fl    class 
#>   <chr>        <chr> <dbl> <int> <int> <chr>      <chr> <int> <int> <chr> <chr> 
#> 1 audi         a4      1.8  1999     4 auto(l5)   f        18    29 p     compa~
#> 2 audi         a4      1.8  1999     4 manual(m5) f        21    29 p     compa~
#> 3 audi         a4      2    2008     4 manual(m6) f        20    31 p     compa~
#> 4 audi         a4      2    2008     4 auto(av)   f        21    30 p     compa~
#> 5 audi         a4      2.8  1999     6 auto(l5)   f        16    26 p     compa~
length(mpg)
#> [1] 11
```
__Example__: The `sum()` function:


```r
?sum
```

1. __input__. takes in a vector of elements (_class_ must be numeric or logical)
2. __processing__. Calculates the sum of elements
3. __return__. Returns numeric vector: length=1; value is sum of input vector

```r
sum(c(1,2,3))
#> [1] 6
sum(c(1,2,3)) %>% str()
#>  num 6
```

### User-wrtten functions

"__user-written functions__" [my term]

- functions you write to perform some specific task, often a data-manipulation or analysis task specific to your project

Like all functions, user-written functions usually follow three steps:

1. take in one or more __inputs__
2. __process__ the inputs
    - this may include using pre-written functions like `select()` or `sum()`
3. __return__ a new object

Example things we might want to write a function to do:

- Write function to read in annual data; call function for each year
- Create interactive maps: [NAED_presentation](https://ozanj.github.io/naed_presentation)
    - see "deep dive" results
- [Ben Skinner](https://github.com/btskinner) recommends [paraphrasing] writing "short functions that do one thing and do it well"
    
<br>

__When to write a function__

- Since functions are _reusable_ pieces of code, they allow you to "automate" tasks that you perform more than once
  - e.g., check to see if IPEDS data file already downloaded. and if not, then download data
  - e.g., write function that runs regression model and creates results table
- The alternative to writing a function to perform some specific task (aside from loops/iteration) is to copy and paste the code each time you want to perform a task
- [Wickham and Grolemund chapter 19.2](https://r4ds.had.co.nz/functions.html#when-should-you-write-a-function):

  > "You should consider writing a function whenever you’ve copied and pasted a block of code more than twice"
  
- Darin Christenson (professor, UCLA public policy) refers to the programming mantra __DRY__
  - "Do not Repeat Yourself (DRY)"
  
  > "Functions enable you to perform multiple tasks (that are similar to one another) without copying the same code over and over"

<br>

__Why write functions__ to complete a task (as opposed to the copy-and-paste approach)


- As task requirements change (and they always do!), you only need to revise code in one place rather than many places
- Reduce errors that are common in copy-and-paste approach (e.g., forgetting to change variable name or variable value)
- Functions give you an opportunity to make continual improvements to completing a task
    - e.g., you realize your function does not work for certain input values, so you modify function to handle those values


__How to approach writing functions__ (broad recipe)

1. Experiment with performing the task outside of a function
    - experiment with performing task with different sets of inputs
    - sometimes you will have to revise this code, when an approach that worked outside a function does not work within a function
1. Write the function
1. Test the function; try to "break" it
1. __Continual improvement__. As you use the function, make continual improvements going back-and-forth between steps 1-3

## Writing functions, basics

This section teaches the basics of writing functions. 


Often, the functions we write ("user-written functions") will utilize existing functions from R packages. For example, we will create a function named `z_score()` that calculates how many standard deviations an observation is from the mean. Our `z_score()` function will use the existing `mean()` and `sd()` functions.


We will avoid creating user-written functions that utilize `Tidyverse` functions, particularly functions from the `dplyr` package such as `group_by()`. The reason is that including certain `Tidyverse`/`dplyr` functions in a user-written function (or loo) requires knowledge of some advanced programming skills that we have not introduced yet. For more explanation, see [CRYSTAL ADD OTHER/BETTER LINKS?] https://www.r-bloggers.com/data-frame-columns-as-arguments-to-dplyr-functions/. 

Therefore, when writing funtions that perform data manipulation tasks, we will use a "Base R approach" rather than a "Tidyverse approach."

### Components of a function

The `function()` function tells R that you are writing a function

```r
function_name <- function(arg1, arg2, arg3) {
  #function body
}

#to find help file for function():
  ?`function`
  #but help file is not a helpful introduction
```

Three components of a function:

1. __function name__
    - define a function using `function()` and give it a **name** using the assignment operator `<-`
2. __function arguments__ (sometimes called "inputs")
    - Inputs that the function takes; they go inside the parentheses of `function()`
      - can be vectors, data frames, logical statements, strings, etc.
    - in above hypothetical code, the function took three inputs `arg1`,`arg2`,`arg3`, but we could have written:
      - `function(x,y,z)` or `function(Larry,Curly,Moe)`
    - In "function call," you specify values to assign to these function arguments
3. __function body__
    - What the function does to the inputs
    - function body goes inside the pair of curly brackets (`{}`) that follows `function()`
    - Above hypothetical function doesn't do anything


### Hello function

`print_hello()` function

- We will write a function that simply prints "Hello, world."
- Then we'll modify this function to print name and age

<br>

__Task__: Write function that prints "Hello!"


__First, perform task outside of function__


```r
"Hello, world"
#> [1] "Hello, world"
```
Alternative approaches to perform task outside of function

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

__Create the function__

```r
# Define function called `print_hello()`
print_hello <- function() {  # This function takes no arguments
  "Hello, world"                   # The body of the function simply prints "Hello!"
}

# Call function
print_hello()
#> [1] "Hello, world"
```

1. __function name__
    - function name is `print_hello`
2. __function arguments__ (sometimes called "inputs")
    - `print_hello` function doesn't take any arguments
3. __function body__ (what the function does to the inputs)
    - body of `print_hello` simply prints "Hello, world"

<br>    
__Task__: modify `print_hello` function so that it prints "Hello, world. My name is <name>", where `<name>` is a function argument that we can specify in function call

__First, perform task outside a function__. 

This seems wrong because my name is not an input

```r

"Hello, world. My name is Ozan Jaquette"
#> [1] "Hello, world. My name is Ozan Jaquette"

# create an object x for name
# 
```
Create an object, x, for name

```r
x <- "Ozan Jaquette"

str_c("Hello, world. My name is",x, sep = " ", collapse = NULL)
#> [1] "Hello, world. My name is Ozan Jaquette"
```


__Modify function__

```r
# Define function
print_hello <- function(x) {  # The argument goes between the parentheses
  str_c("Hello, world. My name is",x, sep = " ", collapse = NULL) # body `str_c()` to concatenate greeting and name
}

# Call function
print_hello(x = "Ozan Jaquette")
#> [1] "Hello, world. My name is Ozan Jaquette"
print_hello("Ozan Jaquette")
#> [1] "Hello, world. My name is Ozan Jaquette"
```
<br>

__Task__: modify `print_hello` function so that it also takes birth date as input and states age in years

- like this: `"Hello, world. My name is Ozan Jaquette and I am 41 years old."`


__Perform task outside of function__

Date of birth

```r
y <- "01/16/1979"
y
#> [1] "01/16/1979"
mdy("01/16/1979")
#> [1] "1979-01-16"
mdy(y)
#> [1] "1979-01-16"
str(mdy(y))
#>  Date[1:1], format: "1979-01-16"
```
Calculate age

```r
y <- "01/16/1979"

today()
#> [1] "2020-05-27"

# calculate duration
today() - mdy(y)
#> Time difference of 15107 days
str(today() - mdy(y))
#>  'difftime' num 15107
#>  - attr(*, "units")= chr "days"

as.duration(today() - mdy(y))
#> [1] "1305244800s (~41.36 years)"

# create age in years as numeric vector
as.numeric(as.duration(today() - mdy(y)), "years")
#> [1] 41.36071
floor(as.numeric(as.duration(today() - mdy(y)), "years"))
#> [1] 41

str(floor(as.numeric(as.duration(today() - mdy(y)), "years")))
#>  num 41

age <- floor(as.numeric(as.duration(today() - mdy(y)), "years"))
age
#> [1] 41
```
Print name and age in years

```r
x <- "Ozan Jaquette"
y <- "01/16/1979"

age <- floor(as.numeric(as.duration(today() - mdy(y)), "years"))

str_c("Hello, world. My name is",x, "and I am",age,"years old",sep = " ", collapse = NULL)
#> [1] "Hello, world. My name is Ozan Jaquette and I am 41 years old"
```


__Modify function__


```r
# Define function
print_hello <- function(x,y) {  # The argument goes between the parentheses
  
  age <- floor(as.numeric(as.duration(today() - mdy(y)), "years"))
  str_c("Hello, world. My name is",x, "and I am",age,"years old", sep = " ", collapse = NULL) # body `str_c()` to concatenate greeting and name
}

# Call function
print_hello(x = "Ozan Jaquette","01/16/1979")
#> [1] "Hello, world. My name is Ozan Jaquette and I am 41 years old"
print_hello(x = "Kartal Jaquette","01/24/1983")
#> [1] "Hello, world. My name is Kartal Jaquette and I am 37 years old"
print_hello(x = "Sumru Erkut","06/15/1944")
#> [1] "Hello, world. My name is Sumru Erkut and I am 75 years old"
print_hello(x = "Sumru Jaquette-Nasiali","04/05/2019")
#> [1] "Hello, world. My name is Sumru Jaquette-Nasiali and I am 1 years old"
```

Test/break function

- what if date of birth is input using a different format?

```r
print_hello(x = "Sumru Jaquette-Nasiali","04/05/2019") # this works

print_hello(x = "Sumru Jaquette-Nasiali","2019/04/05") # this breaks
```

Next step would be to modify function to create date object for date of birth, allowing DOB to be entered using multiple formats

- first, do outside of function
- second, modify function

### z_score function

The __z-score__ for an observation _i_ is number of standard deviations from mean

- $z_i = \frac{x_i - \bar{x}}{sd(x)}$

<br>

__Task__: 

- Write function that calculates `z-score` for each element of a vector

<br>

__First, experiment calculating z-score without writing function__

Create a vector of numbers we'll use to calculate z-score

```r
v=c(seq(5,15))
v
#>  [1]  5  6  7  8  9 10 11 12 13 14 15
typeof(v) # type==integer vector
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

We can calculate the z-score using the Base R `mean()` and `sd()` functions

- $z_i = \frac{x_i - \bar{x}}{sd(x)}$

```r
mean(v)
#> [1] 10
sd(v)
#> [1] 3.316625
```

- Calculate z-score for some value

```r
(5-mean(v))/sd(v)
#> [1] -1.507557
(10-mean(v))/sd(v)
#> [1] 0
```

- Calculate z-score for particular elements of vector `v`

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

- Calculate `z_i` for multiple elements of vector `v`

```r
c(v[1],v[8],v[11])
#> [1]  5 12 15
c((v[1]-mean(v))/sd(v),(v[8]-mean(v))/sd(v),(v[11]-mean(v))/sd(v))
#> [1] -1.5075567  0.6030227  1.5075567
```
__Next, write function__

Write function to calculate z_score for each element of vector

```r
z_score <- function(x) {
  (x - mean(x))/sd(x)
}
```

__Components of function__

1. __function name__ is `z_score`
2. __function arguments__. Takes one input, which we named `x`
    - inputs can be vectors, dataframes, logical statements, etc.
3. __function body__.What function does to the inputs
    - for each element of `x`, calculate difference between value of element and mean value of elements, then divide by standard deviation of elements

Test/call function

```r
z_score(x = c(5,6,7,8,9,10,11,12,13,14,15)) #note use of c() function to indicate individual arguments for multiple calls
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


Improve our function by trying to break it

```r
w=c(NA,seq(1:5),NA)
w
#> [1] NA  1  2  3  4  5 NA
z_score(w)
#> [1] NA NA NA NA NA NA NA
```

- What went wrong?

\medskip
Let's revise our function

```r
z_score <- function(x) {
  (x - mean(x, na.rm=TRUE))/sd(x, na.rm=TRUE)
}

w
#> [1] NA  1  2  3  4  5 NA
z_score(w)
#> [1]         NA -1.2649111 -0.6324555  0.0000000  0.6324555  1.2649111         NA
```

<br>

Does our `z_score` function work when applied to variables from a data frame?

- Create data frame called `df`

```r
set.seed(12345) # set "seed" so we all get the same "random" numbers
df <- tibble(
  a = c(NA,rnorm(9)),
  b = c(NA,rnorm(9)),
  c = c(NA,rnorm(9))
)
class(df) # class of object df
df # print data frame

# subset a data frame w/ one element, using []
df["a"] 
str(df["a"])

# subset values of an element using [[]] or $
df[["a"]]
str(df[["a"]])

df$a # print element "a" (i.e., variable "a") of object df (data frame)
str(df$a) # structure of element "a" of df: a numeric vector
```

Experiment with components of z-score, outside of a function

```r
mean(df[["a"]], na.rm=TRUE) # mean of variable "a"
#> [1] -0.04556883
sd(df[["a"]], na.rm=TRUE) # std dev of variable "a"
#> [1] 0.8117278

mean(df$a, na.rm=TRUE) # mean of variable "a"
#> [1] -0.04556883
sd(df$a, na.rm=TRUE) # std dev of variable "a"
#> [1] 0.8117278

#would these work?
  #mean(df["a"], na.rm=TRUE) # mean of variable "a"
  #sd(df["a"], na.rm=TRUE) # std dev of variable "a"

#manually calculate z score for second observation in variable "a"
df$a[2]
#> [1] 0.5855288
(df$a[2] - mean(df$a, na.rm=TRUE))/sd(df$a, na.rm=TRUE) # check result
#> [1] 0.7774745
```

- Apply `z_score` function to variables in data frame

```r
# z_score function to calculate z-score for each obs of variable "a"
df$a # print variable "a"
z_score(x = df$a)
z_score(x = df[["a"]])
  #z_score(x = df["a"]) # but this doesn't work

# z-score for each obs of variable "b"
z_score(x = df$b) 
```

__Task__

- Use our `z_score` function to create a new variable that is the z-score version of a variable

First, briefly review how to create and delete variables using "Base R" approach

```r
df # print data frame df

df$one <- 1 # create variable "one" that always equals 1
df # print data frame df
df$one <- NULL # remove variable "one"
df 

df$c_plus2 <- df$c+2 #create variable equal to "c" plus 2
df
df$c_plus2 <- NULL # remove variable "c_plus2"
df
```



Use `z_score` function to create a new variable that equals the z-score of another variable

- simply calling the `z_score` function does not create a new variable

```r
z_score(x = df$c)
#>  [1]         NA  0.7824644  0.1323014  0.5126742  1.0474944 -0.6136182
#>  [7] -1.3324528 -1.3677077  1.3237878 -0.4849435
df %>% head(5)
#> # A tibble: 5 x 3
#>        a      b      c
#>    <dbl>  <dbl>  <dbl>
#> 1 NA     NA     NA    
#> 2  0.586 -0.919  1.12 
#> 3  0.709 -0.116  0.299
#> 4 -0.109  1.82   0.780
#> 5 -0.453  0.371  1.46
```

- Do not modify the `z_score` function so that the variable is assigned within the function
- Preferred approach is to call the `z_score` function after the assignment operator `<-`


```r
df$c_z <- z_score(x = df$c)

# examine data frame
df %>% head(5)
#> # A tibble: 5 x 4
#>        a      b      c    c_z
#>    <dbl>  <dbl>  <dbl>  <dbl>
#> 1 NA     NA     NA     NA    
#> 2  0.586 -0.919  1.12   0.782
#> 3  0.709 -0.116  0.299  0.132
#> 4 -0.109  1.82   0.780  0.513
#> 5 -0.453  0.371  1.46   1.05
```
We can apply our function to a "real" dataset too


```r
#load dataset with one obs per recruiting event
load(url("https://github.com/ozanj/rclass/raw/master/data/recruiting/recruit_event_somevars.RData"))

df_event_small <- df_event[1:10,] %>% # keep first 10 observations
  select(instnm,univ_id,event_type,med_inc) # keep 4 vars

df_event_small

#show observations for variable med_inc
df_event_small$med_inc

#calculate z-score of variable med_inc (without assignment)
z_score(x = df_event_small$med_inc)

#assign new variable equal to the z-score of med_inc
df_event_small$med_inc_z <- z_score(x = df_event_small$med_inc)

#inspect
df_event_small %>% head(5)
```

<br>

Improve `z_score` function by first checking whether input `x` is valid [CRYSTAL - MAKE THIS A COLLAPSIBLE]

We could improve `z_score` function by making it more "surly" about inputs it will accept

Current function

```r
z_score <- function(x) {
  (x - mean(x, na.rm=TRUE))/sd(x, na.rm=TRUE)
}
#?mean
#?sd
```

- `z_score` function does simple arithmatic and utilizes the `mean()` and `sd()` functions
- `mean()` and `sd()` functions require `x` to be a numeric (or logical) atomic vector
  - `z_score()` function will break if the input `x` is not an atomic vector
  - `z_score()` function will break if the input `x` is not a numeric/logical atomic vector


```r
#function doesn't work if input is a list/data frame
str(df_event_small$med_inc)
str(df_event_small["med_inc"])

z_score(x = df_event_small$med_inc)

#function doesn't work if x is not a numeric vector
str(df_event_small$instnm)

z_score(x = df_event_small$instnm)
```

- We could modify `z_score()` by using conditional statements calculate the z-score only if input object `x` is the appropriate type and class of object

[CRYSTAL - WE COULD ADD REVISED FUNCTION HERE OR WE COULD PUT THIS CODE LATER IN LECTURE IF WE ADD SUB-SECTION ON "CHECKING VALUES"]

- https://r4ds.had.co.nz/functions.html#checking-values

### Student exercise [skip]

Some common tasks when working with survey data:

- identify number of observations with `NA` values for a specific variable
- identify number of observations with negative values for a specific variable
- Replace negative values with `NA` for a specific variable

#### `num_negative()` function

__Your task for student exercise__: The `num_negative` function

- Write a function that counts the number of observations with negative values for a specific variable
- Apply this function to variables from dataframe `df` (created below)
- Adapted from Ben Skinner's _programming 1_ R Workshop [HERE](https://www.btskinner.me/rworkshop/modules/programming_one.html)


Create a sample dataset `df` that contains some negative values

- code omitted; don't worry about understanding this code

```
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
#> # ... with 90 more rows
```

__Task__: Write a function that counts the number of observations with negative values for a specific variable

__Recommended steps__:

- Perform task outside of function
    - HINT: `sum(data_frame_name$var_name<0)`
- Write function
- Apply/test function on variables

__Step 1__: Perform task outside of function [output omitted]

```r
names(df) # identify variable names
df$age # print observations for a variable

#BaseR
sum(df$age<0) # count number of obs w/ negative values for variable "age"
```

__Step 2__: Write function

```r
num_missing <- function(x){
  sum(x<0)
}
```

__Step 3__: apply function

```r
num_missing(df$age)
#> [1] 27
num_missing(df$sibage)
#> [1] 22
```

#### `num_missing` function

In survey data, negative values often refer to reason for missing values

- e.g., `-8` refers to "didn't take survey"
- e.g., `-7` refers to "took survey, but didn't answer this question"

__Your task__: Write function `num_mising` that counts number of missing observations for a variable and allows you to specify which values are associated with missing for that variable. This function will take two arguments:

- `x`: the variable (e.g., `df$sibage`)
- `miss_vals`: vector of values you want to associate with "missing" variable
    - Values to associate with missing for `df$age`: `-97,-98,-99`
    - Values to associate with missing for `df$sibage`: `-97,-98,-99`
    - Values to associate with missing for `df$parage`: `-4,-7,-8`

__Recommended steps__:

- Perform task outside of function
    - HINT: `sum(data_frame_name$var_name< %in% c(-4,-5))`
- Write function
- Apply/test function on variables


Perform task outside of function

```r
sum(df$age %in% c(-97,-98,-99))
#> [1] 27
```

Write function

```r
num_missing <- function(x, miss_vals){

  sum(x %in% miss_vals)
}
```

Call function

```r
num_missing(df$age,c(-97,-98,-99))
#> [1] 27
num_missing(df$sibage,c(-97,-98,-99))
#> [1] 22
num_missing(df$parage,c(-4,-7,-8))
#> [1] 17
```
