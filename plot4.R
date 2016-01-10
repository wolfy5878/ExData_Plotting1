#Check if data file already downloaded and unzipped for assignment,
##if not, then: download source file, unzip files into clean subdirectory within wd, set to new wd
library("ggplot2")
if(!file.exists("HHP")){dir.create("HHP")}
setwd("./HHP")
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("./exdata-data-household_power_consumption.zip")){     
     download.file(fileurl, destfile="./exdata-data-household_power_consumption.zip")     
}
if (!file.exists("./household_power_consumption.txt")){
     unzip("./exdata-data-household_power_consumption.zip", exdir = ".")
}
##Read in the subset of data needed for the assignment
header <- names(read.table("./household_power_consumption.txt",nrow=1,header=TRUE,sep=';'))
data <- read.table("./household_power_consumption.txt", na.strings = "?", sep = ";", header = FALSE, col.names=header,
                   skip = grep("^[1,2]/2/2007",readLines("./household_power_consumption.txt"))-1, nrow=2880)
##Correct date formats in new column for plotting
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)
##create plot4 for viewing in current graphics device
par(mfrow=c(2,2),mar=c(4,4,2,1),oma=c(0,0,0,0))
##TL
plot(data$Global_active_power~data$Datetime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
##TR
plot(data$Voltage~data$Datetime, type="l",ylab="Voltage",xlab="datetime")
##BL
with(data, {
     plot(Sub_metering_1~Datetime, type="l",
          ylab="Global Active Power (kilowatts)", xlab="")
     lines(Sub_metering_2~Datetime,col="red")
     lines(Sub_metering_3~Datetime,col="blue")
})
legend("topright",col=c("black","red","blue"),lty=1,lwd=2,legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
##BR
plot(data$Global_reactive_power~data$Datetime, type="l",ylab="Global_reactive_power",xlab="datetime")
##Create PNG file plot4
png(file="plot4.png")
par(mfrow=c(2,2),mar=c(4,4,2,1),oma=c(0,0,0,0))
plot(data$Global_active_power~data$Datetime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
plot(data$Voltage~data$Datetime, type="l",ylab="Voltage",xlab="datetime")
with(data, {
     plot(Sub_metering_1~Datetime, type="l",
          ylab="Global Active Power (kilowatts)", xlab="")
     lines(Sub_metering_2~Datetime,col="red")
     lines(Sub_metering_3~Datetime,col="blue")
})
legend("topright",col=c("black","red","blue"),lty=1,lwd=2,legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
plot(data$Global_reactive_power~data$Datetime, type="l",ylab="Global_reactive_power",xlab="datetime")
dev.off()
##Return back to previous working directory to reset user to original location
setwd("..")