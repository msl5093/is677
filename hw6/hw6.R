#1
library(ggplot2)
data(diamonds)

price_df <- as.data.frame(diamonds[,"price"])
colnames(price_df) <- c("price")
summary(price_df$price)
d <- ggplot(price_df["price"], aes(x = price))
d + geom_density()

#2
d_log10 <- ggplot(price_df["price"], aes(x = log(price, base = 10)))
summary(log(price_df$price, base = 10))
d_log10 + geom_density()

#3
set.seed(123)
train_sample <- sample(53940, 26970)

diamonds_train <- diamonds[train_sample, ]
diamonds_test  <- diamonds[-train_sample, ]

str(diamonds_train)
str(diamonds_test)

#4
price_reg <- lm(price ~ carat + cut + color + clarity, data = diamonds_train)
summary(price_reg)

price_reg_log10 <- lm(log(price, base = 10) ~ carat + cut + color + clarity, data = diamonds_train)
summary(price_reg_log10)

#5

diamonds_test$price_log10 <- log(diamonds_test$price, base = 10)
diamonds_test$PricePrediction <- predict(price_reg, newdata = diamonds_test)
diamonds_test$PricePrediction_log10 <- predict(price_reg_log10, newdata = diamonds_test)

#6

a <- ggplot(data = diamonds_test, aes(x = PricePrediction, y = PricePrediction - price))
a + geom_point(alpha = 0.2, color = "black") + geom_smooth(aes(x = PricePrediction, y = PricePrediction - price), color = "black")

b <- ggplot(data = diamonds_test, aes(x = PricePrediction_log10, y = PricePrediction_log10 - price_log10))
b + geom_point(alpha = 0.2, color = "black") + geom_smooth(aes(x = PricePrediction_log10, y = PricePrediction_log10 - price_log10), color = "black")

#7
confint(price_reg)
par(mfrow=c(2,2))
plot(price_reg)

c <- ggplot(data = diamonds_test, aes(x = PricePrediction, y = price))
c + geom_point(alpha = 0.2, color = "black") + geom_smooth(aes(x = PricePrediction, y = price), color = "black") + geom_line(aes(x = log(PricePrediction, base = 10), y = log(price, base = 10)), color = "blue", linetype = 2)

confint(price_reg_log10)
par(mfrow=c(2,2))
plot(price_reg_log10)

d <- ggplot(data = diamonds_test, aes(x = PricePrediction_log10, y = price_log10))
d + geom_point(alpha = 0.2, color = "black") + geom_smooth(aes(x = PricePrediction_log10, y = price_log10), color = "black")