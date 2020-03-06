Visualization using ggplot2
================
Ozan Jaquette

  - [Layered grammar of graphics](#layered-grammar-of-graphics)
      - [Overview of parameters](#overview-of-parameters)
      - [Brief definitions of the seven parameters of layered grammar of
        graphics](#brief-definitions-of-the-seven-parameters-of-layered-grammar-of-graphics)
  - [References](#references)

``` r
library(tidyverse)
library(ggplot2)
```

# Layered grammar of graphics

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

## Overview of parameters

The seven parameters of the layered grammar of graphics consists of:

  - five layers
      - a dataset (**data**)
      - a set of mappings (**mappings**)
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

## Brief definitions of the seven parameters of layered grammar of graphics

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

The five layers of the grammar of graphics

  - dataset (**data**):
    
      - data defines the information to be visualized

  - set of mappings (**mappings**):
    
      - mapping defines how variables in a dataset are applied to a
        graphic.
      - For example, we map *age* to the x-axis and *income* to the
        y-axis

  - statistical transformation (**stat**):
    
      - a statistical transformation transforms the underlying data
        before plotting it
      - For example, when creating a scatterplot (e.g., y=income,
        x=age), we usually do not transform the data for plotting. This
        is the “identity” transformation.
      - By contrast, imagine we have student-level data and want to
        create bar chart of the number of students in the CA higher
        education system, with separate bars for UC, CSU, and CCs. Here,
        we do not plot the raw data. Rather, we count the number of
        observations within each system. This count is a statistical
        transformation.

  - geometric object (**geom**)  

  - position adjustment (**position**)

  - a coordinate system (**coord**)

  - a faceting scheme (**facets**)

“A geom is the geometrical object that a plot uses to represent data.
People often describe plots by the type of geom that the plot uses. For
example, bar charts use bar geoms, line charts use line geoms, boxplots
use boxplot geoms, and so on. Scatterplots break the trend; they use the
point geom. As we see above, you can use different geoms to plot the
same data.”

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
