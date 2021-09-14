# Peer-graded Assignment: Peer-graded Assignment: Course Project 1
# 2021-09-14 18:15:51 JST
# By Yulong Wang

setwd("/Users/yulong/GitHub/ExData_Plotting1")

# load packages
library("data.table")

# fetch raw data
path <- getwd()
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, file.path(path, "exdata_data_household_power_consumption.zip"))
unzip(zipfile = "exdata_data_household_power_consumption.zip")

#Reads in data from file then subsets data for specified dates
powerDT <- data.table::fread(input = "household_power_consumption.txt", 
                             na.strings="?")

# Prevents Scientific Notation
powerDT[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Making a POSIXct date capable of being filtered and graphed by time of day
powerDT[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filter Dates for 2007-02-01 and 2007-02-02
powerDT <- powerDT[(dateTime >= "2007-02-01") & (dateTime < "2007-02-02")]

png("plot2.png", width=480, height=480)

## Plot 2
plot(x = powerDT[, dateTime]
     , y = powerDT[, Global_active_power]
     , type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()