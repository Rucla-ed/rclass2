---
title: "Strings and Regular Expressions"
author: 
date: 
urlcolor: blue
output: 
  html_document:
    toc: true
    toc_depth: 2
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
library(stringr)  # package for manipulating strings (part of tidyverse)
library(lubridate)  # package for working with dates and times
```

Resources used to create this lecture:

- https://r4ds.had.co.nz/strings.html
- https://www.tutorialspoint.com/r/r_strings.htm
- https://swcarpentry.github.io/r-novice-inflammation/13-supp-data-structures/
- https://www.statmethods.net/input/datatypes.html
- https://www.stat.berkeley.edu/~s133/dates.html

## Dataset we will use

We will use `rtweet` to pull Twitter data from the PAC-12 universities. We will use the university admissions Twitter handle if there is one, or the main Twitter handle for the university if there isn't one:


```r
# library(rtweet)
# 
# p12 <- c("uaadmissions", "FutureSunDevils", "caladmissions", "UCLAAdmission",
#          "futurebuffs", "uoregon", "BeaverVIP", "USCAdmission",
#          "engagestanford", "UtahAdmissions", "UW", "WSUPullman")
# p12_full_df <- search_tweets(paste0("from:", p12, collapse = " OR "), n = 500)
#
# saveRDS(p12_full_df, "p12_dataset.RDS")

# Load previously pulled Twitter data
p12_full_df <- readRDS("p12_dataset.RDS")
glimpse(p12_full_df)
```

```
## Observations: 328
## Variables: 90
## $ user_id                 <chr> "22080148", "22080148", "22080148", "220…
## $ status_id               <chr> "1254177694599675904", "1253431405993840…
## $ created_at              <dttm> 2020-04-25 22:37:18, 2020-04-23 21:11:4…
## $ screen_name             <chr> "WSUPullman", "WSUPullman", "WSUPullman"…
## $ text                    <chr> "Big Dez is headed to Indy!\n\n#GoCougs …
## $ source                  <chr> "Twitter for iPhone", "Twitter Web App",…
## $ display_text_width      <dbl> 125, 58, 246, 83, 56, 64, 156, 271, 69, …
## $ reply_to_status_id      <chr> NA, NA, NA, NA, NA, NA, NA, NA, "1252615…
## $ reply_to_user_id        <chr> NA, NA, NA, NA, NA, NA, NA, NA, "2208014…
## $ reply_to_screen_name    <chr> NA, NA, NA, NA, NA, NA, NA, NA, "WSUPull…
## $ is_quote                <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE…
## $ is_retweet              <lgl> TRUE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ favorite_count          <int> 0, 322, 30, 55, 186, 53, 22, 44, 11, 0, …
## $ retweet_count           <int> 230, 32, 1, 5, 0, 3, 2, 6, 2, 6, 3, 4, 5…
## $ quote_count             <int> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ reply_count             <int> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ hashtags                <list> [<"GoCougs", "NFLDraft2020", "NFLCougs"…
## $ symbols                 <list> [NA, NA, NA, NA, NA, NA, NA, NA, NA, NA…
## $ urls_url                <list> [NA, NA, NA, NA, NA, NA, NA, "commencem…
## $ urls_t.co               <list> [NA, NA, NA, NA, NA, NA, NA, "https://t…
## $ urls_expanded_url       <list> [NA, NA, NA, NA, NA, NA, NA, "https://c…
## $ media_url               <list> ["http://pbs.twimg.com/ext_tw_video_thu…
## $ media_t.co              <list> ["https://t.co/NdGsvXnij7", "https://t.…
## $ media_expanded_url      <list> ["https://twitter.com/WSUCougarFB/statu…
## $ media_type              <list> ["photo", "photo", "photo", "photo", "p…
## $ ext_media_url           <list> ["http://pbs.twimg.com/ext_tw_video_thu…
## $ ext_media_t.co          <list> ["https://t.co/NdGsvXnij7", "https://t.…
## $ ext_media_expanded_url  <list> ["https://twitter.com/WSUCougarFB/statu…
## $ ext_media_type          <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ mentions_user_id        <list> [<"1250265324", "1409024796", "18088404…
## $ mentions_screen_name    <list> [<"WSUCougarFB", "dadpat7", "Colts">, N…
## $ lang                    <chr> "en", "en", "en", "en", "en", "en", "en"…
## $ quoted_status_id        <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ quoted_text             <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ quoted_created_at       <dttm> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…
## $ quoted_source           <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ quoted_favorite_count   <int> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ quoted_retweet_count    <int> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ quoted_user_id          <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ quoted_screen_name      <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ quoted_name             <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ quoted_followers_count  <int> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ quoted_friends_count    <int> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ quoted_statuses_count   <int> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ quoted_location         <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ quoted_description      <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ quoted_verified         <lgl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ retweet_status_id       <chr> "1254159118996127746", NA, NA, NA, NA, N…
## $ retweet_text            <chr> "Big Dez is headed to Indy!\n\n#GoCougs …
## $ retweet_created_at      <dttm> 2020-04-25 21:23:29, NA, NA, NA, NA, NA…
## $ retweet_source          <chr> "Twitter for iPhone", NA, NA, NA, NA, NA…
## $ retweet_favorite_count  <int> 1402, NA, NA, NA, NA, NA, NA, NA, NA, 26…
## $ retweet_retweet_count   <int> 230, NA, NA, NA, NA, NA, NA, NA, NA, 6, …
## $ retweet_user_id         <chr> "1250265324", NA, NA, NA, NA, NA, NA, NA…
## $ retweet_screen_name     <chr> "WSUCougarFB", NA, NA, NA, NA, NA, NA, N…
## $ retweet_name            <chr> "Washington State Football", NA, NA, NA,…
## $ retweet_followers_count <int> 77527, NA, NA, NA, NA, NA, NA, NA, NA, 9…
## $ retweet_friends_count   <int> 1448, NA, NA, NA, NA, NA, NA, NA, NA, 31…
## $ retweet_statuses_count  <int> 15363, NA, NA, NA, NA, NA, NA, NA, NA, 1…
## $ retweet_location        <chr> "Pullman, WA", NA, NA, NA, NA, NA, NA, N…
## $ retweet_description     <chr> "Official Twitter home of Washington Sta…
## $ retweet_verified        <lgl> TRUE, NA, NA, NA, NA, NA, NA, NA, NA, FA…
## $ place_url               <chr> NA, NA, NA, NA, NA, "https://api.twitter…
## $ place_name              <chr> NA, NA, NA, NA, NA, "Pullman", NA, NA, N…
## $ place_full_name         <chr> NA, NA, NA, NA, NA, "Pullman, WA", NA, N…
## $ place_type              <chr> NA, NA, NA, NA, NA, "city", NA, NA, NA, …
## $ country                 <chr> NA, NA, NA, NA, NA, "United States", NA,…
## $ country_code            <chr> NA, NA, NA, NA, NA, "US", NA, NA, NA, NA…
## $ geo_coords              <list> [<NA, NA>, <NA, NA>, <NA, NA>, <NA, NA>…
## $ coords_coords           <list> [<NA, NA>, <NA, NA>, <NA, NA>, <NA, NA>…
## $ bbox_coords             <list> [<NA, NA, NA, NA, NA, NA, NA, NA>, <NA,…
## $ status_url              <chr> "https://twitter.com/WSUPullman/status/1…
## $ name                    <chr> "WSU Pullman", "WSU Pullman", "WSU Pullm…
## $ location                <chr> "Pullman, Washington USA", "Pullman, Was…
## $ description             <chr> "We are an award-winning research univer…
## $ url                     <chr> "http://t.co/VxKZH9BuMS", "http://t.co/V…
## $ protected               <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE…
## $ followers_count         <int> 43914, 43914, 43914, 43914, 43914, 43914…
## $ friends_count           <int> 9717, 9717, 9717, 9717, 9717, 9717, 9717…
## $ listed_count            <int> 556, 556, 556, 556, 556, 556, 556, 556, …
## $ statuses_count          <int> 15234, 15234, 15234, 15234, 15234, 15234…
## $ favourites_count        <int> 20124, 20124, 20124, 20124, 20124, 20124…
## $ account_created_at      <dttm> 2009-02-26 23:39:34, 2009-02-26 23:39:3…
## $ verified                <lgl> TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE…
## $ profile_url             <chr> "http://t.co/VxKZH9BuMS", "http://t.co/V…
## $ profile_expanded_url    <chr> "http://www.wsu.edu", "http://www.wsu.ed…
## $ account_lang            <lgl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ profile_banner_url      <chr> "https://pbs.twimg.com/profile_banners/2…
## $ profile_background_url  <chr> "http://abs.twimg.com/images/themes/them…
## $ profile_image_url       <chr> "http://pbs.twimg.com/profile_images/576…
```

```r
p12_df <- p12_full_df %>% select("user_id", "created_at", "screen_name", "text", "location")
head(p12_df)
```

```
## # A tibble: 6 x 5
##   user_id  created_at          screen_name text                 location   
##   <chr>    <dttm>              <chr>       <chr>                <chr>      
## 1 22080148 2020-04-25 22:37:18 WSUPullman  "Big Dez is headed … Pullman, W…
## 2 22080148 2020-04-23 21:11:49 WSUPullman  Cougar Cheese. That… Pullman, W…
## 3 22080148 2020-04-21 04:00:00 WSUPullman  "Darien McLaughlin … Pullman, W…
## 4 22080148 2020-04-24 03:00:00 WSUPullman  6 houses, one pick.… Pullman, W…
## 5 22080148 2020-04-20 19:00:21 WSUPullman  Why did you choose … Pullman, W…
## 6 22080148 2020-04-20 02:20:01 WSUPullman  Tell us one of your… Pullman, W…
```


# Data structures and types

What is an **object**?

- Everything in R is an object
- We can classify objects based on their class and type
  - The class of the object determines what kind of functions we can apply to it
- Objects may be combined to form data structures

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

## Atomtic vectors

What are **atomic vectors**?

- **Atomic vectors** are objects that contains elements
- Elements must be of the same data type (i.e., _homogeneous_)
- The `class()` and `typeof()` a vector describes the elements it contains

<br>
<details><summary>**Example**: Investigating logical vectors</summary>


```r
v <- c(TRUE, FALSE, FALSE, TRUE)
str(v)
```

```
##  logi [1:4] TRUE FALSE FALSE TRUE
```

```r
class(v)
```

```
## [1] "logical"
```

```r
typeof(v)
```

```
## [1] "logical"
```

</details>

<br>
<details><summary>**Example**: Investigating numeric vectors</summary>


```r
v <- c(1, 3, 5, 7)
str(v)
```

```
##  num [1:4] 1 3 5 7
```

```r
class(v)
```

```
## [1] "numeric"
```

```r
typeof(v)
```

```
## [1] "double"
```
</details>

<br>
<details><summary>**Example**: Investigating integer vectors</summary>


```r
v <- c(1L, 3L, 5L, 7L)
str(v)
```

```
##  int [1:4] 1 3 5 7
```

```r
class(v)
```

```
## [1] "integer"
```

```r
typeof(v)
```

```
## [1] "integer"
```

</details>

<br>
<details><summary>**Example**: Investigating character vectors</summary>

Each element in a `character` vector is a **string** (covered in next section):


```r
v <- c("a", "b", "c", "d")
str(v)
```

```
##  chr [1:4] "a" "b" "c" "d"
```

```r
class(v)
```

```
## [1] "character"
```

```r
typeof(v)
```

```
## [1] "character"
```

</details>


## Lists

What are **lists**?

- **Lists** are objects that contains elements
- Elements do not need to be of the same type (i.e., _heterogeneous_)
  - Elements can be atomic vectors or even other lists
- The `class()` and `typeof()` a list is `list`

<br>
<details><summary>**Example**: Investigating heterogeneous lists</summary>


```r
l <- list(2.5, "abc", TRUE, c(1L, 2L, 3L))
str(l)
```

```
## List of 4
##  $ : num 2.5
##  $ : chr "abc"
##  $ : logi TRUE
##  $ : int [1:3] 1 2 3
```

```r
class(l)
```

```
## [1] "list"
```

```r
typeof(l)
```

```
## [1] "list"
```

</details>

<br>
<details><summary>**Example**: Investigating nested lists</summary>


```r
l <- list(list(TRUE, c(1, 2, 3), list(c("a", "b", "c"))), FALSE, 10L)
str(l)
```

```
## List of 3
##  $ :List of 3
##   ..$ : logi TRUE
##   ..$ : num [1:3] 1 2 3
##   ..$ :List of 1
##   .. ..$ : chr [1:3] "a" "b" "c"
##  $ : logi FALSE
##  $ : int 10
```

```r
class(l)
```

```
## [1] "list"
```

```r
typeof(l)
```

```
## [1] "list"
```

</details>


### Dataframes

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
```

```
## # A tibble: 3 x 3
##    colA colB  colC 
##   <dbl> <chr> <lgl>
## 1     1 a     TRUE 
## 2     2 b     FALSE
## 3     3 c     TRUE
```

```r
str(df)
```

```
## 'data.frame':	3 obs. of  3 variables:
##  $ colA: num  1 2 3
##  $ colB: chr  "a" "b" "c"
##  $ colC: logi  TRUE FALSE TRUE
```

```r
class(df)
```

```
## [1] "data.frame"
```

```r
typeof(df)
```

```
## [1] "list"
```

</details>

## Converting between classes

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

Character vector coerced to numeric vector:


```r
# Strings containing numeric values can be coerced to numeric (leading 0's are dropped) 
# All other characters become NA
as.numeric(c("0", "007", "2.5", "abc", "."))
```

```
## [1] 0.0 7.0 2.5  NA  NA
```

</details>

<br>
<details><summary>**Example**: Using `as.integer()` to convert to `integer`</summary>

Logical vector coerced to integer vector:


```r
# FALSE is mapped to 0 and TRUE is mapped to 1
as.integer(c(FALSE, TRUE))
```

```
## [1] 0 1
```

Character vector coerced to integer vector:


```r
# Strings containing numeric values can be coerced to integer (leading 0's are dropped, decimals are truncated) 
# All other characters become NA
as.integer(c("0", "007", "2.5", "abc", "."))
```

```
## [1]  0  7  2 NA NA
```

Numeric vector coerced to integer vector:


```r
# All decimal places are truncated
as.integer(c(0, 2.1, 10.5, 8.8, -1.8))
```

```
## [1]  0  2 10  8 -1
```

</details>

<br>
<details><summary>**Example**: Using `as.character()` to convert to `character`</summary>

Logical vector coerced to character vector:


```r
as.character(c(FALSE, TRUE))
```

```
## [1] "FALSE" "TRUE"
```

Numeric vector coerced to character vector:


```r
as.character(c(-5, 0, 2.5))
```

```
## [1] "-5"  "0"   "2.5"
```

Integer vector coerced to character vector:


```r
as.character(c(-2L, 0L, 10L))
```

```
## [1] "-2" "0"  "10"
```

</details>

<br>
<details><summary>**Example**: Using `as.list()` to convert to `list`</summary>

Atomic vectors coerced to list:


```r
# Logical vector
as.list(c(TRUE, FALSE))
```

```
## [[1]]
## [1] TRUE
## 
## [[2]]
## [1] FALSE
```

```r
# Character vector
as.list(c("a", "b", "c"))
```

```
## [[1]]
## [1] "a"
## 
## [[2]]
## [1] "b"
## 
## [[3]]
## [1] "c"
```

```r
# Numeric vector
as.list(1:3)
```

```
## [[1]]
## [1] 1
## 
## [[2]]
## [1] 2
## 
## [[3]]
## [1] 3
```

</details>

<br>
<details><summary>**Example**: Using `as.data.frame()` to convert to `data.frame`</summary>

Lists coerced to dataframe:


```r
# Create a list
l <- list(A = c("x", "y", "z"), B = c(1, 2, 3))
str(l)
```

```
## List of 2
##  $ A: chr [1:3] "x" "y" "z"
##  $ B: num [1:3] 1 2 3
```

```r
# Convert to class `data.frame`
df <- as.data.frame(l, stringsAsFactors = F)
str(df)
```

```
## 'data.frame':	3 obs. of  2 variables:
##  $ A: chr  "x" "y" "z"
##  $ B: num  1 2 3
```

</details>

# String basics

What are **strings**?

- String is a type of data in R
- You can create strings using either single quotes (`'`) or double quotes (`"`)
  - Internally, R stores strings using double quotes
- The `class()` and `typeof()` a string is `character`

<br>
**Example**: Creating string using single quotes

Notice how R stores strings using double quotes internally:


```r
my_string <- 'This is a string'
my_string
```

```
## [1] "This is a string"
```

<br>
**Example**: Creating string using double quotes


```r
my_string <- "Strings can also contain numbers: 123"
my_string
```

```
## [1] "Strings can also contain numbers: 123"
```

<br>
**Example**: Checking class and type of strings


```r
class(my_string)
```

```
## [1] "character"
```

```r
typeof(my_string)
```

```
## [1] "character"
```


## Escape sequence and `writeLines()`

> "A sequence in a string that starts with a `\` is called an **escape sequence** and allows us to include special characters in our strings."

*Credit: [Escape sequences](https://campus.datacamp.com/courses/string-manipulation-with-stringr-in-r/string-basics?ex=4) from DataCamp*

Common **special characters**:

- `\'`: literal single quote
- `\"`: literal double quote
- `\\`: literal backslash
- `\n`: newline
- `\t`: tab


<br>
__The `writeLines()` function__:


```r
?writeLines

# SYNTAX AND DEFAULT VALUES
writeLines(text, con = stdout(), sep = "\n", useBytes = FALSE)
```

- "`writeLines()` displays quotes and backslashes as they would be read, rather than as R stores them." (From [writeLines](https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/writeLines) documentation)
- When we include **escape sequences** in the string, it is helpful to use `writeLines()` to see how the escaped string looks
- `writeLines()` will also output the string without showing the outer pair of double quotes that R uses to store it, so we only see the content of the string


<br>
<details><summary>**Example**: Escaping single quotes</summary>


```r
my_string <- 'Escaping single quote \' within single quotes'
my_string
```

```
## [1] "Escaping single quote ' within single quotes"
```

Alternatively, we could've just created the string using double quotes:


```r
my_string <- "Single quote ' within double quotes does not need escaping"
my_string
```

```
## [1] "Single quote ' within double quotes does not need escaping"
```

Using `writeLines()` shows us only the content of the string without the outer pair of double quotes that R uses to store strings:


```r
writeLines(my_string)
```

```
## Single quote ' within double quotes does not need escaping
```
</details>

<br>
<details><summary>**Example**: Escaping double quotes</summary>


```r
my_string <- "Escaping double quote \" within double quotes"
my_string
```

```
## [1] "Escaping double quote \" within double quotes"
```

Alternatively, we could've just created the string using single quotes:


```r
my_string <- 'Double quote " within single quotes does not need escaping'
my_string
```

```
## [1] "Double quote \" within single quotes does not need escaping"
```

Notice how the backslash still showed up in the above output to escape our double quote from the outer pair of double quotes that R uses to store the string. This is no longer an issue if we use `writeLines()` to only show the string content:


```r
writeLines(my_string)
```

```
## Double quote " within single quotes does not need escaping
```
</details>

<br>
<details><summary>**Example**: Escaping backslashes</summary>

To include a literal backslash in the string, we need to escape the backslash with another backslash:


```r
my_string <- "The executable is located in C:\\Program Files\\Git\\bin"
my_string
```

```
## [1] "The executable is located in C:\\Program Files\\Git\\bin"
```

Use `writeLines()` to see the escaped string:


```r
writeLines(my_string)
```

```
## The executable is located in C:\Program Files\Git\bin
```
</details>

<br>
<details><summary>**Example**: Other special characters</summary>


```r
my_string <- "A\tB\nC\tD"
my_string
```

```
## [1] "A\tB\nC\tD"
```

Use `writeLines()` to see the escaped string:


```r
writeLines(my_string)
```

```
## A	B
## C	D
```
</details>

# `stringr` package

> "A consistent, simple and easy to use set of wrappers around the fantastic `stringi` package. All function and argument names (and positions) are consistent, all functions deal with `NA`'s and zero length vectors in the same way, and the output from one function is easy to feed into the input of another."

*Credit: `stringr` [R documentation](https://www.rdocumentation.org/packages/stringr/versions/1.4.0)*

The `stringr` package:

- The `stringr` package is based off the `stringi` package and is part of __Tidyverse__ 
- `stringr` contains functions to work with strings
- For many functions in the `stringr` package, there are equivalent "base R" functions 
- But `stringr` functions all follow the same rules, while rules often differ across different "base R" string functions, so we will focus exclusively on `stringr` functions
- Most `stringr` functions start with `str_` (e.g., `str_length`)


## `str_length()`

<br>
__The `str_length()` function__:


```r
?str_length

# SYNTAX
str_length(string)
```

- Function: Find string length
- Arguments:
  - `string`: Character vector (or vector coercible to character)
- Note that `str_length()` calculates the length of a string, whereas the `length()` function (which is not part of `stringr` package) calculates the number of elements in an object

<br>
<details><summary>**Example**: Using `str_length()` on string</summary>


```r
str_length("cats")
```

```
## [1] 4
```

Compare to `length()`, which treats the string as a single object:


```r
length("cats")
```

```
## [1] 1
```

</details>

<br>
<details><summary>**Example**: Using `str_length()` on character vector</summary>


```r
str_length(c("cats", "in", "hat"))
```

```
## [1] 4 2 3
```

Compare to `length()`, which finds the number of elements in the vector:


```r
length(c("cats", "in", "hat"))
```

```
## [1] 3
```

</details>

<br>
<details><summary>**Example**: Using `str_length()` on other vectors coercible to character</summary>

Logical vectors can be coerced to character vectors:


```r
str_length(c(TRUE, FALSE))
```

```
## [1] 4 5
```

Numeric vectors can be coerced to character vectors:


```r
str_length(c(1, 2.5, 3000))
```

```
## [1] 1 3 4
```

Integer vectors can be coerced to character vectors:


```r
str_length(c(2L, 100L))
```

```
## [1] 1 3
```

</details>

<br>
<details><summary>**Example**: Using `str_length()` on dataframe column</summary>

Recall that the columns in a dataframe are just vectors, so we can use `str_length()` as long as the vector is coercible to character type. Let's look at the `screen_name` column from the `p12_df`:


```r
# `p12_df` is a dataframe object
str(p12_df)
```

```
## Classes 'tbl_df', 'tbl' and 'data.frame':	328 obs. of  5 variables:
##  $ user_id    : chr  "22080148" "22080148" "22080148" "22080148" ...
##  $ created_at : POSIXct, format: "2020-04-25 22:37:18" "2020-04-23 21:11:49" ...
##  $ screen_name: chr  "WSUPullman" "WSUPullman" "WSUPullman" "WSUPullman" ...
##  $ text       : chr  "Big Dez is headed to Indy!\n\n#GoCougs | #NFLDraft2020 | @dadpat7 | @Colts | #NFLCougs https://t.co/NdGsvXnij7" "Cougar Cheese. That's it. That's the tweet. \U0001f9c0#WSU #GoCougs https://t.co/0OWGvQlRZs" "Darien McLaughlin '19, and her dog, Yuki, went on a #Pullman distance walk this weekend. We will let you judge "| __truncated__ "6 houses, one pick. Cougs, which one you got? Reply \u2b07️  #WSU #CougsContain #GoCougs https://t.co/lNDx7r71b2" ...
##  $ location   : chr  "Pullman, Washington USA" "Pullman, Washington USA" "Pullman, Washington USA" "Pullman, Washington USA" ...
```

```r
# `screen_name` column is a character vector
str(p12_df$screen_name)
```

```
##  chr [1:328] "WSUPullman" "WSUPullman" "WSUPullman" "WSUPullman" ...
```

<br>
**[Base R method]** Use `str_length()` to calculate the length of each `screen_name`:


```r
# Let's focus on just the unique screen names
unique(p12_df$screen_name)
```

```
##  [1] "WSUPullman"      "CalAdmissions"   "UW"             
##  [4] "USCAdmission"    "uoregon"         "FutureSunDevils"
##  [7] "UCLAAdmission"   "UtahAdmissions"  "futurebuffs"    
## [10] "uaadmissions"    "BeaverVIP"
```

```r
str_length(unique(p12_df$screen_name))
```

```
##  [1] 10 13  2 12  7 15 13 14 11 12  9
```

<br>
**[Tidyverse method]** Use `str_length()` to calculate the length of each `screen_name`:


```r
# Let's focus on just the unique screen names
p12_df %>% select(screen_name) %>% unique()
```

```
## # A tibble: 11 x 1
##    screen_name    
##    <chr>          
##  1 WSUPullman     
##  2 CalAdmissions  
##  3 UW             
##  4 USCAdmission   
##  5 uoregon        
##  6 FutureSunDevils
##  7 UCLAAdmission  
##  8 UtahAdmissions 
##  9 futurebuffs    
## 10 uaadmissions   
## 11 BeaverVIP
```

```r
p12_df %>% select(screen_name) %>% unique() %>% str_length()
```

```
## Warning in stri_length(string): argument is not an atomic vector; coercing
```

```
## [1] 163
```

Notice that the above line does not work as expected because we passed in a dataframe to `str_length()` and it is trying to coerce that to character:


```r
class(p12_df %>% select(screen_name) %>% unique())
```

```
## [1] "tbl_df"     "tbl"        "data.frame"
```

An alternative way is to add a column to the dataframe that contains the result of applying `str_length()` to the `screen_name` vector:


```r
p12_df %>% select(screen_name) %>% unique() %>% 
  mutate(screen_name_len = str_length(screen_name))
```

```
## # A tibble: 11 x 2
##    screen_name     screen_name_len
##    <chr>                     <int>
##  1 WSUPullman                   10
##  2 CalAdmissions                13
##  3 UW                            2
##  4 USCAdmission                 12
##  5 uoregon                       7
##  6 FutureSunDevils              15
##  7 UCLAAdmission                13
##  8 UtahAdmissions               14
##  9 futurebuffs                  11
## 10 uaadmissions                 12
## 11 BeaverVIP                     9
```

</details>

## `str_c()`

<br>
__The `str_c()` function__:


```r
?str_c

# SYNTAX AND DEFAULT VALUES
str_c(..., sep = "", collapse = NULL)
```

- Function: Concatenate strings between vectors (element-wise)
- Arguments:
  - The input is one or more character vectors (or vectors coercible to character)
    - Zero length arguments are removed
    - Short arguments are recycled to the length of the longest
  - `sep`: String to insert between input vectors
  - `collapse`: Optional string used to combine input vectors into single string

<br>
<details><summary>**Example**: Using `str_c()` on strings</summary>

Each string input is treated as a character vector of size 1:


```r
str_c("a", "b", "c")
```

```
## [1] "abc"
```

We can use `sep` to specify how the elements are separated:


```r
str_c("a", "b", "c", sep = "~")
```

```
## [1] "a~b~c"
```

Note that we can also use any other input that can be coerced to character:


```r
str_c(TRUE, 1.5, 2L, "X")
```

```
## [1] "TRUE1.52X"
```

</details>

<br>
<details><summary>**Example**: Using `str_c()` on single vector</summary>

Since we only provided one input vector, each individual element has nothing to concatenate with:


```r
str_c(c("a", "b", "c"))
```

```
## [1] "a" "b" "c"
```

But we can still specify the `collapse` argument to collapse the elements to a single string:


```r
str_c(c("a", "b", "c"), collapse = "|")
```

```
## [1] "a|b|c"
```

</details>

<br>
<details><summary>**Example**: Using `str_c()` on multiple vectors</summary>

When multiple vectors are provided, they are joined together element-wise, recycling the elements of the shorter vectors:


```r
str_c("#", c("a", "b", "c", "d"), c(1, 2, 3), c(TRUE, FALSE))
```

```
## [1] "#a1TRUE"  "#b2FALSE" "#c3TRUE"  "#d1FALSE"
```

We can specify `sep` and `collapse`:


```r
str_c("#", c("a", "b", "c", "d"), c(1, 2, 3), c(TRUE, FALSE), sep = "~", collapse = "|")
```

```
## [1] "#~a~1~TRUE|#~b~2~FALSE|#~c~3~TRUE|#~d~1~FALSE"
```

</details>

<br>
<details><summary>**Example**: Using `str_c()` on dataframe columns</summary>

Let's combine the `user_id` and `screen_name` columns from `p12_df`. We'll focus on unique Twitter handles:


```r
p12_unique_df <- p12_df %>% select(user_id, screen_name) %>% unique()
p12_unique_df
```

```
## # A tibble: 11 x 2
##    user_id    screen_name    
##    <chr>      <chr>          
##  1 22080148   WSUPullman     
##  2 15988549   CalAdmissions  
##  3 27103822   UW             
##  4 198643896  USCAdmission   
##  5 40940457   uoregon        
##  6 325014504  FutureSunDevils
##  7 2938776590 UCLAAdmission  
##  8 4922145709 UtahAdmissions 
##  9 45879674   futurebuffs    
## 10 44733626   uaadmissions   
## 11 403743606  BeaverVIP
```

<br>
**[Base R method]** Use `str_c()` to combine `user_id` and `screen_name`:


```r
str_c(p12_unique_df$user_id, "=", p12_unique_df$screen_name, sep = " ", collapse = ", ")
```

```
## [1] "22080148 = WSUPullman, 15988549 = CalAdmissions, 27103822 = UW, 198643896 = USCAdmission, 40940457 = uoregon, 325014504 = FutureSunDevils, 2938776590 = UCLAAdmission, 4922145709 = UtahAdmissions, 45879674 = futurebuffs, 44733626 = uaadmissions, 403743606 = BeaverVIP"
```

<br>
**[Tidyverse method]** Use `str_c()` to combine `user_id` and `screen_name`:


```r
p12_unique_df %>% mutate(twitter_handle = str_c("User #", user_id, " is @", screen_name))
```

```
## # A tibble: 11 x 3
##    user_id    screen_name     twitter_handle                     
##    <chr>      <chr>           <chr>                              
##  1 22080148   WSUPullman      User #22080148 is @WSUPullman      
##  2 15988549   CalAdmissions   User #15988549 is @CalAdmissions   
##  3 27103822   UW              User #27103822 is @UW              
##  4 198643896  USCAdmission    User #198643896 is @USCAdmission   
##  5 40940457   uoregon         User #40940457 is @uoregon         
##  6 325014504  FutureSunDevils User #325014504 is @FutureSunDevils
##  7 2938776590 UCLAAdmission   User #2938776590 is @UCLAAdmission 
##  8 4922145709 UtahAdmissions  User #4922145709 is @UtahAdmissions
##  9 45879674   futurebuffs     User #45879674 is @futurebuffs     
## 10 44733626   uaadmissions    User #44733626 is @uaadmissions    
## 11 403743606  BeaverVIP       User #403743606 is @BeaverVIP
```

</details>

## `str_sub()`

<br>
__The `str_sub()` function__:


```r
?str_sub

# SYNTAX AND DEFAULT VALUES
str_sub(string, start = 1L, end = -1L)
str_sub(string, start = 1L, end = -1L, omit_na = FALSE) <- value
```

- Function: Subset strings
- Arguments:
  - `string`: Character vector (or vector coercible to character)
  - `start`: Position of first character to be included in substring (default: `1`)
  - `end`: Position of last character to be included in substring (default: `-1`)
    - Negative index means counting backwards from the end of the string
    - If an element in the vector is shorter than the specified `end`, it will just include all the available characters that it does have
  - `omit_na`: If `TRUE`, missing values in any of the arguments provided will result in an unchanged input
- When `str_sub()` is used in the assignment form, you can replace the subsetted part of the string with a `value` of your choice
  - If an element in the vector is too short to meet the subset specification, the replacement `value` will be concatenated to the end of that element
  - Note that this modifies your input vector directly, so you must have the vector saved to a variable (see example below)


<br>
<details><summary>**Example**: Using `str_sub()` to subset strings</summary>

If no `start` and `end` positions are specified, `str_sub()` will by default return the entire (original) string:


```r
str_sub(c("abcdefg", 123, TRUE))
```

```
## [1] "abcdefg" "123"     "TRUE"
```

Note that if an element is shorter than the specified `end` (i.e., `123` in the example below), it will just include all the available characters that it does have:


```r
str_sub(c("abcdefg", 123, TRUE), start = 2, end = 4)
```

```
## [1] "bcd" "23"  "RUE"
```

Remember we can also use negative index to count the position starting from the back:


```r
str_sub(c("abcdefg", 123, TRUE), start = 2, end = -2)
```

```
## [1] "bcdef" "2"     "RU"
```

</details>

<br>
<details><summary>**Example**: Using `str_sub()` to replace strings</summary>

If no `start` and `end` positions are specified, `str_sub()` will by default return the original string, so the entire string would be replaced:


```r
v <- c("A", "AB", "ABC", "ABCD", "ABCDE")
str_sub(v) <- "*"
v
```

```
## [1] "*" "*" "*" "*" "*"
```

If an element in the vector is too short to meet the subset specification, the replacement `value` will be concatenated to the end of that element:


```r
v <- c("A", "AB", "ABC", "ABCD", "ABCDE")
str_sub(v, 2, 3) <- "*"
v
```

```
## [1] "A*"   "A*"   "A*"   "A*D"  "A*DE"
```

Note that because the replacement form of `str_sub()` modifies the input vector directly, we need to save it in a variable first. Directly passing in the vector to `str_sub()` would give us an error:


```r
# Does not work
str_sub(c("A", "AB", "ABC", "ABCD", "ABCDE")) <- "*"
```

</details>

<br>
<details><summary>**Example**: Using `str_sub()` on dataframe column</summary>

We can use `as.character()` to turn the `created_at` value to a string, then use `str_sub()` to extract out various date/time components from the string:


```r
p12_datetime_df <- p12_df %>% select(created_at) %>%
  mutate(
      dt_chr = as.character(created_at),
      date_chr = str_sub(dt_chr, 1, 10),
      yr_chr = str_sub(dt_chr, 1, 4),
      mth_chr = str_sub(dt_chr, 6, 7),
      day_chr = str_sub(dt_chr, 9, 10),
      hr_chr = str_sub(dt_chr, -8, -7),
      min_chr = str_sub(dt_chr, -5, -4),
      sec_chr = str_sub(dt_chr, -2, -1)
    )
p12_datetime_df
```

```
## # A tibble: 328 x 9
##    created_at          dt_chr date_chr yr_chr mth_chr day_chr hr_chr
##    <dttm>              <chr>  <chr>    <chr>  <chr>   <chr>   <chr> 
##  1 2020-04-25 22:37:18 2020-… 2020-04… 2020   04      25      22    
##  2 2020-04-23 21:11:49 2020-… 2020-04… 2020   04      23      21    
##  3 2020-04-21 04:00:00 2020-… 2020-04… 2020   04      21      04    
##  4 2020-04-24 03:00:00 2020-… 2020-04… 2020   04      24      03    
##  5 2020-04-20 19:00:21 2020-… 2020-04… 2020   04      20      19    
##  6 2020-04-20 02:20:01 2020-… 2020-04… 2020   04      20      02    
##  7 2020-04-22 04:00:00 2020-… 2020-04… 2020   04      22      04    
##  8 2020-04-25 17:00:00 2020-… 2020-04… 2020   04      25      17    
##  9 2020-04-21 15:13:06 2020-… 2020-04… 2020   04      21      15    
## 10 2020-04-21 17:52:47 2020-… 2020-04… 2020   04      21      17    
## # … with 318 more rows, and 2 more variables: min_chr <chr>, sec_chr <chr>
```

</details>

## Other `stringr` functions

Other useful `stringr` functions:

- `str_to_upper()`: Turn strings to uppercase
- `str_to_lower()`: Turn strings to lowercase
- `str_sort()`: Sort a character vector
- `str_trim()`: Trim whitespace from strings (including `\n`, `\t`, etc.)
- `str_pad()`: Pad strings with specified character


<br>
<details><summary>**Example**: Using `str_to_upper()` to turn strings to uppercase</summary>

Turn column names of `p12_df` to uppercase:


```r
# Column names are originally lowercase
names(p12_df)
```

```
## [1] "user_id"     "created_at"  "screen_name" "text"        "location"
```

```r
# Turn column names to uppercase
names(p12_df) <- str_to_upper(names(p12_df))
names(p12_df)
```

```
## [1] "USER_ID"     "CREATED_AT"  "SCREEN_NAME" "TEXT"        "LOCATION"
```

</details>

<br>
<details><summary>**Example**: Using `str_to_lower()` to turn strings to lowercase</summary>

Turn column names of `p12_df` to lowercase:


```r
# Column names are originally uppercase
names(p12_df)
```

```
## [1] "USER_ID"     "CREATED_AT"  "SCREEN_NAME" "TEXT"        "LOCATION"
```

```r
# Turn column names to lowercase
names(p12_df) <- str_to_lower(names(p12_df))
names(p12_df)
```

```
## [1] "user_id"     "created_at"  "screen_name" "text"        "location"
```

</details>

<br>
<details><summary>**Example**: Using `str_sort()` to sort character vector</summary>

Sort the vector of `p12_df` column names:


```r
# Before sort
names(p12_df)
```

```
## [1] "user_id"     "created_at"  "screen_name" "text"        "location"
```

```r
# Sort alphabetically (default)
str_sort(names(p12_df))
```

```
## [1] "created_at"  "location"    "screen_name" "text"        "user_id"
```

```r
# Sort reverse alphabetically
str_sort(names(p12_df), decreasing = TRUE)
```

```
## [1] "user_id"     "text"        "screen_name" "location"    "created_at"
```

</details>

<br>
<details><summary>**Example**: Using `str_trim()` to trim whitespace from string</summary>


```r
# Trim whitespace from both left and right sides (default)
str_trim(c("\nABC ", " XYZ\t"))
```

```
## [1] "ABC" "XYZ"
```

```r
# Trim whitespace from left side
str_trim(c("\nABC ", " XYZ\t"), side = "left")
```

```
## [1] "ABC "  "XYZ\t"
```

```r
# Trim whitespace from right side
str_trim(c("\nABC ", " XYZ\t"), side = "right")
```

```
## [1] "\nABC" " XYZ"
```

</details>

<br>
<details><summary>**Example**: Using `str_pad()` to pad string with character</summary>

Let's say we have a vector of zip codes that has lost all leading 0's. We can use `str_pad()` to add that back in:


```r
# Pad the left side of strings with "0" until width of 5 is reached
str_pad(c(95035, 90024, 5009, 5030), width = 5, side = "left", pad = "0")
```

```
## [1] "95035" "90024" "05009" "05030"
```

</details>


# Dates and times

> "Date-time data can be frustrating to work with in R. R commands for date-times are generally unintuitive and change depending on the type of date-time object being used. Moreover, the methods we use with date-times must be robust to time zones, leap days, daylight savings times, and other time related quirks, and R lacks these capabilities in some situations. Lubridate makes it easier to do the things R does with date-times and possible to do the things R does not."

*Credit: `lubridate` [documentation](https://lubridate.tidyverse.org/)*

How are dates and times stored in R? (From [Dates and Times in R](https://www.stat.berkeley.edu/~s133/dates.html))

- The `Date` class is used for storing dates
  - "Internally, `Date` objects are stored as the number of days since January 1, 1970, using negative numbers for earlier dates. The `as.numeric()` function can be used to convert a `Date` object to its internal form."
- POSIX classes can be used for storing date plus times
  - "The `POSIXct` class stores date/time values as the number of seconds since January 1, 1970"
  - "The `POSIXlt` class stores date/time values as a list of components (hour, min, sec, mon, etc.) making it easy to extract these parts"
- There is no native R class for storing only time


Why use date/time objects?

- Using date/time objects makes it easier to fetch or modify various date/time components (e.g., year, month, day, day of the week)
  - Compared to if the date/time is just stored in a string, these components are not as readily accessible and needs to be parsed
- You can perform certain arithmetics with date/time objects (e.g., find the "difference" between date/time points)


## Creating date/time objects

### Creating date/time objects by parsing input

Functions that create date/time objects **by parsing character or numeric input**:

- Create `Date` object: `ymd()`, `ydm()`, `mdy()`, `myd()`, `dmy()`, `dym()`
  - `y` stands for year, `m` stands for month, `d` stands for day
  - Select the function that represents the order in which your date input is formatted, and the function will be able to parse your input and create a `Date` object
- Create `POSIXct` object: `ymd_h()`, `ymd_hm()`, `ymd_hms()`, etc.
  - `h` stands for hour, `m` stands for minute, `s` stands for second
  - For any of the previous 6 date functions, you can append `h`, `hm`, or `hms` if you want to provide additional time information in order to create a `POSIXct` object
  - To force a `POSIXct` object without providing any time information, you can just provide a timezone (using `tz`) to one of the date functions and it will assume midnight as the time
  - You can use `Sys.timezone()` to get the timezone for your location
  

<br>
<details><summary>**Example**: Creating `Date` object from character or numeric input</summary>

The `lubridate` functions are flexible and can parse dates in various formats:


```r
d <- mdy("1/1/2020")
d
```

```
## [1] "2020-01-01"
```

```r
d <- mdy("1-1-2020")
d
```

```
## [1] "2020-01-01"
```

```r
d <- mdy("Jan. 1, 2020")
d
```

```
## [1] "2020-01-01"
```

```r
d <- ymd(20200101)
d
```

```
## [1] "2020-01-01"
```

<br>
Investigate the `Date` object:


```r
class(d)
```

```
## [1] "Date"
```

```r
typeof(d)
```

```
## [1] "double"
```

```r
# Number of days since January 1, 1970
as.numeric(d)
```

```
## [1] 18262
```

</details>


<br>
<details><summary>**Example**: Creating `POSIXct` object from character or numeric input</summary>

The `lubridate` functions are flexible and can parse AM/PM in various formats:


```r
dt <- mdy_h("12/31/2019 11pm")
dt
```

```
## [1] "2019-12-31 23:00:00 UTC"
```

```r
dt <- mdy_hm("12/31/2019 11:59 pm")
dt
```

```
## [1] "2019-12-31 23:59:00 UTC"
```

```r
dt <- mdy_hms("12/31/2019 11:59:59 PM")
dt
```

```
## [1] "2019-12-31 23:59:59 UTC"
```

```r
dt <- ymd_hms(20191231235959)
dt
```

```
## [1] "2019-12-31 23:59:59 UTC"
```

<br>
Investigate the `POSIXct` object:


```r
class(dt)
```

```
## [1] "POSIXct" "POSIXt"
```

```r
typeof(dt)
```

```
## [1] "double"
```

```r
# Number of seconds since January 1, 1970
as.numeric(dt)
```

```
## [1] 1577836799
```

<br>
We can also create a `POSIXct` object from a date function by providing a timezone. The time would default to midnight:


```r
dt <- mdy("1/1/2020", tz = "UTC")
dt
```

```
## [1] "2020-01-01 UTC"
```

```r
# Number of seconds since January 1, 1970
as.numeric(dt)  # Note that this is indeed 1 sec after the previous example
```

```
## [1] 1577836800
```

</details>


<br>
<details><summary>**Example**: Creating `Date` objects from dataframe column</summary>

Using the `p12_datetime_df` we created earlier, we can create `Date` objects from the `date_chr` column:


```r
# Use `ymd()` to parse the string stored in the `date_chr` column
p12_datetime_df %>% select(created_at, dt_chr, date_chr) %>%
  mutate(date_ymd = ymd(date_chr))
```

```
## # A tibble: 328 x 4
##    created_at          dt_chr              date_chr   date_ymd  
##    <dttm>              <chr>               <chr>      <date>    
##  1 2020-04-25 22:37:18 2020-04-25 22:37:18 2020-04-25 2020-04-25
##  2 2020-04-23 21:11:49 2020-04-23 21:11:49 2020-04-23 2020-04-23
##  3 2020-04-21 04:00:00 2020-04-21 04:00:00 2020-04-21 2020-04-21
##  4 2020-04-24 03:00:00 2020-04-24 03:00:00 2020-04-24 2020-04-24
##  5 2020-04-20 19:00:21 2020-04-20 19:00:21 2020-04-20 2020-04-20
##  6 2020-04-20 02:20:01 2020-04-20 02:20:01 2020-04-20 2020-04-20
##  7 2020-04-22 04:00:00 2020-04-22 04:00:00 2020-04-22 2020-04-22
##  8 2020-04-25 17:00:00 2020-04-25 17:00:00 2020-04-25 2020-04-25
##  9 2020-04-21 15:13:06 2020-04-21 15:13:06 2020-04-21 2020-04-21
## 10 2020-04-21 17:52:47 2020-04-21 17:52:47 2020-04-21 2020-04-21
## # … with 318 more rows
```

</details>

<br>
<details><summary>**Example**: Creating `POSIXct` objects from dataframe column</summary>

Using the `p12_datetime_df` we created earlier, we can recreate the `created_at` column (class `POSIXct`) from the `dt_chr` column (class `character`):


```r
# Use `ymd_hms()` to parse the string stored in the `dt_chr` column
p12_datetime_df %>% select(created_at, dt_chr) %>%
  mutate(datetime_ymd_hms = ymd_hms(dt_chr))
```

```
## # A tibble: 328 x 3
##    created_at          dt_chr              datetime_ymd_hms   
##    <dttm>              <chr>               <dttm>             
##  1 2020-04-25 22:37:18 2020-04-25 22:37:18 2020-04-25 22:37:18
##  2 2020-04-23 21:11:49 2020-04-23 21:11:49 2020-04-23 21:11:49
##  3 2020-04-21 04:00:00 2020-04-21 04:00:00 2020-04-21 04:00:00
##  4 2020-04-24 03:00:00 2020-04-24 03:00:00 2020-04-24 03:00:00
##  5 2020-04-20 19:00:21 2020-04-20 19:00:21 2020-04-20 19:00:21
##  6 2020-04-20 02:20:01 2020-04-20 02:20:01 2020-04-20 02:20:01
##  7 2020-04-22 04:00:00 2020-04-22 04:00:00 2020-04-22 04:00:00
##  8 2020-04-25 17:00:00 2020-04-25 17:00:00 2020-04-25 17:00:00
##  9 2020-04-21 15:13:06 2020-04-21 15:13:06 2020-04-21 15:13:06
## 10 2020-04-21 17:52:47 2020-04-21 17:52:47 2020-04-21 17:52:47
## # … with 318 more rows
```

</details>


### Creating date/time objects from individual components

Functions that create date/time objects **from various date/time components**:

- Create `Date` object: `make_date()`
  - Syntax and default values: `make_date(year = 1970L, month = 1L, day = 1L)`
  - All inputs are coerced to integer
- Create `POSIXct` object: `make_datetime()`
  - Syntax and default values: `make_datetime(year = 1970L, month = 1L, day = 1L, hour = 0L, min = 0L, sec = 0, tz = "UTC")`

<br>
<details><summary>**Example**: Creating `Date` object from individual components</summary>

There are various ways to pass in the inputs to create the same `Date` object:


```r
d <- make_date(2020, 1, 1)
d
```

```
## [1] "2020-01-01"
```

```r
# Characters can be coerced to integers
d <- make_date("2020", "01", "01")
d
```

```
## [1] "2020-01-01"
```

```r
# Remember that the default values for month and day would be 1L
d <- make_date(2020)
d
```

```
## [1] "2020-01-01"
```

</details>


<br>
<details><summary>**Example**: Creating `POSIXct` object from individual components</summary>


```r
# Inputs should be numeric
d <- make_datetime(2019, 12, 31, 23, 59, 59)
d
```

```
## [1] "2019-12-31 23:59:59 UTC"
```

</details>

<br>
<details><summary>**Example**: Creating `Date` objects from dataframe columns</summary>

Using the `p12_datetime_df` we created earlier, we can create `Date` objects from the various date component columns:


```r
# Use `make_date()` to create a `Date` object from the `yr_chr`, `mth_chr`, `day_chr` fields
p12_datetime_df %>% select(created_at, dt_chr, yr_chr, mth_chr, day_chr) %>%
  mutate(date_make_date = make_date(yr_chr, mth_chr, day_chr))
```

```
## # A tibble: 328 x 6
##    created_at          dt_chr         yr_chr mth_chr day_chr date_make_date
##    <dttm>              <chr>          <chr>  <chr>   <chr>   <date>        
##  1 2020-04-25 22:37:18 2020-04-25 22… 2020   04      25      2020-04-25    
##  2 2020-04-23 21:11:49 2020-04-23 21… 2020   04      23      2020-04-23    
##  3 2020-04-21 04:00:00 2020-04-21 04… 2020   04      21      2020-04-21    
##  4 2020-04-24 03:00:00 2020-04-24 03… 2020   04      24      2020-04-24    
##  5 2020-04-20 19:00:21 2020-04-20 19… 2020   04      20      2020-04-20    
##  6 2020-04-20 02:20:01 2020-04-20 02… 2020   04      20      2020-04-20    
##  7 2020-04-22 04:00:00 2020-04-22 04… 2020   04      22      2020-04-22    
##  8 2020-04-25 17:00:00 2020-04-25 17… 2020   04      25      2020-04-25    
##  9 2020-04-21 15:13:06 2020-04-21 15… 2020   04      21      2020-04-21    
## 10 2020-04-21 17:52:47 2020-04-21 17… 2020   04      21      2020-04-21    
## # … with 318 more rows
```

</details>

<br>
<details><summary>**Example**: Creating `POSIXct` objects from dataframe columns</summary>

Using the `p12_datetime_df` we created earlier, we can recreate the `created_at` column (class `POSIXct`) from the various date and time component columns (class `character`):


```r
# Use `make_datetime()` to create a `POSIXct` object from the `yr_chr`, `mth_chr`, `day_chr`, `hr_chr`, `min_chr`, `sec_chr` fields
# Convert inputs to integers first
p12_datetime_df %>%
  mutate(datetime_make_datetime = make_datetime(
    as.integer(yr_chr), as.integer(mth_chr), as.integer(day_chr), 
    as.integer(hr_chr), as.integer(min_chr), as.integer(sec_chr)
  ))
```

```
## # A tibble: 328 x 10
##    created_at          dt_chr date_chr yr_chr mth_chr day_chr hr_chr
##    <dttm>              <chr>  <chr>    <chr>  <chr>   <chr>   <chr> 
##  1 2020-04-25 22:37:18 2020-… 2020-04… 2020   04      25      22    
##  2 2020-04-23 21:11:49 2020-… 2020-04… 2020   04      23      21    
##  3 2020-04-21 04:00:00 2020-… 2020-04… 2020   04      21      04    
##  4 2020-04-24 03:00:00 2020-… 2020-04… 2020   04      24      03    
##  5 2020-04-20 19:00:21 2020-… 2020-04… 2020   04      20      19    
##  6 2020-04-20 02:20:01 2020-… 2020-04… 2020   04      20      02    
##  7 2020-04-22 04:00:00 2020-… 2020-04… 2020   04      22      04    
##  8 2020-04-25 17:00:00 2020-… 2020-04… 2020   04      25      17    
##  9 2020-04-21 15:13:06 2020-… 2020-04… 2020   04      21      15    
## 10 2020-04-21 17:52:47 2020-… 2020-04… 2020   04      21      17    
## # … with 318 more rows, and 3 more variables: min_chr <chr>,
## #   sec_chr <chr>, datetime_make_datetime <dttm>
```

</details>

## Date/time object components

Storing data using date/time objects makes it easier to **get and set** the various date/time components.

- Basic accessor functions:
  - `date()`: Date component
  - `year()`: Year
  - `month()`: Month
  - `day()`: Day
  - `hour()`: Hour
  - `min()`: Minute
  - `sec()`: Second
  - `week()`: Week of the year
  - `wday()`: Day of the week (`1` for Sunday to `7` for Saturday)
  - `am()`: Is it in the am? (returns `TRUE` or `FALSE`)
  - `pm()`: Is it in the pm? (returns `TRUE` or `FALSE`)
- To **get** a date/time component, you can simply pass a date/time object to the function
  - Syntax: `accessor_function(<date/time_object>)`
- To **set** a date/time component, you can assign into the accessor function to change the component
  - Syntax: `accessor_function(<date/time_object>) <- "new_component"`
  - Note that `am()` and `pm()` can't be set. Modify the time components instead.

<br>
<details><summary>**Example**: Getting date/time components</summary>


```r
# Create datetime for New Year's Eve
dt <- make_datetime(2019, 12, 31, 23, 59, 59)
dt
```

```
## [1] "2019-12-31 23:59:59 UTC"
```

```r
# Get date
date(dt)
```

```
## [1] "2019-12-31"
```

```r
# Get hour
hour(dt)
```

```
## [1] 23
```

```r
# Is it pm?
pm(dt)
```

```
## [1] TRUE
```

```r
# Day of the week (3 = Tuesday)
wday(dt)
```

```
## [1] 3
```

</details>

<br>
<details><summary>**Example**: Setting date/time components</summary>


```r
# Create datetime for New Year's Eve
dt <- make_datetime(2019, 12, 31, 23, 59, 59)
dt
```

```
## [1] "2019-12-31 23:59:59 UTC"
```

```r
# Get week of year
week(dt)
```

```
## [1] 53
```

```r
# Set week of year (move back 1 week)
week(dt) <- week(dt) - 1

# Date now moved from New Year's Eve to Christmas Eve
dt
```

```
## [1] "2019-12-24 23:59:59 UTC"
```

```r
# Set day to Christmas Day
day(dt) <- 25

# Date now moved from Christmas Eve to Christmas Day
dt
```

```
## [1] "2019-12-25 23:59:59 UTC"
```

</details>

<br>
<details><summary>**Example**: Getting date/time components from dataframe column</summary>

Using the `p12_datetime_df` we created earlier, we can isolate the various date/time components from the `POSIXct` object in the `created_at` column:


```r
# The extracted date/time components will be of numeric type
p12_datetime_df %>% select(created_at) %>%
  mutate(
    yr_num = year(created_at),
    mth_num = month(created_at),
    day_num = day(created_at),
    hr_num = hour(created_at),
    min_num = minute(created_at),
    sec_num = second(created_at),
    ampm = ifelse(am(created_at), 'AM', 'PM')  # am()/pm() returns TRUE/FALSE
  )
```

```
## # A tibble: 328 x 8
##    created_at          yr_num mth_num day_num hr_num min_num sec_num ampm 
##    <dttm>               <dbl>   <dbl>   <int>  <int>   <int>   <dbl> <chr>
##  1 2020-04-25 22:37:18   2020       4      25     22      37      18 PM   
##  2 2020-04-23 21:11:49   2020       4      23     21      11      49 PM   
##  3 2020-04-21 04:00:00   2020       4      21      4       0       0 AM   
##  4 2020-04-24 03:00:00   2020       4      24      3       0       0 AM   
##  5 2020-04-20 19:00:21   2020       4      20     19       0      21 PM   
##  6 2020-04-20 02:20:01   2020       4      20      2      20       1 AM   
##  7 2020-04-22 04:00:00   2020       4      22      4       0       0 AM   
##  8 2020-04-25 17:00:00   2020       4      25     17       0       0 PM   
##  9 2020-04-21 15:13:06   2020       4      21     15      13       6 PM   
## 10 2020-04-21 17:52:47   2020       4      21     17      52      47 PM   
## # … with 318 more rows
```

</details>


## Time spans

![](../../assets/images/time_spans.png)

3 ways to represent time spans (From [lubridate cheatsheet](https://rawgit.com/rstudio/cheatsheets/master/lubridate.pdf))

- **Intervals** represent specific intervals of the timeline, bounded by start and end date-times
  - Example: People with birthdays between the **interval** October 23 to November 22 are Scorpios
- **Periods** track changes in clock times, which ignore time line irregularities
  - Example: Daylight savings time ends at the beginning of November and we gain an hour - this extra hour is _ignored_ when determining the **period** between October 23 to November 22
- **Durations** track the passage of physical time, which deviates from clock time when irregularities occur
  - Example: Daylight savings time ends at the beginning of November and we gain an hour - this extra hour is _added_ when determining the **duration** between October 23 to November 22


### Time spans using `lubridate`

Using the `lubridate` package for time spans:

- **Interval**
  - Create an interval using `interval()` or `%--%`
    - Syntax: `interval(<date/time_object1>, <date/time_object2>)` or `<date/time_object1> %--% <date/time_object2>`
- **Periods**
  - "Periods are time spans but don’t have a fixed length in seconds, instead they work with '_human_' times, like days and months." (From [R for Data Science](https://r4ds.had.co.nz/dates-and-times.html#periods))
  - Create periods using functions whose name is the time unit pluralized (e.g., `years()`, `months()`, `weeks()`, `days()`, `hours()`, `minutes()`, `seconds()`)
    - Example: `days(1)` creates a period of 1 day - it does not matter if this day happened to have an extra hour due to daylight savings ending, since periods do not have a physical length
      
      ```r
      days(1)
      ```
      
      ```
      ## [1] "1d 0H 0M 0S"
      ```
  - You can add and subtract periods
  - You can also use `as.period()` to get period of an interval
- **Durations**
  - Durations keep track of the physical amount of time elapsed, so it is "stored as seconds, the only time unit with a consistent length" (From [lubridate cheatsheet](https://rawgit.com/rstudio/cheatsheets/master/lubridate.pdf))
  - Create durations using functions whose name is the time unit prefixed with a `d` (e.g., `dyears()`, `dweeks()`, `ddays()`, `dhours()`, `dminutes()`, `dseconds()`)
    - Example: `ddays(1)` creates a duration of `86400s`, using the standard conversion of `60` seconds in an minute, `60` minutes in an hour, and `24` hours in a day:
      
      ```r
      ddays(1)
      ```
      
      ```
      ## [1] "86400s (~1 days)"
      ```
      Notice that the output says this is equivalent to _approximately_ `1` day, since it acknowledges that not all days have `24` hours. In the case of daylight savings, one particular day may have `25` hours, so the duration of that day should be represented as:
      
      ```r
      ddays(1) + dhours(1)
      ```
      
      ```
      ## [1] "90000s (~1.04 days)"
      ```
  - You can add and subract durations
  - You can also use `as.duration()` to get duration of an interval


<br>
<details><summary>**Example**: Working with interval</summary>


```r
# Use `Sys.timezone()` to get timezone for your location (time is midnight by default)
scorpio_start <- ymd("2019-10-23", tz = Sys.timezone())
scorpio_end <- ymd("2019-11-22", tz = Sys.timezone())

# These datetime objects have class `POSIXct`
class(scorpio_start)
```

```
## [1] "POSIXct" "POSIXt"
```

```r
# Create interval for the datetimes
scorpio_interval <- scorpio_start %--% scorpio_end  # or `interval(scorpio_start, scorpio_end)`
scorpio_interval
```

```
## [1] 2019-10-23 PDT--2019-11-22 PST
```

```r
# The object has class `Interval`
class(scorpio_interval)
```

```
## [1] "Interval"
## attr(,"package")
## [1] "lubridate"
```

</details>

<br>
<details><summary>**Example**: Working with period</summary>

If we use `as.period()` to get the period of `scorpio_interval`, we see that it is a period of `30` days. We do not worry about the extra `1` hour gained due to daylight savings ending:


```r
# Period is 30 days
scorpio_period <- as.period(scorpio_interval)
scorpio_period
```

```
## [1] "30d 0H 0M 0S"
```

```r
# The object has class `Period`
class(scorpio_period)
```

```
## [1] "Period"
## attr(,"package")
## [1] "lubridate"
```

<br>
Because periods work with "human" times like days, it is more intuitive. For example, if we add a period of `30` days to the `scorpio_start` datetime object, we get the expected end datetime that is `30` days later:


```r
# Start datetime for Scorpio birthdays (time is midnight)
scorpio_start
```

```
## [1] "2019-10-23 PDT"
```

```r
# After adding 30 day period, we get the expected end datetime (time is midnight)
scorpio_start + days(30)
```

```
## [1] "2019-11-22 PST"
```

</details>

<br>
<details><summary>**Example**: Working with duration</summary>

If we use `as.duration()` to get the duration of `scorpio_interval`, we see that it is a duration of `2595600` seconds. It takes into account the extra `1` hour gained due to daylight savings ending:


```r
# Duration is 2595600 seconds, which is equivalent to 30 24-hr days + 1 additional hour
scorpio_duration <- as.duration(scorpio_interval)
scorpio_duration
```

```
## [1] "2595600s (~4.29 weeks)"
```

```r
# The object has class `Duration`
class(scorpio_duration)
```

```
## [1] "Duration"
## attr(,"package")
## [1] "lubridate"
```

```r
# Using the standard 60s/min, 60min/hr, 24hr/day conversion,
# confirm duration is slightly more than 30 "standard" (ie. 24-hr) days
2595600 / (60 * 60 * 24)
```

```
## [1] 30.04167
```

```r
# Specifically, it is 30 days + 1 hour, if we define a day to have 24 hours
seconds_to_period(scorpio_duration)
```

```
## [1] "30d 1H 0M 0S"
```


<br>
Because durations work with physical time, when we add a duration of `30` days to the `scorpio_start` datetime object, we do not get the end datetime we'd expect:


```r
# Start datetime for Scorpio birthdays (time is midnight)
scorpio_start
```

```
## [1] "2019-10-23 PDT"
```

```r
# After adding 30 day duration, we do not get the expected end datetime
# `ddays(30)` adds the number of seconds in 30 standard 24-hr days, but one of the days has 25 hours
scorpio_start + ddays(30)
```

```
## [1] "2019-11-21 23:00:00 PST"
```

```r
# We need to add the additional 1 hour of physical time that elapsed during this time span
scorpio_start + ddays(30) + dhours(1)
```

```
## [1] "2019-11-22 PST"
```

</details>


