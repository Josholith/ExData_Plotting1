# Read in the data from flat file.
data <- read.delim(file = "household_power_consumption.txt"
                 , sep = ";"
                 , stringsAsFactors = FALSE
                 , na.strings = "?")

# Combine the separate Date and Time columns into a single POSIXct called datetime
data$datetime <- as.POSIXct(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")

# Drop the original Date and Time columns
data <- subset(data, select = -c(Date, Time) )
