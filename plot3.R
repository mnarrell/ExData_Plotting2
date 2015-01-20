# Matt Narrell (mnarrell@gmail.com)
# plot3.R
#
# Draws the Plot 3 image.

library("dplyr")
library("ggplot2")

# Ensure our data frames are loaded
source("fetch_data.R")

# Baltimore Emissions, totaled by type per year
agg <- NEI %>% 
  filter(fips == "24510") %>% 
  group_by(year, type) %>% 
  rename(Type = type, Year = year) %>% 
  summarize(emission_sum = sum(Emissions))

# Plot factored by year/type
png("plot3.png")
qplot(Year, emission_sum, data = agg, color = Type, geom = c("point", "line"), 
      ylab = expression("PM"[2.5] * " emissions in tons"), 
      main = expression("PM"[2.5] * " emission totals by type per year"))
dev.off() 
