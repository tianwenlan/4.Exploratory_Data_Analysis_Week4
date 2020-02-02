library(ggplot2)
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
NEI_LA <- subset(NEI, fips=="06037")

data_baltimore <- merge(NEI_baltimore, SCC, by='SCC', all.x = TRUE, sort=FALSE)
data_LA <- merge(NEI_LA, SCC, by='SCC', all.x = TRUE, sort=FALSE)

data_baltimore_motor <- subset(data_baltimore, type =="ON-ROAD")
data_LA_motor <- subset(data_LA, EI.Sector %like% 'Mobile')



png(filename="plot6.png", width = 580, height = 480)


myplot<- ggplot()+ 
  stat_summary(data=data_baltimore_motor, mapping=aes(year, Emissions, color = "Baltimore"), fun.y = sum, na.rm = TRUE, geom ='point', size=5) +
  stat_summary(data=data_LA_motor, mapping=aes(year, Emissions, color = "LA"), fun.y = sum, na.rm = TRUE, geom ='point', size=5) +
  labs(title = "Total PM2.5 emission from Motors in Baltimore City vs Los Angeles")+ xlab('Year') + ylab('Total PM2.5 emission') +
  theme(legend.position = 'right') +scale_fill_discrete(name = '', labels = c("Baltimore", "Los Angeles"))

print(myplot)

dev.off()
