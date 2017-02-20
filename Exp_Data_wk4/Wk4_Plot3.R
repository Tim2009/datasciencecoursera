


#Coursera Data Science - Exploratory Data Analysis Assignment
#Plot 3 - ggplot 4 panel of each "type" of emissions in Baltimore city over time
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip data source

#Check that this download works with 
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip","exdata%2Fdata%2FNEI_data.zip")
dateDownloaded <- date()


unzip("exdata%2Fdata%2FNEI_data.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(dplyr)
library(data.table)

Balt_NEI <- filter(NEI, NEI$fips == "24510") #24510 is Baltimore city
by_year_Balt <- group_by(Balt_NEI, year)

Balt_table <- data.table(Balt_NEI) #using data table package
Balt_table[, Total:=sum(Emissions), by=list(type, year)]

balt_plot <- ggplot(DT, aes(x=year, y = Total)) + geom_point(shape = 1) + geom_line()
balt_plot + facet_grid(type ~ .) #gives 4 panels/facets

png("plot3.png", width=480, height=480)
balt_plot <- ggplot(DT, aes(x=year, y = Total)) + geom_point(shape = 1) + geom_line()
balt_plot + facet_grid(type ~ .) #gives 4 panels/facets
dev.off()

