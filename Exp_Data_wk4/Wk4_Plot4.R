#Coursera Data Science - Exploratory Data Analysis Assignment
#Plot 4 - Emissions from coal combustion sources over time
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip data source

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip","exdata%2Fdata%2FNEI_data.zip")
dateDownloaded <- date()


unzip("exdata%2Fdata%2FNEI_data.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(dplyr)
library(data.table)

Coal_Comb <- filter(SCC, grepl("Coal", EI.Sector)) #anything with Coal in EI.Sector
Coal_ID <- Coal_Comb$SCC
Coal_ID <- as.character((Coal_ID))
Coal_Emis <- filter(NEI, SCC %in% Coal_ID)
by_year_Coal <- group_by(Coal_Emis, year)
total_year_coal <- summarize(by_year_Coal, sum(Emissions))


png("plot4.png", width=480, height=480)
plot(total_year_coal,
     type = "l",
     ylab = "Total Coal Combustion Emissions",
     xlab = "Year"
)
dev.off()

