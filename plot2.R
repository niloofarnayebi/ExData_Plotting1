data <- read.table("household_power_consumption.txt", header = T, 
                   sep = ";", na.strings = "?")
# convert the date variable to Date class
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

# Subset the data
subSetData <- subset(data, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))

# Convert dates and times
subSetData$datetime <- strptime(paste(subSetData$Date, subSetData$Time), "%Y-%m-%d %H:%M:%S")

#datetime <- strptime(paste(subSetData$Date, subSetData$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

datetime <- as.POSIXct(subSetData$datetime)

globalActivePower <- as.numeric(subSetData$Global_active_power)

png("plot2.png", width=480, height=480)
plot(globalActivePower ~ datetime, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()