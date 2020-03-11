Visualization using ggplot2
================
Ozan Jaquette

  - [Intro/logistics](#intrologistics)
      - [Datasets we will use](#datasets-we-will-use)
  - [Concepts](#concepts)
      - [Layers](#layers)
  - [Creating graphs using `ggplot`](#creating-graphs-using-ggplot)
      - [`ggplot() and`aes()\` functions](#ggplot-andaes-functions)
      - [Adding geometric layer to a ggplot object using a “geom
        function”](#adding-geometric-layer-to-a-ggplot-object-using-a-geom-function)
      - [Small multiples using
        faceting](#small-multiples-using-faceting)
  - [References](#references)

# Intro/logistics

Load packages

``` r
library(tidyverse)
library(ggplot2) # superfluous because ggplot2 is part of tidyverse

library(haven)
library(labelled)
```

Resources used to create this lecture

  - <https://r4ds.had.co.nz/data-visualisation.html>
  - <https://cfss.uchicago.edu/notes/grammar-of-graphics/#data-and-mapping>
  - <https://codewords.recurse.com/issues/six/telling-stories-with-data-using-the-grammar-of-graphics>
  - <http://r-statistics.co/Complete-Ggplot2-Tutorial-Part1-With-R-Code.html>
  - <https://ggplot2-book.org/>

## Datasets we will use

We will use two datasets that are part of the `ggplot2` package

  - `mpg`: EPA fuel economy data in 1999 and 2008 for 38 car models that
    had a new release every year between 1999 and 2008
      - note: no set of variables that uniquely identify observations
  - `diamonds`: prices and attributes of about 54,000 diamonds

<!-- end list -->

``` r
#?mpg
glimpse(mpg)
```

    ## Observations: 234
    ## Variables: 11
    ## $ manufacturer <chr> "audi", "audi", "audi", "audi", "audi", "audi", "audi"...
    ## $ model        <chr> "a4", "a4", "a4", "a4", "a4", "a4", "a4", "a4 quattro"...
    ## $ displ        <dbl> 1.8, 1.8, 2.0, 2.0, 2.8, 2.8, 3.1, 1.8, 1.8, 2.0, 2.0,...
    ## $ year         <int> 1999, 1999, 2008, 2008, 1999, 1999, 2008, 1999, 1999, ...
    ## $ cyl          <int> 4, 4, 4, 4, 6, 6, 6, 4, 4, 4, 4, 6, 6, 6, 6, 6, 6, 8, ...
    ## $ trans        <chr> "auto(l5)", "manual(m5)", "manual(m6)", "auto(av)", "a...
    ## $ drv          <chr> "f", "f", "f", "f", "f", "f", "f", "4", "4", "4", "4",...
    ## $ cty          <int> 18, 21, 20, 21, 16, 18, 18, 18, 16, 20, 19, 15, 17, 17...
    ## $ hwy          <int> 29, 29, 31, 30, 26, 26, 27, 26, 25, 28, 27, 25, 25, 25...
    ## $ fl           <chr> "p", "p", "p", "p", "p", "p", "p", "p", "p", "p", "p",...
    ## $ class        <chr> "compact", "compact", "compact", "compact", "compact",...

``` r
  #Uniquely identify obs?
  #mpg %>% group_by(manufacturer,model,cyl,trans,drv,fl,year) %>% count()
  #mpg %>% group_by(manufacturer,model,cyl,trans,drv,fl,year,displ,cty,hwy,class) %>% count()
```

``` r
#?diamonds
glimpse(diamonds)
```

    ## Observations: 53,940
    ## Variables: 10
    ## $ carat   <dbl> 0.23, 0.21, 0.23, 0.29, 0.31, 0.24, 0.24, 0.26, 0.22, 0.23,...
    ## $ cut     <ord> Ideal, Premium, Good, Premium, Good, Very Good, Very Good, ...
    ## $ color   <ord> E, E, E, I, J, J, I, H, E, H, J, J, F, J, E, E, I, J, J, J,...
    ## $ clarity <ord> SI2, SI1, VS1, VS2, SI2, VVS2, VVS1, SI1, VS2, VS1, SI1, VS...
    ## $ depth   <dbl> 61.5, 59.8, 56.9, 62.4, 63.3, 62.8, 62.3, 61.9, 65.1, 59.4,...
    ## $ table   <dbl> 55, 61, 65, 58, 58, 57, 57, 55, 61, 61, 55, 56, 61, 54, 62,...
    ## $ price   <int> 326, 326, 327, 334, 335, 336, 336, 337, 337, 338, 339, 340,...
    ## $ x       <dbl> 3.95, 3.89, 4.05, 4.20, 4.34, 3.94, 3.95, 4.07, 3.87, 4.00,...
    ## $ y       <dbl> 3.98, 3.84, 4.07, 4.23, 4.35, 3.96, 3.98, 4.11, 3.78, 4.05,...
    ## $ z       <dbl> 2.43, 2.31, 2.31, 2.63, 2.75, 2.48, 2.47, 2.53, 2.49, 2.39,...

We will use public-use data from the National Center for Education
Statistics (NCES) Educational Longitudinal Survey (ELS) of 2002

  - follows 10th graders from 2002 until 2012
  - variable `stu_id` uniquely identifies observations

<!-- end list -->

``` r
## variables we want to select from full ELS dataset
els_keepvars <- c(
    "STU_ID",        # student id
    "STRAT_ID",      # stratum id
    "PSU",           # primary sampling unit
    "BYRACE",        # (base year) race/ethnicity 
    "BYINCOME",      # (base year) parental income
    "BYPARED",       # (base year) parental education
    "BYNELS2M",      # (base year) math score
    "BYNELS2R",      # (base year) reading score
    "F3ATTAINMENT",  # (3rd follow up) attainment
    "F2PS1SEC",      # (2nd follow up) first institution attended
    "F3ERN2011",     # (3rd follow up), earnings from employment in 2011
    "F1SEX",         # (1st follow up) sex composite
    "F2EVRATT",      # (2nd follow up, composite) ever attended college
    "F2PS1LVL",      # (2nd follow up, composite) first attended postsecondary institution, level 
    "F2PS1CTR",      # (2nd follow up, composite) first attended postsecondary institution, control
    "F2PS1SLC"       # (2nd follow up, composite) first attended postsecondary institution, selectivity
)
els_keepvars
```

    ##  [1] "STU_ID"       "STRAT_ID"     "PSU"          "BYRACE"       "BYINCOME"    
    ##  [6] "BYPARED"      "BYNELS2M"     "BYNELS2R"     "F3ATTAINMENT" "F2PS1SEC"    
    ## [11] "F3ERN2011"    "F1SEX"        "F2EVRATT"     "F2PS1LVL"     "F2PS1CTR"    
    ## [16] "F2PS1SLC"

``` r
if (!exists("els")) { # if object named "els" does not exist, read in stata dataset
  els <- read_dta(file="C:/Users/ozanj/Documents/rclass2/data/els/els_02_12_byf3pststu_v1_0.dta") %>%
    # keep only subset of vars
    select(one_of(els_keepvars)) %>%
    # lower variable names
    rename_all(tolower)
}

glimpse(els)
```

    ## Observations: 16,197
    ## Variables: 16
    ## $ stu_id       <dbl> 101101, 101102, 101104, 101105, 101106, 101107, 101108...
    ## $ strat_id     <dbl> 101, 101, 101, 101, 101, 101, 101, 101, 101, 101, 101,...
    ## $ psu          <dbl+lbl> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,...
    ## $ byrace       <dbl+lbl> 5, 2, 7, 3, 4, 4, 4, 7, 4, 3, 3, 4, 3, 2, 2, 3, 3,...
    ## $ byincome     <dbl+lbl> 10, 11, 10, 2, 6, 9, 10, 10, 8, 3, 8, 8, 5, 8, 12,...
    ## $ bypared      <dbl+lbl> 5, 5, 2, 2, 1, 2, 6, 2, 2, 1, 6, 4, 4, 2, 7, 2, 7,...
    ## $ bynels2m     <dbl+lbl> 47.84, 55.30, 66.24, 35.33, 29.97, 24.28, 45.16, 6...
    ## $ bynels2r     <dbl+lbl> 39.04, 36.35, 42.68, 27.86, 13.07, 11.70, 19.66, 4...
    ## $ f3attainment <dbl+lbl> 3, 10, 6, 4, 4, 3, 4, 6, -4, 3, 3, 3, 5, 5, 6, -4,...
    ## $ f2ps1sec     <dbl+lbl> -8, 1, 1, 4, 4, -3, 4, 2, -4, 4, 1, -4, -4, 4, 2, ...
    ## $ f3ern2011    <dbl+lbl> 4000, 3000, 37000, 1500, 48000, 35000, 17000, 6800...
    ## $ f1sex        <dbl+lbl> 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 2, 2, 1, 1, 1, 2,...
    ## $ f2evratt     <dbl+lbl> -8, 1, 1, 1, 1, 0, 1, 1, -4, 1, 1, -4, -4, 1, 1, -...
    ## $ f2ps1lvl     <dbl+lbl> -8, 1, 1, 2, 2, -3, 2, 1, -4, 2, 1, -4, -4, 2, 1, ...
    ## $ f2ps1ctr     <dbl+lbl> -8, 1, 1, 1, 1, -3, 1, 2, -4, 1, 1, -4, -4, 1, 2, ...
    ## $ f2ps1slc     <dbl+lbl> -5, -5, -5, -5, -5, -5, -5, -5, -5, -5, -5, -5, -5...

``` r
els %>% var_label()
```

    ## $stu_id
    ## [1] "Student ID"
    ## 
    ## $strat_id
    ## [1] "Stratum"
    ## 
    ## $psu
    ## [1] "Primary sampling unit"
    ## 
    ## $byrace
    ## [1] "Student's race/ethnicity-composite"
    ## 
    ## $byincome
    ## [1] "Total family income from all sources 2001-composite"
    ## 
    ## $bypared
    ## [1] "Parents' highest level of education"
    ## 
    ## $bynels2m
    ## [1] "ELS-NELS 1992 scale equated sophomore math score"
    ## 
    ## $bynels2r
    ## [1] "ELS-NELS 1992 scale equated sophomore reading score"
    ## 
    ## $f3attainment
    ## [1] "Highest level of education earned as of F3"
    ## 
    ## $f2ps1sec
    ## [1] "Sector of first postsecondary institution"
    ## 
    ## $f3ern2011
    ## [1] "2011 employment income:  R only"
    ## 
    ## $f1sex
    ## [1] "F1 sex-composite"
    ## 
    ## $f2evratt
    ## [1] "Whether has ever attended a postsecondary institution - composite"
    ## 
    ## $f2ps1lvl
    ## [1] "Level of offering of first postsecondary institution"
    ## 
    ## $f2ps1ctr
    ## [1] "Control of first postsecondary institution"
    ## 
    ## $f2ps1slc
    ## [1] "Institutional selectivity of first attended postsecondary institution"

``` r
#count number of obs per student id
els %>% group_by(stu_id) %>% # group by your candidate key
  summarise(n_per_id=n()) %>% # create a measure of number of observations per group
  ungroup %>% # ungroup, otherwise frequency table [next step] created separately for each group
  count(n_per_id) # frequency of number of observations per group
```

    ## # A tibble: 1 x 2
    ##   n_per_id     n
    ##      <int> <int>
    ## 1        1 16197

``` r
#UNROLLMENT_PROJ DATA
elsdir <- "C:/Users/ozanj/Documents/unrollment_proj/data/cleaned"

list.files(path= elsdir)
file.path(elsdir)
file.path(elsdir,"els.Rds")

df <- readRDS(file = file.path(elsdir, "els.Rds"))
df
glimpse(df)
```

# Concepts

Grammar

  - Grammar
      - “the fundamental principles or rules of an art or science”
        \[Oxford English dictonary\]
  - Grammar of graphics (Wilkinson, 1999)
      - Principles/rules to describe and construct statistical graphics
  - Layered grammar of graphics (Wickham, 2010)
      - Principles/rules to describe and construct statistical graphics
        “based around the idea of building up a graphic from multiple
        layers of data” (Wickham, 2010, p. 4)
      - The layered grammar of graphics is a “formal system for building
        plots…based on the insight that you can uniquely describe *any*
        plot as a combination of” seven paramaters (Wickham & Grolemund,
        2017, Chapter 3)
  - Aesthetics
      - **aesthetics** are visual elements of the plot (e.g., lines,
        points, symbols, colors, axes)
      - **aesthetic mappings** are visual elements of the plot
        determined by values of specific variables (e.g., a scatterplot
        where the color of each point depends on the value of the
        variable `race`)
      - However, aesthetics need not be determined by variable values.
        For example, when creating scatterplot you may specify that the
        color of each point be blue

The seven parameters of the layered grammar of graphics consists of:

  - five layers
      - a dataset (**data**)
      - a set of aesthetic mappings (**mappings**)
      - a statistical transformation (**stat**)
      - a geometric object (**geom**)  
      - a position adjustment (**position**)
  - a coordinate system (**coord**)
  - a faceting scheme (**facets**)

`ggplot2` – part of the `tidyverse` – is an R package to create graphics
and `ggplot` is a function within the `ggplot2` package.

> In practice, you rarely need to supply all seven parameters to make a
> graph because ggplot2 will provide useful defaults for everything
> except the data, the mappings, and the geom function (Wickham &
> Grolemund, 2017, Chapter 3)

Syntax conveying the seven parameters of the layered grammer of graphics

``` r
ggplot(data = <DATA>) + 
  <GEOM_FUNCTION>(
     mapping = aes(<MAPPINGS>),
     stat = <STAT>, 
     position = <POSITION>
  ) +
  <COORDINATE_FUNCTION> +
  <FACET_FUNCTION>
```

## Layers

What does Wickham mean by **layers**? (from “[Telling Stories with Data
Using the Grammar of
Graphics](https://codewords.recurse.com/issues/six/telling-stories-with-data-using-the-grammar-of-graphics)”
by Liz Sander)

  - In the grammar of a language, words have different parts of speach
    (e.g., noun, verb, adjective), with each part of speech performing a
    different role in a sentence
  - the layered grammar of graphics decomposes a graphic into different
    **layers**
      - “These are layers in a literal sense – you can think of them as
        transparency sheets for an overhead projector, each containing a
        piece of the graphic, which can be arranged and combined in a
        variety of ways.”

The five layers of the grammar of graphics:

  - a dataset (**data**); a set of mappings (**mappings**); a
    statistical transformation (**stat**); a geometric object
    (**geom**); a position adjustment (**position**)

### dataset (**data**)

  - data defines the information to be visualized
  - For example, imagine a dataset where each observation is a student
    and the variables of interest are high-school math test score,
    `bynels2m`, and earnings in 2011, `f3ern2011`

<!-- end list -->

``` r
glimpse(els)
```

    ## Observations: 16,197
    ## Variables: 16
    ## $ stu_id       <dbl> 101101, 101102, 101104, 101105, 101106, 101107, 101108...
    ## $ strat_id     <dbl> 101, 101, 101, 101, 101, 101, 101, 101, 101, 101, 101,...
    ## $ psu          <dbl+lbl> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,...
    ## $ byrace       <dbl+lbl> 5, 2, 7, 3, 4, 4, 4, 7, 4, 3, 3, 4, 3, 2, 2, 3, 3,...
    ## $ byincome     <dbl+lbl> 10, 11, 10, 2, 6, 9, 10, 10, 8, 3, 8, 8, 5, 8, 12,...
    ## $ bypared      <dbl+lbl> 5, 5, 2, 2, 1, 2, 6, 2, 2, 1, 6, 4, 4, 2, 7, 2, 7,...
    ## $ bynels2m     <dbl+lbl> 47.84, 55.30, 66.24, 35.33, 29.97, 24.28, 45.16, 6...
    ## $ bynels2r     <dbl+lbl> 39.04, 36.35, 42.68, 27.86, 13.07, 11.70, 19.66, 4...
    ## $ f3attainment <dbl+lbl> 3, 10, 6, 4, 4, 3, 4, 6, -4, 3, 3, 3, 5, 5, 6, -4,...
    ## $ f2ps1sec     <dbl+lbl> -8, 1, 1, 4, 4, -3, 4, 2, -4, 4, 1, -4, -4, 4, 2, ...
    ## $ f3ern2011    <dbl+lbl> 4000, 3000, 37000, 1500, 48000, 35000, 17000, 6800...
    ## $ f1sex        <dbl+lbl> 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 2, 2, 1, 1, 1, 2,...
    ## $ f2evratt     <dbl+lbl> -8, 1, 1, 1, 1, 0, 1, 1, -4, 1, 1, -4, -4, 1, 1, -...
    ## $ f2ps1lvl     <dbl+lbl> -8, 1, 1, 2, 2, -3, 2, 1, -4, 2, 1, -4, -4, 2, 1, ...
    ## $ f2ps1ctr     <dbl+lbl> -8, 1, 1, 1, 1, -3, 1, 2, -4, 1, 1, -4, -4, 1, 2, ...
    ## $ f2ps1slc     <dbl+lbl> -5, -5, -5, -5, -5, -5, -5, -5, -5, -5, -5, -5, -5...

``` r
els %>% select(stu_id,bynels2m,f3ern2011,f1sex) %>% as_factor() %>% head(10)
```

    ## # A tibble: 10 x 4
    ##    stu_id bynels2m f3ern2011     f1sex 
    ##     <dbl> <fct>    <fct>         <fct> 
    ##  1 101101 47.84    4000          Female
    ##  2 101102 55.3     3000          Female
    ##  3 101104 66.24    37000         Female
    ##  4 101105 35.33    1500          Female
    ##  5 101106 29.97    48000         Female
    ##  6 101107 24.28    35000         Male  
    ##  7 101108 45.16    17000         Male  
    ##  8 101109 66.01    68000         Male  
    ##  9 101110 28.28    Nonrespondent Male  
    ## 10 101111 38.85    42000         Male

PROBABLY CUT THIS HYPOTHETICAL DATASET

``` r
incage <- tribble(
  ~id, ~age, ~inc000,
  1, 30, 70,
  2, 20, 18,
  3, 25, 150,
  4, 50, 200,
  5, 65, 15
)
incage
```

    ## # A tibble: 5 x 3
    ##      id   age inc000
    ##   <dbl> <dbl>  <dbl>
    ## 1     1    30     70
    ## 2     2    20     18
    ## 3     3    25    150
    ## 4     4    50    200
    ## 5     5    65     15

### set of mappings (**mappings**)

  - mapping defines how variables in a dataset are applied (mapped) to a
    graphic.
  - For example, map HS math test score to the x-axis and 2011 income to
    the y-axis
  - Additionally, if we are creating a scatterplot of test score (x) and
    income (y), we might use sex to define the color of each point

<!-- end list -->

``` r
els %>% select(stu_id,bynels2m,f3ern2011,f1sex) %>% 
  rename(x=bynels2m, y=f3ern2011, color=f1sex) %>% 
  as_factor() %>% head(10)
```

    ## # A tibble: 10 x 4
    ##    stu_id x     y             color 
    ##     <dbl> <fct> <fct>         <fct> 
    ##  1 101101 47.84 4000          Female
    ##  2 101102 55.3  3000          Female
    ##  3 101104 66.24 37000         Female
    ##  4 101105 35.33 1500          Female
    ##  5 101106 29.97 48000         Female
    ##  6 101107 24.28 35000         Male  
    ##  7 101108 45.16 17000         Male  
    ##  8 101109 66.01 68000         Male  
    ##  9 101110 28.28 Nonrespondent Male  
    ## 10 101111 38.85 42000         Male

ADD EXAMPLES

### statistical transformation (**stat**):

  - a statistical transformation transforms the underlying data before
    plotting it
  - Imagine creating a scatterplot of the relationship HS math test
    score (x-axis) and 2011 income (y-axis)
      - When creating a scatterplot we usually do not transform the data
        prior to plotting. This is the “identity” transformation.

<!-- end list -->

``` r
els %>% select(stu_id,bynels2m,f3ern2011) %>% rename(x=bynels2m, y=f3ern2011) %>% 
  as_factor() %>% head(10)
```

    ## # A tibble: 10 x 3
    ##    stu_id x     y            
    ##     <dbl> <fct> <fct>        
    ##  1 101101 47.84 4000         
    ##  2 101102 55.3  3000         
    ##  3 101104 66.24 37000        
    ##  4 101105 35.33 1500         
    ##  5 101106 29.97 48000        
    ##  6 101107 24.28 35000        
    ##  7 101108 45.16 17000        
    ##  8 101109 66.01 68000        
    ##  9 101110 28.28 Nonrespondent
    ## 10 101111 38.85 42000

  - Imagine we have student-level data and want to create bar chart of
    the number of students by postsecondary institution type
      - Here, we do not plot the raw data. Rather, we count the number
        of observations within each system. This count is a statistical
        transformation.

MODIFY TO COMBINE CATEGORIES? OR MAYBE DRAW FROM A DIFFERENT INPUT
VARIABLE?

``` r
#glimpse(els)
els %>% count(f2ps1sec) %>% as_factor
```

    ## # A tibble: 13 x 2
    ##    f2ps1sec                                     n
    ##    <fct>                                    <int>
    ##  1 Missing                                     50
    ##  2 Survey component legitimate skip/NA        359
    ##  3 Nonrespondent                             1691
    ##  4 Item legitimate skip/NA                   3613
    ##  5 Public, 4-year or above                   4178
    ##  6 Private not-for-profit, 4-year or above   2135
    ##  7 Private for-profit, 4-year or above        176
    ##  8 Public, 2-year                            3465
    ##  9 Private not-for-profit, 2-year              42
    ## 10 Private for-profit, 2-year                 184
    ## 11 Public, less than 2-year                   114
    ## 12 Private not-for-profit, less than 2-year    25
    ## 13 Private for-profit, less than 2-year       165

### geometric objects (**geoms**)

  - graphs visually display data, using geometric objects like a point,
    line, bar, etc.
  - each geometric object in a graph is called a “geom”
  - “A geom is the geometrical object that a plot uses to represent
    data” (Wickham & Grolemund, 2017, Chapter 3)
  - “People often describe plots by the type of geom that the plot uses.
    For example, bar charts use bar geoms, line charts use line geoms,
    boxplots use boxplot geoms” (Wickham & Grolemund, 2017, Chapter 3)
  - **aesthetics** are “visual attributes of the geom” (e.g., color,
    fill, shape, position)
    <https://cfss.uchicago.edu/notes/grammar-of-graphics/>
      - Each geom can only display certain aesthetics
      - For example, a “point geom” can only include the aesthetics
        position, color, shape, and size
  - We can plot the same underlying data using different geoms (e.g.,
    bar chart vs. pie chart)
  - A single graph can layer multiple geoms. For example, consider a
    scatterplot with a “line of best fit” layered on top

### position adjustment (**position**)

  - Position adjustment adusts the position of visual elements in the
    plot so that these visual elements do not overlap one another in
    ways that make the plot difficult to interpret
  - A simple example:
      - The dataset `mpg` (included in the `ggplot2` package) contains
        variables for the specifications of different cars, with 234
        observations
      - Create a scatterplot of the relationship between number of
        cylinders in the engine (x-axis) and highway miles-per gallon
        (y-axis)
      - Below plot is difficult to interpet because many points overlap
        with one another

<!-- end list -->

``` r
#glimpse(mpg)
ggplot(data = mpg, mapping = aes(x = cyl, y = hwy)) +
  geom_point()
```

![](ggplot_lecture_files/figure-gfm/unnamed-chunk-12-1.png)<!-- -->

  - the `jitter` position adjustment “adds a small amount of random
    variation to the location of each point” (from ?geom\_jitter)

<!-- end list -->

``` r
ggplot(data = mpg, mapping = aes(x = cyl, y = hwy)) +
  geom_point(position = "jitter")
```

![](ggplot_lecture_files/figure-gfm/unnamed-chunk-13-1.png)<!-- -->

### Coordinate system and faceting

Coordinate system (**coord**)

  - “A coordinate system (coord) maps the position of objects onto the
    plane of the plot, and controls how the axes and grid lines are
    drawn. Plots typically use two coordinates (x,y), but could use any
    number of coordinates”
    <https://cfss.uchicago.edu/notes/grammar-of-graphics/>
  - Most plots use the “Cartesian coordinate system” but other
    coordinate systems exist, such as the “polar coordinate system”
  - From <https://cfss.uchicago.edu/notes/grammar-of-graphics/>:

<!-- end list -->

``` r
x1 <- c(1, 10)
y1 <- c(1, 5)
p <- qplot(x = x1, y = y1, geom = "blank", xlab = NULL, ylab = NULL) +
  theme_bw()

p +
  ggtitle(label = "Cartesian coordinate system")
```

![](ggplot_lecture_files/figure-gfm/unnamed-chunk-14-1.png)<!-- -->

``` r
p +
  coord_polar() +
  ggtitle(label = "Polar coordinate system")
```

![](ggplot_lecture_files/figure-gfm/unnamed-chunk-14-2.png)<!-- --> -
When using the default Cartesian coordinate system, a common task is to
flip the x and y axis. From
<https://r4ds.had.co.nz/data-visualisation.html#coordinate-systems>

``` r
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot()
```

![](ggplot_lecture_files/figure-gfm/unnamed-chunk-15-1.png)<!-- -->

``` r
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot() +
  coord_flip()
```

![](ggplot_lecture_files/figure-gfm/unnamed-chunk-15-2.png)<!-- -->

Faceting scheme (**facets**)

  - **facets** are subplots that display one subset of the data
  - facets are most commonly used to create “small multiples”
  - For example, here we create a scatterplot of the relationship
    between engine cylinder (x-axis) and highway miles per gallon
    (y-axis), with separate subplots for car `class` (e.g., midsize,
    minivan, pickup, suv)

<!-- end list -->

``` r
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = cyl, y = hwy), position = "jitter") + 
  facet_wrap(~ class, nrow = 2)
```

![](ggplot_lecture_files/figure-gfm/unnamed-chunk-16-1.png)<!-- -->

# Creating graphs using `ggplot`

## `ggplot() and`aes()\` functions

Show index for package `ggplot2`

``` r
help(package = ggplot2)
```

The `ggplot` function

``` r
?ggplot

#SYNTAX AND DEFAULT VALUES
ggplot(data = NULL, mapping = aes())
```

  - Description (from help file)
      - “`ggplot()` initializes a ggplot object. It can be used to
        declare the input data frame for a graphic and to specify the
        set of plot aesthetics intended to be common throughout all
        subsequent layers unless specifically overridden”
  - Arguments
      - `data`: dataset to use for plot. If not specified in `ggplot`
        function, must be supplied in each layer added to the plot.
      - `mapping`: default list of aesthetic mappings to use for plot.
        If not specified, must be supplied in each layer added to the
        plot

The `aes` function (often called within the `ggplot` function)

``` r
?aes

#SYNTAX
aes(x, y, ...)
```

  - Description (from help file)
      - “Aesthetic mappings describe how variables in the data are
        mapped to visual properties (aesthetics) of geoms. Aesthetic
        mappings can be set in `ggplot()` and in individual layers.”
  - Arguments
      - `x`, `y`: List of name value pairs giving aesthetics to map to
        variables.
      - `...` additional aesthetic mappings specified by user

Putting `ggplot()` and `aes()` together

``` r
ggplot(data= mpg, aes(x = displ, y = hwy))
```

![](ggplot_lecture_files/figure-gfm/unnamed-chunk-20-1.png)<!-- -->

  - Specifying `ggplot()` and `aes()` without specifying a geom layer
    (e.g., `geom_point()`) creates a blank ggplot

<!-- end list -->

``` r
#diamonds
ggplot(data= diamonds, aes(x = carat, y = price))
```

![](ggplot_lecture_files/figure-gfm/unnamed-chunk-21-1.png)<!-- --> - We
can create assign a ggplot object for later use

``` r
diam_ggplot <- ggplot(data= diamonds, aes(x = carat, y = price))

diam_ggplot # creates blank ggplot
```

![](ggplot_lecture_files/figure-gfm/unnamed-chunk-22-1.png)<!-- --> -
Investigate ggplot object

``` r
typeof(diam_ggplot)
```

    ## [1] "list"

``` r
class(diam_ggplot)
```

    ## [1] "gg"     "ggplot"

``` r
str(diam_ggplot)
```

    ## List of 9
    ##  $ data       :Classes 'tbl_df', 'tbl' and 'data.frame': 53940 obs. of  10 variables:
    ##   ..$ carat  : num [1:53940] 0.23 0.21 0.23 0.29 0.31 0.24 0.24 0.26 0.22 0.23 ...
    ##   ..$ cut    : Ord.factor w/ 5 levels "Fair"<"Good"<..: 5 4 2 4 2 3 3 3 1 3 ...
    ##   ..$ color  : Ord.factor w/ 7 levels "D"<"E"<"F"<"G"<..: 2 2 2 6 7 7 6 5 2 5 ...
    ##   ..$ clarity: Ord.factor w/ 8 levels "I1"<"SI2"<"SI1"<..: 2 3 5 4 2 6 7 3 4 5 ...
    ##   ..$ depth  : num [1:53940] 61.5 59.8 56.9 62.4 63.3 62.8 62.3 61.9 65.1 59.4 ...
    ##   ..$ table  : num [1:53940] 55 61 65 58 58 57 57 55 61 61 ...
    ##   ..$ price  : int [1:53940] 326 326 327 334 335 336 336 337 337 338 ...
    ##   ..$ x      : num [1:53940] 3.95 3.89 4.05 4.2 4.34 3.94 3.95 4.07 3.87 4 ...
    ##   ..$ y      : num [1:53940] 3.98 3.84 4.07 4.23 4.35 3.96 3.98 4.11 3.78 4.05 ...
    ##   ..$ z      : num [1:53940] 2.43 2.31 2.31 2.63 2.75 2.48 2.47 2.53 2.49 2.39 ...
    ##  $ layers     : list()
    ##  $ scales     :Classes 'ScalesList', 'ggproto', 'gg' <ggproto object: Class ScalesList, gg>
    ##     add: function
    ##     clone: function
    ##     find: function
    ##     get_scales: function
    ##     has_scale: function
    ##     input: function
    ##     n: function
    ##     non_position_scales: function
    ##     scales: NULL
    ##     super:  <ggproto object: Class ScalesList, gg> 
    ##  $ mapping    :List of 2
    ##   ..$ x: language ~carat
    ##   .. ..- attr(*, ".Environment")=<environment: R_GlobalEnv> 
    ##   ..$ y: language ~price
    ##   .. ..- attr(*, ".Environment")=<environment: R_GlobalEnv> 
    ##   ..- attr(*, "class")= chr "uneval"
    ##  $ theme      : list()
    ##  $ coordinates:Classes 'CoordCartesian', 'Coord', 'ggproto', 'gg' <ggproto object: Class CoordCartesian, Coord, gg>
    ##     aspect: function
    ##     backtransform_range: function
    ##     clip: on
    ##     default: TRUE
    ##     distance: function
    ##     expand: TRUE
    ##     is_free: function
    ##     is_linear: function
    ##     labels: function
    ##     limits: list
    ##     modify_scales: function
    ##     range: function
    ##     render_axis_h: function
    ##     render_axis_v: function
    ##     render_bg: function
    ##     render_fg: function
    ##     setup_data: function
    ##     setup_layout: function
    ##     setup_panel_params: function
    ##     setup_params: function
    ##     transform: function
    ##     super:  <ggproto object: Class CoordCartesian, Coord, gg> 
    ##  $ facet      :Classes 'FacetNull', 'Facet', 'ggproto', 'gg' <ggproto object: Class FacetNull, Facet, gg>
    ##     compute_layout: function
    ##     draw_back: function
    ##     draw_front: function
    ##     draw_labels: function
    ##     draw_panels: function
    ##     finish_data: function
    ##     init_scales: function
    ##     map_data: function
    ##     params: list
    ##     setup_data: function
    ##     setup_params: function
    ##     shrink: TRUE
    ##     train_scales: function
    ##     vars: function
    ##     super:  <ggproto object: Class FacetNull, Facet, gg> 
    ##  $ plot_env   :<environment: R_GlobalEnv> 
    ##  $ labels     :List of 2
    ##   ..$ x: chr "carat"
    ##   ..$ y: chr "price"
    ##  - attr(*, "class")= chr [1:2] "gg" "ggplot"

  - Attributes of ggplot object

<!-- end list -->

``` r
attributes(diam_ggplot)
```

    ## $names
    ## [1] "data"        "layers"      "scales"      "mapping"     "theme"      
    ## [6] "coordinates" "facet"       "plot_env"    "labels"     
    ## 
    ## $class
    ## [1] "gg"     "ggplot"

``` r
diam_ggplot$mapping
```

    ## Aesthetic mapping: 
    ## * `x` -> `carat`
    ## * `y` -> `price`

``` r
diam_ggplot$labels
```

    ## $x
    ## [1] "carat"
    ## 
    ## $y
    ## [1] "price"

## Adding geometric layer to a ggplot object using a “geom function”

Adding a geometric layer to a ggplot object dictates how observations
are displayed in the plot

  - Geometric layers are specified using “geom functions”
  - There are many different geom functions.
      - For example, `geom_point()` creates a scatterplot, `geom_bar()`
        creates a bar chart
  - We will start by creating scatterplots
      - Scatterplots are most useful for showing the relationship
        between two continuous variables

### Scatterplots using `geom_point()`

``` r
ggplot(data= diamonds, aes(x = carat, y = price)) + geom_point()
```

![](ggplot_lecture_files/figure-gfm/unnamed-chunk-25-1.png)<!-- --> If
we already created and assigned a ggplot object, we can use that object
to create the plot

``` r
diam_ggplot + geom_point()
```

![](ggplot_lecture_files/figure-gfm/unnamed-chunk-26-1.png)<!-- -->

Using the `els` data frame, let’s create a scatterplot of the
relationship between high school math test score (`bynels2m`, x-axis)
and 2011 earnings (`f3ern2011`, y-axis)

  - first, let’s investigate the underlying variables

<!-- end list -->

``` r
els %>% select(bynels2m,f3ern2011) %>%
  summarize_all(.funs = list(~ mean(., na.rm = TRUE), ~ min(., na.rm = TRUE), ~ max(., na.rm = TRUE)))
```

    ## # A tibble: 1 x 6
    ##   bynels2m_mean f3ern2011_mean bynels2m_min f3ern2011_min bynels2m_max
    ##           <dbl>          <dbl>        <dbl>         <dbl>        <dbl>
    ## 1          44.3         21276.           -8            -8         79.3
    ## # ... with 1 more variable: f3ern2011_max <dbl>

  - Investigate values less than zero

<!-- end list -->

``` r
els %>% select(bynels2m) %>% filter(bynels2m<0) %>% count(bynels2m)
```

    ## # A tibble: 1 x 2
    ##                                   bynels2m     n
    ##                                  <dbl+lbl> <int>
    ## 1 -8 [Survey component legitimate skip/NA]   305

``` r
els %>% select(bynels2m) %>% filter(bynels2m<0) %>% count(bynels2m) %>% as_factor()
```

    ## # A tibble: 1 x 2
    ##   bynels2m                                n
    ##   <fct>                               <int>
    ## 1 Survey component legitimate skip/NA   305

``` r
els %>% select(f3ern2011) %>% filter(f3ern2011<0) %>% count(f3ern2011)
```

    ## # A tibble: 2 x 2
    ##                                  f3ern2011     n
    ##                                  <dbl+lbl> <int>
    ## 1 -8 [Survey component legitimate skip/NA]   459
    ## 2 -4 [Nonrespondent]                        2488

``` r
els %>% select(f3ern2011) %>% filter(f3ern2011<0) %>% count(f3ern2011) %>% as_factor()
```

    ## # A tibble: 2 x 2
    ##   f3ern2011                               n
    ##   <fct>                               <int>
    ## 1 Survey component legitimate skip/NA   459
    ## 2 Nonrespondent                        2488

  - Create version of variables the replace values less than zero with
    `NA`

<!-- end list -->

``` r
els_v2 <- els %>% 
  mutate(
    hs_math = if_else(bynels2m<0,NA_real_,as.numeric(bynels2m)),
    earn2011 = if_else(f3ern2011<0,NA_real_,as.numeric(f3ern2011)),
  )

#check
els_v2 %>% filter(bynels2m<0) %>% count(bynels2m, hs_math)
```

    ## # A tibble: 1 x 3
    ##                                   bynels2m hs_math     n
    ##                                  <dbl+lbl>   <dbl> <int>
    ## 1 -8 [Survey component legitimate skip/NA]      NA   305

``` r
els_v2 %>% filter(f3ern2011<0) %>% count(f3ern2011, earn2011)
```

    ## # A tibble: 2 x 3
    ##                                  f3ern2011 earn2011     n
    ##                                  <dbl+lbl>    <dbl> <int>
    ## 1 -8 [Survey component legitimate skip/NA]       NA   459
    ## 2 -4 [Nonrespondent]                             NA  2488

``` r
els_v2 %>% count(bypared) %>% as_factor()
```

    ## # A tibble: 11 x 2
    ##    bypared                                      n
    ##    <fct>                                    <int>
    ##  1 Missing                                     49
    ##  2 Survey component legitimate skip/NA        179
    ##  3 Nonrespondent                              648
    ##  4 Did not finish high school                 944
    ##  5 Graduated from high school or GED         3053
    ##  6 Attended 2-year school, no degree         1666
    ##  7 Graduated from 2-year school              1597
    ##  8 Attended college, no 4-year degree        1758
    ##  9 Graduated from college                    3468
    ## 10 Completed Master's degree or equivalent   1786
    ## 11 Completed PhD, MD, other advanced degree  1049

  - to avoid scatterplot with too many points, create data frame
    consisting of students whose parents have a PhD or first
    professional degree

<!-- end list -->

``` r
els_parphd <- els_v2 %>% filter(bypared==8)
```

  - Plot

<!-- end list -->

``` r
#ggplot(data= els_v2, aes(x = hs_math, y = earn2011)) + geom_point()
ggplot(data= els_parphd, aes(x = hs_math, y = earn2011)) + geom_point()
```

    ## Warning: Removed 115 rows containing missing values (geom_point).

![](ggplot_lecture_files/figure-gfm/unnamed-chunk-31-1.png)<!-- -->

geom function syntax options (`geom_point()`)

``` r
?geom_point
```

  - Syntax (with defaults)
      - `geom_point(mapping = NULL, data = NULL, stat = "identity",
        position = "identity", ..., na.rm = FALSE, show.legend = NA,
        inherit.aes = TRUE)`
      - See arguments in help file
  - Aesthetics: `geom_point()` understands (i.e., accepts) the following
    aesthetics (required aesthetics in bold)
      - **x**; **y**; alpha; colour; fill; group; shape; size; stroke
      - note: other geom functions (e.g., `geom_bar()`) accepts a
        different set of aesthetics

Scatterplot of relationship between engine displacement (`displ`, x) and
highway miles per gallon (`hwy`, y), with color of points determined by
type of car (`class`)

``` r
ggplot(data = mpg, aes(x = displ, y = hwy, color = class)) + 
  geom_point()
```

![](ggplot_lecture_files/figure-gfm/unnamed-chunk-33-1.png)<!-- -->

  - Alternatively, can specify the `color` aethetic within
    `geom_point()`

<!-- end list -->

``` r
ggplot(data = mpg, aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class))
```

![](ggplot_lecture_files/figure-gfm/unnamed-chunk-34-1.png)<!-- -->

Task: Create scatterplot of relationship between math score (x) and 2011
earnings (y), with color of points determined by sex (`f1sex`)

  - below code doesn’t work because `aes()` expects the “color”
    aesthetic to be a factor variable

<!-- end list -->

``` r
ggplot(data= els_parphd, aes(x = hs_math, y = earn2011, color = f1sex)) + geom_point()
```

``` r
ggplot(data= els_parphd, aes(x = hs_math, y = earn2011, color = as_factor(f1sex))) + geom_point()
```

    ## Warning: Removed 115 rows containing missing values (geom_point).

![](ggplot_lecture_files/figure-gfm/unnamed-chunk-36-1.png)<!-- -->
\#\#\# Smoothed prediction lines using `geom_smooth()`

Motivation

  - biggest problem with scatterplots is “overplotting.” That is, when
    you plot many observations, points may be plotted on top of one
    another and difficult to visually discern the relationship

<!-- end list -->

``` r
ggplot(data= els_v2, aes(x = hs_math, y = earn2011)) + geom_point()
```

    ## Warning: Removed 3151 rows containing missing values (geom_point).

![](ggplot_lecture_files/figure-gfm/unnamed-chunk-37-1.png)<!-- -->

`geom_smooth()` creates smoothed prediction lines with shaded confidence
intervals

  - syntax, with default values (very similar to `geom_point()`)
      - `geom_smooth(mapping = NULL, data = NULL, stat = "smooth",
        position = "identity", ..., method = "auto", formula = y ~ x, se
        = TRUE, na.rm = FALSE, show.legend = NA, inherit.aes = TRUE)`
      - Note default “statistical transformation”:
          - `stat = "smooth"` for `geom_smooth()`
          - `stat = "identity"` for `geom_point()`
  - Aesthetics: `geom_smooth()` accepts the following aesthetics
    (required aesthetics in bold)
      - **x**; **y**; alpha; colour; fill; group; linetype; size;
        weight; ymax; ymin

<!-- end list -->

``` r
ggplot(data= els_v2, aes(x = hs_math, y = earn2011)) + geom_smooth()
```

    ## `geom_smooth()` using method = 'gam' and formula 'y ~ s(x, bs = "cs")'

    ## Warning: Removed 3151 rows containing non-finite values (stat_smooth).

![](ggplot_lecture_files/figure-gfm/unnamed-chunk-38-1.png)<!-- --> -
Same as above:

``` r
ggplot(data= els_v2) + geom_smooth(mapping = aes(x = hs_math, y = earn2011))
```

    ## `geom_smooth()` using method = 'gam' and formula 'y ~ s(x, bs = "cs")'

    ## Warning: Removed 3151 rows containing non-finite values (stat_smooth).

![](ggplot_lecture_files/figure-gfm/unnamed-chunk-39-1.png)<!-- --> -
use `group` aesthetic to create separate prediction lines by sex
(`f1sex`)

``` r
ggplot(data= els_v2) + geom_smooth(mapping = aes(x = hs_math, y = earn2011, group=as_factor(f1sex)))
```

    ## `geom_smooth()` using method = 'gam' and formula 'y ~ s(x, bs = "cs")'

    ## Warning: Removed 3151 rows containing non-finite values (stat_smooth).

![](ggplot_lecture_files/figure-gfm/unnamed-chunk-40-1.png)<!-- -->

``` r
#same:
#ggplot(data= els_v2, aes(x = hs_math, y = earn2011, group=as_factor(f1sex))) + geom_smooth()
```

  - use `linetype` aesthetic to create separate prediction lines (with
    different line styles) by sex (`f1sex`)

<!-- end list -->

``` r
ggplot(data= els_v2) + geom_smooth(mapping = aes(x = hs_math, y = earn2011, linetype=as_factor(f1sex)))
```

    ## `geom_smooth()` using method = 'gam' and formula 'y ~ s(x, bs = "cs")'

    ## Warning: Removed 3151 rows containing non-finite values (stat_smooth).

![](ggplot_lecture_files/figure-gfm/unnamed-chunk-41-1.png)<!-- -->

``` r
#same:
#ggplot(data= els_v2, aes(x = hs_math, y = earn2011, linetype=as_factor(f1sex))) + geom_smooth()
```

  - use `color` aesthatic to create separate prediction lines (with
    different colors) by sex (`f1sex`)

<!-- end list -->

``` r
ggplot(data= els_v2) + geom_smooth(mapping = aes(x = hs_math, y = earn2011, color=as_factor(f1sex)))
```

    ## `geom_smooth()` using method = 'gam' and formula 'y ~ s(x, bs = "cs")'

    ## Warning: Removed 3151 rows containing non-finite values (stat_smooth).

![](ggplot_lecture_files/figure-gfm/unnamed-chunk-42-1.png)<!-- -->

``` r
#same:
ggplot(data= els_v2, aes(x = hs_math, y = earn2011, color=as_factor(f1sex))) + geom_smooth()
```

    ## `geom_smooth()` using method = 'gam' and formula 'y ~ s(x, bs = "cs")'

    ## Warning: Removed 3151 rows containing non-finite values (stat_smooth).

![](ggplot_lecture_files/figure-gfm/unnamed-chunk-42-2.png)<!-- -->

### Plot multiple geom layers by adding multiple geom functions

Layer smoothed prediction line (`geom_smooth()`) on top of scatterplot
(`geom_point()`)

``` r
ggplot(data= els_v2) + 
  geom_point(mapping = aes(x = hs_math, y = earn2011)) + 
  geom_smooth(mapping = aes(x = hs_math, y = earn2011))
```

    ## `geom_smooth()` using method = 'gam' and formula 'y ~ s(x, bs = "cs")'

    ## Warning: Removed 3151 rows containing non-finite values (stat_smooth).

    ## Warning: Removed 3151 rows containing missing values (geom_point).

![](ggplot_lecture_files/figure-gfm/unnamed-chunk-43-1.png)<!-- --> -
can create same plot using this syntax:

``` r
ggplot(data= els_v2, aes(x = hs_math, y = earn2011)) + 
  geom_point() +
  geom_smooth()
```

    ## `geom_smooth()` using method = 'gam' and formula 'y ~ s(x, bs = "cs")'

    ## Warning: Removed 3151 rows containing non-finite values (stat_smooth).

    ## Warning: Removed 3151 rows containing missing values (geom_point).

![](ggplot_lecture_files/figure-gfm/unnamed-chunk-44-1.png)<!-- -->

  - Adjust x-axis and y-axis limits by using `+ xlim()` and `+ ylim()`

<!-- end list -->

``` r
ggplot(data= els_v2, aes(x = hs_math, y = earn2011)) + 
  geom_point() +
  geom_smooth() +
  xlim(c(20,80)) + ylim(c(0,100000))
```

    ## `geom_smooth()` using method = 'gam' and formula 'y ~ s(x, bs = "cs")'

    ## Warning: Removed 3538 rows containing non-finite values (stat_smooth).

    ## Warning: Removed 3538 rows containing missing values (geom_point).

![](ggplot_lecture_files/figure-gfm/unnamed-chunk-45-1.png)<!-- -->

  - layer smooth line (with different color )
  - Layer smoothed prediction line with different line types by sex
    (`f1sex`) on top of scatterplot with color of points determined by
    sex

<!-- end list -->

``` r
ggplot(data= els_v2) + 
  geom_point(mapping = aes(x = hs_math, y = earn2011, color = as_factor(f1sex))) + 
  geom_smooth(mapping = aes(x = hs_math, y = earn2011, linetype = as_factor(f1sex))) +
  xlim(c(20,80)) + ylim(c(0,100000))
```

    ## `geom_smooth()` using method = 'gam' and formula 'y ~ s(x, bs = "cs")'

    ## Warning: Removed 3538 rows containing non-finite values (stat_smooth).

    ## Warning: Removed 3538 rows containing missing values (geom_point).

![](ggplot_lecture_files/figure-gfm/unnamed-chunk-46-1.png)<!-- --> -
same as above \[chunk not evaluated\]

``` r
ggplot(data= els_v2, aes(x = hs_math, y = earn2011, color = as_factor(f1sex))) + 
  geom_point() + 
  geom_smooth() +
  xlim(c(20,80)) + ylim(c(0,100000))
```

### Bar charts (`geom_bar()`) to plot a single, discrete variable

Bar charts:

  - X-axis typically represents a categorical variable (e.g,. race,
    gender, institutional type)
      - Each value of the categorical variable is a “group”
  - Y-axis often represents the number of cases in a group (or the
    proportion of cases in a group)
      - But height of bar could also represent mean value for a group or
        some other summary statistic (e.g., min, max, std)

Two geom functions to create bar charts

  - `geom_bar()`: the height of each bar represents the number of cases
    (i.e., observations) in the group
      - Statistical transformation = “count”
          - counts the number of cases in each group
          - Y value for a group is number of cases in the group
      - Use `geom_bar()` when using (for example) student-level data and
        you don’t want to summarize student-level data prior to creating
        the chart
  - `geom_col()`: the height of the bar represents the value of some
    variable for the group
      - Statistical transformation = “identity”
          - Y-value for a group is the value of a variable in the data
            frame
      - Use `geom_col()` when you have already created an object of
        summary statistics (e.g., counts, mean value, etc.)

<!-- end list -->

``` r
?geom_bar
?geom_col
```

Task: Using data frame `diamonds`, create a bar chart w/ variable `cut`
(e.g. “Fair,” “Good,” “Ideal”) as x-axis and number of diamonds as
y-axis

1.  Create bar chart using `geom_bar()`
2.  Create bar chart using `geom_col()`

Essentially, you are being asked to create a bar chart from the
following frequency count:

``` r
diamonds %>% count(cut)
```

    ## # A tibble: 5 x 2
    ##   cut           n
    ##   <ord>     <int>
    ## 1 Fair       1610
    ## 2 Good       4906
    ## 3 Very Good 12082
    ## 4 Premium   13791
    ## 5 Ideal     21551

Create bar chart of `cut` using `geom_bar()`

``` r
ggplot(data = diamonds, aes(x = cut)) +
  geom_bar()
```

![](ggplot_lecture_files/figure-gfm/unnamed-chunk-50-1.png)<!-- -->
Create bar chart of `cut` using `geom_col()`

``` r
#first create an object of frequency count of variable cut
cut <- diamonds %>% count(cut)
cut
```

    ## # A tibble: 5 x 2
    ##   cut           n
    ##   <ord>     <int>
    ## 1 Fair       1610
    ## 2 Good       4906
    ## 3 Very Good 12082
    ## 4 Premium   13791
    ## 5 Ideal     21551

``` r
#next, use ggplot() + geom_col to plot the data fram object cut
ggplot(data = cut, aes(x = cut, y=n)) +
  geom_col()
```

![](ggplot_lecture_files/figure-gfm/unnamed-chunk-51-1.png)<!-- --> - We
can also use `bar_col()` to create bar chart of `cut` without creating
separate object first

``` r
diamonds %>% count(cut) %>% str()
```

    ## Classes 'tbl_df', 'tbl' and 'data.frame':    5 obs. of  2 variables:
    ##  $ cut: Ord.factor w/ 5 levels "Fair"<"Good"<..: 1 2 3 4 5
    ##  $ n  : int  1610 4906 12082 13791 21551

``` r
#below, we can omit the data argument from ggplot because we pipe in value of first argument
diamonds %>% count(cut) %>% ggplot(aes(x= cut, y=n)) + geom_col()
```

![](ggplot_lecture_files/figure-gfm/unnamed-chunk-52-1.png)<!-- -->

Task: Using data frame `els`, create a bar chart w/ variable “ever
attended postsecondary education” (`f2evratt`) as x-axis and number of
students as y-axis

1.  Create bar chart using `geom_bar()`
2.  Create bar chart using `geom_col()`

Essentially, you are being asked to create a bar chart from the
following frequency count:

``` r
#glimpse(els_v2)
els_v2 %>% select(f2evratt) %>% var_label()
```

    ## $f2evratt
    ## [1] "Whether has ever attended a postsecondary institution - composite"

``` r
#ever attended
els_v2 %>%  count(f2evratt)
```

    ## # A tibble: 5 x 2
    ##                                   f2evratt     n
    ##                                  <dbl+lbl> <int>
    ## 1 -8 [Survey component legitimate skip/NA]   359
    ## 2 -4 [Nonrespondent]                        1691
    ## 3 -3 [Item legitimate skip/NA]               108
    ## 4  0 [No]                                   3505
    ## 5  1 [Yes]                                 10534

``` r
els_v2 %>%  count(f2evratt) %>% as_factor()
```

    ## # A tibble: 5 x 2
    ##   f2evratt                                n
    ##   <fct>                               <int>
    ## 1 Survey component legitimate skip/NA   359
    ## 2 Nonrespondent                        1691
    ## 3 Item legitimate skip/NA               108
    ## 4 No                                   3505
    ## 5 Yes                                 10534

Create bar chart of `f2evratt` using `geom_bar()`

``` r
ggplot(data = els_v2, aes(x = as_factor(f2evratt))) +
  geom_bar()
```

![](ggplot_lecture_files/figure-gfm/unnamed-chunk-54-1.png)<!-- -->

``` r
#we can use pipes and then omit the first argument of ggplot, which specifies the data frame we will plot
els_v2 %>% ggplot(aes(x = as_factor(f2evratt))) +
  geom_bar()
```

![](ggplot_lecture_files/figure-gfm/unnamed-chunk-54-2.png)<!-- -->

``` r
#Using pipes, we can filter values of f2evratt before plotting
els_v2 %>% filter(f2evratt>=0) %>% ggplot(aes(x = as_factor(f2evratt))) +
  geom_bar()
```

![](ggplot_lecture_files/figure-gfm/unnamed-chunk-54-3.png)<!-- -->
Create bar chart of `f2evratt` using `geom_col()`

``` r
els_v2 %>% 
  ## filter to remove missing values
  filter(f2evratt>=0) %>% 
  ## use count() to create summary statistics object
  count(f2evratt) %>%
  ## plot summary statistic object
  ggplot(aes(x=as_factor(f2evratt), y=n)) + geom_col()
```

![](ggplot_lecture_files/figure-gfm/unnamed-chunk-55-1.png)<!-- -->

### relationship between discrete x and discrete y

``` r
els_v2 %>% select(f2evratt,f2ps1lvl) %>% var_label()
```

    ## $f2evratt
    ## [1] "Whether has ever attended a postsecondary institution - composite"
    ## 
    ## $f2ps1lvl
    ## [1] "Level of offering of first postsecondary institution"

``` r
#ever attended
els_v2 %>%  count(f2evratt)
```

    ## # A tibble: 5 x 2
    ##                                   f2evratt     n
    ##                                  <dbl+lbl> <int>
    ## 1 -8 [Survey component legitimate skip/NA]   359
    ## 2 -4 [Nonrespondent]                        1691
    ## 3 -3 [Item legitimate skip/NA]               108
    ## 4  0 [No]                                   3505
    ## 5  1 [Yes]                                 10534

``` r
els_v2 %>%  count(f2evratt) %>% as_factor()
```

    ## # A tibble: 5 x 2
    ##   f2evratt                                n
    ##   <fct>                               <int>
    ## 1 Survey component legitimate skip/NA   359
    ## 2 Nonrespondent                        1691
    ## 3 Item legitimate skip/NA               108
    ## 4 No                                   3505
    ## 5 Yes                                 10534

``` r
#level of first postsec institution
els_v2 %>%  count(f2ps1lvl)
```

    ## # A tibble: 7 x 2
    ##                                   f2ps1lvl     n
    ##                                  <dbl+lbl> <int>
    ## 1 -9 [Missing]                                36
    ## 2 -8 [Survey component legitimate skip/NA]   359
    ## 3 -4 [Nonrespondent]                        1691
    ## 4 -3 [Item legitimate skip/NA]              3613
    ## 5  1 [Four or more years]                   6493
    ## 6  2 [At least 2, but less than 4 years]    3692
    ## 7  3 [Less than 2 years]                     313

``` r
els_v2 %>%  count(f2ps1lvl) %>% as_factor()
```

    ## # A tibble: 7 x 2
    ##   f2ps1lvl                                n
    ##   <fct>                               <int>
    ## 1 Missing                                36
    ## 2 Survey component legitimate skip/NA   359
    ## 3 Nonrespondent                        1691
    ## 4 Item legitimate skip/NA              3613
    ## 5 Four or more years                   6493
    ## 6 At least 2, but less than 4 years    3692
    ## 7 Less than 2 years                     313

``` r
#ever attended by level attended
els_v2 %>%  count(f2evratt,f2ps1lvl)
```

    ## # A tibble: 8 x 3
    ##                               f2evratt                            f2ps1lvl     n
    ##                              <dbl+lbl>                           <dbl+lbl> <int>
    ## 1 -8 [Survey component legitimate ski~ -8 [Survey component legitimate sk~   359
    ## 2 -4 [Nonrespondent]                   -4 [Nonrespondent]                   1691
    ## 3 -3 [Item legitimate skip/NA]         -3 [Item legitimate skip/NA]          108
    ## 4  0 [No]                              -3 [Item legitimate skip/NA]         3505
    ## 5  1 [Yes]                             -9 [Missing]                           36
    ## 6  1 [Yes]                              1 [Four or more years]              6493
    ## 7  1 [Yes]                              2 [At least 2, but less than 4 ye~  3692
    ## 8  1 [Yes]                              3 [Less than 2 years]                313

``` r
els_v2 %>%  count(f2evratt,f2ps1lvl) %>% as_factor()
```

    ## # A tibble: 8 x 3
    ##   f2evratt                            f2ps1lvl                                n
    ##   <fct>                               <fct>                               <int>
    ## 1 Survey component legitimate skip/NA Survey component legitimate skip/NA   359
    ## 2 Nonrespondent                       Nonrespondent                        1691
    ## 3 Item legitimate skip/NA             Item legitimate skip/NA               108
    ## 4 No                                  Item legitimate skip/NA              3505
    ## 5 Yes                                 Missing                                36
    ## 6 Yes                                 Four or more years                   6493
    ## 7 Yes                                 At least 2, but less than 4 years    3692
    ## 8 Yes                                 Less than 2 years                     313

## Small multiples using faceting

# References

<div id="refs" class="references">

<div id="ref-RN4561">

Wickham, H. (2010). A layered grammar of graphics. *Journal of
Computational and Graphical Statistics*, *19*(1), 3–28.
<https://doi.org/10.1198/jcgs.2009.07098>

</div>

<div id="ref-RN4564">

Wickham, H., & Grolemund, G. (2017). *R for data science: Import, tidy,
transform, visualize, and model data*. O’Reilly Media, Inc. Retrieved
from <https://r4ds.had.co.nz/>

</div>

<div id="ref-RN4563">

Wilkinson, L. (1999). *The grammar of graphics* (pp. xvii, 408p.). Book,
New York: Springer.

</div>

</div>
