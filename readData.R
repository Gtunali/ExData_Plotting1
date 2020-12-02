library(dplyr)
library(ggplot2)

readData <- function() {
  
    URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    zipname <- "exdata-data-household_powerData_consumption.zip"
    filename <- "household_power_consumption.txt"
    
    
    ## check if the .zip already downloaded and the file is extarced, if not download
    ## check if the .zip already downloaded
    if (!file.exists(zipname)){
      download.file(URL, zipname, method="curl")
    }  
    
    ## check if the file already unzipped
    if (!file.exists(filename)) { 
      unzip(zipname) 
    }
    
    mydata <- read.csv(filename, skip = 1, sep = ";", na.strings = "?")
    names(mydata) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage",
                     "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
  
    mydata <- subset(mydata, mydata$Date == "1/2/2007" | mydata$Date == "2/2/2007")
    mydata$Date <- as.Date(mydata$Date, format="%d/%m/%Y")
    mydata <- transform(mydata, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
}