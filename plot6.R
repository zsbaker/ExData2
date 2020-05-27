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


#Plot 6
# Get all vehicle related sources
SCC_auto <- SCC[grepl(" Vehicle",SCC$EI.Sector) == TRUE,]

# Merge Datasets
NEI_auto <- merge(NEI, SCC_auto, by=c("SCC"))

# Baltimore only vehicles
NEI_subset2 <- NEI_auto[NEI_auto$fips == c("24510","06037"), c("fips","Emissions","year")]

# Grouping emissions by year

EmissionsByArea <- NEI_subset2 %>% group_by(fips,year) %>% summarize_all(funs(sum))

#Change Fips names 
area_names <- c("06037" = "LA","24510" = "Baltimore")

# levels(EmissionsByArea$fips)

area_name_labeller <- function(variable, value){
  return(area_names[value])
}

g <- ggplot(data=EmissionsByArea,aes(year,Emissions)) 

g + geom_point() + facet_grid(.~fips, labeller = labeller(fips = area_names)) + geom_smooth(method ="lm") +
  labs(x="Year", y=expression("Total PM"[2.5]*" Emissions")) +
  labs(title=expression("PM"[2.5]*" Vehicle Emissions in LA & Baltimore, 1999-2008"))

#Save Graph to File
dev.copy(png, file = "plot6.png")
dev.off()

