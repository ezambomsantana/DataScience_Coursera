

twitter_file <- file("/home/eduardo/dev/coursera/swiftkey/en_US/en_US.twitter.txt", "r")
twitter_data <- readLines(twitter_file)
close(twitter_file)

news_file <- file("/home/eduardo/dev/coursera/swiftkey/en_US/en_US.news.txt", "r")
news_data <- readLines(news_file)
close(news_file)

blogs_file <- file("/home/eduardo/dev/coursera/swiftkey/en_US/en_US.blogs.txt", "r")
blogs_data <- readLines(twitter_file)
close(blogs_file)

library(tm)
library(RColorBrewer)

all_data <- c(blogs_data, twitter_data, news_data)

all_data <- removePunctuation(all_data)
all_data <- tolower(all_data)
all_data <- stemDocument(all_data)
all_data <- removeWords(all_data, words=c('the', stopwords("english")))
all_data <- stripWhitespace(all_data)

all_data <- paste0(unlist(all_data), collapse=" ")
all_data <- strsplit(all_data, " ", fixed=TRUE)[[1L]]
all_data <- all_data[all_data != ""]


trigrams <- vapply(ngrams(all_data, 3L), paste, "", collapse=" ")

length(trigrams)
rm(word1 , word2, word3)
word1 <- c()
word2 <- c()
word3 <- c()
for(i in trigrams) {
  word1 <- c(word1, unlist(strsplit(i, " "))[1])
  word2 <- c(word2, unlist(strsplit(i, " "))[2])
  word3 <- c(word3, unlist(strsplit(i, " "))[3])
}

top5 <- sort(table(bigrams), decreasing=T)[1:500]

df_trigram <- data.frame(word1, word2, word3 )

top5

library(magrittr)

library(dplyr)

x <-predict_word('i am sad')

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
    predicted[1:3]
  else
    predicted[1:length(predicted)]
