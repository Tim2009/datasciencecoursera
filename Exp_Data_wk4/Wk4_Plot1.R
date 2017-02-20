#Coursera Data Science - Exploratory Data Analysis Assignment
#Plot1 - all source emission levels over time
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip data source

#Check that this download works with 
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip","exdata%2Fdata%2FNEI_data.zip")
dateDownloaded <- date()

unzip("exdata%2Fdata%2FNEI_data.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#Plot year summary for better picture of trends (reduces outlier effects)
library(dplyr)
by_year_NEI <- group_by(NEI, year)
total_by_year <- summarize(by_year_NEI, sum(Emissions))
png("plot1.png", width=480, height=480)
plot(total_by_year, 
     type = "l",
     ylab = "Total Emissions",
     xlab = "Year"
)
dev.off()