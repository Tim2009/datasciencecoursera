#Coursera Data Science - Exploratory Data Analysis Assignment
#Plot 6 - Vehicle Emissions from motor vehicle sources in LA county and Baltimore over time
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip data source

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip","exdata%2Fdata%2FNEI_data.zip")
dateDownloaded <- date()


unzip("exdata%2Fdata%2FNEI_data.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(dplyr)
library(data.table)

Balt_NEI <- filter(NEI, NEI$fips == "24510") #Baltimore city
LAC_NEI <- filter(NEI, NEI$fips == "06037") #LA County

Motor_Vehicles <- filter(SCC, grepl("Vehicles", SCC.Level.Two))#includes off highway vehicles (ie not onroad type)
Motor_Vehicles_SCC <- as.character(unique(Motor_Vehicles$SCC)) #list of valid SCC codes

Balt_Vehicles <- filter(Balt_NEI, SCC %in% Motor_Vehicles_SCC)
LAC_Vehicles <- filter(LAC_NEI, SCC %in% Motor_Vehicles_SCC)

by_year_Balt_Vehicle <- group_by(Balt_Vehicles, year)
total_by_year_Balt_Vehicle <- summarize(by_year_Balt_Vehicle, sum(Emissions))

by_year_LAC_Vehicle <- group_by(LAC_Vehicles, year)
total_by_year_LAC_Vehicle <- summarize(by_year_LAC_Vehicle, sum(Emissions))

png("plot6.png", width=480, height=480)
par(mfrow = c(2,1))
plot(total_by_year_Balt_Vehicle$year, total_by_year_Balt_Vehicle$`sum(Emissions)`,
     type = "l",
     ylab = "Baltimore Vehicle Emissions",
     xlab = "Year") 
text(total_by_year_Balt_Vehicle$year, total_by_year_Balt_Vehicle$`sum(Emissions)`, 
     format(total_by_year_Balt_Vehicle$`sum(Emissions)`, digits = 4))
plot(total_by_year_LAC_Vehicle$year, total_by_year_LAC_Vehicle$`sum(Emissions)`,
     type = "l",
     ylab = "LA County Vehicle Emissions",
     xlab = "Year")
text(total_by_year_LAC_Vehicle$year, total_by_year_LAC_Vehicle$`sum(Emissions)`, 
     format(total_by_year_LAC_Vehicle$`sum(Emissions)`, digits = 4))      

dev.off()