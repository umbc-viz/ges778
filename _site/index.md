# Setup
Camille Seaberry

This is a collection of notes to fill in examples and walkthroughs for
the Spring 2024 session of GES 778. It will be updated throughout the
semester.

First, install the course’s companion R package,
[`justviz`](https://github.com/umbc-viz/justviz.git)

``` r
# install.packages("devtools")
devtools::install_github("umbc-viz/justviz")
```

Next, some packages that aren’t required by the `justviz` package but
will get us started for class:

``` r
cran_pkgs <- c("ggplot2",     # data visualization powerhouse
               "dplyr",       # nice for calculations and data manipulation
               "tidyr",       # data reshaping
               "forcats",     # handling factors
               "stringr",     # string cleanup
               "showtext",    # nice fonts
               "ggrepel",     # force-repelled placement of labels
               "osmdata",     # easy access to sf data from OpenStreetMap
               "tigris",      # shapefiles from Census Bureau TIGER
               "patchwork",   # assembling plots
               "ggmap",       # basemaps in ggplot
               "ggtext",      # use rich text / markdown in ggplot
               "here",        # marks project roots
               "rcartocolor") # color palettes

install.packages(cran_pkgs)
```
