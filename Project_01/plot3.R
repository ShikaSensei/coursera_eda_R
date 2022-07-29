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
plot_imp_fp = paste(plot_root, 'plot3.png', sep = .Platform$file.sep)
# Colors for plotting
colors = c('chocolate', 'magenta', 'darkcyan')
# Column names
col_names <- sapply(1:3, function(x){paste0('Sub_metering_', x)})
# Open PNG device
png(plot_imp_fp, width = 480, height = 480)
# Create plot 
with(df, {
  plot(DateTime, 
       Sub_metering_1, 
       type = "n",
       xlab = "",
       ylab = "Energy sub metering",
       col = "chocolate")
  for(i in 1:length(colors)) {
    lines(DateTime,
          df[, col_names[i]],
          col = colors[i])
  }
  legend('topright',
         lty = 1,
         col = colors,
         legend = col_names)
})
# Close device
dev.off()
