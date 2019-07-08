#Libraries Needed For The Script
library(dplyr)
library(data.table)

downloadurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(downloadurl,"household_power_consumption.zip",method = "curl")

datedownloaded = date()
unzip("household_power_consumption.zip")


downloadeddata <- read.table("household_power_consumption.txt",header = TRUE, na.strings = c("?"),sep = ";",stringsAsFactors = FALSE) 

downloadeddata$Date <- lapply(downloadeddata$Date,function (x)as.Date(x,format = "%d/%m/%Y") )
downloadeddata$Time <- lapply(downloadeddata$Time, function(x) strptime(x,format = "%H:%M:%S"))

#Extract the 2 day data that we are interested in
feb1daydata <- downloadeddata[which(downloadeddata$Date == as.Date("01/02/2007",format = "%d/%m/%Y")),]
feb2daydata <- downloadeddata[which(downloadeddata$Date == as.Date("02/02/2007",format = "%d/%m/%Y")),]
listtwodays <- list(feb1daydata,feb2daydata)
twodaydata <- rbindlist(listtwodays,use.names = TRUE)


#Plot the graph 
png("plot1.png",width = 480 ,height = 480)
hist(twodaydata$Global_active_power,col = "red",main = paste("Global Active Power"),xlab = "Global Active Power(kilowatts)")
dev.off()

