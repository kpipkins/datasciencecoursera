## This script will read, subset and plot some data

## assumes the data file hasn't changed names and your working
## directory is where the file is contained
data <- read.table("household_power_consumption.txt", header=TRUE, sep=";",na.strings="?",
                   colClasses=c("character","character","numeric","numeric",
                                  "numeric","numeric","numeric","numeric"))

## converts the needed fields to data and numeric instead of characters
data$Date=as.Date(data$Date,"%d/%m/%Y")

## Subset the data for the two days we are asked to analyze and reassings it to subdata
subdata <- subset(data, data$Date >= as.Date("2007-02-01") & data$Date <= as.Date("2007-02-02"))
##get rid of larger table data from environment for space
rm(data)

## plots the histogram to a png file in the working directory called "plot1"
png(file="plot1.png",width=480,height=480)
hist(subdata$Global_active_power, main="Global Active Power",
     xlab="Global Active Power(kilowatts)", col="red", ylim=c(0,1200))
dev.off()

