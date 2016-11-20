# -------------------------------------------------------------------------------------------------------
#
# Coursera: Data Science Course - 4 Exploratory Data Analysis
# @author   Amir Hamzah Khalid
# @since    2016-11-19
#
# plot3.R File Description: Plot3
#
# This script will perform the following steps on the  UC Irvine Machine Learning Repository, 
# a popular repository for machine learning datasets downloaded from: 
# "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
#
# -------------------------------------------------------------------------------------------------------

# Clean up workspace
rm(list = ls(all = TRUE))

library(graphics)   # load R Graphic packages
library(grDevices)  # load R Graphic Devices and Support for Colours and Fonts
library(ggplot2)    # load R package to Create Elegant Data Visulaisations Using the Grammar of Graphics

# Set working directory to the location for the project
# [IMPORTANT] Please set your own workspace directory/location if you want to run this script
    setwd("~/Documents/Study/Data Science Specialization Course/4 Exploratory Data Analysis/Week 1/Project 1")

# Create Data folder in working directory if not exist
    if(!file.exists("./data")) { dir.create("./data") }

# Download zipfile into data folder
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileUrl, destfile = "./data/household_power_consumption.zip")

# Unzip dataSet to /data folder
    unzip(zipfile = "./data/household_power_consumption.zip", exdir = "./data")

# Reading all data from files
    files <- file('./data/household_power_consumption.txt')
    data <- read.table(text = grep("^[1,2]/2/2007",readLines(files),value=TRUE), sep = ';', 
                       col.names = c("Date", "Time", "Global_active_power", 
                                     "Global_reactive_power", "Voltage", 
                                     "Global_intensity", "Sub_metering_1", 
                                     "Sub_metering_2", "Sub_metering_3"), 
                       na.strings = '?')

# Close connection
    close(files)

# Plot3
    
    # Convert data and time to specific format
    data$Date <- as.Date(data$Date, format = '%d/%m/%Y')
    data$DateTime <- as.POSIXct(paste(data$Date, data$Time))

    # Open Devices
    if(!file.exists('figures')) dir.create('figures')
    png(filename = './figures/plot3.png', width = 480, height = 480, units='px')

    # Plot figure
    plot(data$DateTime, data$Sub_metering_1, 
         xlab = '', ylab = 'Energy sub metering', type = 'l')
    
    # Lines
    lines(data$DateTime, data$Sub_metering_2, col = 'red')
    lines(data$DateTime, data$Sub_metering_3, col = 'blue')
    
    # Legend
    legend('topright', col = c('black', 'red', 'blue'), 
           legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), 
           lwd = 1)

    # Close device
    dev.off()
