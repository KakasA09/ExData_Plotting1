library(downloader)
library(dplyr)
library(data.table)

#Setting working directory
setwd("~/Documents/Coursera/Exploratory Data Analysis/ExData_Plotting1")

#Downloading full data set from the internet
my.url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.data <- download(my.url, dest="project1.zip", mode="wb") 

#unzip it
unzip.things <- unzip("project1.zip", exdir = "./")

#convert the loaded data into a table class, allowing for easier manipulation (using dplyr package)
#using the "fread" function enables for much, much, much faster reading of large files

data <- tbl_dt(fread("household_power_consumption.txt")) 

# subsetting the data for only the dates that we will be using
# adding a new "POSIXct" format data variable that merges date and time together
# changing the character variables into numeric ones, and renaming the column names to all lowercase (which I prefer)
# write out the subsetted "mydata" as csv file, so we can easily read it in for subsequent plots (Plots 2, 3 and 4)

mydata <- mutate(data, Date = as.Date(data$Date, format="%d/%m/%Y")) %>% 
        filter(Date >= "2007-02-01" & Date <= "2007-02-02") %>%   
          mutate(date.time = as.POSIXct(paste(as.Date(Date), Time)),
                 Global_active_power= as.numeric(Global_active_power),
                 Global_reactive_power = as.numeric(Global_reactive_power),
                 Voltage = as.numeric(Voltage),
                 Global_intensity = as.numeric(Global_intensity),
                 Sub_metering_1 = as.numeric(Sub_metering_1),
                 Sub_metering_2 = as.numeric(Sub_metering_2),
                 Sub_metering_3 = as.numeric(Sub_metering_3)) %>% select(-c(Date, Time)) %>%
        rename(global.active.power = Global_active_power,
               global.reactive.power =Global_reactive_power,
               voltage = Voltage, global.intensity = Global_intensity,
               sub.metering.1 = Sub_metering_1, sub.metering.2 = Sub_metering_2,
               sub.metering.3 = Sub_metering_3)


# remove the massive file from my working directory, so it does not clutter the memory
rm(data)

# write out the "data munged" mydata file as a csv, so we can read it in later on for the subsequent plots (2,3,4)
mydata.file <- write.csv(mydata, file = "mydata.csv", row.names = FALSE)


# Let's do some plotting and saving png file: Plot 1
hist(mydata$global.active.power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()





