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

# HTML

__Markup Language__

> "A markup language is a computer language that uses tags to define elements within a document. It is human-readable, meaning markup files contain standard words, rather than typical programming syntax." 

*Credit: [Markup Language](https://techterms.com/definition/markup_language) from TechTerms*

<br>
__Hypertext Markup Language (HTML)__

- HTML is a markup language for the creation of websites
    - HTML puts the content on the webpage, but does not "style" the page (e.g., fonts, colors, background)
    - CSS (**C**ascading **S**tyle **S**heets) adds style to the webpage (e.g., fonts, colors, etc.)
    - Javascript adds functionality to the webpage

## HTML Basics  

__Intro to HTML (and CSS)__

- Watch this __excellent__ 12-minute introductory HTML tutorial by LearnCode.academy
    - Link: [HTML Tutorial for beginners](https://www.youtube.com/watch?v=RjHflb-QgVc)
- Watch this 7-minute introductory CSS tutorial by LearnCode.academy
    - Link: [HTML CSS Tutorial for Beginners](https://youtu.be/J35jug1uHzE)

<br>
__A Simple HTML Document__ (From [w3schools](https://www.w3schools.com/html/html_intro.asp))

- HTML consists of a series of **elements**
  - Elements are defined by a start tag, some content, and an end tag:
    - `<tagname> Content </tagname>`
  - Elements can be nested within one another
- Components of a basic HTML document:
  - Begin with `<!DOCTYPE html>` to indicate it is an HTML document
  - The `<html>` element is the root element of an HTML page, where all other elements are nested
  - The `<head>` element contains meta information about the document (ie. not displayed on webpage)
  - The `<body>` element contains the visible page content

```
<!DOCTYPE html>
<html>
<head>
<title>Page Title</title>
</head>
<body>

<h1>My First Heading</h1>
<p>My first paragraph.</p>

</body>
</html>
```

<br>

## Tags

What are **HTML tags**?

- HTML tags are element names surrounded by angle brackets
    - Tags usually come in pairs (e.g. `<p>` and `</p>`)
    - The first tag is the start tag and the second tag is the end tag
    
*Credit: [HTML introduction](https://www.w3schools.com/html/html_intro.asp) from W3schools*   

<br>
Some **common HTML tags** (_not inclusive_): 

Tag                Description    
------------------ ------------------  
\<h1\> - \<h6\>    Heading     
\<p\>              Paragraph
\<a\>              Link
\<img\>            Image
\<div\>            Division (can think of it as a container to group other elements)
\<strong\>         Bold
\<em\>             Italics
\<ul\>             Unordered list (consists of \<li\> elements)
\<ol\>             Ordered list (consists of \<li\> elements)
&nbsp;&nbsp;\<li\> &nbsp;&nbsp;&nbsp;&nbsp;List item
\<table\>          Table (consists of \<tr\>, \<td\>, & \<th\> elements)
&nbsp;&nbsp;\<tr\> &nbsp;&nbsp;Table row
&nbsp;&nbsp;\<td\> &nbsp;&nbsp;Table data/cell 
&nbsp;&nbsp;\<th\> &nbsp;&nbsp;Table header 

<br>


## Attributes  

What are **attributes**?

- Attributed in HTML elements are optional, but all HTML elements can have attributes
- Attributes are used to provide additional information about an element  
- Attributes are __always__ specified in the start tag
- Attributes usually come in name/value pairs like: `name="value"`

*Credit: [HTML attributes](https://www.w3schools.com/html/html_attributes.asp) from W3schools*

<br>
Some **common attributes** you may encounter:

- The `href` attribute for an `<a>` tag (_specifies url to link to_):
  ```
  <a href="https://www.w3schools.com">This is a link</a>
  ```
- The `src` attribute defined by the `<img>` tag (_specifies image to display_):
  ```
  <img src="html_cheatsheet.jpg">
  ```
- You can add more than one attribute to an element:
  ```
  <img src="html_cheatsheet.jpg" width="200" height="300">
  ```
- The `class` and `id` attributes are also commonly added to elements to be able to identify and select for them

<br>

### Class  

- The `class` attribute can specify one or more class names for an HTML element
- An element can be identified by its class
- You can select for an element by its class using `.` followed by the class name (more from GeekstoGeeks [here](https://www.geeksforgeeks.org/html-class-attribute/?ref=lbp))
  - For example, this can be used in CSS to select for and style all elements with a specific class

__HTML__:


```html
<div class="countries">
  <h3>United States</h3>
  <p class="place">Washington D.C.</p>
  <img src="https://cdn.aarp.net/content/dam/aarp/travel/destination-guides/2018/03/1140-trv-dst-dc-main.imgcache.revd66f01d4a19adcecdb09fdacd4471fa8.jpg">
</div>
    
<div class="countries">
  <h3>Mexico</h3>
  <p class="place">Guadalajara</p>
  <img src="https://cityofguadalajara.com/wp-content/uploads/2016/11/Centro-Historico-de-Guadalajara-800x288.jpg">
</div>
```
 
__CSS__:
 

```css
<style>   
.countries {
  background-color: #e6e6e6;
  color: #336699;
  margin: 10px;
  padding: 15px;
}

.place {
  color: black;
}
</style>
```

__Result__:

<style>
.countries {
  background-color: #e6e6e6;
  color: #336699;
  margin: 10px;
  padding: 15px;
  display: inline-block;
}

.place {
  color: black;
}

.countries img {
  width: 200px;
  height: 100px;
  overflow: hidden;
}
</style>

<div class="countries">
<h3>United States</h3>
<p class="place">Washington D.C </p>
<img src="https://cdn.aarp.net/content/dam/aarp/travel/destination-guides/2018/03/1140-trv-dst-dc-main.imgcache.revd66f01d4a19adcecdb09fdacd4471fa8.jpg">
</div>


<div class="countries">
<h3>Mexico</h3>
<p class="place">Guadalajara</p>
<img src="https://cityofguadalajara.com/wp-content/uploads/2016/11/Centro-Historico-de-Guadalajara-800x288.jpg">
</div>

*Credit: [HTML Classes](https://www.w3schools.com/html/html_classes.asp) from W3schools*


### Id  

- The `id` attribute is used to specify one unique HTML element within the HTML document
- An element can be identified by its id
- You can select for an element by its id using `#` followed by the id name (more from GeekstoGeeks [here](https://www.w3schools.com/html/html_id.asp))
  - For example, this can be used in CSS to select for and style a specific element with a certain id

__HTML__:


```html
<div id="banner">My Banner</div>
```

__CSS__:


```css
<style>
#banner {
  background-color: #e6e6e6;
  font-size: 40px;
  padding: 20px;
  text-align: center;
}
</style>
```

__Result__:

<style>
#banner {
  background-color: #e6e6e6;
  font-size: 40px;
  padding: 20px;
  text-align: center;
}
</style>

<div id="banner">My Banner</div>

*Credit: [HTML Id](https://www.w3schools.com/html/html_id.asp) from W3schools*


<br>

## Student Exercise

- Spend 5-10 minutes playing with the simple HTML text below
- Paste the below code into [TryIt Editor](https://www.w3schools.com/html/tryit.asp?filename=tryhtml_default) and click __Run__


```html
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

- Use this website to create/modify HTML code and view the result after it is compiled
    - [TryIt Editor](https://www.w3schools.com/html/tryit.asp?filename=tryhtml_default)
- HTML cheat sheets 
    - [Link to HTML cheat sheet (PDF)](https://web.stanford.edu/group/csp/cs21/htmlcheatsheet.pdf)
    - [Link to another HTML cheat sheet ](http://www.cheat-sheets.org/saved-copy/html-cheat-sheet.png), (shown below) 


[![](http://www.cheat-sheets.org/saved-copy/html-cheat-sheet.png)](https://sharethis.com/best-practices/2020/02/best-html-and-css-cheat-sheets/)


