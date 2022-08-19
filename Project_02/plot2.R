if(!require(dplyr)) {
  install.packages('dplyr')
  library(dplyr)
}
# Download and unzip dataset
source('download_dataset.R')
# Read data set to df variable
source('read_dataset.R')
# Root folder to save the plot
plot_root = 'generated_plots'
if (! dir.exists(plot_root)) {
  dir.create(plot_root,
             recursive = TRUE)
}
# Path to image this script will create
plot_imp_fp = file.path(plot_root, 'plot2.png')
# Open PNG device
png(plot_imp_fp, width = 480, height = 480)
# Process data
total <- df %>% 
  filter(fips == "24510") %>%
  group_by(year) %>% 
  summarise(emissions = sum(Emissions))
# Create plot
plot(total$year, 
     total$emissions,
     type = 'b',
     xlab = 'Year',
     ylab = 'Total Emissions',
     main = 'Total Emissions in Baltimore City, Maryland (1999-2008)',
     ylim = c(0, max(total$emissions)),
     pch = 19,
     lwd = 2,
     col = 'orangered4')

# Close the device
dev.off()