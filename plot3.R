# Common Setup Functions Used
# getwd()
# setwd("C:/Users/zacks/OneDrive/Documents/datascience/3_ExploratoryDataAnalysis/Assignment2/ExData2")
# rm(list=ls())

library(ggplot2)
library(tidyr)
library(dplyr)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Checking Data loaded
str(NEI)
head(NEI)


#Plot 3
NEI_24510 <- NEI[NEI$fips == "24510",4:6]

# Grouping emmissions by year
EmissionsByYear <- aggregate(Emissions ~ year, NEI_24510, sum)

types <- unique(NEI_24510$type)

EmissionsByType <- NEI_24510 %>% group_by(type,year) %>% summarize_all(funs(sum))

qplot(year, Emissions, data = EmissionsByType, facets = type~.)

g <- ggplot(data=EmissionsByType,aes(year,Emissions)) 

g + geom_point() + facet_grid(type~.) + geom_smooth(method ="lm") +
  labs(x="Year", y=expression("Total PM"[2.5]*" Emissions")) +
  labs(title=expression("PM"[2.5]*" Emissions by Type, 1999-2008"))


#Save Graph to File
dev.copy(png, file = "plot3.png")
dev.off()

