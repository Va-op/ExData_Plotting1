data <- read.table("C:/Users/hp/Desktop/household_power_consumption.txt", sep=";", header=TRUE, na.strings="?", stringsAsFactors=FALSE)
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
subset_data <- subset(data, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

# Remove rows with any missing values
subset_data <- na.omit(subset_data)

# Create a DateTime column
subset_data$DateTime <- as.POSIXct(paste(subset_data$Date, subset_data$Time), format="%Y-%m-%d %H:%M:%S")

# Ensure DateTime and Global_active_power have the same length
print(length(subset_data$DateTime))  # Should match
print(length(subset_data$Global_active_power))

# Plot
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))
plot(subset_data$DateTime, subset_data$Global_active_power, type="l", ylab="Global Active Power", xlab="")
plot(subset_data$DateTime, subset_data$Voltage, type="l", ylab="Voltage", xlab="datetime")
plot(subset_data$DateTime, subset_data$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
lines(subset_data$DateTime, subset_data$Sub_metering_2, col="red")
lines(subset_data$DateTime, subset_data$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1, bty="n")
plot(subset_data$DateTime, subset_data$Global_reactive_power, type="l", ylab="Global Reactive Power", xlab="datetime")
dev.off()

dev.off()