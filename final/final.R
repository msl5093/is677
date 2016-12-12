#1a
age <- c(19,23,25,37,65,51,33,51,70,18,23,42,18,39,37)
maxHR <- c(200,182,180,180,156,169,174,172,153, 199, 193, 174, 198, 183, 178)

#1b
plot(age, maxHR, xlab = "Age", ylab = "Maximum Heart Rate", main = "Max. Heart Rate by Age")

#1c
ageHR.df <- as.data.frame(cbind(age, maxHR))
fit <- lm(maxHR ~ age, ageHR.df)
fit # intercept: 208.7079 age: -0.7979

#1d
plot(age, maxHR, xlab = "Age", ylab = "Maximum Heart Rate", main = "Max. Heart Rate by Age")
abline(208.7079, -0.7979)

#1e
layout(matrix(1:4, nrow = 2))
plot(fit)

#####################
# Explain results later
####################

#1f
#1g
#1h

#2a
library(igraph)
library(igraphdata)
data(USairports)