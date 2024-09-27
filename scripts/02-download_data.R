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
library(dplyr)


#### Download data ####
packages <- search_packages("hate crimes")

# Extract the first result's ID (package ID)
package_id <- packages$id[1]

# Use the package ID to get the dataset resources
resources <- list_package_resources(package_id)

# Filter to get the resource with CSV format
data_resource <- resources %>%
  filter(format == "CSV")

# Download the data using the resource ID
data <- get_resource(data_resource$id[1])

# View the first few rows of the dataset
print(head(data))

# Save the data to the data directory
write_csv(data, "data/01-raw_data/raw_data.csv")

         
