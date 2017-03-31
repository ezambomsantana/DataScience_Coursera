# Loading provided datasets
NEI <- readRDS("c:/dev/data2/summarySCC_PM25.rds")
SCC <- readRDS("c:/dev/data2/Source_Classification_Code.rds")

CoalCombustionSCC <- subset(SCC, EI.Sector %in% c("Fuel Comb - 
                            Comm/Institutional - Coal",
                                                  "Fuel Comb - Electric Generation - Coal",
                                                  "Fuel Comb - Industrial Boilers, ICEs - Coal"))
# Compare to Short.Name matching both Comb and Coal
CoalCombustionSCC1 <- subset(SCC, grepl("Comb", Short.Name) & grepl("Coal", 
                                                                    Short.Name))

nrow(CoalCombustionSCC)

CoalCombustionSCCCodes <- union(CoalCombustionSCC$SCC, CoalCombustionSCC1$SCC)


CoalCombustion <- subset(NEI, SCC %in% CoalCombustionSCCCodes)

coalCombustionPM25ByYear <- ddply(CoalCombustion, .(year, type), function(x) 
  sum(x$Emissions))
colnames(coalCombustionPM25ByYear)[3] <- "Emissions"


png(filename='c:/dev/data2/plot4.png')
  qplot(year, Emissions, data = coalCombustionPM25ByYear, color = type, 
      geom = "line") + ggtitle(expression("Coal Combustion" ~ PM[2.5] ~ 
                                            "Emissions by Source Type and Year")) + xlab("Year") + 
  ylab(expression  ("Total" ~ PM[2.5] ~ "Emissions (tons)"))
dev.off()
