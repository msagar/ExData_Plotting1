#Libraries Needed For The Script
library(dplyr)
library(data.table)
library(lubridate)


downloadurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(downloadurl,"household_power_consumption.zip",method = "curl")

datedownloaded = date()
unzip("household_power_consumption.zip")


downloadeddata <- read.table("household_power_consumption.txt",header = TRUE, na.strings = c("?"),sep = ";",stringsAsFactors = FALSE) 


downloadeddata$datetime <- paste(downloadeddata$Date,downloadeddata$Time)
downloadeddata$datetime <- parse_date_time(downloadeddata$datetime,"dmYHMS")
downloadeddata$Date <- parse_date_time(downloadeddata$Date,"%d%m%Y")
downloadeddata$Time <- parse_date_time(downloadeddata$Time,"HMS")

#Extract the 2 day data that we are interested in
feb1daydata <- downloadeddata[which(downloadeddata$Date == as.Date("2007-02-01",format = "%Y-%m-%d")),]
feb2daydata <- downloadeddata[which(downloadeddata$Date == as.Date("2007-02-02",format = "%Y-%m-%d")),]
listtwodays <- list(feb1daydata,feb2daydata)
twodaydata <- rbindlist(listtwodays,use.names = TRUE)




#Plot the graph
png("plot2.png",width = 480 ,height = 480)
plot(twodaydata$datetime,twodaydata$Global_active_power,type = "l",ylab = "Global Active Power(kilowatts)",xlab = " ")

dev.off()



