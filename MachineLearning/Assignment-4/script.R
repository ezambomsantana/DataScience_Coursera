library(caret)
library(randomForest)

set.seed(1234)

trainUrl <- "http://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv"
testUrl <- "http://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv"

trainingData <- read.csv(url(trainUrl), na.strings=c("NA","#DIV/0!",""))
testingData <- read.csv(url(testUrl), na.strings=c("NA","#DIV/0!",""))


train <- createDataPartition(y=trainingData$classe,p=.70,list=F)
training <- trainingData[train,]
testing <- trainingData[-train,]

Cl <- grep("name|timestamp|window|X", colnames(training), value=F) 
trainingCl <- training[,-Cl]

#select variables with high (over 95%) missing data --> exclude them from the analysis
trainingCl[trainingCl==""] <- NA
NArate <- apply(trainingCl, 2, function(x) sum(is.na(x)))/nrow(trainingCl)
trainingCl <- trainingCl[!(NArate>0.95)]
summary(trainingCl)
