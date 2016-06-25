## switch to my working dir (windows 7 as OS)
setwd("C:/data/RProgramming/cert3/week1/")

## download the file from http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
fileURL <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile="./Cert3Week1Project.zip")

## unzip the file and keep it in the same working directory
## as a result, file "household_power_consumption.txt" was created
unzip("Cert3Week1Project.zip") 

## read data, and set stringAsFactors to False, na.strings = "?"
power_data <- read.table("./household_power_consumption.txt", header=T, sep=";", na.strings = "?", stringsAsFactors=FALSE)

## convert Date string to Date
power_data$Date <- as.Date(power_data$Date, format="%d/%m/%Y")

## sub-setting data where dates equal to 2007-02-01 or 2007-02-02
sub_data <- power_data[(power_data$Date=="2007-02-01") | (power_data$Date=="2007-02-02"),]

## convert Global_active_power, subMetering1,2,3, Global_reactive_power, Voltage to numerics
sub_data$Global_active_power <- as.numeric(as.character(sub_data$Global_active_power))
sub_data$subMetering1 <- as.numeric(sub_data$Sub_metering_1)
sub_data$subMetering2 <- as.numeric(sub_data$Sub_metering_2)
sub_data$subMetering3 <- as.numeric(sub_data$Sub_metering_3)
sub_data$Global_reactive_power <- as.numeric(as.character(sub_data$Global_reactive_power))
sub_data$Voltage <- as.numeric(as.character(sub_data$Voltage))

## combine Date and Time to a new column Timestamp in UTC timezone with "%d/%m/%Y %H:%M:%S" format 
sub_data <- transform(sub_data, Timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")

## open png device
png("plot4.png", width=480, height=480)

## divide device to 2 rows and 2 columns
par(mfrow = c(2, 2))

## 1st graph
## generate below plot with X = Timestamp, Y = Global_active_power. Type as Line
plot(sub_data$Timestamp, sub_data$Global_active_power, type="l", xlab = "", ylab="Global Active Power (kilowatts)")

## 2nd graph
## generate below plot with X = Timestamp, Y = Voltage. Type as Line
plot(sub_data$Timestamp, sub_data$Voltage, type="l", xlab="Datetime", ylab="Voltage")

## 3rd graph
## generate below plot with X = Timestamp, Y = subMetering1 with type = Line in the png device.
plot(sub_data$Timestamp, sub_data$subMetering1, type="l", xlab = "", ylab="Energy sub meeting")

#Add line for subMetering2 in red with type = line
lines(sub_data$Timestamp, sub_data$subMetering2, type = "l", col = "red" )

#Add line for subMetering3 in blue with type = line
lines(sub_data$Timestamp, sub_data$subMetering3, type = "l", col = "blue" )

#Add legend to top right corner 
legend("topright", lty= 1, col = c("Black", "red", "blue"), legend = c( "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## 4th graph
## ## generate below plot with X = Timestamp, Y = Global_reactive_power Type as Line
plot(sub_data$Timestamp, sub_data$Global_reactive_power, type="l", xlab="Datetime", ylab="Global_reactive_power")

## close the device
dev.off()