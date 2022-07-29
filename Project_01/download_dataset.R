# Getting system's separator
ssep = .Platform$file.sep
# Data root
data_root = 'data'
# Create Data root folder if required
if(! dir.exists(data_root)) {
  dir.create(data_root, recursive = TRUE)
}
# URL to dataset.zip
url = 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
# Path to dataset.zip
zip_fp = paste0(data_root, ssep, 'dataset.zip')
# Download dataset.zip
if(! file.exists(zip_fp)) {
  download.file(url, zip_fp)
}
# Unzipping dataset
unzip(zip_fp, exdir = data_root)