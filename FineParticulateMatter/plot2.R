# Loading provided datasets
NEI <- readRDS("c:/dev/data2/summarySCC_PM25.rds")
SCC <- readRDS("c:/dev/data2/Source_Classification_Code.rds")

Baltimore <- subset(NEI, fips == "24510")

totalPM25ByYear <- tapply(Baltimore$Emissions, Baltimore$year, sum)

# Generate the graph in the same directory as the source code
png(filename='c:/dev/data2/plot2.png')

plot(names(totalPM25ByYear), totalPM25ByYear, type = "l", xlab = "Year", 
     ylab = expression("Total" ~ PM[2.5] ~ "Emissions (tons)"),
     main = expression("Total Baltimore City" ~ PM[2.5] ~ "Emissions by Year"))

dev.off()
