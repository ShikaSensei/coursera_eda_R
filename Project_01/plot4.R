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
plot_imp_fp = paste(plot_root, 'plot4.png', sep = .Platform$file.sep)
# Open PNG device
png(plot_imp_fp, width = 480, height = 480)
# Create plot 
with(df, {
  # Grid 2 x 2, row wise fill
  par(mfrow = c(2, 2))
  # Graph 1
  plot(DateTime, 
       Global_active_power, 
       type = "S",
       xlab = "",
       ylab = "Global Active Power")
  
  # Graph 2
  plot(DateTime,
       Voltage,
       type = "S",
       xlab = "datetime",
       ylab = "Voltage")
  
  # Graph 3
  # Colors for plotting
  colors = c('darkgreen', 'blue', 'red')
  # Column names
  col_names <- sapply(1:3, function(x){paste0('Sub_metering_', x)})
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
  
  # Graph 4
  plot(DateTime,
       Global_reactive_power,
       xlab = 'datetime',
       type = "S")
})
# Close device
dev.off()
