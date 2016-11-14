library(igraph)

#1
g.er <- erdos.renyi.game(500, p = 0.01, directed = FALSE)
g.er

#2
g.b <- barabasi.game(500, power = 3, directed = FALSE)
g.b

#3
E(g.er)
E(g.b)

V(g.er)
V(g.b)

#4
g.er.density <- graph.density(g.er)
g.er.density

g.b.density <- graph.density(g.b)
g.b.density

#5
g.er.avg <- average.path.length(g.er)
g.er.avg

g.b.avg <- average.path.length(g.b)
g.b.avg

#6
g.er.dia <- diameter(g.er)
g.er.dia

g.b.dia <- diameter(g.b)
g.b.dia

#7
paths <- matrix(ncol = 10, nrow = 10)
dias <- matrix(ncol = 10, nrow = 10)

for (n in seq(100, 1000, 100)) {
  for (i in 1:10) {
    g.er <- erdos.renyi.game(n, p = (10/(n-1)), directed = FALSE) 
    paths[i, n/100] = average.path.length(g.er)
    dias[i, n/100] = diameter(g.er)
  }
}
paths.avg <- apply(paths, 2, mean)
paths.avg

mean_dias <- apply(dias, 2, mean)
mean_dias

x <- seq(100, 1000, 100)
plot(x, paths.avg, type = "b", pch = 20, xlab = "size", ylab = "Avg. Path Lengths")
plot(x, mean_dias, type = "b", pch = 20, xlab = "size", ylab = "Mean Diameter")