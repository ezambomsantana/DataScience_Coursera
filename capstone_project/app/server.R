library(shiny)
library(magrittr)
library(dplyr)

df_trigram <- read.csv("df_trigrams.csv", stringsAsFactors = FALSE)

names(df_trigram) <- c("x", "word1", "word2", "word3","count")
head(df_trigram)

df_trigram$word1 <- as.character(df_trigram$word1)
df_trigram$word2 <- as.character(df_trigram$word2)
df_trigram$word3 <- as.character(df_trigram$word3)

predict_word <- function(x) {
  
  x <- tolower(x)
  x <- gsub("[^[:alnum:][:space:]]", " ", x)
  
  splitted <- unlist(strsplit(x, split=" "))
  
  N <- length(splitted)
  if(N < 2)
    'the'
  else {
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
      predicted[1:10]
    else
      predicted[1:length(predicted)]
  }
}

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  dataInput <- reactive(predict_word(input$entry))
  
  output$top1 <- renderText({
    paste("Top 1:", dataInput()[1])
  })
  output$top2 <- renderText({
    paste("Top 2:", dataInput()[2])
  })
  output$top3 <- renderText({
    paste("Top 3:", dataInput()[3])
  })
  output$top4 <- renderText({
    paste("Top 4:", dataInput()[4])
  })
  output$top5 <- renderText({
    paste("Top 5:", dataInput()[5])
  })
  
  output$text <- renderText({
    dataInput()
  })
  output$sent <- renderText({
    input$entry
  })
  
})
