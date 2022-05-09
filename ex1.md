Exercice 1
================

## Download contacts data from LinkedIn

``` r
library(readr)
Connections <- read_csv(file="exercices/Connections.csv")
```

    ## Rows: 1054 Columns: 6
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (6): First Name, Last Name, Email Address, Company, Position, Connected On
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

``` r
View(Connections)
```

## Get the count of contacts + Create nodes and edges dataframes

You can also embed plots, for example:

``` r
#install.packages("dplyr")
library(dplyr)
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
df = Connections %>% group_by(Company) %>% count(Company) %>% arrange(-n)

df
```

    ## # A tibble: 599 × 2
    ## # Groups:   Company [599]
    ##    Company                                                 n
    ##    <chr>                                               <int>
    ##  1 IBM                                                   190
    ##  2 Saputo Inc.                                            25
    ##  3 <NA>                                                   16
    ##  4 Université de Sherbrooke                               14
    ##  5 Accenture                                              11
    ##  6 CGI                                                     9
    ##  7 Greenfield Global                                       9
    ##  8 McGill University - Desautels Faculty of Management     9
    ##  9 McKinsey & Company                                      9
    ## 10 Agnico Eagle Mines Limited                              8
    ## # … with 589 more rows

Note that the `echo = FALSE` parameter was added to the code chunk to
prevent printing of the R code that generated the plot.
