---
title: "Lecture style guidelines"
subtitle: "Fundamentals of programming using R" 
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

# general

should we be following APA style or something like that for 

# YAML

- output = html_document
- toc
    - numbered
    - toc depth = 2
    - toc float = true
- what other options should we use to improve appearance, functionality of lectures?

# global chunk options?

for intro R class, we included following global option. what others should we include in each .Rmd lecture file?


```r
knitr::opts_chunk$set(collapse = TRUE, comment = "#>", highlight = TRUE)
```

# HEADINGS. level-1 for big topics (e.g., xxxx)

## level-2 heading for ??? topics

### level-3 heading for ??? topics

#### use level 4 heading at all?

__use bold for ??? level topics__

# text style

`code`

- use for code. for example: `git commit -m "my message here"`
- use for function names, option names, etc.
- ? use when we are naming libraries/packages?
- ? use code for file names?

__Bold__

- use for key terms. 
    - ? every time the term is mentioned or only the first time?

_italics_

- I also see italics being used for emphasis, but I tend to find italics _less_ noticable than non-italics text!

<span style="color: red;">Color</span>

- not sure whether/how to use color. or which colors.
- ? use color for emphasis? 

## bullet-points vs. paragraph-style

not sure if main text [below headings] should be paragraph style or bullet-point or a mix of both. so far I am mainly using bullet-points, but that is because I am used to writing lecture slides. 



# References/attribution

- I created `rclass2_bib.bib` for references, but haven't added many references there yet
- I find I am using a lot of quoted text and images from other tutorials/websites. I am trying to be consistent in always attributing the sources, but I haven't been consistent about whether I provide name of author or name of tutorial/article title. what should the standard be?

Below are a couple of examples from draft github lecture, showing this lack of consistency:

What is a __branch__?

- A branch is an "independent line of development" that "isolates your work from that of other team members" ([Using branches](https://backlog.com/git-tutorial/using-branches/) tutorial)
- By default, a git repository "has one branch named __master__ which is considered to be the definitive branch. We use [other] branches to experiment and make edits before committing them to __master__" ([Hello World](https://guides.github.com/activities/hello-world/) tutorial)
- "When you create a branch off the __master__ branch, you’re making a copy, or snapshot, of master as it was at that point in time"
- Branches as sometimes described as "deviations" from the master branch
- The below image shows three branches -- the master, "Branch 1," and "Branch 2" -- and each circle represents a `commit`

[![](https://miro.medium.com/max/552/1*PiduCtSA7kMwdPiMZo1nHw.jpeg)](https://geeks.uniplaces.com/mastering-branches-in-git-f20cb2d0c51f)

*Credit: [Mastering git branches](https://geeks.uniplaces.com/mastering-branches-in-git-f20cb2d0c51f) by Henrique Mota*

<br>

The goal of a `merge` is to "integrate changes from multiple branches into one [branch]" ([An introduction to Git merge and rebase](https://www.freecodecamp.org/news/an-introduction-to-git-merge-and-rebase-what-they-are-and-how-to-use-them-131b863785f/))

The below image shows a merge between the __master__ branch a branch named "develop"

- Each circle represents a `commit`
- the "develop" branch was created after "commit 2" of the __master__
- After two commits, the "develop" branch is merged "into" the __master__

<br>
[![](https://community.intersystems.com/sites/default/files/inline/images/risunok4.png)](https://community.intersystems.com/post/continuous-delivery-your-intersystems-solution-using-gitlab-part-i-git)

*Credit: [Eduard Lebedyuk](https://community.intersystems.com/post/continuous-delivery-your-intersystems-solution-using-gitlab-part-i-git)*
