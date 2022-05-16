ex2
================
2022-05-16

## Load objects

### Load Libraries

``` r
library(tidyverse)
```

    ## ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.1 ──

    ## ✔ ggplot2 3.3.6     ✔ purrr   0.3.4
    ## ✔ tibble  3.1.6     ✔ dplyr   1.0.9
    ## ✔ tidyr   1.2.0     ✔ stringr 1.4.0
    ## ✔ readr   2.1.2     ✔ forcats 0.5.1

    ## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()

``` r
library(ggraph)
library(tidygraph)
```

    ## 
    ## Attaching package: 'tidygraph'

    ## The following object is masked from 'package:stats':
    ## 
    ##     filter

``` r
library(igraph)
```

    ## 
    ## Attaching package: 'igraph'

    ## The following object is masked from 'package:tidygraph':
    ## 
    ##     groups

    ## The following objects are masked from 'package:dplyr':
    ## 
    ##     as_data_frame, groups, union

    ## The following objects are masked from 'package:purrr':
    ## 
    ##     compose, simplify

    ## The following object is masked from 'package:tidyr':
    ## 
    ##     crossing

    ## The following object is masked from 'package:tibble':
    ## 
    ##     as_data_frame

    ## The following objects are masked from 'package:stats':
    ## 
    ##     decompose, spectrum

    ## The following object is masked from 'package:base':
    ## 
    ##     union

### Load nodes table

``` r
nodes <- read_csv(file="exercices/Exercice 2_Nodes table.csv")
```

    ## Rows: 10 Columns: 1
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (1): seat
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

``` r
show(nodes)
```

    ## # A tibble: 10 × 1
    ##    seat 
    ##    <chr>
    ##  1 1    
    ##  2 2    
    ##  3 3    
    ##  4 4    
    ##  5 5    
    ##  6 6    
    ##  7 A    
    ##  8 B    
    ##  9 C    
    ## 10 D

``` r
head(nodes,10)
```

    ## # A tibble: 10 × 1
    ##    seat 
    ##    <chr>
    ##  1 1    
    ##  2 2    
    ##  3 3    
    ##  4 4    
    ##  5 5    
    ##  6 6    
    ##  7 A    
    ##  8 B    
    ##  9 C    
    ## 10 D

### Load links table

``` r
links <- read_csv(file="exercices/Exercice 2_Links table.csv")
```

    ## Rows: 17 Columns: 2
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (2): src, target
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

``` r
show(links)
```

    ## # A tibble: 17 × 2
    ##    src   target
    ##    <chr> <chr> 
    ##  1 1     2     
    ##  2 2     A     
    ##  3 A     B     
    ##  4 A     C     
    ##  5 B     C     
    ##  6 B     3     
    ##  7 B     D     
    ##  8 B     6     
    ##  9 C     3     
    ## 10 C     4     
    ## 11 C     D     
    ## 12 D     3     
    ## 13 D     5     
    ## 14 D     6     
    ## 15 3     4     
    ## 16 3     5     
    ## 17 5     6

``` r
head(links,17)
```

    ## # A tibble: 17 × 2
    ##    src   target
    ##    <chr> <chr> 
    ##  1 1     2     
    ##  2 2     A     
    ##  3 A     B     
    ##  4 A     C     
    ##  5 B     C     
    ##  6 B     3     
    ##  7 B     D     
    ##  8 B     6     
    ##  9 C     3     
    ## 10 C     4     
    ## 11 C     D     
    ## 12 D     3     
    ## 13 D     5     
    ## 14 D     6     
    ## 15 3     4     
    ## 16 3     5     
    ## 17 5     6

## Visualize network

``` r
g <- graph_from_data_frame(d=links, vertices=nodes, directed=FALSE)
par(mar=c(0,0,0,0))

###  Change size of the nodes and node labels so that they match their importance
V(g)$size <- log(strength(g)) * 4 + 3

###  Change color of node based on seat choice
dark_side <- c("A", "B", "C", "D")
light_side <- c("1", "2", "3", "4", "5", "6")
V(g)$color[V(g)$name %in% dark_side] <- "red"
V(g)$color[V(g)$name %in% light_side] <- "gold"
vertex_attr(g)
```

    ## $name
    ##  [1] "1" "2" "3" "4" "5" "6" "A" "B" "C" "D"
    ## 
    ## $size
    ##  [1] 3.000000 5.772589 9.437752 5.772589 7.394449 7.394449 7.394449 9.437752
    ##  [9] 9.437752 9.437752
    ## 
    ## $color
    ##  [1] "gold" "gold" "gold" "gold" "gold" "gold" "red"  "red"  "red"  "red"

``` r
plot(g, layout=layout_with_fr, main="Fakebook bus network graph")
show(g)
```

    ## IGRAPH 1311d4b UN-- 10 17 -- 
    ## + attr: name (v/c), size (v/n), color (v/c)
    ## + edges from 1311d4b (vertex names):
    ##  [1] 1--2 2--A A--B A--C B--C 3--B B--D 6--B 3--C 4--C C--D 3--D 5--D 6--D 3--4
    ## [16] 3--5 5--6

``` r
###  Add legend to indicate what the colors correspond to
legend(x=.75, y=.75, legend=c("Open seat", "Filled seat"), 
       pch=21, pt.bg=c("red", "gold"), pt.cex=2, bty="n")
```

![](ex2_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->

## Calculate measures of centrality

``` r
##  Degree centrality
degree <- degree(g,-4)
show(tail(degree,4))
```

    ## A B C D 
    ## 3 5 5 5

``` r
## Nodes B, C, and D all have the same highest degree centrality (number of edges connected to it) and hence more influence than A

## Closeness centrality
closeness <- closeness(g)
show(tail(closeness,4))
```

    ##          A          B          C          D 
    ## 0.06250000 0.07142857 0.07142857 0.06250000

``` r
## Nodes A and D all have the shortest closeness centrality (mean distance from a node to other nodes) and hence more direct influence on others

## Betweeness centrality

betweenness <- betweenness(g)
show(tail(betweenness,4))
```

    ##         A         B         C         D 
    ## 14.000000  9.033333  8.600000  3.266667

``` r
## Node A has the highest betweenness centrality (extent to which a node lies on paths between other nodes) and hence more influence within a network, followed by nodes B and C
```

## Conclusion

### Choice of a seat: in the context of short bus rides, seat B is likely to be indicated because it would be beneficial for building a network. While for long bus rides, seat A seems to be the most desirable option because it would be beneficial for connecting people with others.
