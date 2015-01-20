# Matt Narrell (mnarrell@gmail.com)
# plot1.R
#
# Draws the Plot 1 image.

library("dplyr")

# Ensure our data frames are loaded
source("fetch_data.R")

# Sum Emissions by year
agg <- NEI %>% 
  group_by(year) %>% 
  summarize(emissions_sum = sum(Emissions))

# Scatter plot, with trend line
png("plot1.png")
par(mar = c(6, 6, 4, 4))
plot(agg, main = expression("PM"[2.5] * " emissions by year"), 
     xlab = "Year", 
     ylab = expression("PM"[2.5] * " emissions in tons"))
abline(lm(agg$emissions_sum ~ agg$year))
dev.off() 
