#carrega o arquivo com os dados sobre os créditos
data <- read.csv("/home/eduardo/Credito.csv", header = TRUE, sep =";")

#gera dois conjuntos de dados aleatórios, para teste e treino
#com 70 e 30% das instâncias, aproximadamente
amostra = sample(2,1000,replace=T, prob=c(0.7,0.3))

creditotreino = data[amostra==1,]
creditoteste = data[amostra==2,]

library(randomForest)
#constrói o modelo usando dados de treino
floresta = randomForest(CLASSE ~ .,data=creditotreino, ntree=100,proximity=T)
#testa o modelo fazendo previsão com dados de teste
previsao = predict(floresta,creditoteste)
#matriz de confusao
floresta$confusion
#calcula a taxa de erro
(floresta$confusion[2] + floresta$confusion[3]) / sum(floresta$confusion)

previsao

library(rpart)
# grow tree 
arvore <- rpart(CLASSE ~ .,data=creditotreino,method="class")
#Predict Output 
previsao = predict(arvore,creditoteste)


previsao <- unlist(lapply(previsao, function(x) print(x[1])  ))
word1 <- unlist(lapply(trigrams, function(x) unlist(strsplit(x , " "))[1] ))

confMat <- table(creditoteste$CLASSE,previsao)

accuracy <- sum(diag(confMat))/sum(confMat)


library(e1071)
# Fitting model
fit <-naiveBayes(CLASSE ~ .,data=creditotreino,)
summary(fit)
#Predict Output 
predicted= predict(fit,creditoteste)

fit$

  
library(caret)
# Fitting model
fitControl <- trainControl( method = "repeatedcv", number = 4, repeats = 4)
fit <- train(CLASSE ~ .,data=creditotreino, method = "gbm", trControl = fitControl,verbose = FALSE)
predicted= predict(fit,creditoteste,type= "prob")[,2] 
