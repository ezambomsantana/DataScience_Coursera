---
title: "week2-milestone"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## Description

The goal of this project is just to display that you've gotten used to working with the data and that you are on track to create your prediction algorithm. Please submit a report on R Pubs (http://rpubs.com/) that explains your exploratory analysis and your goals for the eventual app and algorithm. This document should be concise and explain only the major features of the data you have identified and briefly summarize your plans for creating the prediction algorithm and Shiny app in a way that would be understandable to a non-data scientist manager. You should make use of tables and plots to illustrate important summaries of the data set. The motivation for this project is to: 1. Demonstrate that you've downloaded the data and have successfully loaded it in.2. Create a basic report of summary statistics about the data sets.3. Report any interesting findings that you amassed so far.4. Get feedback on your plans for creating a prediction algorithm and Shiny app. 

This document is organized in 5 sections: 1) Loading the data, 2) Exploratory Analysis, and 3)  Goals for the App and algorithm.

## Loading the data

To load the data, I get the three files and using the R's file function loaded all the files in the memory.

```{r loading, warning=FALSE}
twitter_file <- file("/home/eduardo/dev/coursera/swiftkey/en_US/en_US.twitter.txt", "r")
twitter_data <- readLines(twitter_file)
close(twitter_file)

news_file <- file("/home/eduardo/dev/coursera/swiftkey/en_US/en_US.news.txt", "r")
news_data <- readLines(news_file)
close(news_file)

blogs_file <- file("/home/eduardo/dev/coursera/swiftkey/en_US/en_US.blogs.txt", "r")
blogs_data <- readLines(twitter_file)
close(blogs_file)

blog_char <- scan("/home/eduardo/dev/coursera/swiftkey/en_US/en_US.blogs.txt", what="character")
tweet_char <- scan("/home/eduardo/dev/coursera/swiftkey/en_US/en_US.twitter.txt", what="character")
news_char <- scan("/home/eduardo/dev/coursera/swiftkey/en_US/en_US.news.txt", what="character")

```

## Exploratory Analysis

The first data is the number of number of entries to each dataset:

```{r exploratory_length}
length(twitter_data)
length(news_data)
length(blogs_data)
```

The second data is the word count of each dataset:

```{r char_count}
length(tweet_char)
length(news_char)
length(blog_char)
```



```{r pre_processing}
library(NLP)
library(tm)
library(RColorBrewer)
library(wordcloud)

rm(blog_char, tweet_char, news_char)

blogs_data <- sample(blogs_data, 10000)
twitter_data <- sample(twitter_data, 10000)
news_data <- sample(news_data, 10000)

all_data <- c(blogs_data, twitter_data, news_data)

#processing to remove punctuation, stopwords, and perform stemming.
all_data <- removePunctuation(all_data)
all_data <- tolower(all_data)
all_data <- stemDocument(all_data)
all_data <- removeWords(all_data, words=c('the', stopwords("english")))
all_data <- stripWhitespace(all_data)

```

