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

reduced$Datetime <- as.POSIXct(paste(reduced$Date, reduced$Time), format="%m/%d/%Y %H:%M:%S")

png (filename = 'plot1.png', width =480, height = 480)
hist(reduced$Global_active_power, xlab = 'Global Active Power (kilowatts)', main='Global active Power', col="red", pin = c(480,480))
dev.off()

