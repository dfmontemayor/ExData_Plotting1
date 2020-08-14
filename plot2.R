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
with(dataFinal, plot(dateTime, Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab=""))

# Save into PNG file
dev.copy(device = png, width = 480, height = 480, file = "plot2.png")
dev.off()