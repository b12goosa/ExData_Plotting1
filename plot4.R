##Code of the Peer-graded Assignment: Course Projec 1
##Course 3: Exploratory data analysis
##Week one

##Introduction
##Download the data set
fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url = fileUrl, destfile = "dataset.zip")
##unzip the document in the working directory
unzip(zipfile = "dataset.zip",exdir = ".")

##Reading data and subsetting required data from 01/02/2007 to 02/02/2007
dat<-read.table(file = "household_power_consumption.txt",header = TRUE,
                sep = ";",stringsAsFactors = FALSE)
dat<-subset(dat,Date == "1/2/2007" | Date == "2/2/2007")

##Convert ? to NA
dat[dat=="?"]<-NA

##Giving Class() to the data by column: 
## 1.Date 2.character 3:9.numeric 10.POSIXct
dat[,3:8]<-lapply(dat[,3:8],as.numeric)
dat$Date_Time<-as.POSIXct(strptime(paste(dat$Date, dat$Time, sep = " "),
                               format = "%d/%m/%Y %H:%M:%S"))
dat$Date<-as.Date(dat$Date, format = "%d/%m/%Y")

##Plot 4.set of plots
png(filename = "plot4.png", width = 480, height = 480, units = "px")
par(mfrow = c(2,2))
with(dat,{
        plot(x = Date_Time,y = Global_active_power,
             type = "l",
             ylab = "Global Active Power",
             xlab = " ")
        plot(x = Date_Time, y = Voltage,
             type = "l",
             ylab = "Voltage",
             xlab = "datetime")
        plot(x = dat$Date_Time,y = dat$Sub_metering_1,
             type = "l",
             col= "black",
             ylab = "Energy sub metering",
             xlab = " ")
        lines(x = dat$Date_Time,y = dat$Sub_metering_2,
              type = "l", col= "red")
        lines(x = dat$Date_Time,y = dat$Sub_metering_3,
              type = "l", col= "blue")
        legend("topright", 
               col = c("black", "blue", "red"),
               legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),
               lty = 1)
        plot(x = Date_Time,y = Global_reactive_power,
             type = "l",
             xlab = "datetime",
             ylab = "Global_reactive_power")
})
dev.off()
