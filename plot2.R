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
png("plot2.png",width=480,height=480,units="px")
#Do the plotting, convert the data type of date_time to POSIX
plot(x=as.POSIXct(subdata$date_time), y=as.numeric(subdata$Global_active_power), type="n", ylab = "Global Active Power (kilowatts)", xlab="")
# Add the lines
lines(as.POSIXct(subdata$date_time), subdata$Global_active_power,col="black")
dev.off()