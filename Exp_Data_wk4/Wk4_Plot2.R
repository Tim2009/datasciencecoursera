#Coursera Data Science - Exploratory Data Analysis Assignment
#Plot2 - all source emission levels over time in Baltimore city
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip data source

#Check that this download works with 
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip","exdata%2Fdata%2FNEI_data.zip")
dateDownloaded <- date()


unzip("exdata%2Fdata%2FNEI_data.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(dplyr)

Balt_NEI <- filter(NEI, NEI$fips == "24510") #24510 is Baltimore city
by_year_Balt <- group_by(Balt_NEI, year)

png("plot2.png", width=480, height=480)
plot(total_by_year_Balt, ylab = "Total Baltimore Emissions")
abline(lm(total_by_year_Balt$`sum(Emissions)` ~ total_by_year_Balt$year))
dev.off()

