#Coursera Data Science - Exploratory Data Analysis Assignment
#Plot 5 - Baltimore Emissions from motor vehicles sources over time
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip data source

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip","exdata%2Fdata%2FNEI_data.zip")
dateDownloaded <- date()


unzip("exdata%2Fdata%2FNEI_data.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(dplyr)
library(data.table)

Balt_NEI <- filter(NEI, NEI$fips == "24510")

Motor_Vehicles <- filter(SCC, grepl("Vehicles", SCC.Level.Two)) #includes off highway vehicles (ie not onroad type)
Motor_Vehicles_SCC <- as.character(unique(Motor_Vehicles$SCC)) #list of valid SCC codes


Balt_Vehicles <- filter(Balt_NEI, SCC %in% Motor_Vehicles_SCC)

by_year_Balt_Vehicle <- group_by(Balt_Vehicles, year)
total_by_year_Balt_Vehicle <- summarize(by_year_Balt_Vehicle, sum(Emissions))

png("plot5.png", width=480, height=480)
plot(total_by_year_Balt_Vehicle$year, total_by_year_Balt_Vehicle$`sum(Emissions)`,
     type = "l",
     ylab = "Baltimore Vehicle Emissions",
     xlab = "Year") 
dev.off()