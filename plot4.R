# Matt Narrell (mnarrell@gmail.com)
# plot4.R
#
# Draws the Plot 4 image.

library("dplyr")
library("ggplot2")

# Ensure our data frames are loaded
source("fetch_data.R")

# Find "coal combustion-related sources" from SCC
coal_scc_indexes <- grep("coal", SCC$Short.Name, ignore.case = TRUE)
coal_scc_data <- SCC[coal_scc_indexes, "SCC"]

# Cross reference which "coal combustion-related sources" are present in the NEI data set
coal_nei_indexes <- NEI$SCC %in% coal_scc_data
coal_nei_data <- NEI[coal_nei_indexes, ]

# Sum the Emissions of "coal combustion-related sources" per year
coal_nei_data <- coal_nei_data %>% 
  group_by(year) %>% 
  summarize(emissions_sum = sum(Emissions))

# Histogram of Emissions per year
png("plot4.png")
qplot(factor(year), emissions_sum, data = coal_nei_data, geom = c("bar"), stat = c("identity"), 
      main = expression("U.S. PM"[2.5] * " Emissions From Coal Sources by Year"), 
      ylab = "Total Emissions", xlab = "Year")
dev.off()
 
