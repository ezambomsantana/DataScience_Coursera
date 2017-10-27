df_trigram <- read.csv("/home/eduardo/df_trigrams.csv", stringsAsFactors = FALSE)

names(df_trigram) <- c("x", "word1", "word2", "word3","count")
head(df_trigram)

df_trigram$word1 <- as.character(df_trigram$word1)
df_trigram$word2 <- as.character(df_trigram$word2)
df_trigram$word3 <- as.character(df_trigram$word3)

x <- "pound of bacon, a bouquet, and a case of"
x <- removeWords(x, words=c('the', stopwords("english")))
x <- removePunctuation(x)
x <- tolower(x)
x <- stemDocument(x)
x <- tolower(x)
x <- gsub("[^[:alnum:][:space:]]", " ", x)

splitted <- unlist(strsplit(x, split=" "))

N <- length(splitted)
if(N < 2)
  stop('2 words at least please.')

subdata1 <- df_trigram[df_trigram$word2 == splitted[N],]
subdata2 <- subdata1[subdata1$word1 == splitted[N-1],]


predict_word(x)

predict_word <- function(x) {
  
  x <- tolower(x)
  x <- gsub("[^[:alnum:][:space:]]", " ", x)
  
  splitted <- unlist(strsplit(x, split=" "))
  
  N <- length(splitted)
  if(N < 2)
    stop('2 words at least please.')
  
  subdata1 <- df_trigram[df_trigram$word2 == splitted[N],]
  subdata2 <- subdata1[subdata1$word1 == splitted[N-1],]
  
  if(nrow(subdata2) > 0)
    predicted <- subdata2[order(subdata2$count, decreasing=TRUE), "word3"]
  else if (nrow(subdata1) > 0){
    predicted <- subdata1 %>%
      group_by(word2, word3) %>%
      summarise(count=n()) %>%
      arrange(desc(count))
    predicted <- predicted$word3
  }
  else
    predicted <- 'the'
  
  predicted <- na.omit(predicted)
  
  if(length(predicted) >= 3)
    predicted[1:100]
  else
    predicted[1:length(predicted)]
}
