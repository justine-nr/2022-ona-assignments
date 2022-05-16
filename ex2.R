### 1-Load Libraries

library(tidyverse)
library(ggraph)
library(tidygraph)

### 2-Create nodes table

# Load nodes table
nodes <- read_csv(file="exercices/Exercice 2_Nodes table.csv")
View(nodes)
head(nodes,10)

### 3-Create links table

# Load links table with source and target vectors
links <- read_csv(file="exercices/Exercice 2_Links table.csv")
View(links)
head(links,17)

### 4-Plot network
graph <- igraph::graph_from_data_frame(links, vertices = nodes) %>% as_tbl_graph()

# Create the network 

# Render the network
