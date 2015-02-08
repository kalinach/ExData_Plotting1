
#Read the data while converting ? to NAs; then subset to get only 1 and 2 of Feb
powerdata <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")
Subpower <- powerdata[powerdata$Date %in% c("1/2/2007", "2/2/2007"), ]

#Combine date and time
Subpower$datetime <- paste(Subpower$Date, Subpower$Time)

#Format datetime column as POSIXlt
Subpower$datetime <- strptime(Subpower$datetime, "%d/%m/%Y %H:%M:%S")

#Format the Date column separately (Time col stays factor var)
Subpower$Date <- as.Date(Subpower$Date, "%d/%m/%Y")


#Create plot1 in PNG

hist(Subpower$Global_active_power, xlab = "Global Active Power (kilowatts)", main = "Global Active Power", col = "red")
dev.copy(png, file = "plot1.png")


