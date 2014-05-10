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

## Plot and save to png file
png("plot1.png")
hist(as.numeric(data$Global_active_power), col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
##dev.copy(png, file="plot1.png")
dev.off()