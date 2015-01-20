# Matt Narrell (mnarrell@gmail.com)
# fetch_data.R
#
# Prerequisite utility steps for each plot.

# If our common data frames arent present
if (!exists("NEI") || !exists("SCC")) {
  # If the source data files arent present
  if (!file.exists("./data/Source_Classification_Code.rds") || !file.exists("./data/summarySCC_PM25.rds")) {    
    dataSrcUri <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
    # Download the data files
    download.file(dataSrcUri, temp <- tempfile(), method = "curl")
    unzip(temp, exdir = "./data")
    unlink(temp)
    rm(temp)
}

# Read the data files into our common data frames
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")
} 
