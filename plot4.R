data <- read.table("household_power_consumption.txt", header = T, 
                   sep = ";", na.strings = "?")
# convert the date variable to Date class
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

# Subset the data
subSetData <- subset(data, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))

subSetData$datetime <- strptime(paste(subSetData$Date, subSetData$Time), "%Y-%m-%d %H:%M:%S")
datetime <- as.POSIXct(subSetData$datetime)


globalActivePower <- as.numeric(subSetData$Global_active_power)
globalReactivePower <- as.numeric(subSetData$Global_reactive_power)
voltage <- as.numeric(subSetData$Voltage)
subMetering1 <- as.numeric(subSetData$Sub_metering_1)
subMetering2 <- as.numeric(subSetData$Sub_metering_2)
subMetering3 <- as.numeric(subSetData$Sub_metering_3)


png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2)) 

plot(globalActivePower ~ datetime, type="l", xlab="", ylab="Global Active Power", cex=0.2)

plot(voltage, type="l", xlab="datetime", ylab="Voltage")

plot(subMetering1 ~ datetime, type="l", ylab="Energy Submetering", xlab="")
lines(subMetering2 ~ datetime, type="l", col="red")
lines(subMetering3 ~ datetime, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")

plot(datetime, globalReactivePower, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()