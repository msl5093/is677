#1
polypharm <- read.csv("polypharm.csv")
str(polypharm)

#2
polypharm_data <- polypharm[-1]
str(polypharm_data)

#3
polypharm_data$YEAR <- factor(polypharm_data$YEAR)
polypharm_data$ETHNIC <- factor(polypharm_data$ETHNIC)
polypharm_data$GENDER <- factor(polypharm_data$GENDER)
polypharm_data$URBAN <- factor(polypharm_data$URBAN)
polypharm_data$RACE <- factor(polypharm_data$RACE)
polypharm_data$COMORBID <- factor(polypharm_data$COMORBID)
polypharm_data$GROUP <- factor(polypharm_data$GROUP)
polypharm_data$MHV4 <- factor(polypharm_data$MHV4)
polypharm_data$INPTMHV3 <- factor(polypharm_data$INPTMHV3)
str(polypharm_data)

#4
set.seed(123)
train_sample <- sample(3500,1750)

poly_train <- polypharm_data[train_sample,]
poly_test <- polypharm_data[-train_sample,]

#5
y <- "POLYPHARMACY"
x <- c('MHV4','INPTMHV3','YEAR','GROUP','URBAN','COMORBID','ANYPRIM','NUMPRIM','GENDER','RACE','ETHNIC','AGE')
poly_log <- paste(y, paste(x, collapse = "+"), sep = "~")

#6
model <- glm(poly_log, family = binomial(link='logit'), data = poly_train)

#7
summary(model)
coefficients(model)

#8
poly_test$PRED <- predict(model, newdata = poly_test, type = "response")
str(poly_test)

#9
loglikelihood <- function(y, py){
  sum(y * log(py) + (1-y)*log(1 - py), na.rm = TRUE)
}

#10
testy <- as.numeric(poly_test$POLYPHARMACY)
testpred <- predict(model, newdata = poly_test, type="response")
pnull.test <- mean(testy)
null.dev.test <- -2*loglikelihood(testy, pnull.test)
resid.dev.test <- -2*loglikelihood(testy, testpred)

null.dev.test
resid.dev.test

# difference between null and residual deviances
delDev <- null.dev.test - resid.dev.test

# difference in degrees of freedom between null and model
df.null <- dim(poly_test)[[1]] - 1
df.model <- dim(poly_test)[[1]] - length(model$coefficients)
deldf <- df.null - df.model

# obtain p value using chi squared distribution
p <- pchisq(delDev, deldf, lower.tail=F)