library(magrittr)

library(dplyr)

predict_word('Besides the wordcloud, tell also')

predict_word <- function(x) {

  x <- tolower(x)
  x <- gsub("[^[:alnum:][:space:]]", " ", x)
  
  splitted <- unlist(strsplit(x, split=" "))
  
  N <- length(splitted)
  if(N < 2)
    stop('2 words at least please.')
  
  subdata1 <- df_trigrams[df_trigrams$word2 == splitted[N],]
  subdata2 <- subdata1[subdata1$word1 == splitted[N-1],]
  
  nrow(subdata2$count)
  
  if(nrow(subdata2) > 0) {
    predicted <- subdata2[, "word3"]
  } else if (nrow(subdata1) > 0){
    predicted <- subdata1 %>%
      group_by(word2, word3) %>%
      summarise(count=n()) %>%
      arrange(desc(count))
    predicted <- predicted$word3
  } else {
    predicted <- 'the'
  }
  
  predicted <- na.omit(predicted)
  
  if(length(predicted) >= 3) {
    sort(table(predicted), decreasing=T)[1:3]
  } else {
    sort(table(predicted), decreasing=T)[1:length(predicted)]
  }
  
}
