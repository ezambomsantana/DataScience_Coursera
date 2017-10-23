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

The following table presents some exploratory analysis about the data. The first column shows the number of entries of each dataset and the second column the word count of each dataset.

Source    | Entries                   | Word Count
----------|---------------------------|------------
Twitter:  | `r  length(twitter_data)` |  `r  length(tweet_char)`
News:     | `r  length(news_data)`    |  `r  length(news_char)`
Blog:     | `r  length(blogs_data)`   |  `r  length(blog_char)`


## Pre-Processing

In the preprocessing phase, I made some activities such as cleaning, tokenization, and stemming. These actions were made in all three source files. In the final, I made these tasks in a subset of 5000 lines of all datasources. In the final, I create a dataframe, in which each column is the data from each dataset.


```{r preprocessing}
library(tm)
library(RColorBrewer)

rm(blog_char, tweet_char, news_char)

blogs_data <- sample(blogs_data, 10000)
twitter_data <- sample(twitter_data, 10000)
news_data <- sample(news_data, 10000)

all_data <- c(blogs_data, twitter_data, news_data)

all_data <- removePunctuation(all_data)
all_data <- tolower(all_data)
all_data <- stemDocument(all_data)
all_data <- removeWords(all_data, words=c('the', stopwords("english")))
all_data <- stripWhitespace(all_data)


```
## Word Frequency


To see the most frequent words, I generated a wordcloud with them.

```{r wordcloud, warning=FALSE}
library(wordcloud)
wordcloud(all_data, max.words=100, min.freq=40, colors=brewer.pal(6, 'Dark2'), rot.per=.2)
```

Besides the wordcloud, I also generated the bigrams of all the data collected. To generate the bigrams I used the function ngrams of the NLP package.

```{r bigram,warning=FALSE}
#Further processing on the corpus before tokenization
all_data <- paste0(unlist(all_data), collapse=" ")
all_data <- strsplit(all_data, " ", fixed=TRUE)[[1L]]
all_data <- all_data[all_data != ""]

bigrams <- vapply(ngrams(all_data, 2L), paste, "", collapse=" ")

top5 <- sort(table(bigrams), decreasing=T)[1:5]

barplot(top5)

```

## Analysis

