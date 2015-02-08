library(dplyr)
library(data.table)

# reading in the already "data munged" data set that we created in "plot1.R"

mydata <- tbl_df(read.csv("mydata.csv", stringsAsFactors = FALSE))

mydata <- mutate(mydata, date.time = (as.POSIXct(date.time)))


# Let's do some plotting and saving png file: Plot 3
with(mydata, {
  plot(sub.metering.1 ~ date.time, type="l",
       ylab="Energy sub metering", xlab="")
  lines(sub.metering.2 ~ date.time ,col='Red')
  lines(sub.metering.3~date.time,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()