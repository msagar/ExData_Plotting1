


library(dplyr)
library(data.table)

downloadurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(downloadurl,"household_power_consumption.zip",method = "curl")

datedownloaded = date()
unzip("household_power_consumption.zip")


#initialdata <- read.table("household_power_consumption.txt", ,header = TRUE, sep = ";",nrows = 100)
# classes <- sapply(initialdata,class)
#colclasses = classes

downloadeddata <- read.table("household_power_consumption.txt",header = TRUE, na.strings = c("?"),sep = ";") 

downloadeddata$Date <- lapply(downloadeddata$Date,function (x)as.Date.factor(x,format = "%d/%m/%Y") )
downloadeddata$Time <- lapply(downloadeddata$Time, function(x) strptime(x,format = "%H:%M:%S"))

#use library(data.table)
#lapply(downloadeddata$Time,function(x) as.ITime(x))
#twodaydata <- filter(downloadeddata, downloadeddata$Date == as.Date(c("2007-02-01","2007-02-02")))
#twodaydata <- downloadeddata[which(downloadeddata$Date == as.Date("01/02/2007",format = "%d/%m/%Y")),]

feb1daydata <- downloadeddata[which(downloadeddata$Date == as.Date("01/02/2007",format = "%d/%m/%Y")),]
feb2daydata <- downloadeddata[which(downloadeddata$Date == as.Date("02/02/2007",format = "%d/%m/%Y")),]
listtwodays <- list(feb1daydata,feb2daydata)
twodaydata <- rbindlist(listtwodays,use.names = TRUE)

#Just making sure that Date and Time are stored in proper format i.e. Date class and POSIXlt class
twodaydata$Date <- lapply (twodaydata$Date, function(x) as.Date(x,format = "%5/%m/%Y"))
twodaydata$Time <- lapply(twodaydata$Time, function(x) strptime(x,format = "%H:%M:%S"))

#Just making sure that Date and Time are stored in proper format i.e. Date class and POSIXlt class
twodaydata$Date <- lapply (twodaydata$Date, function(x) as.Date(x,format = "%5/%m/%Y"))
twodaydata$Time <- lapply(twodaydata$Time, function(x) strptime(x,format = "%H:%M:%S"))

#Plot the graph 
png("plot1.png",width = 480 ,height = 480)
hist(twodaydata$Global_active_power,col = "red",main = paste("Global Active Power"),xlab = "Global Active Power(kilowatts)")
dev.off()


transform(subset(data, Date=="1/2/2007"| Date =="2/2/2007"),
          
          Date=format(as.Date(Date, format="%d/%m/%y"),"%y/%m/%d"),
          
          Time=format(strptime(Time, format="%H:%M:%S"),"%H:%M:%S"))

plot(as.POSIXct(paste(realdata$Date, realdata$Time), format="%d/%m/%Y %H:%M:%S",
                
                realdata$Global_active_power, type="l" ))

marchdata <- filter(tempdownloadeddata, tempdownloadeddata == as_date("01-03-2007"))

# downloadeddata$Date <- lapply(downloadeddata$Date,function (x)as.Date.factor(x,format = "%d/%m/%Y") )
# downloadeddata$Time <- lapply(downloadeddata$Time, function(x) strptime(x,format = "%H:%M:%S"))
# downloadeddata$Date <- lapply(downloadeddata$Date,function (x)as.Date.factor(x,format = "%d/%m/%Y") )
# downloadeddata$Time <- lapply(downloadeddata$Time, function(x) strptime(x,format = "%H:%M:%S"))


# downloadeddata$Date <- lapply(downloadeddata$Date,function (x)as.Date.factor(x,format = "%d/%m/%Y") )
# downloadeddata$Time <- lapply(downloadeddata$Time, function(x) strptime(x,format = "%H:%M:%S"))
