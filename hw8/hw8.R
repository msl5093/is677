#1
url = "https://archive.ics.uci.edu/ml/machine-learning-databases/pima-indians-diabetes/pima-indians-diabetes.data"
diabetes <- read.table(url, sep = ",", header = FALSE)

#2
names(diabetes) <- c("npregant", "plasma", "bp", "triceps", "insulin", "bmi", "pedigree", "age", "class")
str(diabetes)

#3
diabetes$class <- factor(diabetes$class, levels = c(0,1), labels = c("normal","diabetic"))

#4
set.seed(123)
train_sample <- sample(768, 538) #70% = 537.6
train <- diabetes[train_sample,]
test <- diabetes[-train_sample,]

#5
library(rpart)
tree <- rpart(class ~ ., data = train, method="class", parms = list(split="information"))
tree

#6
tree$cptable
plotcp(tree)

# min xerror = 0.6436170
# xstd = 0.05151239
# 0.64 + 0.05 = 0.69
# smallest tree (nsplit) with xerror below 0.69 = tree #3
# cp = 0.01418440 ~ 0.0142

#7
tree.pruned <- prune(tree, cp = .0142)

#8
library(rpart.plot)
prp(tree.pruned, type = 2, extra = 104, fallen.leaves = TRUE, main = "Pruned Decision Tree")

#9
tree.prediction <- predict(tree.pruned, test, type = "class")
tree.perf <- table(test$class, tree.prediction, dnn = c("Actual", "Predicted"))
tree.perf

# The pruned tree performed fairly well, correctly classifying 161 out of 230 test observations, for an accuracy
# of 70% and an error ate of 30%. The tree had nearly identical amounts of false negatives (34) and false positives
# (35).

#10
library(randomForest)
set.seed(1234)
tree.forest <- randomForest(class ~ ., data = train, na.action = na.roughfix, importance = TRUE)
tree.forest

#11
importance(tree.forest, type = 2)

#12
forest.prediction <- predict(tree.forest, test, type = "class")
forest.perf <- table(test$class, forest.prediction, dnn = c("Actual", "Predicted"))

# The random forest performed only slightly better than the pruned tree from question #9. The error rate improved
# by only two percent. Both false negatives and false positives decreased, and still remained close.
# 