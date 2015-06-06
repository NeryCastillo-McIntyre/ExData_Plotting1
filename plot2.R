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

  png("plot2.png", width = 480, height = 480)

# Create a Line Plot

  plot(ihepc$Date_Time, ihepc$Global_active_power, type = "l", col = "black", xlab = "", ylab = "Global Active Power (kilowatts)")
  
dev.off() # Close the PNG device