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

# Erro de 23%

library(rpart)
# grow tree 
arvore <- rpart(CLASSE ~ .,data=creditotreino,method="class")
#Predict Output 
previsao = predict(arvore,creditoteste)

previsao2 <- unlist(lapply(previsao, function(x) if (x[1] >= 0.5) "bom" else "ruim" ))
as.factor(previsao2)

confMat <- table(creditoteste$CLASSE,previsao2[1:length(creditoteste$CLASSE)])

1 - sum(diag(confMat))/sum(confMat)

# Erro de 25%

library(e1071)
# Fitting model
naive <-naiveBayes(CLASSE ~ .,data=creditotreino,)
#Predict Output 
previsao= predict(naive,creditoteste)

confMat <- table(creditoteste$CLASSE,previsao)

1 - sum(diag(confMat))/sum(confMat)

#erro de 26%
