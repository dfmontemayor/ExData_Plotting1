# Reading the data set, separate headers and set classes
fileName = "household_power_consumption.txt"
data <- read.table(fileName, header = TRUE, sep=";", colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), na.strings = "?")

# Change class of Date column
dates <- as.Date(data$Date, format = "%d/%m/%Y")

# Subsetting target dates and remove incomplete observations
dataFinal <- data[dates >= "2007-2-1" & dates <= "2007-2-2",]
dataFinal <- dataFinal[complete.cases(dataFinal),]

# Format dates and times and paste them together
dateTime <- strptime(paste(dataFinal$Date, dataFinal$Time), "%d/%m/%Y %H:%M:%S")

# Plot
par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
with(dataFinal, {
        plot(dateTime, Global_active_power, type = "l", ylab = "Global Active Power", xlab = "")
        plot(dateTime, Voltage, type = "l", ylab = "Voltage", xlab = "datetime")
        plot(dateTime, Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
        lines(dateTime, Sub_metering_2, col = "red")
        lines(dateTime, Sub_metering_3, col = "blue")
        legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, bty = "n", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(dateTime, Global_reactive_power, type = "l", xlab = "datetime")
})

# Save into PNG file
dev.copy(device = png, width = 480, height = 480, file = "plot4.png")
dev.off()