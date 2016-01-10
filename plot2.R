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
##create plot2 for viewing in current graphics device
plot(data$Global_active_power~data$Datetime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
##Create PNG file plot2
png(file="plot2.png")
plot(data$Global_active_power~data$Datetime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
dev.off()
##Return back to previous working directory to reset user to original location
setwd("..")



