## Get dataset file
## CAUTION: if you have already download dataset file,
## please ensure the name and the file path is correctly set to 'destfile' variable to avoid re-download
destfile <- "exdata-data-household_power_consumption.zip"
if (!file.exists(destfile)) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile, method="curl")
}

## Create data frame with the data of 1/2/2007 and 2/2/2007 only
file <- unz(destfile, unzip(destfile, list=TRUE)[1, "Name"])
data <- grep("^[1|2]/2/2007", readLines(file), value=TRUE)
data <- read.csv2(text=data, header=FALSE, colClasses="character", na.strings="?")
names(data) <- unname(unlist(read.csv2(file, header=FALSE, nrow=1)))

## Append DataTime column to data frame
data$DateTime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")

## Plot and save to png file
png("plot3.png")
plot(data$DateTime, data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(data$DateTime, data$Sub_metering_2, type="l", col="red")
lines(data$DateTime, data$Sub_metering_3, type="l", col="blue")
legend("topright", lwd=1, col=c("black", "red", "blue"), legend=names(data[, 7:9]))
##dev.copy(png, file="plot3.png")
dev.off()