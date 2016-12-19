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
png(file="plot1.png",width=480,height=480)

#plot the required histogram
hist(ad$Global_active_power,col="red",xlab="Global Active Power(kilowatts)",main="Global Active Power")

#close connection to the graphical device
dev.off()