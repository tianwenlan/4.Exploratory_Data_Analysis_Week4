library(dplyr)
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
png(filename="plot2.png", width = 480, height = 480)

barplot(tapply(NEI_baltimore$Emissions, NEI_baltimore$year, FUN=sum), main = 'Total PM2.5 emission by year in Baltimore City', xlab='Year', ylab='Total PM2.5 emission', col="red")

dev.off()
