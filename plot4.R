# Common Setup Functions Used
# getwd()
# setwd("C:/Users/zacks/OneDrive/Documents/datascience/3_ExploratoryDataAnalysis/Assignment2/ExData2")
# rm(list=ls())

library(ggplot2)
library(tidyr)
library(dplyr)
library(readr)
library(data.table)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Checking Data loaded
str(NEI)
head(NEI)


#Plot 4
# Get all coal related sources
SCC_coal <- SCC[grepl(" Coal",SCC$Short.Name) == TRUE,1]

NEI_coal <- NEI[NEI$SCC == SCC_coal,c(4,6)]

# Grouping emissions by year
EmissionsByYear <- aggregate(Emissions ~ year, NEI_coal, sum)


barplot(height=EmissionsByYear$Emissions, names.arg=EmissionsByYear$year, yaxt="n",
        xlab="Year", ylab=expression('Total Emissions (in 000s)'),main=expression('Aggregated PM'[2.5]*' Emissions by Year from Coal'), col=rainbow(4))
# Adjusting the y axis (2) to include comma notation

axis(2, axTicks(2), format(axTicks(2), scientific = F, big.mark = ","))


#Save Graph to File
dev.copy(png, file = "plot4.png")
dev.off()
