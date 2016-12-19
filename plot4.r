#read the household power consumption table into memory
mydata<- read.table("household_power_consumption.txt",sep=";",header=TRUE,stringsAsFactors = FALSE)

#create a subset with the dates under scrutiny 
ad <- subset(mydata,Date %in% c("1/2/2007","2/2/2007"))

#convert the character fields to numeric to ensure that they are read properly
ad[,3:9] <- lapply(ad[,3:9],as.numeric)

#initialize the lubridate package(install first if necessary)
library(lubridate)

#join and convert the date and time fields to a valid datetime object using lubridate
ad$date_time <- dmy_hms(paste(ad$Date,ad$Time))

#open a png graphical device
png(file="plot4.png",width=480,height=480)

#create the layout
par(mfrow=c(2,2))

#plot the first chart
plot(ad$date_time,ad$Global_active_power,type="l",xlab = "",ylab = "Global Active Power (kilowatts)",main="")

#plot the second chart
plot(ad$date_time, ad$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")

#plot the third chart
plot(ad$date_time,ad$Sub_metering_1,type="l",ylab = "Energy sub metering",xlab="",main="")
points(ad$date_time,ad$Sub_metering_2,type="l",col="red")
points(ad$date_time,ad$Sub_metering_3,type="l",col="blue")
legend("topright", lty = c(1,1,1), lwd = c(2,2,2), col = c("black", "red", "blue"),legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#plot the fourth chart
plot(ad$date_time, ad$Global_reactive_power,type = "l", ylab = "Global reactive power", xlab = "datetime")

#close connection to the graphical device
dev.off()