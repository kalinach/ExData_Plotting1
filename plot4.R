Sys.setlocale("LC_TIME", "English") #so that dates do not appear in cyrillic

#Read the data while converting ? to NAs; then subset to get only 1 and 2 of Feb
powerdata <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")
Subpower <- powerdata[powerdata$Date %in% c("1/2/2007", "2/2/2007"), ]

#Combine date and time
Subpower$datetime <- paste(Subpower$Date, Subpower$Time)

#Format datetime column as POSIXlt
Subpower$datetime <- strptime(Subpower$datetime, "%d/%m/%Y %H:%M:%S")

#Format the Date column separately (Time col stays factor var)
Subpower$Date <- as.Date(Subpower$Date, "%d/%m/%Y")


#Create plot4 in PNG

par(mfrow = c (2,2))
par(mar = c(4,4,2,2))

##1
plot(Subpower$datetime, Subpower$Global_active_power, type="l", xlab = "", ylab="Global Active Power")

##2
plot(Subpower$datetime, Subpower$Voltage, type="l", xlab = "datetime", ylab="Voltage")

  ##3
plot(Subpower$datetime, Subpower$Sub_metering_1, type="l", xlab = NA, ylab = NA, col = "black")
lines(Subpower$datetime, Subpower$Sub_metering_2,type="l", xlab = NA, ylab = NA, col = "red")
lines(Subpower$datetime, Subpower$Sub_metering_3, type="l",xlab = NA, ylab = NA, col = "blue")
mtext(side = 1, "")
mtext(side = 2, "Energy sub metering", line=2, cex=0.8)
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=0.6)

##4
plot(Subpower$datetime, Subpower$Global_reactive_power, type="l", xlab = "datetime", ylab="Global_reactive_power")

##move to png and close
dev.copy(png, file = "plot4.png")
dev.off()