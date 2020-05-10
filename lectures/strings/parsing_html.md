---
title: "rvest and regex"
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

# `rvest` package

> Wrappers around the `xml2` and `httr` packages to make it easy to download, then manipulate, HTML and XML.

*Source: `rvest` package documentation*


```r
library(tidyverse)
library(rvest)
```

## Scraping HTML

__The `read_html()` function__:


```r
?read_html

# SYNTAX AND DEFAULT VALUES
read_html(x, encoding = "", ..., options = c("RECOVER", "NOERROR", "NOBLANKS"))
```

- Arguments:
  - `x`: The input can be a string containing HTML or url to the webpage you want to scrape
- Output:
  - The HTML that is read in will be returned as an `rvest` `xml_document`/`xml_node` object and can be easily parsed
  - You can also view the raw HTML using `as.character()`

<br>
<details><summary>**Example**: Using `read_html()` to read in HTML from string</summary>


```r
html <- read_html("<h1>This is a heading.</h1><p>This is a paragraph.</p>")

# View object
html
```

```
## {html_document}
## <html>
## [1] <body>\n<h1>This is a heading.</h1>\n<p>This is a paragraph.</p>\n</ ...
```

```r
# View class of object
class(html)
```

```
## [1] "xml_document" "xml_node"
```

```r
# View raw HTML
as.character(html)
```

```
## [1] "<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\" \"http://www.w3.org/TR/REC-html40/loose.dtd\">\n<html><body>\n<h1>This is a heading.</h1>\n<p>This is a paragraph.</p>\n</body></html>\n"
```

</details>

<br>
<details><summary>**Example**: Using `read_html()` to scrape the page `https://corona.help/`</summary>


```r
corona <- read_html("https://corona.help/")

# View object
corona
```

```
## {html_document}
## <html class="loading" lang="en" data-textdirection="ltr">
## [1] <head>\n<meta http-equiv="Content-Type" content="text/html; charset= ...
## [2] <body class="horizontal-layout horizontal-menu dark-layout 2-columns ...
```


```r
# View raw HTML
as.character(corona)
```

</details>

## Parsing HTML

__The `html_node()` and `html_nodes()` functions__:


```r
?html_node

# SYNTAX
html_node(x, css, xpath)


?html_nodes

# SYNTAX
html_nodes(x, css, xpath)
```

- Arguments:
  - `x`: An `rvest` `xml_document`/`xml_node` object (use `read_html()` to get this)
  - `css`: Selector (can search by HTML tag name, its attributes, etc.)
- Output:
  - `html_node()` returns the first element that it finds as an `rvest` `xml_node` object
  - `html_nodes()` returns all elements that it finds as an `rvest` `xml_nodeset` object
  - Again, you can view the raw HTML using `as.character()`

<br>
<details><summary>**Example**: Using `html_node()` and `html_nodes()` I</summary>

Remember that the input to `html_node()`/`html_nodes()` should be an `rvest` `xml_document`/`xml_node` object, which we can obtain from `read_html()`:


```r
html <- read_html("<p>Paragraph #1</p><p>Paragraph #2</p><p>Paragraph #3</p>")

# View class of object
class(html)
```

```
## [1] "xml_document" "xml_node"
```

<br>
If we search for the `p` element using `html_node()`, it will return the first result:


```r
first_p <- html_node(html, 'p')

# View class of object
class(first_p)
```

```
## [1] "xml_node"
```

```r
# View raw HTML
as.character(first_p)
```

```
## [1] "<p>Paragraph #1</p>\n"
```

<br>
If we search for the `p` element using `html_nodes()`, it will return all results:


```r
all_p <- html_nodes(html, 'p')

# View class of object
class(all_p)
```

```
## [1] "xml_nodeset"
```

```r
# View raw HTML
as.character(all_p)
```

```
## [1] "<p>Paragraph #1</p>\n" "<p>Paragraph #2</p>\n" "<p>Paragraph #3</p>"
```

<br>
Note that we could also use `%>%`:


```r
# These are equivalent to the above
first_p <- html %>% html_node('p')
all_p <- html %>% html_nodes('p')
```

</details>


<br>
<details><summary>**Example**: Using `html_node()` and `html_nodes()` II</summary>

Let's revisit the HTML we scraped from `https://corona.help/` in the previous example:


```r
# Scraped HTML is stored in this `xml_document`/`xml_node` object
class(corona)
```

```
## [1] "xml_document" "xml_node"
```

<br>
Select for the `table` element on that page using `html_node()`:


```r
# Since this table is the only table on the page, we can just use `html_node()`
corona_table <- corona %>% html_node('table')
corona_table
```

```
## {html_node}
## <table class="table table-striped table-hover-animation mb-0" id="table">
## [1] <thead id="thead"><tr>\n<th>COUNTRY</th>\n                           ...
## [2] <tbody>\n<tr>\n<td><a href="https://corona.help/country/united-state ...
```

<br>
Select for all rows in the table (ie. `tr` element) using `html_nodes()`:


```r
# We can chain `html_node()`/`html_nodes()` functions
corona_rows <- corona %>% html_node('table') %>% html_nodes('tr')

# Alternatively, we can use `table tr` as the selector to select all `tr` elements within a `table`
corona_rows <- corona %>% html_nodes('table tr')

# View first few rows
head(corona_rows)
```

```
## {xml_nodeset (6)}
## [1] <tr>\n<th>COUNTRY</th>\n                          <th>INFECTED</th>\ ...
## [2] <tr>\n<td><a href="https://corona.help/country/united-states">\n     ...
## [3] <tr>\n<td><a href="https://corona.help/country/spain">\n             ...
## [4] <tr>\n<td><a href="https://corona.help/country/italy">\n             ...
## [5] <tr>\n<td><a href="https://corona.help/country/united-kingdom">\n    ...
## [6] <tr>\n<td><a href="https://corona.help/country/russia">\n            ...
```

</details>

### Practicing regex

Below are some examples using the Coronavirus data from https://corona.help/. Recall that we have selected for all rows in the data table on that page:


```r
# View first few rows
head(corona_rows)
```

```
## {xml_nodeset (6)}
## [1] <tr>\n<th>COUNTRY</th>\n                          <th>INFECTED</th>\ ...
## [2] <tr>\n<td><a href="https://corona.help/country/united-states">\n     ...
## [3] <tr>\n<td><a href="https://corona.help/country/spain">\n             ...
## [4] <tr>\n<td><a href="https://corona.help/country/italy">\n             ...
## [5] <tr>\n<td><a href="https://corona.help/country/united-kingdom">\n    ...
## [6] <tr>\n<td><a href="https://corona.help/country/russia">\n            ...
```

Let's convert this to raw HTML using `as.character()` to practice writing regular expressions:


```r
# Convert rows to raw HTML (skip header row)
rows <- as.character(corona_rows)[-c(1)]

# View first few rows as raw HTML
writeLines(head(rows, 2))
```

```
## <tr>
## <td><a href="https://corona.help/country/united-states">
##                               <div style="height:100%;width:100%">United States</div>
##                             </a></td>
##                           <td class="text-warning">1,347,309</td>
##                           <td class="text-warning text-bold-700">306</td>
##                           <td class="text-danger">80,037</td>
##                           <td class="text-danger text-bold-700">5</td>
##                           <td class="text-success">238,078</td>
##                           <td class="text-success text-bold-700">885</td>
##                           <td class="text-warning">1,029,194</td>
##                           <td class="text-danger">16,816</td>
##                           <td class="text-warning">8,918,263</td>
## 
##                           
##                         </tr>
## 
## <tr>
## <td><a href="https://corona.help/country/spain">
##                               <div style="height:100%;width:100%">Spain</div>
##                             </a></td>
##                           <td class="text-warning">262,783</td>
##                           <td class="text-warning text-bold-700">0</td>
##                           <td class="text-danger">26,478</td>
##                           <td class="text-danger text-bold-700">0</td>
##                           <td class="text-success">173,157</td>
##                           <td class="text-success text-bold-700">0</td>
##                           <td class="text-warning">63,148</td>
##                           <td class="text-danger">1,741</td>
##                           <td class="text-warning">2,467,761</td>
## 
##                           
##                         </tr>
```

<br>
<details><summary>**Example**: Using `str_subset()` to subset rows</summary>

Subset rows by country name:


```r
subset_by_country <- str_subset(string = rows, pattern = 'United \\w+')
writeLines(subset_by_country)
```

```
## <tr>
## <td><a href="https://corona.help/country/united-states">
##                               <div style="height:100%;width:100%">United States</div>
##                             </a></td>
##                           <td class="text-warning">1,347,309</td>
##                           <td class="text-warning text-bold-700">306</td>
##                           <td class="text-danger">80,037</td>
##                           <td class="text-danger text-bold-700">5</td>
##                           <td class="text-success">238,078</td>
##                           <td class="text-success text-bold-700">885</td>
##                           <td class="text-warning">1,029,194</td>
##                           <td class="text-danger">16,816</td>
##                           <td class="text-warning">8,918,263</td>
## 
##                           
##                         </tr>
## 
## <tr>
## <td><a href="https://corona.help/country/united-kingdom">
##                               <div style="height:100%;width:100%">United Kingdom</div>
##                             </a></td>
##                           <td class="text-warning">216,398</td>
##                           <td class="text-warning text-bold-700">0</td>
##                           <td class="text-danger">31,658</td>
##                           <td class="text-danger text-bold-700">0</td>
##                           <td class="text-success">924</td>
##                           <td class="text-success text-bold-700">0</td>
##                           <td class="text-warning">183,816</td>
##                           <td class="text-danger">1,559</td>
##                           <td class="text-warning">1,728,443</td>
## 
##                           
##                         </tr>
## 
## <tr>
## <td><a href="https://corona.help/country/united-arab-emirates">
##                               <div style="height:100%;width:100%">United Arab Emirates</div>
##                             </a></td>
##                           <td class="text-warning">17,417</td>
##                           <td class="text-warning text-bold-700">0</td>
##                           <td class="text-danger">185</td>
##                           <td class="text-danger text-bold-700">0</td>
##                           <td class="text-success">4,295</td>
##                           <td class="text-success text-bold-700">0</td>
##                           <td class="text-warning">12,937</td>
##                           <td class="text-danger">1</td>
##                           <td class="text-warning">1,200,000</td>
## 
##                           
##                         </tr>
```

</details>

<br>
<details><summary>**Example**: Using `str_extract()` to extract link for each row</summary>

Since all links follow the same pattern, we can use regex to extract this info:


```r
links <- str_extract(string = rows, pattern = 'https://corona.help/country/[-a-z]+')

# View first few links
head(links)
```

```
## [1] "https://corona.help/country/united-states" 
## [2] "https://corona.help/country/spain"         
## [3] "https://corona.help/country/italy"         
## [4] "https://corona.help/country/united-kingdom"
## [5] "https://corona.help/country/russia"        
## [6] "https://corona.help/country/france"
```

</details>

<br>
<details><summary>**Example**: Using `str_match()` to extract country for each row</summary>

Since all countries are in a `div` element with the same attributes, we can use the following regex to extract the country name:


```r
countries <- str_match(string = rows, pattern = '<div style="height:100%;width:100%">([\\w ]+)</div>')

# View first few countries
head(countries)
```

```
##      [,1]                                                        
## [1,] "<div style=\"height:100%;width:100%\">United States</div>" 
## [2,] "<div style=\"height:100%;width:100%\">Spain</div>"         
## [3,] "<div style=\"height:100%;width:100%\">Italy</div>"         
## [4,] "<div style=\"height:100%;width:100%\">United Kingdom</div>"
## [5,] "<div style=\"height:100%;width:100%\">Russia</div>"        
## [6,] "<div style=\"height:100%;width:100%\">France</div>"        
##      [,2]            
## [1,] "United States" 
## [2,] "Spain"         
## [3,] "Italy"         
## [4,] "United Kingdom"
## [5,] "Russia"        
## [6,] "France"
```

</details>

<br>
<details><summary>**Example**: Using `str_match_all()` to extract number deaths and critical for each row</summary>

Since both the number of deaths and critical are in a `td` element with the same `class` attribute, we can use the following regex to extract both numbers:


```r
num_danger <- str_match_all(string = rows, pattern = '<td class="text-danger">([\\d,]+)</td>')

# View matches for first few rows
head(num_danger)
```

```
## [[1]]
##      [,1]                                    [,2]    
## [1,] "<td class=\"text-danger\">80,037</td>" "80,037"
## [2,] "<td class=\"text-danger\">16,816</td>" "16,816"
## 
## [[2]]
##      [,1]                                    [,2]    
## [1,] "<td class=\"text-danger\">26,478</td>" "26,478"
## [2,] "<td class=\"text-danger\">1,741</td>"  "1,741" 
## 
## [[3]]
##      [,1]                                    [,2]    
## [1,] "<td class=\"text-danger\">30,395</td>" "30,395"
## [2,] "<td class=\"text-danger\">1,034</td>"  "1,034" 
## 
## [[4]]
##      [,1]                                    [,2]    
## [1,] "<td class=\"text-danger\">31,658</td>" "31,658"
## [2,] "<td class=\"text-danger\">1,559</td>"  "1,559" 
## 
## [[5]]
##      [,1]                                   [,2]   
## [1,] "<td class=\"text-danger\">1,827</td>" "1,827"
## [2,] "<td class=\"text-danger\">2,300</td>" "2,300"
## 
## [[6]]
##      [,1]                                    [,2]    
## [1,] "<td class=\"text-danger\">26,310</td>" "26,310"
## [2,] "<td class=\"text-danger\">2,812</td>"  "2,812"
```

</details>

<br>
<details><summary>**Example**: Using `str_replace_all()` to convert numeric values to thousands for each row</summary>

Rewrite all numeric values greater than one thousand in terms of `k`:


```r
num_to_k <- str_replace_all(string = rows, pattern = '>([\\d,]+),\\d{3}<', replacement = '>\\1k<')

# View replacements for first few rows
writeLines(head(num_to_k))
```

```
## <tr>
## <td><a href="https://corona.help/country/united-states">
##                               <div style="height:100%;width:100%">United States</div>
##                             </a></td>
##                           <td class="text-warning">1,347k</td>
##                           <td class="text-warning text-bold-700">306</td>
##                           <td class="text-danger">80k</td>
##                           <td class="text-danger text-bold-700">5</td>
##                           <td class="text-success">238k</td>
##                           <td class="text-success text-bold-700">885</td>
##                           <td class="text-warning">1,029k</td>
##                           <td class="text-danger">16k</td>
##                           <td class="text-warning">8,918k</td>
## 
##                           
##                         </tr>
## 
## <tr>
## <td><a href="https://corona.help/country/spain">
##                               <div style="height:100%;width:100%">Spain</div>
##                             </a></td>
##                           <td class="text-warning">262k</td>
##                           <td class="text-warning text-bold-700">0</td>
##                           <td class="text-danger">26k</td>
##                           <td class="text-danger text-bold-700">0</td>
##                           <td class="text-success">173k</td>
##                           <td class="text-success text-bold-700">0</td>
##                           <td class="text-warning">63k</td>
##                           <td class="text-danger">1k</td>
##                           <td class="text-warning">2,467k</td>
## 
##                           
##                         </tr>
## 
## <tr>
## <td><a href="https://corona.help/country/italy">
##                               <div style="height:100%;width:100%">Italy</div>
##                             </a></td>
##                           <td class="text-warning">218k</td>
##                           <td class="text-warning text-bold-700">0</td>
##                           <td class="text-danger">30k</td>
##                           <td class="text-danger text-bold-700">0</td>
##                           <td class="text-success">103k</td>
##                           <td class="text-success text-bold-700">0</td>
##                           <td class="text-warning">84k</td>
##                           <td class="text-danger">1k</td>
##                           <td class="text-warning">2,514k</td>
## 
##                           
##                         </tr>
## 
## <tr>
## <td><a href="https://corona.help/country/united-kingdom">
##                               <div style="height:100%;width:100%">United Kingdom</div>
##                             </a></td>
##                           <td class="text-warning">216k</td>
##                           <td class="text-warning text-bold-700">0</td>
##                           <td class="text-danger">31k</td>
##                           <td class="text-danger text-bold-700">0</td>
##                           <td class="text-success">924</td>
##                           <td class="text-success text-bold-700">0</td>
##                           <td class="text-warning">183k</td>
##                           <td class="text-danger">1k</td>
##                           <td class="text-warning">1,728k</td>
## 
##                           
##                         </tr>
## 
## <tr>
## <td><a href="https://corona.help/country/russia">
##                               <div style="height:100%;width:100%">Russia</div>
##                             </a></td>
##                           <td class="text-warning">198k</td>
##                           <td class="text-warning text-bold-700">0</td>
##                           <td class="text-danger">1k</td>
##                           <td class="text-danger text-bold-700">0</td>
##                           <td class="text-success">31k</td>
##                           <td class="text-success text-bold-700">0</td>
##                           <td class="text-warning">164k</td>
##                           <td class="text-danger">2k</td>
##                           <td class="text-warning">5,221k</td>
## 
##                           
##                         </tr>
## 
## <tr>
## <td><a href="https://corona.help/country/france">
##                               <div style="height:100%;width:100%">France</div>
##                             </a></td>
##                           <td class="text-warning">176k</td>
##                           <td class="text-warning text-bold-700">0</td>
##                           <td class="text-danger">26k</td>
##                           <td class="text-danger text-bold-700">0</td>
##                           <td class="text-success">56k</td>
##                           <td class="text-success text-bold-700">0</td>
##                           <td class="text-warning">94k</td>
##                           <td class="text-danger">2k</td>
##                           <td class="text-warning">1,384k</td>
## 
##                           
##                         </tr>
```

</details>
