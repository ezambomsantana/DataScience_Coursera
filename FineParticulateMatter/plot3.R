library(ggplot2)
library(plyr)

Baltimore <- subset(NEI, fips == "24510")

typePM25ByYear <- ddply(Baltimore, .(year, type), function(x) sum(x$Emissions))
colnames(typePM25ByYear)[3] <- "Emissions"

# Generate the graph in the same directory as the source code
png(filename='c:/dev/data2/plot3.png')

qplot(year, Emissions, data = typePM25ByYear, color = type, geom = "line") +
  ggtitle(expression("Baltimore City" ~ PM[2.5] ~ 
                       "Emissions by Source Type and Year")) + xlab("Year") +
  ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))

dev.off()
