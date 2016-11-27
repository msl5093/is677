#1/1a
paths.avg <- vector(mode = "numeric", length = 4)

start_time <- Sys.time()

for (i in 1:4){
  g.b1 <- barabasi.game(5000, power = 1, m = 3, directed = FALSE)
  paths.avg[i] <- average.path.length(g.b1)
}

seq_graphs <- Sys.time() - start_time

paths.avg
seq_graphs

##################
#
# > paths.avg
# [1] 4.167523 4.184080 4.172670 4.209938
# > seq_graphs
# Time difference of 5.401342 secs
#
##################

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
parallel_graphs <- Sys.time() - start_time
paths.avg
parallel_graphs


##################
#
# > paths.avg
# [1] 4.167523 4.184080 4.172670 4.209938
# > parallel_graphs
# Time difference of 3.356689 secs
#
##################

#2/2a
paths.avg <- vector(mode = "numeric", length = 4)

start_time <- Sys.time()

for (i in 1:4){
  g.er1 <- erdos.renyi.game(2000, p = (5/(2000-1)), directed = FALSE)
  paths.avg[i] <- average.path.length(g.er1)
}

seq_graphs <- Sys.time() - start_time
paths.avg
seq_graphs

##################
#
# > paths.avg
# [1] 4.996134 4.854284 4.868100 4.837219
# > seq_graphs
# Time difference of 0.8525081 secs
#
##################

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
parallel_graphs <- Sys.time() - start_time
paths.avg
parallel_graphs


##################
#
# paths.avg
# [1] 4.996134 4.854284 4.868100 4.837219
# > parallel_graphs
# Time difference of 0.7520092 secs
#
##################

#3/3a
bw.avg <- vector(mode = "numeric", length = 4)

start_time <- Sys.time()

for (i in 1:4){
  g.b1 <- barabasi.game(5000, power = 1, m = 3, directed = FALSE)
  bw.avg[i] <- mean(betweenness(g.b1, V(g.b1)))
}

seq_graphs <- Sys.time() - start_time
bw.avg
seq_graphs

##################
#
# > bw.avg
# [1] 7997.975 8109.640 7993.172 7964.882
# > seq_graphs
# Time difference of 12.94112 secs
#
##################


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
parallel_graphs <- Sys.time() - start_time
bw.avg
parallel_graphs

##################
#
# > bw.avg
# [1] 7997.975 8109.640 7993.172 7964.882
# > parallel_graphs
# Time difference of 7.655236 secs
#
##################