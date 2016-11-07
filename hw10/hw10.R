#1
airports.df <- read.csv("airports.csv", row.names = 1)

#2
airports.mat <- as.matrix(airports.df)

#3
library(igraph)
g <- graph.adjacency(airports.mat, mode = "directed", weighted = TRUE)

#4
V(g)

#5
E(g)$weight

#6
plot(g, edge.label=round(E(g)$weight), edge.width = E(g)$weight, vertex.label = V(g)$name, vertex.size = degree(g))

#7
regions.df <- read.csv("region.csv")

#8
gnodes.attributes <- regions.df[match(V(g)$name, regions.df$name),]
V(g)$region <- as.character(gnodes.attributes$region)

#9
color.mat <- cbind(c("E","W","C"), c("red","blue","green"))
V(g)$color <- color.mat[match(V(g)$region, color.mat[,1]), 2]
plot(g, edge.label=round(E(g)$weight), edge.width = E(g)$weight, vertex.label = V(g)$name, vertex.color = V(g)$color, vertex.size = degree(g))