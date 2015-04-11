library(data.table)
# Read the data file, use the headers for names, NA strings are ?
data <- fread("household_power_consumption.txt", sep=";", header=TRUE,na.strings="?",stringsAsFactors=TRUE)
# Fix the date format
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
#subset the data to our two dates
subdata <- subset(data, as.Date(Date) == '2007-02-01' | as.Date(Date) == '2007-02-02')
png("plot1.png",width=480,height=480,units="px")
hist(as.numeric(subdata$Global_active_power), freq=TRUE, xlab="Global Active Power (kilowatts)", main="Global Active Power", col="red")
dev.off()