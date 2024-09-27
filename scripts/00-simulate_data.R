#### Preamble ####
# Purpose: Simulates a dataset of Australian electoral divisions, including the 
  #state and party that won each division.
# Author: Rohan Alexander
# Date: 26 September 2024
# Contact: rohan.alexander@utoronto.ca
# License: MIT
# Pre-requisites: The `tidyverse` package must be installed
# Any other information needed? Make sure you are in the `starter_folder` rproj


#### Workspace setup ####
library(tidyverse)
set.seed(1006147812)


#### Simulate data ####
# Define the number of records to simulate
n <- 80
ocyear <- sample(2019:2021, n, replace = TRUE)

simdata <- 
  tibble(
    OCCURRENCE_YEAR = ocyear,
    RACE_BIAS = sample(unique(cleaned_data$RACE_BIAS), n, replace = TRUE),
    ETHNICITY_BIAS = sample(unique(cleaned_data$ETHNICITY_BIAS), n, replace = TRUE),
    RELIGION_BIAS = sample(unique(cleaned_data$RELIGION_BIAS), n, replace = TRUE),
    SEXUAL_ORIENTATION_BIAS = sample(unique(cleaned_data$SEXUAL_ORIENTATION_BIAS), n, replace = TRUE),
    GENDER_BIAS = sample(unique(cleaned_data$GENDER_BIAS), n, replace = TRUE)
  )


#### Save data ####
write_csv(analysis_data, "data/00-simulated_data/simulated_data.csv")
