# Loading provided datasets
NEI <- readRDS("c:/dev/data2/summarySCC_PM25.rds")
SCC <- readRDS("c:/dev/data2/Source_Classification_Code.rds")

MV <- subset(NEI, (fips == "24510" | fips == "06037") & type=="ON-ROAD")
MV <- transform(MV, region = ifelse(fips == "24510", "Baltimore City", "Los Angeles"))

MVPM25ByYearAndRegion <- ddply(MV, .(year, region), function(x) 
  sum(x$Emissions))

colnames(MVPM25ByYearAndRegion)[3] <- "Emissions"

# Create a plot normalized to 1999 levels to better show change over time
Balt1999Emissions <- subset(MVPM25ByYearAndRegion, year == 1999 & 
                              region == "Baltimore City")$Emissions
LAC1999Emissions <- subset(MVPM25ByYearAndRegion, year == 1999 & 
                             region == "Los Angeles County")$Emissions
MVPM25ByYearAndRegionNorm <- transform(MVPM25ByYearAndRegion,
                                       EmissionsNorm = ifelse(region == 
                                                                "Baltimore City",
                                                              Emissions / Balt1999Emissions,
                                                              Emissions / LAC1999Emissions))
png(filename='c:/dev/data2/plot6.png')
qplot(year, EmissionsNorm, data=MVPM25ByYearAndRegionNorm, geom="line", 
      color=region) + ggtitle(expression("Total" ~ PM[2.5] ~
                                           "Motor Vehicle Emissions Normalized to 1999 Levels")) + xlab("Year") +
  ylab(expression("Normalized" ~ PM[2.5] ~ "Emissions"))
dev.off()
