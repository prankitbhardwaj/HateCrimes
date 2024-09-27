#### Preamble ####
# Purpose: Downloads and saves the data from [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 11 February 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]


#### Workspace setup ####
install.packages("opendatatoronto")

library(opendatatoronto)
library(tidyverse)


#### Download data ####
package <- search_packages("hate crimes open data")[[1]]

# Get the resources associated with the package
resources <- list_package_resources(package)

# Filter to the CSV file
data_resource <- resources[resources$format == "CSV", ]

# Download the data
data <- read.csv(data_resource$path)

# Save the data to the data directory
write_csv(data, "data/01-raw_data/raw_data.csv")

         
