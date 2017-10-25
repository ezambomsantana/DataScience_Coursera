library(tm)

twitter_file <- file("/home/eduardo/dev/coursera/swiftkey/en_US/en_US.twitter.txt", "r")
twitter_data <- readLines(twitter_file)
close(twitter_file)

news_file <- file("/home/eduardo/dev/coursera/swiftkey/en_US/en_US.news.txt", "r")
news_data <- readLines(news_file)
close(news_file)

blogs_file <- file("/home/eduardo/dev/coursera/swiftkey/en_US/en_US.blogs.txt", "r")
blogs_data <- readLines(twitter_file)
close(blogs_file)

blogs_data <- sample(blogs_data, 100000)
twitter_data <- sample(twitter_data, 100000)
news_data <- sample(news_data, 100000)

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

word1 <- c()
word2 <- c()
word3 <- c()
word1 <- unlist(lapply(trigrams, function(x) unlist(strsplit(x , " "))[1] ))
word2 <- unlist(lapply(trigrams, function(x) unlist(strsplit(x , " "))[2] ))
word3 <- unlist(lapply(trigrams, function(x) unlist(strsplit(x , " "))[3] ))

df_trigrams = data.frame(word1, word2, word3)

write.csv(df_trigrams,'/home/eduardo/df_trigrams.csv')
