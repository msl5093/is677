#1
boston <- read.csv("Boston.csv")

#2
set.seed(12345)
train_sample <- sample(506, 354) #70% = 354.2
boston_train <- boston[train_sample,]
boston_test <- boston[-train_sample,]

#3
library(mgcv)
formula.glin <- as.formula("medv ~ s(crim) + s(nox) + s(rm) + s(age) + s(dis) + s(tax) + s(ptratio)")
glin.model <- gam(formula.glin, data = boston_train)
summary(glin.model)

#4
sVars <- predict(glin.model, type = "terms")
boston_train <- cbind(boston_train, scrim = sVars[,1], snox = sVars[,2], srm = sVars[,3], sage = sVars[,4], sdis = sVars[,5], stax = sVars[,6], sptratio = sVars[,7])

#5
library(ggplot2)
ggplot(boston_train, aes(x = crim)) + geom_point(aes(y = scale(scrim, scale = F))) + geom_smooth(aes(y = scale(medv, scale = F)))
ggplot(boston_train, aes(x = nox)) + geom_point(aes(y = scale(snox, scale = F))) + geom_smooth(aes(y = scale(medv, scale = F)))
ggplot(boston_train, aes(x = rm)) + geom_point(aes(y = scale(srm, scale = F))) + geom_smooth(aes(y = scale(medv, scale = F)))
ggplot(boston_train, aes(x = age)) + geom_point(aes(y = scale(sage, scale = F))) + geom_smooth(aes(y = scale(medv, scale = F)))
ggplot(boston_train, aes(x = dis)) + geom_point(aes(y = scale(sdis, scale = F))) + geom_smooth(aes(y = scale(medv, scale = F)))
ggplot(boston_train, aes(x = tax)) + geom_point(aes(y = scale(stax, scale = F))) + geom_smooth(aes(y = scale(medv, scale = F)))
ggplot(boston_train, aes(x = ptratio)) + geom_point(aes(y = scale(sptratio, scale = F))) + geom_smooth(aes(y = scale(medv, scale = F)))

#6
residual.glin.train <- boston_train$medv - predict(glin.model, data = boston_train)
residual.glin.test <- boston_test$medv - predict(glin.model, newdata = boston_test)
sqrt(mean(residual.glin.test^2)) #4.24814
sqrt(mean(residual.glin.train^2)) #3.601483

###########
# The R-Squared values are close, which tells us that the model is not overfitted to the training data and would
# likely translate well to unseen data. 
###########

#7
summary(glin.model)

##########
# The model did quite well in predicting the target variable. The overall deviance explained is high (84.5%),
# which explains a great deal of the deviance of predictions in the dependent variable. There are a few smoothed
# features with a low P value (nox, rm, and tax) which indicate those independent features have a noticable
# impact on the outcome variable, P value below 0.05.
##########

#8
##########
# If we remove crim, age, dis, and ptratio from the model, there would be minimal impact on the preditive
# power of the model. The smoothed versions of these features all have a higher P value.
##########