library(dplyr)
library(data.table)
library(lubridate)


# downloadurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
# 
# download.file(downloadurl,"household_power_consumption.zip",method = "curl")
# 
# datedownloaded = date()
# unzip("household_power_consumption.zip")


downloadeddata <- read.table("household_power_consumption.txt",header = TRUE, na.strings = c("?"),sep = ";",stringsAsFactors = FALSE) 


downloadeddata$datetime <- paste(downloadeddata$Date,downloadeddata$Time)
downloadeddata$datetime <- parse_date_time(downloadeddata$datetime,"dmYHMS")
downloadeddata$Date <- parse_date_time(downloadeddata$Date,"%d%m%Y")
downloadeddata$Time <- parse_date_time(downloadeddata$Time,"HMS")

# downloadeddata$Date <- lapply(downloadeddata$Date,function (x)as.Date.factor(x,format = "%d/%m/%Y") )
# downloadeddata$Time <- lapply(downloadeddata$Time, function(x) strptime(x,format = "%H:%M:%S"))

#Extract the 2 day data that we are interested in
feb1daydata <- downloadeddata[which(downloadeddata$Date == as.Date("2007-02-01",format = "%Y-%m-%d")),]
feb2daydata <- downloadeddata[which(downloadeddata$Date == as.Date("2007-02-02",format = "%Y-%m-%d")),]
listtwodays <- list(feb1daydata,feb2daydata)
twodaydata <- rbindlist(listtwodays,use.names = TRUE)


#Plot the graphs 
png("plot4.png",width = 480 ,height = 480)

par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))


plot(twodaydata$datetime,twodaydata$Global_active_power,type = "l",ylab = "Global Active Power",xlab = " ")

plot(twodaydata$datetime,twodaydata$Voltage,type = "l", ylab = "Voltage" , xlab = "datetime")

plot(twodaydata$datetime,twodaydata$Sub_metering_1,type = "l",xlab = " ", ylab = "Energy sub metering ",col = "black")
lines(twodaydata$datetime,twodaydata$Sub_metering_2,col = "red")
lines(twodaydata$datetime,twodaydata$Sub_metering_3,col = "blue")
legend("topright",col = c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),fill = c("black","red","blue"))

plot(twodaydata$datetime,twodaydata$Global_reactive_power,type = "l",ylab = "Global_reactive_power",xlab = "datetime")


dev.off()