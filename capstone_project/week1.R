twitter_file <- file("/home/eduardo/dev/coursera/swiftkey/en_US/en_US.twitter.txt", "r")
twitter_data <- readLines(twitter_file)
close(twitter_file)

news_file <- file("/home/eduardo/dev/coursera/swiftkey/en_US/en_US.news.txt", "r")
twitter_data <- readLines(twitter_file)
close(news_file)

blogs_file <- file("/home/eduardo/dev/coursera/swiftkey/en_US/en_US.blogs.txt", "r")
blogs_data <- readLines(twitter_file)
close(blogs_file)

max(nchar(blogs_data))

love <- sum(grepl("love", twitter_data))
hate <- sum(grepl("hate", twitter_data))

division <- love/hate

grep("biostats", twitter_data, value=TRUE)

grep("A computer once beat me at chess, but it was no match for me at kickboxing", twitter_data)

head(twitter_data)
