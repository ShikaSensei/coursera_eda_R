if(!require(dplyr)) {
  install.packages('dplyr')
  library(dplyr)
}
# Dataset path
dataset_fp = paste0('data', 
                       .Platform$file.sep, 
                       'household_power_consumption.txt')
# Read dataset
df <- read.csv2(dataset_fp, 
                stringsAsFactors = FALSE, 
                na.strings = '?')
# Create DataTime column
df$DateTime <- strptime(paste(df$Date, df$Time, sep='T'),
                        format = '%d/%m/%YT%H:%M:%S')
df <- subset(df, select = -c(Date, Time))
# Subset dataset for dates between 2007-02-01 and 2007-02-02
df <- filter(df, DateTime >= '2007-02-01', DateTime < '2007-02-03')
# Convert all columns except DateTime to numeric
df[, 1:7] <- sapply(df[, 1:7], as.numeric)