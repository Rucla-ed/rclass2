---
title: "html, css, regex"
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
Load packages:

```r
library(tidyverse)
library(rvest)
```

<!--
HTML
  - markup language [DONE]
  - youtube video [DONE]
  - HTML basics 
    - elements [DONE]
        - tags
        - attributes
  - HTML resources
  - Paste code in html editor
  - Short student exercise
  
-->

# appendix

appendix


## HTML

__Markup language__

> "A markup language is a computer language that uses tags to define elements within a document. It is human-readable, meaning markup files contain standard words, rather than typical programming syntax." [Markup language](https://techterms.com/definition/markup_language)

__Hypertext Markup Language (HTML)__

- HTML is a markup language for the creation of websites

    - HTML puts the content on the webpage, but does not "style" the page (e.g., fonts, colors, background)
    - CSS (**C**ascading **S**tyle **S**heets) adds style to the webpage (e.g., fonts, colors, etc.).
    - Javascript adds functionality to the webpage

## Hypertext Basics  

- Watch this __excellent__ 12-minute introductory HTML tutorial by LearnCode.academy
    - Link: [“HTML Tutorial for beginners”](https://www.youtube.com/watch?v=RjHflb-QgVc)

### Tags 

- HTML tags are element names HTML surrounded by angle brackets
    - Tags usually come in pairs (e.g. `<p>` and `</p>`)
    - The first tag is the start tag and the second tag is the end tag.
    
*Credit: [HTML introduction](https://www.w3schools.com/html/html_intro.asp) from W3schools*   

<br>
Some common HTML tags (not inclusive): 

Tag                Description    
------------------ ------------------  
\<h1\> - \<h6\>    Heading     
\<p\>              Paragraph          
\<div\>            Division
\<strong\>         Bold
\<em\>             Italics
\<li\>             List item
\<ul\>             Unordered list
\<ol\>             Ordered list
\<table\>          Table (consists of \<tr\>, \<td\>, & \<th\> elements)
\<tr\>             Table row
\<td\>             Table data/cell 
\<th\>             Table header 

<br>

### Elements  

- HTML consists of a series of elements  
- Elements are defined by a start tag, some content, and an end tag.

`<tagname> Content </tagname>`

*Credit: [HTML elements](https://www.w3schools.com/html/html_elements.asp) from W3schools*

<br>

Start tag  Element Content     End tag
---------- ------------------  --------
\<h1\>      First heading      \</h1\>
\<h2\>      Second heading     \</h2\>
\<p\>       Paragraph          \</p\>

<br>


### Attributes  

- Attributed in HTML elements are optional, but all HTML elements can have attributes.
- Attributes are used to provide additional information about an element  
- Attributes are __always__ specified in the start tag
- Attributes usually come in name/value pairs like: name="value"

Some common attributes you may encounter:

- The `href` attribute defined by an `<a>` tag.

    `<a href="https://www.w3schools.com">This is a link</a>`

- The `src` attribute defined by the `<img>` tag. 

    `<img src="html_cheatsheet.jpg">`
    
- You can add more than one attribute to an element.

    `<img src="html_cheatsheet.jpg" width="200" height="300">`



*Credit: [HTML attributes](https://www.w3schools.com/html/html_attributes.asp) from W3schools*

<br>

### Class
### Id

### Student exercise

- Spend 5-10 minutes playing with the simple HTML text below. 


Paste the below code into [TryIt Editor](https://www.w3schools.com/html/tryit.asp?filename=tryhtml_default) and click __Run__

```r
<!DOCTYPE html>
<html>
<head>
  <title>Page title (in head tag)</title>
</head>
<body>

  <h1>Title of level 1 heading</h1>
  
  <p>My first paragraph.</p>
  <p>My second paragraph.</p>
  <p>Add some bold text <strong>right here</strong></p>
  <p>Add some italics text <em>right here</em></p>
  

  <p>Include a hyperlink tag within a paragraph tag. this book looks interesting : <a href="https://bookdown.org/rdpeng/rprogdatascience/">R Programming for Data Science</a></p>  
  
  <p>Include another hyperlink tag within a paragraph tag. chapter on <a href="https://bookdown.org/rdpeng/rprogdatascience/regular-expressions.html">Regular Expressions</a></p>    
  <p> put a button inside this paragraph <button>I am a button!</button></p>
  
  <p>Here are some items in a list, but items not placed within an unordered list </p>
  
  <li> text you want in item</li>
  <li> text you want in another item</li>
  
  <p>Here are some items in an unordered list</p>
  
  <ul>
  <li> first item in unordered list </li>
  <li> second item in unordered list </li>
  </ul>

</body>
  
</html>
```

<br>

## HTML Resources

Lots of wonderful resources on the web to learn HTML!

- Use this website to create/modify html code and view the result after it is compiled
    - [TryIt Editor](https://www.w3schools.com/html/tryit.asp?filename=tryhtml_default)
- Html cheat sheets 
    - [Link to HTML cheat sheet (PDF)](https://web.stanford.edu/group/csp/cs21/htmlcheatsheet.pdf)
    - [Link to another HTML cheat sheet ](http://www.cheat-sheets.org/saved-copy/html-cheat-sheet.png), (shown below) 

[![](http://www.cheat-sheets.org/saved-copy/html-cheat-sheet.png)](https://sharethis.com/best-practices/2020/02/best-html-and-css-cheat-sheets/)




<!--
### regex and html THIS SECTION IS CHICKEN SCRATCH

Play with some simple html


```r
html_char <- "<!DOCTYPE html>
<html>
<head>
<title>Page Title</title>
</head>
<body>

<h1>This is a Heading</h1>
<p>This is a paragraph.</p>

</body>
</html>"


html_char
```

```
## [1] "<!DOCTYPE html>\n<html>\n<head>\n<title>Page Title</title>\n</head>\n<body>\n\n<h1>This is a Heading</h1>\n<p>This is a paragraph.</p>\n\n</body>\n</html>"
```

```r
#str_view_all(string = html_char, pattern = "<")
str_match(string = html_char, pattern = ">")
```

```
##      [,1]
## [1,] ">"
```

```r
str_match_all(string = html_char, pattern = "<")
```

```
## [[1]]
##       [,1]
##  [1,] "<" 
##  [2,] "<" 
##  [3,] "<" 
##  [4,] "<" 
##  [5,] "<" 
##  [6,] "<" 
##  [7,] "<" 
##  [8,] "<" 
##  [9,] "<" 
## [10,] "<" 
## [11,] "<" 
## [12,] "<" 
## [13,] "<"
```

```r
str_extract(string = html_char, pattern = ">")
```

```
## [1] ">"
```

```r
str_extract_all(string = html_char, pattern = "</")
```

```
## [[1]]
## [1] "</" "</" "</" "</" "</" "</"
```

```r
str_count(string = html_char, pattern = "</")
```

```
## [1] 6
```

```r
# extract all tag names
html_char
```

```
## [1] "<!DOCTYPE html>\n<html>\n<head>\n<title>Page Title</title>\n</head>\n<body>\n\n<h1>This is a Heading</h1>\n<p>This is a paragraph.</p>\n\n</body>\n</html>"
```

```r
str_extract_all(string = html_char, pattern = "</\\w+>")
```

```
## [[1]]
## [1] "</title>" "</head>"  "</h1>"    "</p>"     "</body>"  "</html>"
```

```r
#exctract contents
str_extract_all(string = html_char, pattern = ">.+<")
```

```
## [[1]]
## [1] ">Page Title<"           ">This is a Heading<"    ">This is a paragraph.<"
```

```r
str_extract_all(string = html_char, pattern = "(?<=>).+<") # without leading carrot
```

```
## [[1]]
## [1] "Page Title<"           "This is a Heading<"    "This is a paragraph.<"
```

```r
str_extract_all(string = html_char, pattern = ">.+(?=<)") # without trailing carrot
```

```
## [[1]]
## [1] ">Page Title"           ">This is a Heading"    ">This is a paragraph."
```

```r
str_extract_all(string = html_char, pattern = "(?<=>).+(?=<)") # without leading or trailing carrot
```

```
## [[1]]
## [1] "Page Title"           "This is a Heading"    "This is a paragraph."
```

```r
str_extract_all(string = html_char, pattern = "</\\w+>.+")
```

```
## [[1]]
## character(0)
```

```r
str_extract_all(string = html_char, pattern = "</(\\w+)|(\\w+)>")
```

```
## [[1]]
##  [1] "html>"   "html>"   "head>"   "title>"  "</title" "</head"  "body>"  
##  [8] "h1>"     "</h1"    "p>"      "</p"     "</body"  "</html"
```


```r
str_view_all(string = html_char, pattern = "<")
```

<!--html_preserve--><div id="htmlwidget-71b014ab967b93229aa8" style="width:960px;height:100%;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-71b014ab967b93229aa8">{"x":{"html":"<ul>\n  <li><span class='match'><<\/span>!DOCTYPE html>\n<span class='match'><<\/span>html>\n<span class='match'><<\/span>head>\n<span class='match'><<\/span>title>Page Title<span class='match'><<\/span>/title>\n<span class='match'><<\/span>/head>\n<span class='match'><<\/span>body>\n\n<span class='match'><<\/span>h1>This is a Heading<span class='match'><<\/span>/h1>\n<span class='match'><<\/span>p>This is a paragraph.<span class='match'><<\/span>/p>\n\n<span class='match'><<\/span>/body>\n<span class='match'><<\/span>/html><\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

```r
str_view_all(string = as.character(html_char), pattern = "html")
```

<!--html_preserve--><div id="htmlwidget-0e8bc5f482aa16804c6a" style="width:960px;height:100%;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-0e8bc5f482aa16804c6a">{"x":{"html":"<ul>\n  <li><!DOCTYPE <span class='match'>html<\/span>>\n<<span class='match'>html<\/span>>\n<head>\n<title>Page Title<\/title>\n<\/head>\n<body>\n\n<h1>This is a Heading<\/h1>\n<p>This is a paragraph.<\/p>\n\n<\/body>\n<\/<span class='match'>html<\/span>><\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->


```r
html1 <- read_html(x = "<!DOCTYPE html>
<html>
<head>
<title>Page Title</title>
</head>
<body>

<h1>This is a Heading</h1>
<p>This is a paragraph.</p>

</body>
</html>")


attributes(html1)
str(html1)
html1
html1[[2]]

h <- as_list(read_html("<body><p id = 'a'></p><p class = 'c d'></p></body>"))
str(h)
str(h[[1]])

html_structure(h)

x <- as_list(read_xml("<foo><bar id='a'/><bar id='b'/></foo>"))
str(x)
x
```

Investigate `html1` 

```r
x <- html_text(x = html1, trim = FALSE)
str(x)

#Print html1
as.character(html1[[2]])
temp <- html[[2]]
temp
#writeLines html1
writeLines(html1)

#investigate html1
str(html1)
length(html1)
#str_length(html1)
```
Some basic regex

```r
html1

str_view_all(string = print(html1), pattern = "\\n")
```



```r
some_html <- "<!DOCTYPE html>
<html>
<head>
  <title>Page title (in head tag)</title>
</head>
<body>
  <h1>Title of level 1 heading</h1>
  <p>My first paragraph.</p>
  <p>My second paragraph.</p>
  <p>Add some bold text <strong>right here</strong></p>
  <p>Add some italics text <em>right here</em></p>
  <p>Include a hyperlink tag within a paragraph tag. this book looks interesting : <a href="https://bookdown.org/rdpeng/rprogdatascience/">R Programming for Data Science</a></p>  
  <p>Include another hyperlink tag within a paragraph tag. chapter on <a href="https://bookdown.org/rdpeng/rprogdatascience/regular-expressions.html">Regular Expressions</a></p>    
  <p> put a button inside this paragraph <button>I am a button!</button></p>
  <p>Here are some items in a list, but items not placed within an unordered list </p>

    <li> text you want in item</li>
  <li> text you want in another item</li>
  
  <p>Here are some items in an unordered list</p>
  <ul>
    <li> first item in unordered list </li>
    <li> second item in unordered list </li>
  </ul>
</body>
</html>"
```
-->



