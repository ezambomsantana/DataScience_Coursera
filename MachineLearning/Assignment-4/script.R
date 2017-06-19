library(caret)
library(randomForest)
library(rpart) # Regressive Partitioning and Regression trees
library(e1071)

set.seed(1234)

trainUrl <- "http://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv"
testUrl <- "http://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv"

trainingData <- read.csv(url(trainUrl), na.strings=c("NA","#DIV/0!",""))
testingData <- read.csv(url(testUrl), na.strings=c("NA","#DIV/0!",""))


trainingData <- trainingData[,colSums(is.na(trainingData)) == 0]
testingData <- testingData[,colSums(is.na(testingData)) == 0]
trainingData <- trainingData[,-c(1:7)]
testingData <- testingData[,-c(1:7)]

train <- createDataPartition(y=trainingData$classe,p=.70,list=F)
training <- trainingData[train,]
testing <- trainingData[-train,]


model1 <- rpart(classe ~ ., data=training, method="class")
prediction1 <- predict(model1, testing, type = "class")
confusionMatrix(prediction1, testing$classe)




model2 <- randomForest(classe ~. , data=training, method="class")
prediction2 <- predict(model2, testing, type = "class")
confusionMatrix(prediction2, testing$classe)
