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

Why use the `rvest` package?

- `rvest` makes it easy to parse HTML
- First, we use the `read_html()` function to [read in the HTML](#reading-html) and convert it to an `xml_document`/`xml_node` object
- A **node** is just an HTML **element**
- HTML is made up of nested elements, so once we've read in the HTML to a `xml_node` object, we can easily traverse the nested nodes (ie. children elements) and [parse the HTML](#parsing-html)
- `rvest` comes with many helpful functions to search and extract various parts of the HTML
  - `html_node()`/`html_nodes()`: Search and extract node(s) (ie. HTML elements)
  - `html_text()`: Extract the content between HTML tags
  - `html_attr()`/`html_attrs()`: Extract the attribute(s) of HTML tags


## Reading HTML

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
  
__Scraping HTML from a webpage__:

- Navigate to the webpage (e.g., https://corona.help/) in your browser
  - If possible, use Google Chrome or Mozilla Firefox
- View the HTML of the page by right clicking > `View Page Source`
  - This will be the raw HTML that is scraped when we use `read_html()`
- When you right click, you may notice another option called `Inspect` (Chrome) or `Inspect Element` (Firefox) that will pop up a side panel
  - This can be helpful for visualizing the HTML elements on the page
  - You can also click on this side panel and hit `ctrl` + `f` (Windows) or `cmd` + `f` (Macs) to search for elements using a selector
  - But note that the HTML you see here might not be the same as what you see in `View Page Source` (i.e., _what is scraped_), since it also reflects changes made to the HTML _after_ the page was loaded (e.g., _by JavaScript_)

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
# View class of object
class(corona)
```

```
## [1] "xml_document" "xml_node"
```


```r
# View raw HTML [output omitted]
as.character(corona)
```


```r
# Inspect raw HTML
str(as.character(corona))
```

```
##  chr "<!DOCTYPE html>\n<html class=\"loading\" lang=\"en\" data-textdirection=\"ltr\">\n<!-- BEGIN: Head--><head>\n<m"| __truncated__
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
  - `css`: Selector (can select by HTML tag name, its attributes, etc.)
- Output:
  - `html_node()` returns the first element that it finds as an `rvest` `xml_node` object
    - Recall that a node is just an HTML element
  - `html_nodes()` returns all elements that it finds as an `rvest` `xml_nodeset` object
    - All elements that are selected will be returned in a nodeset
  - Again, you can view the raw HTML using `as.character()`
    - Syntax: `as.character(html_node(...))`

__Selecting for HTML elements__:

- HTML elements can be selected in many ways
  - Selecting by tagname: `'p'`, `'table'`, etc.
  - Selecting by class using `.`: `'.my-class'`
  - Selecting by id using `#`: `'#my-id'`
  - Selecting nested elements: `'table tr'` (_selects all rows within a table_)
- You can test your selector in your browser
  - Right click and select `Inspect` (Chrome) or `Inspect Element` (Firefox) to bring up a side panel
  - Hit `ctrl` + `f` (Windows) or `cmd` + `f` (Macs) and enter your selector to search for elements


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

```r
# View raw HTML to see what elements are there
as.character(html)
```

```
## [1] "<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\" \"http://www.w3.org/TR/REC-html40/loose.dtd\">\n<html><body>\n<p>Paragraph #1</p>\n<p>Paragraph #2</p>\n<p>Paragraph #3</p>\n</body></html>\n"
```

<br>
If we search for the `<p>` element using `html_node()`, it will return the first result:


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
If we search for the `<p>` element using `html_nodes()`, it will return all results:


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


Let's revisit the HTML we scraped from https://corona.help/ in the previous example

  - We will try selecting for the "Total by country" table off of that page
  - In your browser, right click > `View Page Source` to check that the `table` element is indeed in the scraped HTML
  - Then, you can right click the table on the page and inspect it to better visualize the elements



```r
# Scraped HTML is stored in this `xml_document`/`xml_node` object
class(corona)
```

```
## [1] "xml_document" "xml_node"
```

<br>
Select for the `<table>` element on that page using `html_node()`:


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

```r
# View class of object
class(corona_table)
```

```
## [1] "xml_node"
```


```r
# View raw HTML of `corona_table` [output omitted]
as.character(corona_table)
```

<br>
Select all rows in the table (i.e., `<tr>` elements) using `html_nodes()`

- It makes sense to select by row (rather than column) because each row usually represent an observation
- The way HTML tables are structured also makes it easier to extract information by row because each `<tr>` element (i.e., row) has `<th>`/`<td>` elements (i.e., column cells) nested within it, and not the other way around
- But if you wanted to select a certain column, there are ways to do that as well (e.g., `table tr td:nth-child(1)` selects the first cell in each row a.k.a. the first column in table)



```r
# We can chain `html_node()`/`html_nodes()` functions
corona_rows <- corona %>% html_node('table') %>% html_nodes('tr')

# Alternatively, we can use `table tr` as the selector to select all `tr` elements within a `table`
corona_rows <- corona %>% html_nodes('table tr')

# Investigate object
head(corona_rows) # View first few rows
```

```
## {xml_nodeset (6)}
## [1] <tr>\n<th>COUNTRY</th>\n                          <th>INFECTED</th>\ ...
## [2] <tr>\n<td><a href="https://corona.help/country/united-states">\n     ...
## [3] <tr>\n<td><a href="https://corona.help/country/spain">\n             ...
## [4] <tr>\n<td><a href="https://corona.help/country/united-kingdom">\n    ...
## [5] <tr>\n<td><a href="https://corona.help/country/italy">\n             ...
## [6] <tr>\n<td><a href="https://corona.help/country/russia">\n            ...
```

```r
typeof(corona_rows)
```

```
## [1] "list"
```

```r
class(corona_rows)
```

```
## [1] "xml_nodeset"
```

```r
length(corona_rows) # Number of elements
```

```
## [1] 218
```

</details>

<br>

### Practicing regex

The following examples use the Coronavirus data from https://corona.help/

  - Recall that we have selected for all rows in the data table on that page in the previous example
  - If we wanted to try and create a dataframe out of this table, we could further select each cell in the table (i.e., `<td>` elements from each row), but this would involve loops which will be covered in a later lecture
  - For now, we will be practicing parsing data from each row using regex

View `corona_rows` we selected from previous example:


```r
# View first few rows
head(corona_rows)
```

```
## {xml_nodeset (6)}
## [1] <tr>\n<th>COUNTRY</th>\n                          <th>INFECTED</th>\ ...
## [2] <tr>\n<td><a href="https://corona.help/country/united-states">\n     ...
## [3] <tr>\n<td><a href="https://corona.help/country/spain">\n             ...
## [4] <tr>\n<td><a href="https://corona.help/country/united-kingdom">\n    ...
## [5] <tr>\n<td><a href="https://corona.help/country/italy">\n             ...
## [6] <tr>\n<td><a href="https://corona.help/country/russia">\n            ...
```

```r
corona_rows[1:5] # first five rows
```

```
## {xml_nodeset (5)}
## [1] <tr>\n<th>COUNTRY</th>\n                          <th>INFECTED</th>\ ...
## [2] <tr>\n<td><a href="https://corona.help/country/united-states">\n     ...
## [3] <tr>\n<td><a href="https://corona.help/country/spain">\n             ...
## [4] <tr>\n<td><a href="https://corona.help/country/united-kingdom">\n    ...
## [5] <tr>\n<td><a href="https://corona.help/country/italy">\n             ...
```

```r
corona_rows[c(1)] # header row
```

```
## {xml_nodeset (1)}
## [1] <tr>\n<th>COUNTRY</th>\n                          <th>INFECTED</th>\ ...
```

```r
corona_rows[1] # header row
```

```
## {xml_nodeset (1)}
## [1] <tr>\n<th>COUNTRY</th>\n                          <th>INFECTED</th>\ ...
```

<br>
Let's convert this to raw HTML using `as.character()` to practice writing regular expressions. Refer back to this output to help you determine what pattern you want to match:


```r
# Convert rows to raw HTML
rows <- as.character(corona_rows)[-c(1)] # [-c(1)] means skip header row

# View first few rows as raw HTML
writeLines(head(rows, 2))  # printing via writeLines() is much prettier than printing via print()
```

```
## <tr>
## <td><a href="https://corona.help/country/united-states">
##                               <div style="height:100%;width:100%">United States</div>
##                             </a></td>
##                           <td class="text-warning">1,367,638</td>
##                           <td class="text-warning text-bold-700">844</td>
##                           <td class="text-danger">80,787</td>
##                           <td class="text-danger text-bold-700">30</td>
##                           <td class="text-success">256,336</td>
##                           <td class="text-success text-bold-700">682</td>
##                           <td class="text-warning">1,030,515</td>
##                           <td class="text-danger">16,514</td>
##                           <td class="text-warning">9,444,525</td>
## 
##                           
##                         </tr>
## 
## <tr>
## <td><a href="https://corona.help/country/spain">
##                               <div style="height:100%;width:100%">Spain</div>
##                             </a></td>
##                           <td class="text-warning">264,663</td>
##                           <td class="text-warning text-bold-700">0</td>
##                           <td class="text-danger">26,621</td>
##                           <td class="text-danger text-bold-700">0</td>
##                           <td class="text-success">176,439</td>
##                           <td class="text-success text-bold-700">0</td>
##                           <td class="text-warning">61,603</td>
##                           <td class="text-danger">1,650</td>
##                           <td class="text-warning">2,467,761</td>
## 
##                           
##                         </tr>
```

```r
# Investgate object named `rows`, which is a character vector
typeof(rows)
```

```
## [1] "character"
```

```r
class(rows)
```

```
## [1] "character"
```

```r
length(rows)
```

```
## [1] 217
```

<br>
<details><summary>**Example**: Using `str_subset()` to subset rows</summary>

Let's filter for rows whose country name starts with `'United'`. First, preview what our regular expression matches using `str_view()`:


```r
str_view_all(string = head(rows), pattern = 'United \\w+')
```

<!--html_preserve--><div id="htmlwidget-91c36259942381da4c0a" style="width:960px;height:100%;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-91c36259942381da4c0a">{"x":{"html":"<ul>\n  <li><tr>\n<td><a href=\"https://corona.help/country/united-states\">\n                              <div style=\"height:100%;width:100%\"><span class='match'>United States<\/span><\/div>\n                            <\/a><\/td>\n                          <td class=\"text-warning\">1,367,638<\/td>\n                          <td class=\"text-warning text-bold-700\">844<\/td>\n                          <td class=\"text-danger\">80,787<\/td>\n                          <td class=\"text-danger text-bold-700\">30<\/td>\n                          <td class=\"text-success\">256,336<\/td>\n                          <td class=\"text-success text-bold-700\">682<\/td>\n                          <td class=\"text-warning\">1,030,515<\/td>\n                          <td class=\"text-danger\">16,514<\/td>\n                          <td class=\"text-warning\">9,444,525<\/td>\n\n                          \n                        <\/tr>\n<\/li>\n  <li><tr>\n<td><a href=\"https://corona.help/country/spain\">\n                              <div style=\"height:100%;width:100%\">Spain<\/div>\n                            <\/a><\/td>\n                          <td class=\"text-warning\">264,663<\/td>\n                          <td class=\"text-warning text-bold-700\">0<\/td>\n                          <td class=\"text-danger\">26,621<\/td>\n                          <td class=\"text-danger text-bold-700\">0<\/td>\n                          <td class=\"text-success\">176,439<\/td>\n                          <td class=\"text-success text-bold-700\">0<\/td>\n                          <td class=\"text-warning\">61,603<\/td>\n                          <td class=\"text-danger\">1,650<\/td>\n                          <td class=\"text-warning\">2,467,761<\/td>\n\n                          \n                        <\/tr>\n<\/li>\n  <li><tr>\n<td><a href=\"https://corona.help/country/united-kingdom\">\n                              <div style=\"height:100%;width:100%\"><span class='match'>United Kingdom<\/span><\/div>\n                            <\/a><\/td>\n                          <td class=\"text-warning\">220,322<\/td>\n                          <td class=\"text-warning text-bold-700\">0<\/td>\n                          <td class=\"text-danger\">31,926<\/td>\n                          <td class=\"text-danger text-bold-700\">0<\/td>\n                          <td class=\"text-success\">925<\/td>\n                          <td class=\"text-success text-bold-700\">0<\/td>\n                          <td class=\"text-warning\">187,471<\/td>\n                          <td class=\"text-danger\">1,559<\/td>\n                          <td class=\"text-warning\">1,821,280<\/td>\n\n                          \n                        <\/tr>\n<\/li>\n  <li><tr>\n<td><a href=\"https://corona.help/country/italy\">\n                              <div style=\"height:100%;width:100%\">Italy<\/div>\n                            <\/a><\/td>\n                          <td class=\"text-warning\">219,070<\/td>\n                          <td class=\"text-warning text-bold-700\">0<\/td>\n                          <td class=\"text-danger\">30,560<\/td>\n                          <td class=\"text-danger text-bold-700\">0<\/td>\n                          <td class=\"text-success\">105,186<\/td>\n                          <td class=\"text-success text-bold-700\">0<\/td>\n                          <td class=\"text-warning\">83,324<\/td>\n                          <td class=\"text-danger\">1,027<\/td>\n                          <td class=\"text-warning\">2,565,912<\/td>\n\n                          \n                        <\/tr>\n<\/li>\n  <li><tr>\n<td><a href=\"https://corona.help/country/russia\">\n                              <div style=\"height:100%;width:100%\">Russia<\/div>\n                            <\/a><\/td>\n                          <td class=\"text-warning\">209,688<\/td>\n                          <td class=\"text-warning text-bold-700\">0<\/td>\n                          <td class=\"text-danger\">1,915<\/td>\n                          <td class=\"text-danger text-bold-700\">0<\/td>\n                          <td class=\"text-success\">34,306<\/td>\n                          <td class=\"text-success text-bold-700\">0<\/td>\n                          <td class=\"text-warning\">173,467<\/td>\n                          <td class=\"text-danger\">2,300<\/td>\n                          <td class=\"text-warning\">5,448,463<\/td>\n\n                          \n                        <\/tr>\n<\/li>\n  <li><tr>\n<td><a href=\"https://corona.help/country/france\">\n                              <div style=\"height:100%;width:100%\">France<\/div>\n                            <\/a><\/td>\n                          <td class=\"text-warning\">176,970<\/td>\n                          <td class=\"text-warning text-bold-700\">0<\/td>\n                          <td class=\"text-danger\">26,380<\/td>\n                          <td class=\"text-danger text-bold-700\">0<\/td>\n                          <td class=\"text-success\">56,217<\/td>\n                          <td class=\"text-success text-bold-700\">0<\/td>\n                          <td class=\"text-warning\">94,373<\/td>\n                          <td class=\"text-danger\">2,776<\/td>\n                          <td class=\"text-warning\">1,384,633<\/td>\n\n                          \n                        <\/tr>\n<\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->


Inspect the output from `str_detect()`, which returns `TRUE` if there is a match and `FALSE` if not. For example, we see there is a `TRUE` for the first element (United States) and third element (United Kingdom):


```r
str_detect(string = head(rows), pattern = 'United \\w+')
```

```
## [1]  TRUE FALSE  TRUE FALSE FALSE FALSE
```

Finally, subset rows by country name using `str_subset()`, which keeps elements of character vector for which `str_detect()` is `TRUE` (i.e., keeps elements where the pattern "matches"):


```r
subset_by_country <- str_subset(string = rows, pattern = 'United \\w+')
writeLines(subset_by_country)
```

```
## <tr>
## <td><a href="https://corona.help/country/united-states">
##                               <div style="height:100%;width:100%">United States</div>
##                             </a></td>
##                           <td class="text-warning">1,367,638</td>
##                           <td class="text-warning text-bold-700">844</td>
##                           <td class="text-danger">80,787</td>
##                           <td class="text-danger text-bold-700">30</td>
##                           <td class="text-success">256,336</td>
##                           <td class="text-success text-bold-700">682</td>
##                           <td class="text-warning">1,030,515</td>
##                           <td class="text-danger">16,514</td>
##                           <td class="text-warning">9,444,525</td>
## 
##                           
##                         </tr>
## 
## <tr>
## <td><a href="https://corona.help/country/united-kingdom">
##                               <div style="height:100%;width:100%">United Kingdom</div>
##                             </a></td>
##                           <td class="text-warning">220,322</td>
##                           <td class="text-warning text-bold-700">0</td>
##                           <td class="text-danger">31,926</td>
##                           <td class="text-danger text-bold-700">0</td>
##                           <td class="text-success">925</td>
##                           <td class="text-success text-bold-700">0</td>
##                           <td class="text-warning">187,471</td>
##                           <td class="text-danger">1,559</td>
##                           <td class="text-warning">1,821,280</td>
## 
##                           
##                         </tr>
## 
## <tr>
## <td><a href="https://corona.help/country/united-arab-emirates">
##                               <div style="height:100%;width:100%">United Arab Emirates</div>
##                             </a></td>
##                           <td class="text-warning">18,198</td>
##                           <td class="text-warning text-bold-700">0</td>
##                           <td class="text-danger">198</td>
##                           <td class="text-danger text-bold-700">0</td>
##                           <td class="text-success">4,804</td>
##                           <td class="text-success text-bold-700">0</td>
##                           <td class="text-warning">13,196</td>
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
## [3] "https://corona.help/country/united-kingdom"
## [4] "https://corona.help/country/italy"         
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
# We used a capturing group to extract the country name from between the tags
head(countries)
```

```
##      [,1]                                                        
## [1,] "<div style=\"height:100%;width:100%\">United States</div>" 
## [2,] "<div style=\"height:100%;width:100%\">Spain</div>"         
## [3,] "<div style=\"height:100%;width:100%\">United Kingdom</div>"
## [4,] "<div style=\"height:100%;width:100%\">Italy</div>"         
## [5,] "<div style=\"height:100%;width:100%\">Russia</div>"        
## [6,] "<div style=\"height:100%;width:100%\">France</div>"        
##      [,2]            
## [1,] "United States" 
## [2,] "Spain"         
## [3,] "United Kingdom"
## [4,] "Italy"         
## [5,] "Russia"        
## [6,] "France"
```

</details>

<br>
<details><summary>**Example**: Using `str_match_all()` to extract number deaths and critical for each row</summary>

Since both the number of deaths and critical are in a `<td>` element with the same `class` attribute, we can use the following regex to extract both numbers:


```r
num_danger <- str_match_all(string = rows, pattern = '<td class="text-danger">([\\d,]+)</td>')

# View matches for first few rows
# We used a capturing group to extract the numbers from between the tags
head(num_danger)
```

```
## [[1]]
##      [,1]                                    [,2]    
## [1,] "<td class=\"text-danger\">80,787</td>" "80,787"
## [2,] "<td class=\"text-danger\">16,514</td>" "16,514"
## 
## [[2]]
##      [,1]                                    [,2]    
## [1,] "<td class=\"text-danger\">26,621</td>" "26,621"
## [2,] "<td class=\"text-danger\">1,650</td>"  "1,650" 
## 
## [[3]]
##      [,1]                                    [,2]    
## [1,] "<td class=\"text-danger\">31,926</td>" "31,926"
## [2,] "<td class=\"text-danger\">1,559</td>"  "1,559" 
## 
## [[4]]
##      [,1]                                    [,2]    
## [1,] "<td class=\"text-danger\">30,560</td>" "30,560"
## [2,] "<td class=\"text-danger\">1,027</td>"  "1,027" 
## 
## [[5]]
##      [,1]                                   [,2]   
## [1,] "<td class=\"text-danger\">1,915</td>" "1,915"
## [2,] "<td class=\"text-danger\">2,300</td>" "2,300"
## 
## [[6]]
##      [,1]                                    [,2]    
## [1,] "<td class=\"text-danger\">26,380</td>" "26,380"
## [2,] "<td class=\"text-danger\">2,776</td>"  "2,776"
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
##                           <td class="text-warning">1,367k</td>
##                           <td class="text-warning text-bold-700">844</td>
##                           <td class="text-danger">80k</td>
##                           <td class="text-danger text-bold-700">30</td>
##                           <td class="text-success">256k</td>
##                           <td class="text-success text-bold-700">682</td>
##                           <td class="text-warning">1,030k</td>
##                           <td class="text-danger">16k</td>
##                           <td class="text-warning">9,444k</td>
## 
##                           
##                         </tr>
## 
## <tr>
## <td><a href="https://corona.help/country/spain">
##                               <div style="height:100%;width:100%">Spain</div>
##                             </a></td>
##                           <td class="text-warning">264k</td>
##                           <td class="text-warning text-bold-700">0</td>
##                           <td class="text-danger">26k</td>
##                           <td class="text-danger text-bold-700">0</td>
##                           <td class="text-success">176k</td>
##                           <td class="text-success text-bold-700">0</td>
##                           <td class="text-warning">61k</td>
##                           <td class="text-danger">1k</td>
##                           <td class="text-warning">2,467k</td>
## 
##                           
##                         </tr>
## 
## <tr>
## <td><a href="https://corona.help/country/united-kingdom">
##                               <div style="height:100%;width:100%">United Kingdom</div>
##                             </a></td>
##                           <td class="text-warning">220k</td>
##                           <td class="text-warning text-bold-700">0</td>
##                           <td class="text-danger">31k</td>
##                           <td class="text-danger text-bold-700">0</td>
##                           <td class="text-success">925</td>
##                           <td class="text-success text-bold-700">0</td>
##                           <td class="text-warning">187k</td>
##                           <td class="text-danger">1k</td>
##                           <td class="text-warning">1,821k</td>
## 
##                           
##                         </tr>
## 
## <tr>
## <td><a href="https://corona.help/country/italy">
##                               <div style="height:100%;width:100%">Italy</div>
##                             </a></td>
##                           <td class="text-warning">219k</td>
##                           <td class="text-warning text-bold-700">0</td>
##                           <td class="text-danger">30k</td>
##                           <td class="text-danger text-bold-700">0</td>
##                           <td class="text-success">105k</td>
##                           <td class="text-success text-bold-700">0</td>
##                           <td class="text-warning">83k</td>
##                           <td class="text-danger">1k</td>
##                           <td class="text-warning">2,565k</td>
## 
##                           
##                         </tr>
## 
## <tr>
## <td><a href="https://corona.help/country/russia">
##                               <div style="height:100%;width:100%">Russia</div>
##                             </a></td>
##                           <td class="text-warning">209k</td>
##                           <td class="text-warning text-bold-700">0</td>
##                           <td class="text-danger">1k</td>
##                           <td class="text-danger text-bold-700">0</td>
##                           <td class="text-success">34k</td>
##                           <td class="text-success text-bold-700">0</td>
##                           <td class="text-warning">173k</td>
##                           <td class="text-danger">2k</td>
##                           <td class="text-warning">5,448k</td>
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
