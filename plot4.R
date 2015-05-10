if (!file.exists("household_power_consumption.zip"))
{
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile='household_power_consumption.zip')
}
z <- read.table(unz("household_power_consumption.zip", "household_power_consumption.txt"), 
                header = T, 
                stringsAsFactors = F, 
                sep=';', 
                na.strings = '?'
                )
reduced <- z [ z$Date %in% c('1/2/2007', '2/2/2007'), ]
z <- NULL

reduced$Datetime <- as.POSIXct(paste(reduced$Date, reduced$Time), format="%d/%m/%Y %H:%M:%S")

png (filename = 'plot4.png', width =480, height = 480)
par(mfcol = c(2,2))
plot (reduced$Datetime, reduced$Global_active_power, type="n", main="", xlab="", ylab="Global Active Power (kilowatts)")
lines (reduced$Datetime, reduced$Global_active_power)

plot (reduced$Datetime, reduced$Sub_metering_1, type="l", main="", xlab="", ylab="Emergency sub metering")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black","red","blue"), lty=c(1,1,1))
lines (reduced$Sub_metering_1, reduced$Global_active_power, col="black")
lines (reduced$Datetime, reduced$Sub_metering_2, col="red")
lines (reduced$Datetime, reduced$Sub_metering_3, col="blue")

plot(reduced$Datetime, reduced$Voltage, type='l', ylab = 'voltage', xlab="datetime")

plot (reduced$Datetime, reduced$Global_reactive_power, type="l", main="", xlab="datetime", ylab="Global Reactive Power")
dev.off()

