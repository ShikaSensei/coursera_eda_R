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
plot_imp_fp = file.path(plot_root, 'plot5.png')

# Create process data
# Extract point related to motor vehicles
mot_veh <- map %>% 
  filter(
    SCC.Level.One == 'Mobile Sources', 
    grepl('[hH]ighway Vehicle', SCC.Level.Two)) %>%
  select(SCC, SCC.Level.Two)
# Extract Baltimore point and merge with motor vehicle
balt_mv <- df %>%
  filter(fips == "24510") %>%
  merge(mot_veh) %>%
  mutate(
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
png(plot_imp_fp, width = 480, height = 480)
# Create plot
plt <- balt_mv %>% group_by(year, type) %>%
  summarise(Emissions = sum(Emissions)) %>%
  ggplot(aes(x=year, y=Emissions, fill=type)) +
  geom_col( position='dodge') +
  ggtitle('Motor vehicle emissions in Baltimore City, Maryland (1999-2008)')
print(plt)
# Close the device
dev.off()