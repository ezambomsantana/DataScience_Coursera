library(tm)

### Twitter File ###

twitter_file <- file("/home/eduardo/dev/coursera/swiftkey/en_US/en_US.twitter.txt", "r")
twitter_data <- readLines(twitter_file)
close(twitter_file)

twitter_data <- removeWords(twitter_data, words=c('the', stopwords("english")))
twitter_data <- sample(twitter_data, 0.2 * length(twitter_data))
twitter_data <- removePunctuation(twitter_data)
twitter_data <- tolower(twitter_data)
twitter_data <- stemDocument(twitter_data)

### News File ###

news_file <- file("/home/eduardo/dev/coursera/swiftkey/en_US/en_US.news.txt", "r")
news_data <- readLines(news_file)
close(news_file)

news_data <- removeWords(news_data, words=c('the', stopwords("english")))
news_data <- sample(news_data, 0.2 * length(news_data))
news_data <- removePunctuation(news_data)
news_data <- tolower(news_data)
news_data <- stemDocument(news_data)

### Blogs File ###

blogs_file <- file("/home/eduardo/dev/coursera/swiftkey/en_US/en_US.blogs.txt", "r")
blogs_data <- readLines(blogs_file)
close(blogs_file)

blogs_data <- removeWords(blogs_data, words=c('the', stopwords("english")))
blogs_data <- sample(blogs_data, 0.2 * length(blogs_data))
blogs_data <- removePunctuation(blogs_data)
blogs_data <- tolower(blogs_data)
blogs_data <- stemDocument(blogs_data)

### merge all the data ###
all_data <- c(blogs_data, twitter_data, news_data)

## remove the old variables to save memory
rm(blogs_data, twitter_data, news_data)
rm(blogs_file, news_file, twitter_file)


## clean the data and split
all_data <- paste0(unlist(all_data), collapse=" ")
all_data <- strsplit(all_data, " ", fixed=TRUE)[[1L]]
all_data <- all_data[all_data != ""]

trigrams <- vapply(ngrams(all_data, 4L), paste, "", collapse=" ")

word1 <- c()
word2 <- c()
word3 <- c()
word1 <- unlist(lapply(trigrams, function(x) unlist(strsplit(x , " "))[1] ))
word2 <- unlist(lapply(trigrams, function(x) unlist(strsplit(x , " "))[2] ))
word3 <- unlist(lapply(trigrams, function(x) unlist(strsplit(x , " "))[3] ))
word4 <- unlist(lapply(trigrams, function(x) unlist(strsplit(x , " "))[4] ))


library(dplyr)


df_four = data.frame(word1, word2, word3, word4)
df_four <- df_trigrams %>% add_count(word1, word2, word3,word4)
df_four <- unique(df_four)

write.csv(df_four,'/home/eduardo/df_fourgrams.csv')
