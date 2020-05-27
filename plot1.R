

# Common Setup Functions Used
# getwd()
# setwd("C:/Users/zacks/OneDrive/Documents/datascience/3_ExploratoryDataAnalysis/Assignment2/ExData2")
# rm(list=ls())


## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Checking Data loaded
str(NEI)
head(NEI)


#Plot 1
# Grouping emmissions by year
EmissionsByYear <- aggregate(Emissions ~ year, NEI, sum)


barplot(height=EmissionsByYear$Emissions/1000, names.arg=EmissionsByYear$year, yaxt="n",
        xlab="Year", ylab=expression('Total Emissions (in 000s)'),main=expression('Aggregated PM'[2.5]*' Emissions by Year'), col=rainbow(4))

# Adjusting the y axis (2) to include comma notation
axis(2, axTicks(2), format(axTicks(2), scientific = F, big.mark = ","))

#Save Graph to File
dev.copy(png, file = "plot1.png")
dev.off()











