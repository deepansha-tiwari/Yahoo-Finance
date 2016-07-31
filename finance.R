#YahooFinance
#Deepansha Tiwari

#installing the required packages
install.packages("quantmod")
install.packages("xts")
install.packages("ggplot2")
library(quantmod)
library(ggplot2)
library(xts)

#set the working directory
setwd('~/Documents/Yahoo Finance')

#read the csv file downloaded from yahoo finance
finance<-read.csv("table.csv", header = TRUE, stringsAsFactors=F)

#converting the date format
finance$Date <- as.Date(finance$Date,format = "%m/%d/%y")

#extracting january first date
jan<-as.Date("2015-01-01")

#extracting december last date
dec<-as.Date("2015-12-31")

#subsetting the data for the year of 2015
data <- subset(finance, as.Date(finance$Date) >= jan  & as.Date(finance$Date) <= dec)
#print(data$Date)

#subsetting the data for the month of february
febdata <- subset(finance, as.Date(finance$Date) >= "2015-02-01"  & as.Date(finance$Date) <= "2015-02-28")

#plotting the data and the vertical and horizontal lines
require(ggplot2)
plot(data$Date,data$Close, xlab='For the year of 2015',ylab='Closing prices')
abline(v=as.Date("2015-07-01"), col="red", h=min(febdata$Close))

#returning the periodic returns, i.e. the monthly returns
timeseries<-xts(data$Close,data$Date)
returns<-data.frame(monthlyReturn(timeseries))

#creating a csv with two columns month and return
write.csv(returns, file = "SPYReturn.csv")


