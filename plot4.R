## This script will read, subset and plot some data

## assumes the data file hasn't changed names and your working
## directory is where the file is contained
data <- read.table("household_power_consumption.txt", header=TRUE, sep=";",na.strings="?",
                   colClasses=c("character","character","numeric","numeric",
                                "numeric","numeric","numeric","numeric"))

# Convert Date column to date type
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
## Subset the data for the two days we are asked to analyze and reassings it to subdata
subdata <- subset(data, data$Date >= as.Date("2007-02-01") & data$Date <= as.Date("2007-02-02"))
##get rid of larger table data from environment for space
rm(data)

## creates new column 'DateTime' 
subdata$DateTime <- strptime(paste(subdata$Date, subdata$Time), format="%Y-%m-%d %H:%M:%S" ) 

## opens the png for everything below to be plotted to...
png(file="plot4.png",width=480,height=480)

## establishes a 2x2 plotting window 4 graphs total
par(mfrow=c(2,2))

## plot 1 (top left)
plot(subdata$DateTime,subdata$Global_active_power, type="n", xlab="", ylab = "Global Active Power")
lines(subdata$DateTime,subdata$Global_active_power)

## plot 2 (top right)
plot(subdata$DateTime, subdata$Voltage, type="n", xlab="datetime", ylab="Voltage", main="")
lines(subdata$DateTime,subdata$Voltage)

## plot 3 (bottom left)
plot(subdata$DateTime, subdata$Sub_metering_1, type="n", col="black", xlab="", ylab = "Energy sub metering")
lines(subdata$DateTime, subdata$Sub_metering_1, col="black")
lines(subdata$DateTime, subdata$Sub_metering_2, col="red")
lines(subdata$DateTime, subdata$Sub_metering_3, col="blue")

legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col=c("black","red","blue"), lty=1)

## plot 4 (bottom right)
plot(subdata$DateTime,subdata$Global_reactive_power, type="n", xlab="datetime", ylab = "Global_reactive_power")
lines(subdata$DateTime,subdata$Global_reactive_power)

## closes png
dev.off()