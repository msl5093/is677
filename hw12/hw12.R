library(igraph)
library(foreach)
library(doParallel)

#1
g.b1 <- barabasi.game(5000, power = 1, m = 3, directed = FALSE)
g.b2 <- barabasi.game(5000, power = 1, m = 3, directed = FALSE)
g.b3 <- barabasi.game(5000, power = 1, m = 3, directed = FALSE)
g.b4 <- barabasi.game(5000, power = 1, m = 3, directed = FALSE)

#1a
paths.avg <- vector(mode = "numeric", length = 4)

start_time <- Sys.time()

paths.avg[1] <- average.path.length(g.b1)
paths.avg[2] <- average.path.length(g.b2)
paths.avg[3] <- average.path.length(g.b3)
paths.avg[4] <- average.path.length(g.b4)

paths.avg
seq_graphs <- Sys.time() - start_time
seq_graphs

#1b
numParCores <- max(1, detectCores() - 1)
cl <- makeCluster(numParCores)
registerDoParallel(cl)

start_time <- Sys.time()

results <- foreach(i = 1:4, .packages='igraph') %dopar%{
  paths.avg[1] <- average.path.length(g.b1)
  paths.avg[2] <- average.path.length(g.b2)
  paths.avg[3] <- average.path.length(g.b3)
  paths.avg[4] <- average.path.length(g.b4)
}

stopCluster(cl)
paths.avg
parallel_graphs <- Sys.time() - start_time
parallel_graphs

#2
g.er1 <- erdos.renyi.game(2000, p = (5/(2000-1)), directed = FALSE)
g.er2 <- erdos.renyi.game(4000, p = (5/(4000-1)), directed = FALSE)
g.er3 <- erdos.renyi.game(6000, p = (5/(6000-1)), directed = FALSE)
g.er4 <- erdos.renyi.game(8000, p = (5/(8000-1)), directed = FALSE)

#2a
paths.avg <- vector(mode = "numeric", length = 4)

start_time <- Sys.time()

paths.avg[1] <- average.path.length(g.er1)
paths.avg[2] <- average.path.length(g.er2)
paths.avg[3] <- average.path.length(g.er3)
paths.avg[4] <- average.path.length(g.er4)

paths.avg
seq_graphs <- Sys.time() - start_time
seq_graphs

#2b
numParCores <- max(1, detectCores() - 1)
cl <- makeCluster(numParCores)
registerDoParallel(cl)

start_time <- Sys.time()

results <- foreach(i = 1:4, .packages='igraph') %dopar%{
  paths.avg[1] <- average.path.length(g.er1)
  paths.avg[2] <- average.path.length(g.er2)
  paths.avg[3] <- average.path.length(g.er3)
  paths.avg[4] <- average.path.length(g.er4)
}

stopCluster(cl)
paths.avg
parallel_graphs <- Sys.time() - start_time
parallel_graphs

#3
g.b1 <- barabasi.game(5000, power = 1, m = 3, directed = FALSE)
g.b2 <- barabasi.game(5000, power = 1, m = 3, directed = FALSE)
g.b3 <- barabasi.game(5000, power = 1, m = 3, directed = FALSE)
g.b4 <- barabasi.game(5000, power = 1, m = 3, directed = FALSE)

#3a
bw.avg <- vector(mode = "numeric", length = 4)

start_time <- Sys.time()

bw.avg[1] <- mean(betweenness(g.b1, V(g.b1)))
bw.avg[2] <- mean(betweenness(g.b2, V(g.b2)))
bw.avg[3] <- mean(betweenness(g.b3, V(g.b3)))
bw.avg[4] <- mean(betweenness(g.b4, V(g.b4)))

bw.avg
seq_graphs <- Sys.time() - start_time
seq_graphs

#3b
numParCores <- max(1, detectCores() - 1)
cl <- makeCluster(numParCores)
registerDoParallel(cl)

start_time <- Sys.time()

results <- foreach(i = 1:4, .packages='igraph') %dopar%{
  bw.avg[1] <- mean(betweenness(g.b1, V(g.b1)))
  bw.avg[2] <- mean(betweenness(g.b2, V(g.b2)))
  bw.avg[3] <- mean(betweenness(g.b3, V(g.b3)))
  bw.avg[4] <- mean(betweenness(g.b4, V(g.b4)))
}

stopCluster(cl)
bw.avg
parallel_graphs <- Sys.time() - start_time
parallel_graphs