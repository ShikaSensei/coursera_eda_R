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
plot_imp_fp = file.path(plot_root, 'plot1.png')
# Open PNG device
png(plot_imp_fp, width = 480, height = 480)
# Process data
total <- df %>% 
  group_by(year) %>% 
  summarise(emissions = sum(Emissions))
# Create plot
barplot(total$emissions,
        names.arg = total$year,
        xlab = 'Year',
        ylab = 'Total Emissions',
        main = 'Total Emissions in USA (1999-2008)',
        col = 'red4')
# Close the device
dev.off()