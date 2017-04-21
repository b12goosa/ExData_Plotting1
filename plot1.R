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

##Plot 1.Global active power
png(filename = "plot1.png", width = 480, height = 480, units = "px")
hist(dat$Global_active_power,xlab = "Global active power (kilowatts)",
     main = "Global active Power",col = "red")
dev.off()
