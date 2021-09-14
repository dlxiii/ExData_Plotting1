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

# load file from subsets data for specified dates
powerDT <- data.table::fread(input = "household_power_consumption.txt", 
                             na.strings="?")

# Prevents histogram from printing in scientific notation
powerDT[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Change Date Column to Date Type
powerDT[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

# Filter Dates for 2007-02-01 and 2007-02-07
powerDT <- powerDT[(Date >= "2007-02-01") & (Date <= "2007-02-07")]

png("plot1.png", width=480, height=480)

## Plot 1
hist(powerDT[, Global_active_power], main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.off()