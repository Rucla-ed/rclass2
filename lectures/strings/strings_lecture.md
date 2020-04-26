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
```

Resources used to create this lecture:

- https://r4ds.had.co.nz/strings.html
- https://www.tutorialspoint.com/r/r_strings.htm
- https://swcarpentry.github.io/r-novice-inflammation/13-supp-data-structures/
- https://www.statmethods.net/input/datatypes.html

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
## Rows: 328
## Columns: 90
## $ user_id                 <chr> "22080148", "22080148", "22080148", "22080148…
## $ status_id               <chr> "1254177694599675904", "1253431405993840646",…
## $ created_at              <dttm> 2020-04-25 22:37:18, 2020-04-23 21:11:49, 20…
## $ screen_name             <chr> "WSUPullman", "WSUPullman", "WSUPullman", "WS…
## $ text                    <chr> "Big Dez is headed to Indy!\n\n#GoCougs | #NF…
## $ source                  <chr> "Twitter for iPhone", "Twitter Web App", "Twi…
## $ display_text_width      <dbl> 125, 58, 246, 83, 56, 64, 156, 271, 69, 140, …
## $ reply_to_status_id      <chr> NA, NA, NA, NA, NA, NA, NA, NA, "125261586265…
## $ reply_to_user_id        <chr> NA, NA, NA, NA, NA, NA, NA, NA, "22080148", N…
## $ reply_to_screen_name    <chr> NA, NA, NA, NA, NA, NA, NA, NA, "WSUPullman",…
## $ is_quote                <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FAL…
## $ is_retweet              <lgl> TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ favorite_count          <int> 0, 322, 30, 55, 186, 53, 22, 44, 11, 0, 69, 4…
## $ retweet_count           <int> 230, 32, 1, 5, 0, 3, 2, 6, 2, 6, 3, 4, 5, 5, …
## $ quote_count             <int> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
## $ reply_count             <int> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
## $ hashtags                <list> [<"GoCougs", "NFLDraft2020", "NFLCougs">, <"…
## $ symbols                 <list> [NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…
## $ urls_url                <list> [NA, NA, NA, NA, NA, NA, NA, "commencement.w…
## $ urls_t.co               <list> [NA, NA, NA, NA, NA, NA, NA, "https://t.co/R…
## $ urls_expanded_url       <list> [NA, NA, NA, NA, NA, NA, NA, "https://commen…
## $ media_url               <list> ["http://pbs.twimg.com/ext_tw_video_thumb/12…
## $ media_t.co              <list> ["https://t.co/NdGsvXnij7", "https://t.co/0O…
## $ media_expanded_url      <list> ["https://twitter.com/WSUCougarFB/status/125…
## $ media_type              <list> ["photo", "photo", "photo", "photo", "photo"…
## $ ext_media_url           <list> ["http://pbs.twimg.com/ext_tw_video_thumb/12…
## $ ext_media_t.co          <list> ["https://t.co/NdGsvXnij7", "https://t.co/0O…
## $ ext_media_expanded_url  <list> ["https://twitter.com/WSUCougarFB/status/125…
## $ ext_media_type          <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
## $ mentions_user_id        <list> [<"1250265324", "1409024796", "180884045">, …
## $ mentions_screen_name    <list> [<"WSUCougarFB", "dadpat7", "Colts">, NA, "W…
## $ lang                    <chr> "en", "en", "en", "en", "en", "en", "en", "en…
## $ quoted_status_id        <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, "1252…
## $ quoted_text             <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, "My W…
## $ quoted_created_at       <dttm> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 2020…
## $ quoted_source           <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, "Twit…
## $ quoted_favorite_count   <int> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 209, …
## $ quoted_retweet_count    <int> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 6, NA…
## $ quoted_user_id          <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, "4394…
## $ quoted_screen_name      <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, "madd…
## $ quoted_name             <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, "Madd…
## $ quoted_followers_count  <int> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 629, …
## $ quoted_friends_count    <int> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 382, …
## $ quoted_statuses_count   <int> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 8881,…
## $ quoted_location         <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, "Seat…
## $ quoted_description      <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, "WSU …
## $ quoted_verified         <lgl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, FALSE…
## $ retweet_status_id       <chr> "1254159118996127746", NA, NA, NA, NA, NA, NA…
## $ retweet_text            <chr> "Big Dez is headed to Indy!\n\n#GoCougs | #NF…
## $ retweet_created_at      <dttm> 2020-04-25 21:23:29, NA, NA, NA, NA, NA, NA,…
## $ retweet_source          <chr> "Twitter for iPhone", NA, NA, NA, NA, NA, NA,…
## $ retweet_favorite_count  <int> 1402, NA, NA, NA, NA, NA, NA, NA, NA, 26, NA,…
## $ retweet_retweet_count   <int> 230, NA, NA, NA, NA, NA, NA, NA, NA, 6, NA, N…
## $ retweet_user_id         <chr> "1250265324", NA, NA, NA, NA, NA, NA, NA, NA,…
## $ retweet_screen_name     <chr> "WSUCougarFB", NA, NA, NA, NA, NA, NA, NA, NA…
## $ retweet_name            <chr> "Washington State Football", NA, NA, NA, NA, …
## $ retweet_followers_count <int> 77527, NA, NA, NA, NA, NA, NA, NA, NA, 996, N…
## $ retweet_friends_count   <int> 1448, NA, NA, NA, NA, NA, NA, NA, NA, 316, NA…
## $ retweet_statuses_count  <int> 15363, NA, NA, NA, NA, NA, NA, NA, NA, 1666, …
## $ retweet_location        <chr> "Pullman, WA", NA, NA, NA, NA, NA, NA, NA, NA…
## $ retweet_description     <chr> "Official Twitter home of Washington State Co…
## $ retweet_verified        <lgl> TRUE, NA, NA, NA, NA, NA, NA, NA, NA, FALSE, …
## $ place_url               <chr> NA, NA, NA, NA, NA, "https://api.twitter.com/…
## $ place_name              <chr> NA, NA, NA, NA, NA, "Pullman", NA, NA, NA, NA…
## $ place_full_name         <chr> NA, NA, NA, NA, NA, "Pullman, WA", NA, NA, NA…
## $ place_type              <chr> NA, NA, NA, NA, NA, "city", NA, NA, NA, NA, "…
## $ country                 <chr> NA, NA, NA, NA, NA, "United States", NA, NA, …
## $ country_code            <chr> NA, NA, NA, NA, NA, "US", NA, NA, NA, NA, "US…
## $ geo_coords              <list> [<NA, NA>, <NA, NA>, <NA, NA>, <NA, NA>, <NA…
## $ coords_coords           <list> [<NA, NA>, <NA, NA>, <NA, NA>, <NA, NA>, <NA…
## $ bbox_coords             <list> [<NA, NA, NA, NA, NA, NA, NA, NA>, <NA, NA, …
## $ status_url              <chr> "https://twitter.com/WSUPullman/status/125417…
## $ name                    <chr> "WSU Pullman", "WSU Pullman", "WSU Pullman", …
## $ location                <chr> "Pullman, Washington USA", "Pullman, Washingt…
## $ description             <chr> "We are an award-winning research university …
## $ url                     <chr> "http://t.co/VxKZH9BuMS", "http://t.co/VxKZH9…
## $ protected               <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FAL…
## $ followers_count         <int> 43914, 43914, 43914, 43914, 43914, 43914, 439…
## $ friends_count           <int> 9717, 9717, 9717, 9717, 9717, 9717, 9717, 971…
## $ listed_count            <int> 556, 556, 556, 556, 556, 556, 556, 556, 556, …
## $ statuses_count          <int> 15234, 15234, 15234, 15234, 15234, 15234, 152…
## $ favourites_count        <int> 20124, 20124, 20124, 20124, 20124, 20124, 201…
## $ account_created_at      <dttm> 2009-02-26 23:39:34, 2009-02-26 23:39:34, 20…
## $ verified                <lgl> TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRU…
## $ profile_url             <chr> "http://t.co/VxKZH9BuMS", "http://t.co/VxKZH9…
## $ profile_expanded_url    <chr> "http://www.wsu.edu", "http://www.wsu.edu", "…
## $ account_lang            <lgl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
## $ profile_banner_url      <chr> "https://pbs.twimg.com/profile_banners/220801…
## $ profile_background_url  <chr> "http://abs.twimg.com/images/themes/theme5/bg…
## $ profile_image_url       <chr> "http://pbs.twimg.com/profile_images/57650290…
```

```r
p12_df <- p12_full_df %>% select("user_id", "created_at", "screen_name", "text", "location")
head(p12_df)
```

```
## # A tibble: 6 x 5
##   user_id  created_at          screen_name text                     location    
##   <chr>    <dttm>              <chr>       <chr>                    <chr>       
## 1 22080148 2020-04-25 22:37:18 WSUPullman  "Big Dez is headed to I… Pullman, Wa…
## 2 22080148 2020-04-23 21:11:49 WSUPullman  "Cougar Cheese. That's … Pullman, Wa…
## 3 22080148 2020-04-21 04:00:00 WSUPullman  "Darien McLaughlin '19,… Pullman, Wa…
## 4 22080148 2020-04-24 03:00:00 WSUPullman  "6 houses, one pick. Co… Pullman, Wa…
## 5 22080148 2020-04-20 19:00:21 WSUPullman  "Why did you choose to … Pullman, Wa…
## 6 22080148 2020-04-20 02:20:01 WSUPullman  "Tell us one of your Br… Pullman, Wa…
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

Recall that the columns in a dataframe is just a vector, so we can use `str_length()` as long as the vector is coercible to character type. Let's look at the `screen_name` column from the `p12_df`:


```r
# `p12_df` is a dataframe object
str(p12_df)
```

```
## tibble [328 × 5] (S3: tbl_df/tbl/data.frame)
##  $ user_id    : chr [1:328] "22080148" "22080148" "22080148" "22080148" ...
##  $ created_at : POSIXct[1:328], format: "2020-04-25 22:37:18" "2020-04-23 21:11:49" ...
##  $ screen_name: chr [1:328] "WSUPullman" "WSUPullman" "WSUPullman" "WSUPullman" ...
##  $ text       : chr [1:328] "Big Dez is headed to Indy!\n\n#GoCougs | #NFLDraft2020 | @dadpat7 | @Colts | #NFLCougs https://t.co/NdGsvXnij7" "Cougar Cheese. That's it. That's the tweet. \U0001f9c0#WSU #GoCougs https://t.co/0OWGvQlRZs" "Darien McLaughlin '19, and her dog, Yuki, went on a #Pullman distance walk this weekend. We will let you judge "| __truncated__ "6 houses, one pick. Cougs, which one you got? Reply \u2b07️  #WSU #CougsContain #GoCougs https://t.co/lNDx7r71b2" ...
##  $ location   : chr [1:328] "Pullman, Washington USA" "Pullman, Washington USA" "Pullman, Washington USA" "Pullman, Washington USA" ...
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
##  [1] "WSUPullman"      "CalAdmissions"   "UW"              "USCAdmission"   
##  [5] "uoregon"         "FutureSunDevils" "UCLAAdmission"   "UtahAdmissions" 
##  [9] "futurebuffs"     "uaadmissions"    "BeaverVIP"
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



# Date and times

