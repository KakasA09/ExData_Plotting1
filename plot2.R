library(dplyr)
library(data.table)

# reading in the already "data munged" data set that we created in "plot1.R"

mydata <- tbl_df(read.csv("mydata.csv", stringsAsFactors = FALSE))

mydata <- mutate(mydata, date.time = (as.POSIXct(date.time)))


# Let's do some plotting and saving png file: Plot 2

plot(mydata$global.active.power ~ mydata$date.time, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()