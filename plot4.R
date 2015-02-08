library(dplyr)
library(data.table)

# reading in the already "data munged" data set that we created in "plot1.R"

mydata <- tbl_df(read.csv("mydata.csv", stringsAsFactors = FALSE))

mydata <- mutate(mydata, date.time = (as.POSIXct(date.time)))


# Let's do some plotting and saving png file: Plot 4

par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

with(mydata, {
  plot(global.active.power ~ date.time, type="l", 
       ylab="Global Active Power", xlab="")
  
  plot(voltage ~date.time, type="l", 
       ylab="Voltage", xlab="")
  
  plot(sub.metering.1 ~ date.time, type="l",
       ylab="Energy sub metering", xlab="")
  lines(sub.metering.2 ~ date.time ,col='Red')
  lines(sub.metering.3~date.time,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  
  
  plot(global.reactive.power ~date.time, type="l", 
       ylab="Global_reactive_power",xlab="")
})


dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()