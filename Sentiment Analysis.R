# installing and loading all the required packages
install.packages("twitteR")
install.packages("ROAuth")
library("NLP", lib.loc="~/R/win-library/3.5")
library("twitteR", lib.loc="~/R/win-library/3.5")
library("syuzhet", lib.loc="~/R/win-library/3.5")
library("tm", lib.loc="~/R/win-library/3.5")
library("SnowballC", lib.loc="~/R/win-library/3.5")
library("stringi", lib.loc="~/R/win-library/3.5")
library("topicmodels")
library("syuzhet", lib.loc="~/R/win-library/3.5")
library("twitteR")
library("ROAuth")
library('tm')


#Connecting Twitter account with R to extract required tweets.
consumer_key <- 'Iop6G36tt07jNPTeDi3wN3ogZ'
consumer_secret <- 'n3aHia8TNNWrGRhNZlaEea1QpzOeOx6JPlYsvCBQJG8XaJfnXn'
access_token <- '1045909182438952961-OzfVBAUbj9MCpoWnInJvh5qMcyRVRH'
access_secret <- 'AM6NG1blvvckCDYx21a0AKQImL1JFMTg4KOKbaBx1QCdb'
setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)


# Extracting tweets using particular hashtags
tweets_g <- searchTwitter("#google", n=1000,lang = "en")
tweets_a <- searchTwitter("#amazon", n=1000,lang = "en")
tweets_f <- searchTwitter("#facebook", n=1000,lang = "en")
tweets_tech <- searchTwitter("#technology", n=1000,lang = "en")
tweets_t <- searchTwitter("#twitter", n=1000,lang = "en")
tweets_ap <- searchTwitter("#apple", n=1000,lang = "en")
tweets_tl <- searchTwitter("#tesla", n=1000,lang = "en")


# Converting extracted tweets to a dataframe to make it more readable and easier to work with
amazon_tweets <- twListToDF(tweets_a)
google_tweets <- twListToDF(tweets_g)
facebook_tweets <- twListToDF(tweets_f)
tech_tweets <- twListToDF(tweets_tech)
apple_tweets <- twListToDF(tweets_ap)
twitter_tweets <- twListToDF(tweets_t)
tesla_tweets <- twListToDF(tweets_tl)


# Extracting only text from tweets
google_text<- google_tweets$text
amazon_text <- amazon_tweets$text
facebook_text <- facebook_tweets$text
twitter_text <- twitter_tweets$text
apple_text <- apple_tweets$text
tech_text <- tech_tweets$text
tesla_text <- tesla_tweets$text


#convert all text to lower case
google_text<- tolower(google_text)
amazon_text<- tolower(amazon_text)
facebook_text<- tolower(facebook_text)
tech_text<- tolower(tech_text)
apple_text <- tolower(apple_text)
twitter_text <- tolower(twitter_text)
tesla_text <- tolower(tesla_text)


# Replace blank space ("rt")
google_text <- gsub("rt", "", google_text)
amazon_text <- gsub("rt", "", amazon_text)
facebook_text <- gsub("rt", "", facebook_text)
tech_text <- gsub("rt", "", tech_text)
apple_text <- gsub("rt", "", apple_text)
twitter_text <- gsub("rt", "", twitter_text)
tesla_text <- gsub("rt", "", tesla_text)


# Replace @UserName
google_text <- gsub("@\\w+", "", google_text)
amazon_text <- gsub("@\\w+", "", amazon_text)
facebook_text <- gsub("@\\w+", "", facebook_text)
tech_text <- gsub("@\\w+", "", tech_text)
apple_text <- gsub("@\\w+", "", apple_text)
twitter_text <- gsub("@\\w+", "", twitter_text)
tesla_text <- gsub("@\\w+", "", tesla_text)


# Remove punctuation
google_text <- gsub("[[:punct:]]", "", google_text)
amazon_text <- gsub("[[:punct:]]", "", amazon_text)
facebook_text <- gsub("[[:punct:]]", "", facebook_text)
tech_text <- gsub("[[:punct:]]", "", tech_text)
apple_text <- gsub("[[:punct:]]", "", apple_text)
twitter_text <- gsub("[[:punct:]]", "", twitter_text)
tesla_text <- gsub("[[:punct:]]", "", tesla_text)


# Remove links
google_text <- gsub("http\\w+", "", google_text)
amazon_text <- gsub("http\\w+", "", amazon_text)
facebook_text <- gsub("http\\w+", "", facebook_text)
tech_text <- gsub("http\\w+", "", tech_text)
apple_text <- gsub("http\\w+", "", apple_text)
twitter_text <- gsub("http\\w+", "", twitter_text)
tesla_text <- gsub("http\\w+", "", tesla_text)


#Remove tabs
google_text <- gsub("[ |\t]{2,}", "", google_text)
amazon_text <- gsub("[ |\t]{2,}", "", amazon_text)
facebook_text <- gsub("[ |\t]{2,}", "", facebook_text)
tech_text <- gsub("[ |\t]{2,}", "", tech_text)
apple_text <- gsub("[ |\t]{2,}", "", apple_text)
twitter_text <- gsub("[ |\t]{2,}", "", twitter_text)
tesla_text <- gsub("[ |\t]{2,}", "", tesla_text)


# Remove blank spaces at the beginning
google_text <- gsub("^ ", "", google_text)
amazon_text <- gsub("^ ", "", amazon_text)
facebook_text <- gsub("^ ", "", facebook_text)
tech_text <- gsub("^ ", "", tech_text)
apple_text <- gsub("^ ", "", apple_text)
twitter_text <- gsub("^ ", "", twitter_text)
tesla_text <- gsub("^ ", "", tesla_text)


# Remove blank spaces at the end
google_text <- gsub(" $", "", google_text)
amazon_text <- gsub(" $", "", amazon_text)
facebook_text <- gsub(" $", "", facebook_text)
tech_text <- gsub(" $", "", tech_text)
apple_text <- gsub(" $", "", apple_text)
twitter_text <- gsub(" $", "", twitter_text)
tesla_text <- gsub(" $", "", tesla_text)


#creating Corpus
# Corpus is a collection of text documents.
#VectorSource is used only for characters, same as in this case.
library('tm')
google_tweets.text.corpus <- Corpus(VectorSource(google_text))
amazon_tweets.text.corpus <- Corpus(VectorSource(amazon_text))
facebook_tweets.text.corpus <- Corpus(VectorSource(facebook_text))
tech_tweets.text.corpus <- Corpus(VectorSource(tech_text))
apple_tweets.text.corpus <- Corpus(VectorSource(apple_text))
twitter_tweets.text.corpus <- Corpus(VectorSource(twitter_text))
tesla_tweets.text.corpus <- Corpus(VectorSource(tesla_text))


#clean up by removing stop words
#tm : package used for text mining.
#tm package has 174 english words which can be called stop words and can be removed from your text analysis.
#tm_map is used for applying certain transformation functions in corpus, here in this case we are using removewords function to remove stopwords.
google_tweets.text.corpus <- tm_map(google_tweets.text.corpus, function(x)removeWords(x,stopwords()))
amazon_tweets.text.corpus <- tm_map(amazon_tweets.text.corpus, function(x)removeWords(x,stopwords()))
facebook_tweets.text.corpus <- tm_map(facebook_tweets.text.corpus, function(x)removeWords(x,stopwords()))
tech_tweets.text.corpus <- tm_map(tech_tweets.text.corpus, function(x)removeWords(x,stopwords()))
apple_tweets.text.corpus <- tm_map(apple_tweets.text.corpus, function(x)removeWords(x,stopwords()))
twitter_tweets.text.corpus <- tm_map(twitter_tweets.text.corpus, function(x)removeWords(x,stopwords()))
tesla_tweets.text.corpus <- tm_map(tesla_tweets.text.corpus, function(x)removeWords(x,stopwords()))
                                                                   

# Displaying Wordcloud for each, installing packages
install.packages('wordcloud')
install.packages('RColorBrewer')
library('wordcloud')



#Generating wordcloud
# the more a specific word appears in a source of textual data (such as a speech, blog post, or database), the bigger and bolder it appears in the word cloud.
# Next biggest word after each of the tech giants(amazon , google etc) in the wordcloud is of most significance and viral accross users.
#min.freq : a word that is tweeted less than this minimum frequency will not be plotted on the cloud.
wordcloud(google_tweets.text.corpus,min.freq = 10,colors=brewer.pal(9, "Dark2"),random.color = TRUE,max.words = 500)
wordcloud(amazon_tweets.text.corpus,min.freq = 10,colors=brewer.pal(8, "Dark2"),random.color = TRUE,max.words = 500)
wordcloud(facebook_tweets.text.corpus,min.freq = 10,colors=brewer.pal(8, "Dark2"),random.color = TRUE,max.words = 500)
wordcloud(tech_tweets.text.corpus,min.freq = 10,colors=brewer.pal(8, "Dark2"),random.color = TRUE,max.words = 500)
wordcloud(apple_tweets.text.corpus,min.freq = 10,colors=brewer.pal(8, "Dark2"),random.color = TRUE,max.words = 500)
wordcloud(twitter_tweets.text.corpus,min.freq = 10,colors=brewer.pal(8, "Dark2"),random.color = TRUE,max.words = 500)
wordcloud(tesla_tweets.text.corpus,min.freq = 10,colors=brewer.pal(8, "Dark2"),random.color = TRUE,max.words = 500)
                                   
                                   

#getting emotions using in-built function
#get_nrc_sentiment is used to get analysis of emotions using the text that is being tested and divide the emotions in 8 categories.
# package syuzhet is used to load get_nrc_sentiment
mysentiment_google<-get_nrc_sentiment((google_text))
mysentiment_amazon<-get_nrc_sentiment((amazon_text))
mysentiment_facebook<-get_nrc_sentiment((facebook_text))
mysentiment_tech<-get_nrc_sentiment((tech_text))
mysentiment_apple<-get_nrc_sentiment((apple_text))
mysentiment_twitter<-get_nrc_sentiment((twitter_text))
mysentiment_tesla<-get_nrc_sentiment((tesla_text))

                                   
#calculationg total score for each sentiment
Sentimentscores_google<-data.frame(colSums(mysentiment_google[,]))
Sentimentscores_amazon<-data.frame(colSums(mysentiment_amazon[,]))
Sentimentscores_facebook<-data.frame(colSums(mysentiment_facebook[,]))
Sentimentscores_tech<-data.frame(colSums(mysentiment_tech[,]))
Sentimentscores_apple<-data.frame(colSums(mysentiment_apple[,]))
Sentimentscores_twitter<-data.frame(colSums(mysentiment_twitter[,]))
Sentimentscores_tesla<-data.frame(colSums(mysentiment_tesla[,]))

                                   
                                   
#naming the columns as sentiments and score in sentimentscore_xyz
#cbind is used to combine vectors , character by columns
names(Sentimentscores_google)<-"Score"
Sentimentscores_google<-cbind("sentiment"=rownames(Sentimentscores_google),Sentimentscores_google)
rownames(Sentimentscores_google)<-NULL

names(Sentimentscores_amazon)<-"Score"
Sentimentscores_amazon<-cbind("sentiment"=rownames(Sentimentscores_amazon),Sentimentscores_amazon)
rownames(Sentimentscores_amazon)<-NULL

names(Sentimentscores_facebook)<-"Score"
Sentimentscores_facebook<-cbind("sentiment"=rownames(Sentimentscores_facebook),Sentimentscores_facebook)
rownames(Sentimentscores_facebook)<-NULL

names(Sentimentscores_tech)<-"Score"
Sentimentscores_tech<-cbind("sentiment"=rownames(Sentimentscores_tech),Sentimentscores_tech)
rownames(Sentimentscores_tech)<-NULL

names(Sentimentscores_apple)<-"Score"
Sentimentscores_apple<-cbind("sentiment"=rownames(Sentimentscores_apple),Sentimentscores_apple)
rownames(Sentimentscores_apple)<-NULL

names(Sentimentscores_twitter)<-"Score"
Sentimentscores_twitter<-cbind("sentiment"=rownames(Sentimentscores_twitter),Sentimentscores_twitter)
rownames(Sentimentscores_twitter)<-NULL

names(Sentimentscores_tesla)<-"Score"
Sentimentscores_tesla<-cbind("sentiment"=rownames(Sentimentscores_tesla),Sentimentscores_tesla)
rownames(Sentimentscores_tesla)<-NULL



#plotting the sentiments with scores
install.packages('ggplot2')
library('ggplot2')
ggplot(data=Sentimentscores_google,aes(x=sentiment,y=Score))+geom_bar(aes(fill=sentiment),stat = "identity")+
  theme(legend.position="none")+
  xlab("Sentiments")+ylab("scores")+ggtitle("Sentiments of people behind tweets on Google")


ggplot(data=Sentimentscores_amazon,aes(x=sentiment,y=Score))+geom_bar(aes(fill=sentiment),stat = "identity")+
  theme(legend.position="none")+
  xlab("Sentiments")+ylab("scores")+ggtitle("Sentiments of people behind the tweets on AMAZON")


ggplot(data=Sentimentscores_facebook,aes(x=sentiment,y=Score))+geom_bar(aes(fill=sentiment),stat = "identity")+
  theme(legend.position="none")+
  xlab("Sentiments")+ylab("scores")+ggtitle("Sentiments of people behind the tweets on FACEBOOK")


ggplot(data=Sentimentscores_tech,aes(x=sentiment,y=Score))+geom_bar(aes(fill=sentiment),stat = "identity")+
  theme(legend.position="none")+
  xlab("Sentiments")+ylab("scores")+ggtitle("Sentiments of people behind the tweets on techology as a whole")

ggplot(data=Sentimentscores_apple,aes(x=sentiment,y=Score))+geom_bar(aes(fill=sentiment),stat = "identity")+
  theme(legend.position="none")+
  xlab("Sentiments")+ylab("scores")+ggtitle("Sentiments of people behind the tweets on Apple")

ggplot(data=Sentimentscores_twitter,aes(x=sentiment,y=Score))+geom_bar(aes(fill=sentiment),stat = "identity")+
  theme(legend.position="none")+
  xlab("Sentiments")+ylab("scores")+ggtitle("Sentiments of people behind the tweets on twitter")

