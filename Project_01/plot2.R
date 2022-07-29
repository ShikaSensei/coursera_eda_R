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
plot_imp_fp = paste(plot_root, 'plot2.png', sep = .Platform$file.sep)
# Open PNG device
png(plot_imp_fp, width = 480, height = 480)
# Create plot 
with(df, {
  plot(DateTime, 
       Global_active_power, 
       type = "S",
       xlab = "",
       ylab = "Global Active Power (kilowatts)")
})
# Close device
dev.off()
