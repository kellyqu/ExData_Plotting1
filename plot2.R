## switch to my working dir (windows 7 as OS)
setwd("C:/data/RProgramming/cert3/week1/")

## download the file from http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
fileURL <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile="./Cert3Week1Project.zip")

## unzip the file and keep it in the same working directory
## as a result, file "household_power_consumption.txt" was created
unzip("Cert3Week1Project.zip") 

## read data, and set stringAsFactors to False, na.strings="?"
power_data <- read.table("./household_power_consumption.txt", header=T, sep=";", na.strings = "?", stringsAsFactors=FALSE)

## convert Date string to Date
power_data$Date <- as.Date(power_data$Date, format="%d/%m/%Y")

## subsetting data where dates equal to 2007-02-01 or 2007-02-02
sub_data <- power_data[(power_data$Date=="2007-02-01") | (power_data$Date=="2007-02-02"),]

## convert Global_active_power to numeric
sub_data$Global_active_power <- as.numeric(as.character(sub_data$Global_active_power))

## combine Date and Time to a new column Timestamp in UTC timezone with "%d/%m/%Y %H:%M:%S" format 
sub_data <- transform(sub_data, Timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")

## open png device
png("plot2.png", width=480, height=480)

## generate below plot with X = Timestamp, Y = Global_active_power. Type as Line in the png device.
plot(sub_data$Timestamp, sub_data$Global_active_power, type="l", xlab = "", ylab="Global Active Power (kilowatts)")

## close the device
dev.off()