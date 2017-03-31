# Loading provided datasets
NEI <- readRDS("c:/dev/data2/summarySCC_PM25.rds")
SCC <- readRDS("c:/dev/data2/Source_Classification_Code.rds")

Baltimore <- subset(NEI, fips == "24510" & type=="ON-ROAD")

BaltimoreByYear <- ddply(Baltimore, .(year), 
                               function(x) sum(x$Emissions))

colnames(BaltimoreByYear)[2] <- "Emissions"




png(filename='c:/dev/data2/plot5.png')
  qplot(year, Emissions, data=BaltimoreByYear, geom="line") +
  ggtitle(expression("Baltimore City" ~ PM[2.5] ~ "Motor Vehicle Emissions
                     by Year")) + xlab("Year") + ylab(expression("Total" ~ PM[2.5] ~ 
                                                                   "Emissions (tons)"))
dev.off()
