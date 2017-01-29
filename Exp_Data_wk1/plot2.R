temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
unzip(temp) #unzips all to working dir

#colClasses to read in right format
cc <- c("Date" = "character", #keep as text for filtering
        "Time" = "character", 
        "Global_active_power" = "numeric",
        "Global_reactive_power" = "numeric",
        "Voltage"= "numeric",
        "Global_intensity" = "numeric",
        "Sub_metering_1" = "numeric",
        "Sub_metering_2" = "numeric",
        "Sub_metering_3" = "numeric")

#read unipped text file
power_data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, colClasses = cc, na.strings = "?")
library(dplyr) #for filter function to extract only the two days
Feb_data <- filter(power_data, Date == "1/2/2007" | Date == "2/2/2007")

#add extra column for formatted Date_Time
Feb_data$Date_Time <- strptime(paste(Feb_data$Date,Feb_data$Time), format = "%d/%m/%Y %H:%M:%S")

#Plot line plot
png("plot2.png", width=480, height=480)
plot(x = Feb_data$Date_Time, 
     y = Feb_data$Global_active_power, 
     type = "l",
     ylab = "Global Active Power (kilowatts)",
     xlab = ""
)
dev.off()



