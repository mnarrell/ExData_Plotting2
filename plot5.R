# Matt Narrell (mnarrell@gmail.com)
# plot5.R
#
# Draws the Plot 5 image.

library("dplyr")
library("ggplot2")

# Ensure our data frames are loaded
source("fetch_data.R")

# Find "motor vehicle sources" from SCC.  Assumption is "Onroad".
onroad_scc_data <- subset(SCC, Data.Category == "Onroad")

# Cross reference which "motor vehicle sources" are present in the NEI data set
onroad_nei_indexes <- NEI$SCC %in% onroad_scc_data$SCC
onroad_nei_data <- NEI[onroad_nei_indexes, ]

# Sum the Emissions of "motor vehicle sources", for Baltimore City, per year
onroad_nei_baltimore_data <- onroad_nei_data %>% 
  filter(fips == "24510") %>% 
  group_by(year) %>% 
  summarize(emissions_sum = sum(Emissions))

# Plot an elaborate line graph of Emissions from Baltimore "motor vehicle sources" per Year
png("plot5.png")
g <- ggplot(onroad_nei_baltimore_data, aes(year, emissions_sum))
g <- g + ggtitle("Baltimore Emission Totals by Year")
g <- g + ylab(expression("Total PM"[2.5] * " Emissions (tons)"))
g <- g + xlab("Year")
g <- g + geom_text(aes(label = round(emissions_sum)), size = 4, vjust = -1, hjust = -0.5)
g <- g + geom_point(size = 3)
g <- g + geom_line(color = "darkgreen")
print(g)
dev.off() 
