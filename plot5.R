library(ggplot2)
library(data.table)
#step 0: downlaod files

zipUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
zipFile <- "exdata_data_NEI_data.zip"

if (!file.exists(zipFile)) {
  download.file(zipUrl, zipFile, mode = "wb")
}

# unzip zip file containing data if data directory doesn't already exist
dataPath <- "exdata_data_NEI_data"
if (!file.exists(dataPath)) {
  unzip(zipFile)
}


#read the file
NEI <- readRDS("summarySCC_PM25.rds")
SCC <-readRDS('Source_Classification_Code.rds')

#make the plot

NEI_baltimore <- subset(NEI, fips=="24510")
data_baltimore <- merge(NEI_baltimore, SCC, by='SCC', all.x = TRUE, sort=FALSE)

data_baltimore_motor <- subset(data_baltimore, type =="ON-ROAD")

png(filename="plot5.png", width = 480, height = 480)

plot(tapply(data_baltimore_motor$Emissions, data_baltimore_motor$year, FUN=sum), cex = 4, main = 'Total PM2.5 emission from motor vehicles in Baltimore City', xlab='Year', ylab='Total PM2.5 emission', col="red")

dev.off()
