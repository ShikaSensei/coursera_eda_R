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
plot_imp_fp = file.path(plot_root, 'plot6.png')

# Create process data
# Extract point related to motor vehicles
mot_veh <- map %>% 
  filter(
    SCC.Level.One == 'Mobile Sources', 
    grepl('[hH]ighway Vehicle', SCC.Level.Two)) %>%
  select(SCC, SCC.Level.Two)
# Filter for baltimore and LA, merge and modify
bal_la_mv <- df %>%
  filter(fips == "24510" | fips == "06037") %>%
  merge(mot_veh) %>%
  mutate(
    place = factor(recode(fips, '24510' = 'Baltimore City', 
                        '06037' = 'Los Angeles County')),
    type = paste(
      if_else(
        grepl('Highway', SCC.Level.Two), 
        'highway', 
        'off-highway'),
      if_else(
        grepl('Gasoline', SCC.Level.Two),
        'gasoline',
        'diesel')),
    year = factor(year))
  
# Open PNG device
png(plot_imp_fp, width = 1000, height = 1000)
# Create plot
plt <- bal_la_mv %>%
  ggplot(aes(x=year, y=Emissions, fill=place)) +
  geom_boxplot() +
  scale_y_log10() +
  ylab('Emissions (log scale)') +
  ggtitle('Motor vehicle emissions in Baltimore City and Los Angeles County (1999-2008)') +
  facet_wrap(.~type)
print(plt)
# Close the device
dev.off()