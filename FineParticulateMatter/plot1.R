# Loading provided datasets
NEI <- readRDS("c:/dev/data2/summarySCC_PM25.rds")
SCC <- readRDS("c:/dev/data2/Source_Classification_Code.rds")

totalPMByYear <- tapply(NEI$Emissions, NEI$year, sum)

# Generate the graph in the same directory as the source code
png(filename='c:/dev/data2/plot1.png')

  plot(names(totalPMByYear), totalPMByYear, type = "l",
     xlab = "Year", ylab = expression("Total" ~ PM[2.5] ~ "Emissions (tons)"),
     main = expression("Total US" ~ PM[2.5] ~ "Emissions by Year"))

dev.off()
