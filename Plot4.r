# Read only the specified rows of the household_power_consumption.txt file
# into R, using the sqldf package

library(sqldf)

  HPCSelect <- read.csv.sql("household_power_consumption.txt", sql = "select * from file where Date in ('1/2/2007', '2/2/2007')", header = TRUE, sep = ";")

# Load packages to further manipulate data

library(plyr); library(dplyr); library(tidyr); library(lubridate);

# Load the data into a 'data frame tbl' or 'tbl_df'

  ihepc <- tbl_df(HPCSelect)

# Convert Date & Time columns, currently factors, to class Date & Time

  ihepc$Date_Time <- dmy_hms(paste(ihepc$Date, ihepc$Time))

  dmy(ihepc$Date)
  hms(ihepc$Time)

# Extract specific name of the weekdays

Day <- wday(ihepc$Date_Time, label = TRUE)

# Open the PNG Device

  png("plot4.png", width = 480, height = 480)

# Create Multiple Base Plots

par(mfcol = c(2,2), mar = c(4, 4, 2, 1))
with(ihepc, {
  
  plot(Date_Time, Global_active_power, type = "l", col = "black", xlab = "", ylab = "Global Active Power (kilowatts)")
  
  plot(Date_Time, Sub_metering_1, type = "l", col = "black", xlab = "", ylab = "Energy sub metering") 
  lines(Date_Time, Sub_metering_2, col = "red")
  lines(Date_Time, Sub_metering_3, col = "blue")
  legend("topright", bty = "n", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), pch = 45, lwd = 1, col = c("black", "red", "blue"))
  
  plot(Date_Time, Voltage, type = "l", col = "black", xlab = "datetime", ylab = "Voltage")
  
  plot(Date_Time, Global_reactive_power, type = "l", col = "black", xlab = "datetime", ylab = "Global_reactive_power")
  
})

dev.off() # Close the PNG device