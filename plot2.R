# Matt Narrell (mnarrell@gmail.com)
# plot2.R
#
# Draws the Plot 2 image.

library("dplyr")

# Ensure our data frames are loaded
source("fetch_data.R")

# Sum Baltimore Emissions by Year
agg <- NEI %>% 
  filter(fips == "24510") %>% 
  group_by(year) %>% 
  summarize(emissions_sum = sum(Emissions))

# Scatter plot with trend line
png("plot2.png")
par(mar = c(6, 6, 4, 4))
plot(agg, main = expression("Baltimore City PM"[2.5] * " emissions by year"), 
     xlab = "Year", 
     ylab = expression("Baltimore City PM"[2.5] * " emissions in tons"))
abline(lm(agg$emissions_sum ~ agg$year))
dev.off() 
