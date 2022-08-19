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
plot_imp_fp = file.path(plot_root, 'plot4.png')

# Create process data
# Extract point related to coal fuel combustion and merge with dataset
comb_coal <- map %>%
  filter(grepl('Fuel Comb', EI.Sector) & grepl('Coal', EI.Sector)) %>%
  select(SCC, EI.Sector, SCC.Level.One, 
         SCC.Level.Two, SCC.Level.Three, SCC.Level.Four) %>%
  merge(df) %>%
  mutate(year = factor(year))
# Open PNG device
png(plot_imp_fp, width = 1000, height = 500)
# Create plot
plt <- comb_coal %>% ggplot(aes(y=Emissions, fill=year)) +
  geom_boxplot() +
  facet_wrap(.~SCC.Level.Two) +
  scale_y_log10() +
  ggtitle('Coal combustion-related emissions in USA (1999-2008)') +
  theme(axis.ticks.x = element_blank(),
        axis.text.x = element_blank()) +
  ylab('Emissions (log scale)')
print(plt)
# Close the device
dev.off()