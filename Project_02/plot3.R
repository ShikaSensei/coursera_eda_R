if(!require(dplyr)) {
  install.packages('dplyr')
  library(dplyr)
}
if(!require(ggplot2)) {
  install.packages('ggplot2')
  library(ggplot2)
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
plot_imp_fp = file.path(plot_root, 'plot3.png')
# Process data
total <- df %>% 
  filter(fips == "24510") %>%
  group_by(year, type) %>% 
  summarise(emissions = sum(Emissions))
# Open PNG device
png(plot_imp_fp, width = 480, height = 480)
# Create plot
plt <-total %>%
  ggplot(aes(x=year, y=emissions, color=type)) +
  geom_line() +
  geom_point() +
  ggtitle("Emissions in Baltimore City, Maryland per sources' type (1999-2008)")
print(plt)
# Close the device
dev.off()