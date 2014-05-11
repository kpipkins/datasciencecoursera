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

## plots the histogram to a png file in the working directory called "plot3"
png(file="plot3.png",width=480,height=480)
plot(subdata$DateTime , subdata$Sub_metering_1, type="n", col="black", xlab="", ylab = "Energy sub metering")
lines(subdata$DateTime, subdata$Sub_metering_1, col="black")
lines(subdata$DateTime, subdata$Sub_metering_2, col="red")
lines(subdata$DateTime, subdata$Sub_metering_3, col="blue")

legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col=c("black","red","blue"), lty=1)
dev.off()