library(data.table)
# Read the data file, use the headers for names, NA strings are ?
data <- fread("household_power_consumption.txt", sep=";", header=TRUE,na.strings="?",stringsAsFactors=TRUE)
# Fix the date format
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
#subset the data to our two dates
subdata <- subset(data, as.Date(Date) == '2007-02-01' | as.Date(Date) == '2007-02-02')
# Combine the dates
subdata$date_time<- paste(subdata$Date, subdata$Time)
# Start the png device
png("plot4.png",width=480,height=480,units="px")
# 2x2 of plots
par(mfrow =c(2,2))
#Global Active power (top left)
plot(x=as.POSIXct(subdata$date_time), y=as.numeric(subdata$Global_active_power), type="n", ylab = "Global Active Power", xlab="");
lines(as.POSIXct(subdata$date_time), subdata$Global_active_power)

#Voltage plot (top right)
plot(x=as.POSIXct(subdata$date_time), y=as.numeric(subdata$Voltage), type="n", ylab = "Voltage", xlab="datetime");
lines(as.POSIXct(subdata$date_time), subdata$Voltage)

#Sub Metering plot (bottom left)
plot(x=as.POSIXct(subdata$date_time), y=as.numeric(subdata$Sub_metering_1), type="n", ylab = "Energy sub metering", xlab="")
lines(as.POSIXct(subdata$date_time), subdata$Sub_metering_1,col="black")
lines(as.POSIXct(subdata$date_time), subdata$Sub_metering_2,col="red")
lines(as.POSIXct(subdata$date_time), subdata$Sub_metering_3,col="blue")
legend("topright", col = c("black","red","blue"), bty="n", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), pch = c('-','-','-'), lwd=c(2.5,2.5,2.5), lty=c(1,1,1))

#plot for bottom right
plot(x=as.POSIXct(subdata$date_time), y=as.numeric(subdata$Global_reactive_power), type="n", ylab = "Global_reactive_power", xlab="datetime");
lines(as.POSIXct(subdata$date_time), subdata$Global_reactive_power)
dev.off()




dev.off()
