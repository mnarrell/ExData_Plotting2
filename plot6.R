# Matt Narrell (mnarrell@gmail.com)
# plot6.R
#
# Draws the Plot 6 image.

library("dplyr")
library("ggplot2")

# Ensure our data frames are loaded
source("fetch_data.R")

# Find "motor vehicle sources" from SCC.  Assumption is "Onroad".
onroad_scc_data <- subset(SCC, Data.Category == "Onroad")

# Cross reference which "motor vehicle sources" are present in the NEI data set
onroad_nei_indexes <- NEI$SCC %in% onroad_scc_data$SCC
onroad_nei_data <- NEI[onroad_nei_indexes, ]

# Sum the Emissions of "motor vehicle sources", for Baltimore and Los Angeles, per year
nei_data <- onroad_nei_data %>% 
  filter(fips == "24510" | fips == "06037") %>% 
  group_by(fips, year) %>% 
  summarize(emissions_sum = sum(Emissions)) %>%   
  # Add a city label for convenience
  mutate(city = ifelse(fips == "24510", "Baltimore", "Los Angeles"))

# Plot two panels of histograms contrasting total Emissions per year of Baltimore against Los Angeles
png("plot6.png")
g <- ggplot(nei_data, aes(factor(year), emissions_sum))
g <- g + facet_grid(. ~ city)
g <- g + geom_bar(aes(fill = year), stat = "identity")
g <- g + ggtitle("Emission Totals by Year for Baltimore and Los Angeles")
g <- g + ylab(expression("Total PM"[2.5] * " Emissions (tons)"))
g <- g + xlab("Year")
g <- g + theme_bw() + theme(legend.position = "none")
print(g) 
dev.off()
