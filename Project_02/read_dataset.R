if(!require(dplyr)) {
  install.packages('dplyr')
  library(dplyr)
}
# Dataset path
mapping_fp = file.path('data', 'Source_Classification_Code.rds')
dataset_fp = file.path('data', 'summarySCC_PM25.rds')
# Read dataset
map <- readRDS(mapping_fp)
df <- readRDS(dataset_fp)

