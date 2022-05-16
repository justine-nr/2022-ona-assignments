ex2
================
2022-05-16

# Load objects

### Load Libraries

library(tidyverse) library(ggraph) library(tidygraph) library(igraph)

### Load nodes table

nodes \<- read_csv(file=“exercices/Exercice 2_Nodes table.csv”)
View(nodes) head(nodes,10)

### Load links table

links \<- read_csv(file=“exercices/Exercice 2_Links table.csv”)
View(links) head(links,17)

# Visualize network

g \<- graph_from_data_frame(d=links, vertices=nodes, directed=FALSE)
par(mar=c(0,0,0,0))

### Change size of the nodes and node labels so that they match their importance

V(g)$size \<- log(strength(g)) \* 4 + 3

### Change color of node based on seat choice

dark_side \<- c(“A”, “B”, “C”, “D”) light_side \<- c(“1”, “2”, “3”, “4”,
“5”, “6”)
V(g)![color\[V(g)](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;color%5BV%28g%29 "color[V(g)")name
%in% dark_side\] \<- “red”
V(g)![color\[V(g)](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;color%5BV%28g%29 "color[V(g)")name
%in% light_side\] \<- “gold” vertex_attr(g)

plot(g, layout=layout_with_fr, main=“Fakebook bus network graph”)

### Add legend to indicate what the colors correspond to

legend(x=.75, y=.75, legend=c(“Open seat”, “Filled seat”), pch=21,
pt.bg=c(“red”, “gold”), pt.cex=2, bty=“n”)

# Calculate measures of centrality

### Degree centrality

degree \<- degree(g,-4) view(tail(degree,4))

Nodes B, C, and D all have the same highest degree centrality (number of
edges connected to it) and hence more influence than A

### Closeness centrality

closeness \<- closeness(g) view(tail(closeness,4))

Nodes A and D all have the shortest closeness centrality (mean distance
from a node to other nodes) and hence more direct influence on others

### Betweeness centrality

betweenness \<- betweenness(g) view(tail(betweenness,4))

Node A has the highest betweenness centrality (extent to which a node
lies on paths between other nodes) and hence more influence within a
network, followed by nodes B and C

### Conclusion

Choice of a seat: in the context of short bus rides, seat B is likely to
be indicated because it would be beneficial for building a network.
While for long bus rides, seat A seems to be the most desirable option
because it would be beneficial for connecting people with others.
