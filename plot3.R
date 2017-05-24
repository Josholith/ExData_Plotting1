# Read in the data from flat file,
# filtered to only load the rows matching date condition.
# Prefiltering with shell pipe is much more space efficient
#  than loading the whole file followed by subsetting the frame.
data <- read.delim(pipe("head -n1 household_power_consumption.txt;
                         grep '^[1-2]/2/2007' household_power_consumption.txt")
                , sep = ";"
                , stringsAsFactors = FALSE
                , na.strings = "?")

# Combine the separate Date and Time columns into a single POSIXct called datetime
data$datetime <- as.POSIXct(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")

# Drop the original Date and Time columns
data <- subset(data, select = -c(Date, Time) )

# Open plot device so we will write to a PNG file
png("plot3.png", width=480, height=480)

# Make the plot
with(data, plot(datetime, Sub_metering_1, type="l", ylab="Energy sub metering", xlab="", col="black"))
with(data, lines(datetime, Sub_metering_2, type="l", ylab="Energy sub metering", xlab="", col="red"))
with(data, lines(datetime, Sub_metering_3, type="l", ylab="Energy sub metering", xlab="", col="blue"))
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = c(1,1,1), col=c("black","red","blue"))

# Close the plot device (write the PNG file)
dev.off()
